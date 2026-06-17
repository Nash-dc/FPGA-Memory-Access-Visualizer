#!/usr/bin/env python3
import re
from collections import defaultdict, deque

from .common import parse_int, transaction_sort_key
from .logical_access import access_metadata


def _append_unique(dependencies, dependency):
    if dependency not in dependencies:
        dependencies.append(dependency)
        return True
    return False


def _compact_ranges(indices):
    sorted_indices = sorted(set(indices))
    if not sorted_indices:
        return []
    ranges = []
    start = previous = sorted_indices[0]
    for index in sorted_indices[1:]:
        if index == previous + 1:
            previous = index
            continue
        ranges.append((start, previous))
        start = previous = index
    ranges.append((start, previous))
    return ranges


def _compact_element_labels(labels):
    grouped = defaultdict(list)
    passthrough = []
    for label in labels:
        match = re.match(r"^(.+)\[(-?\d+)\]$", str(label))
        if match:
            grouped[match.group(1)].append(parse_int(match.group(2), 0))
        else:
            passthrough.append(label)
    result = []
    for port in sorted(grouped):
        for first, last in _compact_ranges(grouped[port]):
            result.append(
                f"{port}[{first}]"
                if first == last
                else f"{port}[{first}..{last}]"
            )
    result.extend(list(dict.fromkeys(passthrough)))
    return result


def _transaction_ordinal(transaction):
    txn_id = str(transaction.get("transaction_id", ""))
    match = re.search(r"_(\d+)$", txn_id)
    if match:
        return parse_int(match.group(1), 0)
    return parse_int(transaction.get("first_trace_event_index"), 0)


def _append_stream_channel_dependencies(blocks_by_id, ordered):
    """Infer local producer-consumer edges for DATAFLOW-style stream pipelines.

    HLS reports expose dataflow and FIFO processes, but they do not always map
    FIFO instances back to LLVM memory transactions. The conservative fallback
    here pairs read/write bursts on the same top-level port by their local burst
    ordinal. That models a process-local stream token dependency without adding
    a false full-process barrier.
    """
    reads_by_port = defaultdict(list)
    writes_by_port = defaultdict(list)
    for transaction in ordered:
        port = transaction.get("port", "")
        direction = transaction.get("direction", "")
        if not port:
            continue
        if direction == "read":
            reads_by_port[port].append(transaction)
        elif direction == "write":
            writes_by_port[port].append(transaction)

    added = 0
    for port, writes in writes_by_port.items():
        reads = sorted(reads_by_port.get(port, []), key=_transaction_ordinal)
        if not reads:
            continue
        for index, write in enumerate(sorted(writes, key=_transaction_ordinal)):
            if index >= len(reads):
                break
            read = reads[index]
            source_txn = read.get("transaction_id", "")
            target_txn = write.get("transaction_id", "")
            if (
                not source_txn
                or not target_txn
                or source_txn == target_txn
                or target_txn not in blocks_by_id
            ):
                continue
            dependency = {
                "source_transaction_id": source_txn,
                "kind": "stream_channel",
                "via": f"{port}_stream",
                "source_access_id": read.get("access_site", ""),
                "target_access_id": write.get("access_site", ""),
                "source_element_ranges": [
                    read.get("element_range_label", "")
                ],
                "target_element_ranges": [
                    write.get("element_range_label", "")
                ],
                "logical_edge_count": 0,
                "logical_source_count": 0,
                "logical_target_count": 0,
                "reason": (
                    "DATAFLOW producer-consumer FIFO token block; matched "
                    "by port and local transaction ordinal"
                ),
                "port": port,
                "channel": f"{port}_stream",
            }
            if _append_unique(
                blocks_by_id[target_txn]["dependencies"], dependency
            ):
                added += 1
    return added


def _access_by_id(report):
    return {
        access.get("id", ""): access
        for access in report.get("off_chip_accesses", [])
        if access.get("id")
    }


def _local_access_by_id(report):
    return {
        access.get("id", ""): access
        for access in report.get("local_accesses", [])
        if access.get("id")
    }


def _dependency_adjacency(report):
    adjacency = defaultdict(list)
    for edge in report.get("dependency_edges", []):
        source = edge.get("source_id", "")
        target = edge.get("target_id", "")
        if source and target:
            adjacency[source].append((target, edge))
    return adjacency


def _same_loop_index(source, target):
    return (
        bool(source.get("loop"))
        and source.get("loop") == target.get("loop")
        and bool(source.get("index"))
        and source.get("index") == target.get("index")
    )


def _dedupe_shortest_barrier_paths(pairs):
    shortest = {}
    for pair in pairs:
        key = (pair["source_access_id"], pair["target_access_id"])
        current = shortest.get(key)
        if current is None or len(pair["path_edge_ids"]) < len(
            current["path_edge_ids"]
        ):
            shortest[key] = pair
    return list(shortest.values())


def _find_local_buffer_barrier_pairs(report, csynth):
    """Find non-DATAFLOW read->local-buffer->write phase barriers.

    DATAFLOW stream channels can overlap at token granularity, so this rule is
    deliberately disabled there. For a single pipelined loop that reads from an
    off-chip port, updates a local array, then writes another off-chip port
    through that same local array, Vitis may materialize the widened AXI bursts
    as a read phase followed by a write phase. The static report exposes this
    as a path through local_access nodes with local_buffer_raw edges.
    """
    if csynth.get("dataflow", {}).get("enabled"):
        return []

    access_nodes = _access_by_id(report)
    local_nodes = _local_access_by_id(report)
    adjacency = _dependency_adjacency(report)
    read_ids = [
        access_id
        for access_id, access in access_nodes.items()
        if str(access.get("type", "")).upper() == "READ"
    ]
    write_ids = {
        access_id
        for access_id, access in access_nodes.items()
        if str(access.get("type", "")).upper() == "WRITE"
    }
    pairs = []
    for read_id in read_ids:
        read_access = access_nodes[read_id]
        queue = deque([(read_id, [], set(), False)])
        visited = set()
        while queue:
            node, path, buffers, saw_local_raw = queue.popleft()
            state = (node, tuple(sorted(buffers)), saw_local_raw)
            if state in visited:
                continue
            visited.add(state)
            for next_node, edge in adjacency.get(node, []):
                next_path = path + [edge]
                next_buffers = set(buffers)
                next_saw_local_raw = saw_local_raw or (
                    edge.get("kind") == "local_buffer_raw"
                )
                if next_node in local_nodes:
                    buffer_name = local_nodes[next_node].get("buffer", "")
                    if buffer_name:
                        next_buffers.add(buffer_name)
                if next_node in write_ids:
                    write_access = access_nodes[next_node]
                    if (
                        _same_loop_index(read_access, write_access)
                        and next_buffers
                        and next_saw_local_raw
                    ):
                        pairs.append(
                            {
                                "source_access_id": read_id,
                                "target_access_id": next_node,
                                "buffers": sorted(next_buffers),
                                "path_edge_ids": [
                                    item.get("id", "") for item in next_path
                                ],
                            }
                        )
                    continue
                if next_node.startswith("local_access:"):
                    queue.append(
                        (
                            next_node,
                            next_path,
                            next_buffers,
                            next_saw_local_raw,
                        )
                    )
    return _dedupe_shortest_barrier_paths(pairs)


def _append_local_buffer_barrier_dependencies(
    blocks_by_id, ordered, report, csynth
):
    pairs = _find_local_buffer_barrier_pairs(report, csynth)
    if not pairs:
        return 0

    transactions_by_access = defaultdict(list)
    for transaction in ordered:
        access_site = transaction.get("access_site", "")
        if access_site:
            transactions_by_access[access_site].append(transaction)

    added = 0
    for pair in pairs:
        producer_txns = sorted(
            transactions_by_access.get(pair["source_access_id"], []),
            key=transaction_sort_key,
        )
        consumer_txns = sorted(
            transactions_by_access.get(pair["target_access_id"], []),
            key=transaction_sort_key,
        )
        if not producer_txns or not consumer_txns:
            continue
        group_tail = producer_txns[-1]
        source_txn = group_tail.get("transaction_id", "")
        if not source_txn:
            continue
        for consumer in consumer_txns:
            target_txn = consumer.get("transaction_id", "")
            if (
                not target_txn
                or target_txn == source_txn
                or target_txn not in blocks_by_id
            ):
                continue
            dependency = {
                "source_transaction_id": source_txn,
                "kind": "local_buffer_barrier",
                "via": ",".join(pair["buffers"]),
                "source_access_id": pair["source_access_id"],
                "target_access_id": pair["target_access_id"],
                "source_element_ranges": [
                    item.get("element_range_label", "")
                    for item in producer_txns
                    if item.get("element_range_label")
                ],
                "target_element_ranges": [
                    consumer.get("element_range_label", "")
                ],
                "logical_edge_count": 0,
                "logical_source_count": len(producer_txns),
                "logical_target_count": 1,
                "reason": (
                    "non-DATAFLOW local-buffer phase barrier: widened write "
                    "transactions wait for the producer read transaction group "
                    "that feeds the local buffer"
                ),
                "path_edge_ids": pair["path_edge_ids"],
            }
            if _append_unique(
                blocks_by_id[target_txn]["dependencies"], dependency
            ):
                added += 1
    return added


def build_transaction_dependency_graph_from_logical(
    report, transactions, logical_graph, csynth=None
):
    csynth = csynth or {}
    metadata = access_metadata(report)
    ordered = sorted(transactions, key=transaction_sort_key)
    blocks_by_id = {
        transaction["transaction_id"]: {
            "transaction_id": transaction["transaction_id"],
            "dependencies": [],
        }
        for transaction in ordered
    }
    edge_counts = defaultdict(int)
    grouped_edges = defaultdict(
        lambda: {
            "source_elements": [],
            "target_elements": [],
            "source_logical_access_ids": [],
            "target_logical_access_ids": [],
            "reasons": [],
            "port": "",
        }
    )

    for edge in logical_graph.get("dependencies", []):
        source_txn = edge.get("source_transaction_id", "")
        target_txn = edge.get("target_transaction_id", "")
        if (
            not source_txn
            or not target_txn
            or source_txn == target_txn
            or source_txn not in blocks_by_id
            or target_txn not in blocks_by_id
        ):
            continue
        key = (
            target_txn,
            source_txn,
            edge.get("kind", ""),
            edge.get("via", ""),
            edge.get("source_access_id", ""),
            edge.get("target_access_id", ""),
        )
        grouped = grouped_edges[key]
        grouped["port"] = edge.get("port", grouped["port"])
        for source_key, target_key in (
            ("source_element", "source_elements"),
            ("target_element", "target_elements"),
            ("source_logical_access_id", "source_logical_access_ids"),
            ("target_logical_access_id", "target_logical_access_ids"),
            ("reason", "reasons"),
        ):
            if edge.get(source_key):
                grouped[target_key].append(edge[source_key])
        edge_counts[edge.get("kind", "")] += 1

    for key, grouped in grouped_edges.items():
        (
            target_txn,
            source_txn,
            kind,
            via,
            source_access_id,
            target_access_id,
        ) = key
        source_ranges = _compact_element_labels(grouped["source_elements"])
        target_ranges = _compact_element_labels(grouped["target_elements"])
        dependency = {
            "source_transaction_id": source_txn,
            "kind": kind,
            "via": via,
            "source_access_id": source_access_id,
            "target_access_id": target_access_id,
            "source_element_ranges": source_ranges,
            "target_element_ranges": target_ranges,
            "logical_edge_count": len(
                set(grouped["target_logical_access_ids"])
            ),
            "logical_source_count": len(
                set(grouped["source_logical_access_ids"])
            ),
            "logical_target_count": len(
                set(grouped["target_logical_access_ids"])
            ),
            "reason": next(iter(dict.fromkeys(grouped["reasons"])), ""),
        }
        if kind == "dynamic_memory_raw":
            dependency["port"] = grouped["port"]
            dependency["overlap_element_ranges"] = target_ranges
        elif kind == "control_dependency":
            dependency["condition_operation"] = "branch_condition"
            dependency["condition_role"] = "comparison_operand_or_condition_value"
        _append_unique(blocks_by_id[target_txn]["dependencies"], dependency)

    stream_channel_edges = 0
    if csynth.get("dataflow", {}).get("enabled"):
        stream_channel_edges = _append_stream_channel_dependencies(
            blocks_by_id, ordered
        )
    local_buffer_barrier_edges = _append_local_buffer_barrier_dependencies(
        blocks_by_id, ordered, report, csynth
    )

    blocks = [blocks_by_id[item["transaction_id"]] for item in ordered]
    return {
        "schema": "hls.transaction_dependency_graph.v10",
        "dependency_source": (
            "Physical transaction dependencies aggregated from the dynamic "
            "logical access graph. Logical graph edges combine LLVM static "
            "value/control metadata with actual IR trace execution and dynamic "
            "same port[element] RAW tracking. DATAFLOW stream-channel edges "
            "model local producer-consumer token availability without a "
            "full-process barrier. Non-DATAFLOW local-buffer barrier edges "
            "model widened producer-read groups that must complete before "
            "consumer write bursts are issued through the same local buffer."
        ),
        "detail_files": {
            "physical_transactions": "inferred_physical_axi_transactions.json",
            "logical_access_graph": "logical_access_graph.json",
        },
        "counts": {
            "blocks": len(blocks),
            "static_dependency_edges": len(report.get("dependency_edges", [])),
            "logical_dependency_edges": len(logical_graph.get("dependencies", [])),
            "dynamic_memory_raw_edges": edge_counts.get("dynamic_memory_raw", 0),
            "stream_channel_edges": stream_channel_edges,
            "local_buffer_barrier_edges": local_buffer_barrier_edges,
            "value_flow_edges": sum(
                count
                for kind, count in edge_counts.items()
                if kind not in ("dynamic_memory_raw", "control_dependency")
            ),
            "control_dependency_edges": edge_counts.get("control_dependency", 0),
        },
        "blocks": blocks,
        "static_nodes": metadata,
        "static_dependency_edges": report.get("dependency_edges", []),
    }
