#!/usr/bin/env python3
"""Assemble trace-first logical and physical memory timeline outputs."""

import argparse
import sys
from pathlib import Path

TOOLS_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(TOOLS_DIR / "src"))

from hls_memory_analysis.hls_metadata import (
    build_trace_events,
    merge_csynth_interfaces,
    parse_interfaces,
    parse_schedule_xml,
    schedule_identifiers,
)
from hls_memory_analysis.logical_access import build_logical_access_graph
from hls_memory_analysis.common import parse_int
from hls_memory_analysis.io import (
    load_json,
    read_trace,
    read_tsv,
    write_json,
    write_tsv,
)
from hls_memory_analysis.physical_axi import (
    build_bandwidth_utilization_summary,
    build_inferred_physical_axi_transactions,
)
from hls_memory_analysis.transaction_dependencies import (
    build_transaction_dependency_graph_from_logical,
)
from hls_memory_analysis.transaction_timeline import (
    annotate_transaction_timing,
    build_summary,
    element_tsv_rows,
    parse_csynth_xml,
    render_html,
    transaction_tsv_rows,
)


def parse_args():
    parser = argparse.ArgumentParser(
        description="Build trace-first off-chip memory timelines."
    )
    parser.add_argument("--trace", required=True, type=Path)
    parser.add_argument("--manifest", required=True, type=Path)
    parser.add_argument("--report", required=True, type=Path)
    parser.add_argument("--interface-xml", type=Path)
    parser.add_argument("--schedule-xml", nargs="*", type=Path, default=[])
    parser.add_argument("--csynth-xml", nargs="*", type=Path, default=[])
    parser.add_argument("--out-dir", required=True, type=Path)
    parser.add_argument(
        "--emit-rtl-bursts",
        action="store_true",
        help=(
            "deprecated compatibility flag; physical AXI transactions are "
            "inferred without RTL input"
        ),
    )
    return parser.parse_args()


def build_outputs(args):
    args.out_dir.mkdir(parents=True, exist_ok=True)
    report = load_json(args.report)
    trace_rows = read_trace(args.trace)
    manifest_rows = read_tsv(args.manifest)
    interfaces = parse_interfaces(args.interface_xml)
    csynth = parse_csynth_xml(args.csynth_xml)
    merge_csynth_interfaces(interfaces, csynth)
    schedules = parse_schedule_xml(
        args.schedule_xml, schedule_identifiers(report)
    )

    events = build_trace_events(
        trace_rows, manifest_rows, report, interfaces, schedules
    )
    physical = build_inferred_physical_axi_transactions(
        report, events, interfaces
    )
    transactions = physical["axi_transactions"]
    logical_graph = build_logical_access_graph(report, events)
    dependency_graph = build_transaction_dependency_graph_from_logical(
        report, transactions, logical_graph, csynth
    )
    annotate_transaction_timing(transactions, dependency_graph, csynth)
    transactions.sort(
        key=lambda transaction: (
            parse_int(transaction.get("issue_order"), 0),
            parse_int(transaction.get("complete_order"), 0),
            transaction.get("transaction_id", ""),
        )
    )

    summary = build_summary(
        report, events, transactions, dependency_graph, interfaces, csynth
    )
    summary["inputs"].update(
        {
            "trace": str(args.trace),
            "manifest": str(args.manifest),
            "memory_access_report": str(args.report),
            "interface_xml": (
                str(args.interface_xml) if args.interface_xml else None
            ),
            "schedule_xml": [str(path) for path in args.schedule_xml],
        }
    )
    summary["counts"].update(
        {
            "logical_dependency_edges": logical_graph["counts"]["dependencies"],
            "ports_with_hls_schedule": len(schedules),
        }
    )

    write_json(args.out_dir / "summary.json", summary)
    write_tsv(
        args.out_dir / "element_timeline.tsv",
        element_tsv_rows(events, logical_graph),
    )
    write_json(args.out_dir / "logical_access_graph.json", logical_graph)
    write_tsv(
        args.out_dir / "transactions.tsv",
        transaction_tsv_rows(transactions),
    )
    write_json(
        args.out_dir / "transaction_dependency_graph.json", dependency_graph
    )
    write_json(
        args.out_dir / "inferred_physical_axi_transactions.json", physical
    )
    write_json(
        args.out_dir / "bandwidth_utilization_summary.json",
        build_bandwidth_utilization_summary(transactions),
    )
    render_html(
        args.out_dir / "transaction_timeline.html",
        transactions,
        dependency_graph,
        report.get("function", "HLS transaction timeline"),
    )
    stale_rtl_output = args.out_dir / "rtl_burst_transactions.json"
    if stale_rtl_output.exists():
        stale_rtl_output.unlink()

    return len(trace_rows), len(events), len(transactions)


def main():
    args = parse_args()
    trace_count, event_count, transaction_count = build_outputs(args)
    print(f"trace events: {trace_count}")
    print(f"inferred physical AXI transactions: {transaction_count}")
    print(f"element events: {event_count}")
    print(f"outputs: {args.out_dir}")


if __name__ == "__main__":
    main()
