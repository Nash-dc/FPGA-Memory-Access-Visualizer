import html
import json
from collections import defaultdict

from .timeline_timing import (
    _integer,
    dependency_details,
    dependency_sources,
    pipeline_timing_profile,
)


def transaction_tsv_rows(transactions):
    rows = []
    for transaction in transactions:
        axi = transaction.get("axi", {})
        dependency_labels = []
        for dependency in transaction.get("dependency_details", []):
            source = dependency.get("source_transaction_id", "")
            kind = dependency.get("kind", "")
            via = dependency.get("via", "")
            label = source
            if kind or via:
                label = f"{source}:{kind}"
                if via:
                    label += f":{via}"
            dependency_labels.append(label)
        rows.append(
            {
                "txn_id": transaction.get("transaction_id", ""),
                "direction": transaction.get("direction", ""),
                "argument": transaction.get("port", ""),
                "bundle": transaction.get("bundle", ""),
                "start_index": transaction.get("first_element", ""),
                "end_index": transaction.get("last_element", ""),
                "byte_addr": transaction.get("physical_start_offset_bytes", ""),
                "beats": axi.get("beat_count", ""),
                "axlen": axi.get("arlen_or_awlen", ""),
                "elements_per_beat": axi.get("source_elements_per_beat", ""),
                "issue_order": transaction.get("issue_order", ""),
                "complete_order": transaction.get("complete_order", ""),
                "depends_on": ",".join(transaction.get("depends_on_transaction_ids", [])),
                "dependency_details": ",".join(dependency_labels),
                "timeline_lane": transaction.get("timeline_lane", ""),
            }
        )
    return rows


def element_tsv_rows(events, logical_graph):
    incoming = defaultdict(list)
    for edge in logical_graph.get("dependencies", []):
        target = edge.get("target_logical_access_id", "")
        source = edge.get("source_logical_access_id", "")
        if source and source not in incoming[target]:
            incoming[target].append(source)
    rows = []
    for event in events:
        logical_id = event.get("logical_access_id", "")
        rows.append(
            {
                "element_id": logical_id,
                "order": event.get("trace_event_index", ""),
                "op_type": event.get("direction", ""),
                "argument": event.get("port", ""),
                "bundle": event.get("bundle", ""),
                "index": event.get("element_index", ""),
                "byte_addr": event.get("offset_bytes", ""),
                "source_loc": event.get("source_instruction", ""),
                "txn_id": event.get("transaction_id", ""),
                "depends_on": ",".join(incoming.get(logical_id, [])),
            }
        )
    return rows


def _uniform_or_map(values):
    cleaned = {key: value for key, value in values.items() if value not in (None, "")}
    unique = set(cleaned.values())
    if len(unique) == 1:
        return next(iter(unique))
    return cleaned


def build_summary(report, events, transactions, dependency_graph, interfaces, csynth):
    port_data_width = {}
    read_bursts = {}
    write_bursts = {}
    element_width = {}
    elements_per_beat = {}
    for transaction in transactions:
        port = transaction.get("port", "")
        axi = transaction.get("axi", {})
        port_data_width[port] = _integer(axi.get("data_width_bits"))
        element_width[port] = _integer(transaction.get("bytes_per_element"), 0) * 8
        elements_per_beat[port] = _integer(axi.get("source_elements_per_beat"))
        attrs = interfaces.get(port, {})
        read_bursts[port] = _integer(attrs.get("max_read_burst_length"))
        write_bursts[port] = _integer(attrs.get("max_write_burst_length"))

    loops = [loop for loop in csynth.get("loops", []) if loop.get("pipeline_ii")]
    pipeline = pipeline_timing_profile(csynth)
    transaction_edges = sum(
        len(block.get("dependencies", []))
        for block in dependency_graph.get("blocks", [])
    )
    return {
        "function_name": csynth.get("function_name") or report.get("function", ""),
        "loop_name": [loop["name"] for loop in loops],
        "loop_ii": {loop["name"]: loop["pipeline_ii"] for loop in loops},
        "pipeline_analysis": {
            **pipeline,
            "loops": csynth.get("loops", []),
            "dataflow": csynth.get("dataflow", {}),
            "interpretation": (
                "II=1 permits consecutive read-request issue when addresses are "
                "sequential and the AXI master supports outstanding requests. "
                "For DATAFLOW regions, independent process lanes may overlap. "
                "Stream-channel dependencies delay each consumer transaction "
                "until the matching producer transaction block is available. "
                "When csynth reports a bounded FIFO and the producer loop II is "
                "smaller than the consumer loop II, capacity annotations flag "
                "producer backpressure risk."
            ),
        },
        "data_width_bits": _uniform_or_map(port_data_width),
        "element_width_bits": _uniform_or_map(element_width),
        "elements_per_beat": _uniform_or_map(elements_per_beat),
        "max_read_burst_length": _uniform_or_map(read_bursts),
        "max_write_burst_length": _uniform_or_map(write_bursts),
        "total_read_elements": sum(
            1 for event in events if event.get("direction") == "read"
        ),
        "total_write_elements": sum(
            1 for event in events if event.get("direction") == "write"
        ),
        "total_read_transactions": sum(
            1 for transaction in transactions if transaction.get("direction") == "read"
        ),
        "total_write_transactions": sum(
            1 for transaction in transactions if transaction.get("direction") == "write"
        ),
        "transaction_dependency_edges": transaction_edges,
        "notes_about_assumptions": [
            "LLVM IR trace is the source of executed logical accesses and dynamic order.",
            "HLS interface/csynth metadata supplies AXI width, burst limits, outstanding settings, and loop II when available.",
            "Physical transactions are inferred from aligned addresses, continuity, width, and burst limits; no RTL waveform is used.",
            "Issue/completion values are logical estimates, not RTL cycle-accurate timestamps.",
            "Timeline lane order is not a data dependency. Only explicit graph edges are dependencies.",
        ],
        "inputs": {"csynth_xml": csynth.get("files", [])},
        "counts": {
            "trace_events": len(events),
            "element_events": len(events),
            "axi_transactions": len(transactions),
            "access_sites_from_pass_report": len(report.get("off_chip_accesses", [])),
        },
    }


def render_html(path, transactions, dependency_graph, title):
    dependencies = dependency_sources(dependency_graph)
    dependency_by_target = dependency_details(dependency_graph)
    payload = []
    for transaction in transactions:
        axi = transaction.get("axi", {})
        details = dependency_by_target.get(transaction.get("transaction_id", ""), [])
        payload.append(
            {
                "id": transaction.get("transaction_id", ""),
                "direction": transaction.get("direction", ""),
                "argument": transaction.get("port", ""),
                "bundle": transaction.get("bundle", ""),
                "byte_addr": transaction.get("physical_start_offset_bytes", ""),
                "axlen": axi.get("arlen_or_awlen", ""),
                "beats": axi.get("beat_count", ""),
                "elements_per_beat": axi.get("source_elements_per_beat", ""),
                "element_count": transaction.get("element_count", ""),
                "range": transaction.get("element_range_label", ""),
                "elements": transaction.get("elements", []),
                "dependencies": dependencies.get(transaction.get("transaction_id", ""), []),
                "dependency_details": details,
                "issue_order": transaction.get("issue_order", 0),
                "complete_order": transaction.get("complete_order", 0),
                "timing_model": transaction.get("timing_model", {}),
                "timeline_order_predecessor_id": transaction.get(
                    "timeline_order_predecessor_id", ""
                ),
                "lane": transaction.get("timeline_lane", ""),
            }
        )
    data = json.dumps(payload).replace("</", "<\\/")
    document = """<!doctype html>
<html><head><meta charset="utf-8"><title>__TITLE__</title>
<style>
body{margin:0;font:14px Arial,sans-serif;color:#172033;background:#f6f8fb}
header{padding:14px 20px;background:#fff;border-bottom:1px solid #d9dfE8}
h1{margin:0;font-size:18px;letter-spacing:0}.layout{display:grid;grid-template-columns:minmax(700px,1fr) 340px;height:calc(100vh - 50px)}
#viewport{overflow:auto;position:relative}.canvas{position:relative;margin:20px;min-height:300px}
.lane-label{position:absolute;left:0;width:110px;font-weight:700;padding-top:22px}
.lane-line{position:absolute;left:110px;height:1px;background:#ccd4df}
.node{position:absolute;height:64px;padding:8px;box-sizing:border-box;background:#fff;border:2px solid #2463eb;border-radius:6px;cursor:pointer;overflow:hidden}
.node.write{border-color:#dc2626}.node.selected{box-shadow:0 0 0 3px #fbbf24}.node b{display:block}.node small{display:block;color:#526071;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.node.compact{height:34px;padding:0;border-radius:3px}.node.compact b,.node.compact small{display:none}
svg{position:absolute;left:0;top:0;pointer-events:none;overflow:visible}.edge{stroke:#707b8c;stroke-width:1.5;fill:none}.order-edge{stroke:#9aa4b2;stroke-width:1;stroke-dasharray:4 4;fill:none}
aside{background:#fff;border-left:1px solid #d9dfe8;padding:18px;overflow:auto}dt{font-weight:700;margin-top:12px}dd{margin:3px 0;word-break:break-word}.hint{color:#667085}
</style></head><body><header><h1>__TITLE__</h1></header>
<div class="layout"><div id="viewport"><div id="canvas" class="canvas"><svg id="edges"></svg></div></div>
<aside><div id="details" class="hint">Click a transaction to inspect its AXI and dependency details.</div></aside></div>
<script>
const txns=__DATA__, canvas=document.getElementById('canvas'), svg=document.getElementById('edges');
const lanes=[...new Set(txns.map(t=>t.lane))], compact=txns.length>80;
const laneStep=compact?70:110, nodeHeight=compact?34:64;
const laneY=new Map(lanes.map((v,i)=>[v,30+i*laneStep]));
const maxComplete=Math.max(1,...txns.map(t=>Number(t.complete_order)||0));
const targetWidth=compact?9000:12000;
const timeScale=Math.max(1,Math.min(compact?3:4,Math.floor(targetWidth/maxComplete)));
const widthScale=Math.max(1,Math.min(compact?1.4:1.8,timeScale*0.55));
const minNodeWidth=compact?12:72;
const maxNodeWidth=compact?96:260;
const laneGap=compact?8:28,left=130;
txns.forEach(t=>{const issue=Number(t.issue_order)||0,elementCount=Number(t.element_count)||((t.elements||[]).length)||1;t._width=Math.min(maxNodeWidth,Math.max(minNodeWidth,Math.round(elementCount*widthScale)));t._timeLeft=left+issue*timeScale});
const txnById=new Map(txns.map(t=>[t.id,t]));
function laneTxns(lane){return txns.filter(t=>t.lane===lane).sort((a,b)=>(Number(a.issue_order)||0)-(Number(b.issue_order)||0)||String(a.id).localeCompare(String(b.id)))}
function placeLaneTxns(){lanes.forEach(l=>{let cursor=left;laneTxns(l).forEach(t=>{const required=Math.max(t._left??t._timeLeft,cursor);if(t._left===undefined||required>t._left)t._left=required;cursor=t._left+t._width+laneGap})})}
function isHardDependency(d){return d.readiness==='source_transaction_complete'||d.kind!=='stream_channel'}
function applyDependencyConstraints(){let changed=false;txns.forEach(t=>{(t.dependency_details||[]).filter(isHardDependency).forEach(d=>{const s=txnById.get(d.source_transaction_id);if(!s)return;const required=s._left+s._width+laneGap;if(required>t._left){t._left=required;changed=true}})});return changed}
placeLaneTxns();
for(let pass=0;pass<txns.length;pass++){const shifted=applyDependencyConstraints();placeLaneTxns();if(!shifted)break}
const width=Math.max(900,...txns.map(t=>t._left+t._width+40)), height=Math.max(300,lanes.length*laneStep+60);
canvas.style.width=width+'px';canvas.style.height=height+'px';svg.setAttribute('width',width);svg.setAttribute('height',height);
const byId=new Map();
lanes.forEach(l=>{const y=laneY.get(l);const label=document.createElement('div');label.className='lane-label';label.style.top=y+'px';label.textContent=l;canvas.appendChild(label);const line=document.createElement('div');line.className='lane-line';line.style.top=(y+nodeHeight/2)+'px';line.style.width=(width-110)+'px';canvas.appendChild(line)});
txns.forEach(t=>{const elementCount=Number(t.element_count)||((t.elements||[]).length)||1;const n=document.createElement('div');n.className='node '+t.direction+(compact?' compact':'');n.style.width=t._width+'px';n.style.left=t._left+'px';n.style.top=laneY.get(t.lane)+'px';n.title=t.id+' | '+t.direction+' '+t.range+' | elements '+elementCount;n.innerHTML='<b>'+t.id+'</b><small>'+t.direction+' '+t.range+'</small><small>'+elementCount+' elements</small>';n.onclick=()=>select(t,n);canvas.appendChild(n);byId.set(t.id,n)});
svg.innerHTML='<defs><marker id="arrow" markerWidth="8" markerHeight="8" refX="7" refY="3" orient="auto"><path d="M0,0 L0,6 L8,3 z" fill="#707b8c"/></marker><marker id="order-arrow" markerWidth="8" markerHeight="8" refX="7" refY="3" orient="auto"><path d="M0,0 L0,6 L8,3 z" fill="#9aa4b2"/></marker></defs>';
txns.forEach(t=>t.dependencies.forEach(s=>{const a=byId.get(s),b=byId.get(t.id);if(!a||!b)return;const x1=a.offsetLeft+a.offsetWidth,y1=a.offsetTop+nodeHeight/2,x2=b.offsetLeft,y2=b.offsetTop+nodeHeight/2;const bend=compact?12:35;const p=document.createElementNS('http://www.w3.org/2000/svg','path');p.setAttribute('class','edge');p.setAttribute('marker-end','url(#arrow)');p.setAttribute('d',`M${x1},${y1} C${x1+bend},${y1} ${x2-bend},${y2} ${x2},${y2}`);svg.appendChild(p)}));
txns.forEach(t=>{const s=t.timeline_order_predecessor_id;if(!s)return;const a=byId.get(s),b=byId.get(t.id);if(!a||!b)return;const x1=a.offsetLeft+a.offsetWidth,y1=a.offsetTop+nodeHeight/2,x2=b.offsetLeft,y2=b.offsetTop+nodeHeight/2;const p=document.createElementNS('http://www.w3.org/2000/svg','path');p.setAttribute('class','order-edge');p.setAttribute('marker-end','url(#order-arrow)');p.setAttribute('d',`M${x1},${y1} C${x1+10},${y1} ${x2-10},${y2} ${x2},${y2}`);svg.appendChild(p)});
function esc(v){return String(v).replace(/[&<>"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]))}
function capacityText(c){if(!c)return '';return 'FIFO '+(c.channel||'')+' depth='+(c.fifo_static_depth??'n/a')+', producer II='+(c.producer_loop_ii??'n/a')+', consumer II='+(c.consumer_loop_ii??'n/a')+', tokens='+(c.tokens_in_transaction??'n/a')+', backpressure='+(c.backpressure_expected?'yes':'no')}
function depText(t){const deps=t.dependency_details||[];if(!deps.length)return 'none';return deps.map(d=>{let s=d.source_transaction_id||'';let k=d.kind||'';let via=d.via||'';let r=d.readiness||'';let cap=capacityText(d.capacity_constraint);let why=d.reason||'';return [s,k,via,r,cap,why].filter(Boolean).join(' | ')}).join('\\n')}
function backpressureText(m){const cs=m.stream_capacity_constraints||[];if(!cs.length)return 'n/a';return cs.map(capacityText).join('\\n')}
function incomingCapacityText(t){const cs=(t.dependency_details||[]).map(d=>d.capacity_constraint).filter(Boolean);if(!cs.length)return 'n/a';return cs.map(capacityText).join('\\n')}
function select(t,n){document.querySelectorAll('.node').forEach(x=>x.classList.remove('selected'));n.classList.add('selected');const m=t.timing_model||{};const rows=[['transaction id',t.id],['direction',t.direction],['argument',t.argument],['bundle',t.bundle],['byte address',t.byte_addr],['AXI length',t.axlen],['beats',t.beats],['elements per beat',t.elements_per_beat],['element count',t.element_count||((t.elements||[]).length)],['index range',t.range],['elements',t.elements.join(', ')],['data dependencies',t.dependencies.join(', ')||'none'],['dependency source',depText(t)],['timeline predecessor',t.timeline_order_predecessor_id||'none'],['achieved loop II',m.loop_ii??'n/a'],['stream dependency model',m.stream_dependency_model||'n/a'],['incoming capacity constraints',incomingCapacityText(t)],['producer backpressure model',m.stream_backpressure_model||'n/a'],['producer backpressure estimate',m.backpressure_limited_order_slots??'n/a'],['producer capacity constraints',backpressureText(m)]];document.getElementById('details').innerHTML='<dl>'+rows.map(r=>'<dt>'+esc(r[0])+'</dt><dd>'+esc(r[1])+'</dd>').join('')+'</dl>'}
</script></body></html>"""
    path.write_text(
        document.replace("__TITLE__", html.escape(title)).replace("__DATA__", data)
    )
