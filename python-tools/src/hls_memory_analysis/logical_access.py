#!/usr/bin/env python3
from collections import defaultdict

from .common import event_element_label, event_sort_key, parse_int


def access_metadata(report):
    metadata = {}
    for access in report.get("off_chip_accesses", []):
        metadata[access.get("id", "")] = {
            "id": access.get("id", ""),
            "kind": "transaction",
            "direction": str(access.get("type", "")).lower(),
            "port": access.get("port", ""),
            "bundle": access.get("bundle", ""),
            "index": access.get("index", ""),
            "loop": access.get("loop", ""),
        }
    for access in report.get("local_accesses", []):
        metadata[access.get("id", "")] = {
            "id": access.get("id", ""),
            "kind": "local_buffer_access",
            "direction": str(access.get("type", "")).lower(),
            "buffer": access.get("buffer", ""),
            "index": access.get("index", ""),
            "operation": access.get("operation", ""),
            "loop": access.get("loop", ""),
        }
    return metadata


def _incoming_static_edges(report):
    incoming = defaultdict(list)
    for edge in report.get("dependency_edges", []):
        incoming[edge.get("target_id", "")].append(edge)
    return incoming


def _static_upstream_accesses(node_id, incoming, metadata, seen=None):
    seen = set() if seen is None else seen
    if node_id in seen:
        return []
    seen.add(node_id)
    if metadata.get(node_id, {}).get("kind") == "transaction":
        return [node_id]
    result = []
    for edge in incoming.get(node_id, []):
        result.extend(
            _static_upstream_accesses(
                edge.get("source_id", ""), incoming, metadata, seen
            )
        )
    return list(dict.fromkeys(result))


def _latest_logical_source(source_access_id, target_trace_index, events_by_site):
    for event in reversed(events_by_site.get(source_access_id, [])):
        if parse_int(event.get("trace_event_index"), -1) < target_trace_index:
            return event
    return None


def _dependency_from_event(source_event, target_event, edge):
    return {
        "source_logical_access_id": source_event["logical_access_id"],
        "target_logical_access_id": target_event["logical_access_id"],
        "source_transaction_id": source_event.get("transaction_id", ""),
        "target_transaction_id": target_event.get("transaction_id", ""),
        "kind": edge.get("kind", ""),
        "via": edge.get("via", ""),
        "source_access_id": source_event.get("access_site", ""),
        "target_access_id": target_event.get("access_site", ""),
        "source_element": event_element_label(source_event),
        "target_element": event_element_label(target_event),
        "reason": edge.get("reason", ""),
    }


def build_logical_access_graph(report, events):
    metadata = access_metadata(report)
    incoming = _incoming_static_edges(report)
    events_by_site = defaultdict(list)
    for event in events:
        event["logical_access_id"] = f"la:{event['trace_event_index']}"
        events_by_site[event.get("access_site", "")].append(event)

    nodes = []
    edges = []
    last_write_by_element = defaultdict(dict)
    edge_counts = defaultdict(int)

    for event in sorted(events, key=event_sort_key):
        nodes.append(
            {
                "logical_access_id": event["logical_access_id"],
                "trace_event_index": event.get("trace_event_index", ""),
                "transaction_id": event.get("transaction_id", ""),
                "access_site": event.get("access_site", ""),
                "port": event.get("port", ""),
                "bundle": event.get("bundle", ""),
                "direction": event.get("direction", ""),
                "element_index": event.get("element_index", ""),
                "element": event_element_label(event),
                "offset_bytes": event.get("offset_bytes", ""),
                "bytes": event.get("bytes", ""),
                "function": event.get("function", ""),
                "basic_block": event.get("basic_block", ""),
                "loop": event.get("loop", ""),
                "source_instruction": event.get("source_instruction", ""),
                "timeline_source": "dynamic_ir_trace_logical_access",
            }
        )

        if event.get("direction") == "read":
            source_event = last_write_by_element[event.get("port", "")].get(
                event.get("element_index")
            )
            if source_event:
                dependency = {
                    "source_logical_access_id": source_event["logical_access_id"],
                    "target_logical_access_id": event["logical_access_id"],
                    "source_transaction_id": source_event.get("transaction_id", ""),
                    "target_transaction_id": event.get("transaction_id", ""),
                    "kind": "dynamic_memory_raw",
                    "port": event.get("port", ""),
                    "overlap_element_ranges": [event_element_label(event)],
                    "source_element": event_element_label(source_event),
                    "target_element": event_element_label(event),
                    "reason": (
                        "latest prior write to the same port[element] in the "
                        "dynamic IR trace"
                    ),
                }
                edges.append(dependency)
                edge_counts[dependency["kind"]] += 1

        target_trace_index = parse_int(event.get("trace_event_index"), 0)
        for static_edge in incoming.get(event.get("access_site", ""), []):
            source_id = static_edge.get("source_id", "")
            source = metadata.get(source_id, {})
            source_access_ids = (
                [source_id]
                if source.get("kind") == "transaction"
                else _static_upstream_accesses(
                    source_id, incoming, metadata
                )
            )
            for source_access_id in source_access_ids:
                source_event = _latest_logical_source(
                    source_access_id, target_trace_index, events_by_site
                )
                if source_event:
                    dependency = _dependency_from_event(
                        source_event, event, static_edge
                    )
                    edges.append(dependency)
                    edge_counts[dependency["kind"]] += 1

        if event.get("direction") == "write":
            last_write_by_element[event.get("port", "")][
                event.get("element_index")
            ] = event

    return {
        "schema": "hls.logical_access_graph.v1",
        "source": (
            "Dynamic logical memory access graph from LLVM IR trace, annotated "
            "with static value/control dependency metadata and dynamic RAW edges"
        ),
        "counts": {
            "logical_accesses": len(nodes),
            "dependencies": len(edges),
            "dependency_kinds": dict(sorted(edge_counts.items())),
        },
        "nodes": nodes,
        "dependencies": edges,
        "static_nodes": metadata,
        "static_dependency_edges": report.get("dependency_edges", []),
    }
