#!/usr/bin/env python3
import copy
import importlib.util
import sys
from pathlib import Path


def load_builder():
    path = Path(__file__).resolve().with_name("build_trace_memory_timeline.py")
    spec = importlib.util.spec_from_file_location("build_trace_memory_timeline", path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def existing_path(*candidates):
    for path in candidates:
        if path.exists():
            return path
    raise FileNotFoundError("none of these paths exist: " + ", ".join(map(str, candidates)))


def first_b_transaction(builder, report, trace_rows, manifest_rows, interfaces):
    events = builder.build_trace_events(
        trace_rows,
        manifest_rows,
        report,
        interfaces,
        schedules={},
    )
    physical = builder.build_inferred_physical_axi_transactions(
        report,
        events,
        interfaces,
    )
    for transaction in physical["axi_transactions"]:
        if transaction.get("port") == "b":
            return transaction
    raise AssertionError("no B-port transaction found")


def check_case(name, transaction, *, arlen, arsize, length, useful_elements):
    actual = {
        "arlen": transaction["axi"]["arlen_or_awlen"],
        "arsize": transaction["axi"]["address_size_log2_bytes"],
        "length": transaction["physical_length_bytes"],
        "useful_elements": transaction["element_count"],
    }
    expected = {
        "arlen": arlen,
        "arsize": arsize,
        "length": length,
        "useful_elements": useful_elements,
    }
    if actual != expected:
        raise AssertionError(f"{name}: expected {expected}, got {actual}")
    print(f"{name}: ok {actual}")


def main():
    builder = load_builder()
    root = Path(__file__).resolve().parents[2]
    project = "matrix_mul_row_col_hls"
    trace_root = existing_path(
        root / "Results" / "trace-timeline" / project,
    )
    static_root = existing_path(
        root / "Results" / "pass-reports" / project,
    )
    interface_xml = existing_path(
        root
        / "toy-test-cases"
        / project
        / "component_matmul_row_col"
        / "hls"
        / ".autopilot"
        / "db"
        / "top-io-fe.xml"
    )

    report = builder.load_json(static_root / "memory_access_report.json")
    trace_rows = builder.read_trace(trace_root / "top_level_memory_trace.tsv")
    manifest_rows = builder.read_tsv(trace_root / "top_level_memory_sites.tsv")
    base_interfaces = builder.parse_interfaces(interface_xml)

    cases = [
        (
            "case_a_maxburst1_widen512",
            {"final_bitwidth": "512", "max_widen_bitwidth": "512", "hw_bitwidth": "512", "max_read_burst_length": "1"},
            {"arlen": 0, "arsize": 6, "length": 64, "useful_elements": 1},
        ),
        (
            "case_b_maxburst16_widen512",
            {"final_bitwidth": "512", "max_widen_bitwidth": "512", "hw_bitwidth": "512", "max_read_burst_length": "16"},
            {"arlen": 15, "arsize": 6, "length": 1024, "useful_elements": 16},
        ),
        (
            "case_c_maxburst16_widen32",
            {"final_bitwidth": "32", "max_widen_bitwidth": "32", "hw_bitwidth": "32", "max_read_burst_length": "16"},
            {"arlen": 0, "arsize": 2, "length": 4, "useful_elements": 1},
        ),
    ]

    for name, overrides, expected in cases:
        interfaces = copy.deepcopy(base_interfaces)
        interfaces.setdefault("b", {}).update(overrides)
        transaction = first_b_transaction(
            builder,
            report,
            trace_rows,
            manifest_rows,
            interfaces,
        )
        check_case(name, transaction, **expected)


if __name__ == "__main__":
    main()
