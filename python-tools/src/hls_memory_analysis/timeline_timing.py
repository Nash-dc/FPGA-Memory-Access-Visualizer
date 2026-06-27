#!/usr/bin/env python3
"""User-facing transaction timeline exports.

Logical accesses are source-level element operations. AXI beats are transfers on
the bus, and an AXI burst transaction contains one or more beats. The issue and
completion orders below are estimates: issue models request availability, while
completion includes transfer time. Dependency edges describe data/control
requirements; lane order is presentation order and is not a dependency.
"""

from collections import defaultdict
from pathlib import Path
import xml.etree.ElementTree as ET

from .common import transaction_sort_key


def _integer(value, default=None):
    try:
        return int(value)
    except (TypeError, ValueError):
        return default


def parse_csynth_xml(paths):
    """Collect optional loop and synthesized AXI metadata from csynth XML."""
    result = {
        "function_name": "",
        "loops": [],
        "interfaces": {},
        "files": [],
        "dataflow": {
            "enabled": False,
            "pipeline_type": "",
            "processes": [],
            "fifos": [],
        },
    }
    loops_by_name = {}
    processes_by_instance = {}
    fifos_by_name = {}
    for path in paths or []:
        path = Path(path)
        if not path.exists():
            continue
        try:
            root = ET.parse(path).getroot()
        except ET.ParseError:
            continue
        result["files"].append(str(path))
        top = root.findtext(".//TopModelName")
        if top and not result["function_name"]:
            result["function_name"] = top
        top_pipeline_type = (
            root.findtext(".//PerformanceEstimates/PipelineType")
            or root.findtext(
                ".//PerformanceEstimates/SummaryOfOverallLatency/PipelineType"
            )
            or ""
        )
        if "dataflow" in top_pipeline_type.lower():
            result["dataflow"]["enabled"] = True
            result["dataflow"]["pipeline_type"] = top_pipeline_type

        for loop_node in root.findall(".//SummaryOfLoopLatency//*"):
            name = loop_node.findtext("Name") or loop_node.tag
            ii = loop_node.findtext("PipelineII")
            pipeline = loop_node.findtext("PipelineType")
            trip_count = loop_node.findtext("TripCount")
            pipeline_depth = loop_node.findtext("PipelineDepth")
            if not any((ii, pipeline, trip_count, pipeline_depth)):
                continue
            candidate = {
                "name": name,
                "pipeline_ii": _integer(ii),
                "pipeline_depth": _integer(pipeline_depth),
                "pipeline_type": pipeline or "",
                "trip_count": _integer(trip_count),
            }
            current = loops_by_name.get(name, {})
            loops_by_name[name] = {
                "name": name,
                "pipeline_ii": candidate["pipeline_ii"]
                if candidate["pipeline_ii"] is not None
                else current.get("pipeline_ii"),
                "pipeline_type": candidate["pipeline_type"]
                or current.get("pipeline_type", ""),
                "pipeline_depth": candidate["pipeline_depth"]
                if candidate["pipeline_depth"] is not None
                else current.get("pipeline_depth"),
                "trip_count": candidate["trip_count"]
                if candidate["trip_count"] is not None
                else current.get("trip_count"),
            }

        for interface in root.findall(".//Interface"):
            if interface.attrib.get("type") != "axi4full":
                continue
            params = {
                item.attrib.get("busParamName", "").lower(): (item.text or "").strip()
                for item in interface.findall(".//busParam")
            }
            constraint = interface.find(".//constraint[@mode='m_axi']")
            attrs = dict(constraint.attrib) if constraint is not None else {}
            argument = attrs.get("argName", "")
            if not argument:
                continue
            result["interfaces"][argument] = {
                "data_width_bits": _integer(interface.attrib.get("dataWidth")),
                "max_read_burst_length": _integer(
                    attrs.get("max_read_burst_length")
                    or params.get("max_read_burst_length")
                ),
                "max_write_burst_length": _integer(
                    attrs.get("max_write_burst_length")
                    or params.get("max_write_burst_length")
                ),
                "num_read_outstanding": _integer(
                    attrs.get("num_read_outstanding")
                    or params.get("num_read_outstanding")
                ),
                "num_write_outstanding": _integer(
                    attrs.get("num_write_outstanding")
                    or params.get("num_write_outstanding")
                ),
                "max_widen_bitwidth": _integer(attrs.get("max_widen_bitwidth")),
                "interface_name": interface.attrib.get("InterfaceName", ""),
            }

        top_module = root.find(".//RTLDesignHierarchy/TopModule")
        if top_module is not None:
            for instance in top_module.findall(".//Instance"):
                inst_name = (instance.findtext("InstName") or "").strip()
                module_name = (instance.findtext("ModuleName") or "").strip()
                if not inst_name or not module_name:
                    continue
                processes_by_instance[inst_name] = {
                    "instance": inst_name,
                    "module": module_name,
                }
        for fifo in root.findall(".//FIFOInformation/FIFOInst"):
            name = (fifo.findtext("Name") or "").strip()
            if not name:
                continue
            fifos_by_name[name] = {
                "name": name,
                "static_depth": _integer(fifo.findtext("StaticDepth")),
                "runtime_depth": (fifo.findtext("RuntimeDepth") or "").strip(),
            }
    result["loops"] = list(loops_by_name.values())
    result["dataflow"]["processes"] = list(processes_by_instance.values())
    result["dataflow"]["fifos"] = list(fifos_by_name.values())
    return result


def dependency_sources(dependency_graph):
    result = defaultdict(list)
    for block in dependency_graph.get("blocks", []):
        target = block.get("transaction_id", "")
        for dependency in block.get("dependencies", []):
            source = dependency.get("source_transaction_id", "")
            if source and source not in result[target]:
                result[target].append(source)
    return result


def dependency_details(dependency_graph):
    result = defaultdict(list)
    for block in dependency_graph.get("blocks", []):
        target = block.get("transaction_id", "")
        for dependency in block.get("dependencies", []):
            if target:
                result[target].append(dependency)
    return result


def pipeline_timing_profile(csynth):
    loops = csynth.get("loops", [])
    pipelined = [
        loop
        for loop in loops
        if loop.get("pipeline_ii") is not None
        or "yes" in str(loop.get("pipeline_type", "")).lower()
        or "loop " in str(loop.get("pipeline_type", "")).lower()
    ]
    ii_one = [loop for loop in pipelined if loop.get("pipeline_ii") == 1]
    achieved_iis = [
        loop["pipeline_ii"]
        for loop in pipelined
        if loop.get("pipeline_ii") is not None
    ]
    pipeline_depths = [
        loop["pipeline_depth"]
        for loop in pipelined
        if loop.get("pipeline_depth") is not None
    ]
    return {
        "is_pipelined": bool(pipelined),
        "has_ii_one_loop": bool(ii_one),
        "continuous_read_issue_candidate": bool(ii_one),
        "minimum_achieved_ii": min(achieved_iis) if achieved_iis else None,
        "maximum_pipeline_depth": max(pipeline_depths) if pipeline_depths else None,
        "basis": (
            "csynth achieved PipelineII=1"
            if ii_one
            else "no csynth loop with achieved PipelineII=1"
        ),
    }


def transaction_pipeline_parameters(transaction, csynth, pipeline):
    loop_name = str(transaction.get("loop", ""))
    loops = [
        loop
        for loop in csynth.get("loops", [])
        if loop.get("pipeline_ii") is not None
        or "yes" in str(loop.get("pipeline_type", "")).lower()
    ]
    matching = [
        loop
        for loop in loops
        if loop_name
        and (
            loop.get("name") == loop_name
            or loop_name in str(loop.get("name", ""))
            or str(loop.get("name", "")) in loop_name
        )
    ]
    candidates = matching or loops
    iis = [
        loop["pipeline_ii"]
        for loop in candidates
        if loop.get("pipeline_ii") is not None
    ]
    depths = [
        loop["pipeline_depth"]
        for loop in candidates
        if loop.get("pipeline_depth") is not None
    ]
    return (
        min(iis) if iis else pipeline.get("minimum_achieved_ii") or 1,
        max(depths) if depths else pipeline.get("maximum_pipeline_depth") or 0,
    )


def timeline_order_predecessors(transactions):
    """Infer dynamic phase order without adding false data dependencies.

    A scalar write between two different loop regions commonly closes one
    outer-loop computation before the next load region can execute. This is a
    control/timeline constraint, not a memory dependency. Burst writes and
    writes in the same pipelined loop are deliberately excluded because they
    may overlap later reads through buffering.
    """
    ordered = sorted(
        transactions,
        key=lambda item: (
            _integer(item.get("first_trace_event_index"), 0),
            item.get("transaction_id", ""),
        ),
    )
    result = {}
    latest_scalar_write = None
    for transaction in ordered:
        direction = transaction.get("direction", "")
        if direction == "read" and latest_scalar_write is not None:
            write_loop = str(latest_scalar_write.get("loop", ""))
            read_loop = str(transaction.get("loop", ""))
            write_last = _integer(
                latest_scalar_write.get("last_trace_event_index"), -1
            )
            read_first = _integer(transaction.get("first_trace_event_index"), 0)
            if (
                write_last < read_first
                and write_loop
                and read_loop
                and write_loop != read_loop
            ):
                result[transaction["transaction_id"]] = latest_scalar_write[
                    "transaction_id"
                ]
        if (
            direction == "write"
            and _integer(transaction.get("element_count"), 0) == 1
        ):
            latest_scalar_write = transaction
    return result


def lane_order_predecessors(transactions):
    grouped = defaultdict(list)
    for transaction in transactions:
        direction = transaction.get("direction", "")
        bundle = transaction.get("bundle") or transaction.get("port", "")
        lane_key = (bundle, direction)
        grouped[lane_key].append(transaction)

    result = {}
    for group in grouped.values():
        ordered = sorted(group, key=transaction_sort_key)
        for previous, current in zip(ordered, ordered[1:]):
            result[current["transaction_id"]] = previous["transaction_id"]
    return result


def write_timing_estimate(transaction, csynth, pipeline, has_dependencies):
    beats = max(1, _integer(transaction.get("axi", {}).get("beat_count"), 1))
    useful_elements = max(1, _integer(transaction.get("element_count"), 1))
    loop_ii, pipeline_depth = transaction_pipeline_parameters(
        transaction, csynth, pipeline
    )
    # A scalar pipelined loop normally produces one logical write element per
    # iteration. Filling a burst therefore takes useful_elements * II cycles.
    # The W channel additionally needs at least one cycle per AXI beat.
    burst_formation_cycles = useful_elements * max(1, loop_ii)
    issue_spacing = max(beats, burst_formation_cycles) + 1
    pipeline_fill_cycles = 0
    return {
        "loop_ii": loop_ii,
        "pipeline_depth": pipeline_depth,
        "burst_formation_cycles": burst_formation_cycles,
        "axi_transfer_cycles": beats,
        "pipeline_fill_cycles": pipeline_fill_cycles,
        "request_gap_cycles": 1,
        "minimum_issue_spacing": issue_spacing,
        "formula": (
            "dependency readiness plus "
            "max(axi_beat_count, useful_element_count * achieved_loop_ii) "
            "plus one visual request-gap slot"
        ),
        "confidence": "estimated_from_csynth_and_ir_trace",
        "is_cycle_accurate": False,
    }


def stream_capacity_backpressure_by_producer(detailed_dependencies):
    result = defaultdict(list)
    for dependencies in detailed_dependencies.values():
        for dependency in dependencies:
            if dependency.get("kind") != "stream_channel":
                continue
            capacity = dependency.get("capacity_constraint", {})
            if not capacity.get("backpressure_expected"):
                continue
            source = dependency.get("source_transaction_id", "")
            if source:
                result[source].append(capacity)
    return result


def annotate_interface_outstanding_limit(transaction, timing_model):
    interface = transaction.get("interface", {})
    direction = transaction.get("direction", "")
    if direction == "read":
        limit = _integer(interface.get("num_read_outstanding"))
        if limit is None:
            return
        timing_model["num_read_outstanding"] = limit
        if limit == 1:
            beats = max(1, _integer(transaction.get("axi", {}).get("beat_count"), 1))
            timing_model["minimum_issue_spacing"] = max(
                timing_model.get("minimum_issue_spacing", 1), beats + 1
            )
            timing_model["request_gap_cycles"] = 1
            timing_model["read_outstanding_limit_model"] = (
                "num_read_outstanding=1: this AXI master can have only one "
                "read request in flight; the timeline leaves a one-slot gap "
                "after each read burst to visualize internal FIFO/R-channel "
                "stall risk"
            )
            timing_model["read_outstanding_limit_expected"] = True
        elif "backpressure_limited_order_slots" not in timing_model:
            timing_model["minimum_issue_spacing"] = 1
            timing_model["read_outstanding_limit_model"] = (
                f"num_read_outstanding={limit}: this AXI master can keep "
                "multiple read requests in flight, so consecutive read "
                "transactions may be issued close together"
            )
            timing_model["read_outstanding_limit_expected"] = False
    elif direction == "write":
        limit = _integer(interface.get("num_write_outstanding"))
        if limit is not None:
            timing_model["num_write_outstanding"] = limit


def annotate_transaction_timing(transactions, dependency_graph, csynth=None):
    """Estimate request and completion order without inventing data edges.

    Independent reads can issue on consecutive logical slots, reflecting a
    pipelined master with outstanding requests. Writes wait for their dynamic
    dependencies and one estimated burst-formation slot. Exact cycles still
    require RTL/cosim and are deliberately not claimed here.
    """
    dependencies = dependency_sources(dependency_graph)
    detailed_dependencies = dependency_details(dependency_graph)
    producer_backpressure = stream_capacity_backpressure_by_producer(
        detailed_dependencies
    )
    timeline_predecessors = timeline_order_predecessors(transactions)
    csynth = csynth or {}
    dataflow_enabled = bool(csynth.get("dataflow", {}).get("enabled"))
    lane_predecessors = lane_order_predecessors(transactions)
    pipeline = pipeline_timing_profile(csynth)
    by_id = {
        transaction["transaction_id"]: transaction for transaction in transactions
    }
    ordered = sorted(
        transactions,
        key=lambda item: (
            _integer(item.get("first_trace_event_index"), 0),
            item.get("transaction_id", ""),
        ),
    )
    pending = list(ordered)
    completed = {}
    next_issue = defaultdict(int)

    while pending:
        progressed = False
        for transaction in list(pending):
            txn_id = transaction["transaction_id"]
            sources = [source for source in dependencies.get(txn_id, []) if source in by_id]
            if any(source not in completed for source in sources):
                continue
            timeline_predecessor = timeline_predecessors.get(txn_id)
            if (
                timeline_predecessor
                and timeline_predecessor in by_id
                and timeline_predecessor not in completed
            ):
                continue
            lane_predecessor = lane_predecessors.get(txn_id)
            if (
                lane_predecessor
                and lane_predecessor in by_id
                and lane_predecessor not in completed
            ):
                continue
            direction = transaction.get("direction", "")
            bundle = transaction.get("bundle") or transaction.get("port", "")
            lane_key = (bundle, direction)
            stream_sources = {
                dependency.get("source_transaction_id", "")
                for dependency in detailed_dependencies.get(txn_id, [])
                if dependency.get("kind") == "stream_channel"
            }
            dependency_ready = max(
                (
                    completed[source]["complete_order"] + 1
                    for source in sources
                ),
                default=0,
            )
            timeline_ready = (
                completed[timeline_predecessor]["issue_order"] + 1
                if timeline_predecessor in completed
                else 0
            )
            beats = max(1, _integer(transaction.get("axi", {}).get("beat_count"), 1))
            if direction == "write":
                transaction_dependencies = detailed_dependencies.get(txn_id, [])
                has_phase_order = any(
                    dependency.get("kind") == "local_buffer_phase_order"
                    for dependency in transaction_dependencies
                )
                timing_model = write_timing_estimate(
                    transaction, csynth, pipeline, bool(sources)
                )
                if has_phase_order:
                    timing_model["write_phase_order_model"] = (
                        "non-DATAFLOW local-buffer phase order: write request "
                        "issue is delayed until the widened producer read "
                        "phase is available, then same-lane write requests are "
                        "spaced by burst formation through the pipelined loop"
                    )
                    timing_model["write_phase_order_expected"] = True
                if stream_sources:
                    ready_delay = 0
                    timing_model["stream_consumer_cycles"] = timing_model[
                        "burst_formation_cycles"
                    ]
                    timing_model["minimum_issue_spacing"] = timing_model[
                        "axi_transfer_cycles"
                    ]
                    timing_model["formula"] = (
                        "DATAFLOW stream write request issue spacing: "
                        "axi_beat_count; consumer loop II is recorded as "
                        "stream_consumer_cycles"
                    )
                    timing_model["stream_dependency_model"] = (
                        "producer-consumer FIFO transaction block: write "
                        "request waits for the matching producer read "
                        "transaction to complete"
                    )
                else:
                    ready_delay = (
                        timing_model["pipeline_fill_cycles"]
                        + timing_model["burst_formation_cycles"]
                    )
                annotate_interface_outstanding_limit(transaction, timing_model)
            else:
                if dataflow_enabled:
                    loop_ii, pipeline_depth = transaction_pipeline_parameters(
                        transaction, csynth, pipeline
                    )
                    token_block_cycles = max(
                        beats,
                        max(
                            1,
                            _integer(transaction.get("element_count"), 1),
                        )
                        * max(1, loop_ii),
                    )
                    timing_model = {
                        "loop_ii": loop_ii,
                        "pipeline_depth": pipeline_depth,
                        "minimum_issue_spacing": token_block_cycles,
                        "axi_transfer_cycles": beats,
                        "token_block_cycles": token_block_cycles,
                        "transaction_complete_cycles": token_block_cycles,
                        "formula": (
                            "DATAFLOW producer token block spacing: "
                            "max(axi_beat_count, useful_element_count * "
                            "achieved_loop_ii)"
                        ),
                        "confidence": "estimated_from_csynth_dataflow_and_ir_trace",
                        "is_cycle_accurate": False,
                    }
                    capacity_constraints = producer_backpressure.get(txn_id, [])
                    if capacity_constraints:
                        tokens = max(
                            1, _integer(transaction.get("element_count"), 1)
                        )
                        limited_slots = 0
                        for constraint in capacity_constraints:
                            depth = max(
                                0,
                                _integer(
                                    constraint.get("fifo_static_depth"), 0
                                ),
                            )
                            producer_ii = max(
                                1,
                                _integer(
                                    constraint.get("producer_loop_ii"), 1
                                ),
                            )
                            consumer_ii = max(
                                1,
                                _integer(
                                    constraint.get("consumer_loop_ii"), 1
                                ),
                            )
                            prefix = min(tokens, depth) * producer_ii
                            throttled = max(0, tokens - depth) * consumer_ii
                            limited_slots = max(
                                limited_slots, prefix + throttled
                            )
                        if limited_slots > token_block_cycles:
                            timing_model["minimum_issue_spacing"] = limited_slots
                            timing_model[
                                "transaction_complete_cycles"
                            ] = limited_slots
                            timing_model[
                                "backpressure_limited_order_slots"
                            ] = limited_slots
                            timing_model[
                                "stream_backpressure_model"
                            ] = (
                                "bounded FIFO backpressure: producer read "
                                "transaction ordering is throttled by downstream "
                                "consumer loop rate"
                            )
                            timing_model[
                                "stream_capacity_constraints"
                            ] = capacity_constraints
                    annotate_interface_outstanding_limit(
                        transaction, timing_model
                    )
                    ready_delay = 0
                else:
                    timing_model = {
                        "minimum_issue_spacing": (
                            1 if pipeline["continuous_read_issue_candidate"] else beats
                        ),
                        "axi_transfer_cycles": beats,
                        "formula": (
                            "one logical issue slot for pipelined outstanding reads"
                            if pipeline["continuous_read_issue_candidate"]
                            else "axi_beat_count"
                        ),
                        "confidence": "estimated_from_csynth_and_ir_trace",
                        "is_cycle_accurate": False,
                    }
                    annotate_interface_outstanding_limit(
                        transaction, timing_model
                    )
                    ready_delay = 0
            issue = max(
                next_issue[lane_key],
                dependency_ready + ready_delay,
                timeline_ready,
            )
            complete = issue + max(
                beats, timing_model.get("transaction_complete_cycles", beats)
            )
            transaction["issue_order"] = issue
            transaction["complete_order"] = complete
            transaction["timeline_lane"] = (
                f"{transaction.get('port', '')}_{direction}"
                if dataflow_enabled
                else transaction.get("port", "")
            )
            transaction["depends_on_transaction_ids"] = sources
            transaction["dependency_details"] = detailed_dependencies.get(
                txn_id, []
            )
            transaction["timeline_order_predecessor_id"] = (
                timeline_predecessor or ""
            )
            transaction["timing_model"] = timing_model
            completed[txn_id] = transaction
            issue_spacing = max(1, timing_model["minimum_issue_spacing"])
            next_issue[lane_key] = issue + issue_spacing
            pending.remove(transaction)
            progressed = True
        if progressed:
            continue
        # Cyclic or incomplete static metadata must not prevent visualization.
        transaction = pending.pop(0)
        txn_id = transaction["transaction_id"]
        direction = transaction.get("direction", "")
        bundle = transaction.get("bundle") or transaction.get("port", "")
        lane_key = (bundle, direction)
        issue = next_issue[lane_key]
        beats = max(1, _integer(transaction.get("axi", {}).get("beat_count"), 1))
        if direction == "write":
            timing_model = write_timing_estimate(
                transaction, csynth, pipeline, False
            )
        else:
            timing_model = {
                "minimum_issue_spacing": 1,
                "axi_transfer_cycles": beats,
                "formula": "fallback logical issue order",
                "confidence": "fallback",
                "is_cycle_accurate": False,
            }
        transaction["issue_order"] = issue
        transaction["complete_order"] = issue + beats
        transaction["timeline_lane"] = (
            f"{transaction.get('port', '')}_{direction}"
            if dataflow_enabled
            else transaction.get("port", "")
        )
        transaction["depends_on_transaction_ids"] = [
            source for source in dependencies.get(txn_id, []) if source in by_id
        ]
        transaction["dependency_details"] = detailed_dependencies.get(txn_id, [])
        transaction["timeline_order_predecessor_id"] = (
            timeline_predecessors.get(txn_id, "")
        )
        transaction["timing_model"] = timing_model
        completed[txn_id] = transaction
        next_issue[lane_key] = issue + max(
            1, timing_model["minimum_issue_spacing"]
        )
