#!/usr/bin/env python3
import importlib.util
import sys
import unittest
from pathlib import Path


TOOLS = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(TOOLS / "src"))
SPEC = importlib.util.spec_from_file_location(
    "build_trace_memory_timeline",
    TOOLS / "run" / "build_trace_memory_timeline.py",
)
BUILDER = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BUILDER)

from hls_memory_analysis.transaction_timeline import (
    annotate_transaction_timing,
    dependency_sources,
)


class TransactionTimelineGoldenTest(unittest.TestCase):
    def test_sequential_128_bit_axi_four_beat_bursts(self):
        report = {
            "function": "example",
            "m_axi_ports": [
                {"name": "a", "bundle": "gmem"},
                {"name": "b", "bundle": "gmem"},
            ],
            "off_chip_accesses": [
                {
                    "id": "access:0",
                    "type": "READ",
                    "port": "a",
                    "bundle": "gmem",
                    "pattern": "sequential",
                    "burst_candidate": True,
                },
                {
                    "id": "access:1",
                    "type": "WRITE",
                    "port": "b",
                    "bundle": "gmem",
                    "pattern": "sequential",
                    "burst_candidate": True,
                },
            ],
            "local_accesses": [],
            "dependency_edges": [
                {
                    "source_id": "access:0",
                    "target_id": "access:1",
                    "kind": "llvm_def_use",
                    "via": "ssa_value",
                    "reason": "stored value depends on the source read",
                }
            ],
        }
        interfaces = {
            "a": {
                "bundle": "gmem",
                "final_bitwidth": "128",
                "max_read_burst_length": "4",
            },
            "b": {
                "bundle": "gmem",
                "final_bitwidth": "128",
                "max_write_burst_length": "4",
            },
        }
        events = []
        for index in range(64):
            events.extend(
                [
                    {
                        "trace_event_index": index * 2,
                        "access_site": "access:0",
                        "port": "a",
                        "bundle": "gmem",
                        "direction": "read",
                        "element_index": index,
                        "offset_bytes": index * 4,
                        "bytes": 4,
                    },
                    {
                        "trace_event_index": index * 2 + 1,
                        "access_site": "access:1",
                        "port": "b",
                        "bundle": "gmem",
                        "direction": "write",
                        "element_index": index,
                        "offset_bytes": index * 4,
                        "bytes": 4,
                    },
                ]
            )

        physical = BUILDER.build_inferred_physical_axi_transactions(
            report, events, interfaces
        )
        transactions = physical["axi_transactions"]
        logical = BUILDER.build_logical_access_graph(report, events)
        graph = BUILDER.build_transaction_dependency_graph_from_logical(
            report, transactions, logical
        )
        annotate_transaction_timing(
            transactions,
            graph,
            {
                "loops": [
                    {
                        "name": "example_loop",
                        "pipeline_ii": 1,
                        "pipeline_depth": 17,
                        "pipeline_type": "yes",
                        "trip_count": 64,
                    }
                ]
            },
        )

        reads = [item for item in transactions if item["direction"] == "read"]
        writes = [item for item in transactions if item["direction"] == "write"]
        self.assertEqual([(item["first_element"], item["last_element"]) for item in reads],
                         [(0, 15), (16, 31), (32, 47), (48, 63)])
        self.assertEqual([(item["first_element"], item["last_element"]) for item in writes],
                         [(0, 15), (16, 31), (32, 47), (48, 63)])
        self.assertTrue(all(item["axi"]["beat_count"] == 4 for item in transactions))

        sources = dependency_sources(graph)
        self.assertEqual(
            [sources[item["transaction_id"]] for item in writes],
            [[item["transaction_id"]] for item in reads],
        )
        self.assertEqual([item["issue_order"] for item in reads], [0, 1, 2, 3])
        self.assertTrue(
            all(
                write["issue_order"] > read["complete_order"]
                for read, write in zip(reads, writes)
            )
        )
        self.assertTrue(
            all(
                right["issue_order"] - left["issue_order"] >= 16
                for left, right in zip(writes, writes[1:])
            )
        )
        self.assertEqual(
            writes[0]["timing_model"]["burst_formation_cycles"], 16
        )


if __name__ == "__main__":
    unittest.main()
