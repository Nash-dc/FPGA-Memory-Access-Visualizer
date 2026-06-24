#!/usr/bin/env python3
import math
from collections import defaultdict

from .common import (
    access_sites_by_id,
    align_down,
    event_element_label,
    event_sort_key,
    make_transaction_id,
    parse_int,
    transaction_sort_key,
)


def _max_burst_beats(port, direction, interfaces, default=256):
    attrs = interfaces.get(port, {})
    key = (
        "max_read_burst_length"
        if direction == "read"
        else "max_write_burst_length"
    )
    parsed = parse_int(attrs.get(key))
    return parsed if parsed and parsed > 0 else default


def _axi_data_width_bits(port, interfaces):
    attrs = interfaces.get(port, {})
    for key in ("final_bitwidth", "max_widen_bitwidth", "hw_bitwidth", "orig_bitwidth"):
        value = parse_int(attrs.get(key))
        if value and value > 0:
            return value
    return None


def _axi_size_log2(beat_bytes):
    if not beat_bytes or beat_bytes <= 0:
        return ""
    return int(math.log2(beat_bytes)) if beat_bytes & (beat_bytes - 1) == 0 else ""


def _axi_range_burst_count(offset, length, max_depth=16):
    if length <= 0:
        return 0
    count = ((offset + length - 1) // 4096) - (offset // 4096) + 1
    return min(count, max_depth)


def _event_beat_start(event, beat_bytes):
    return align_down(parse_int(event.get("offset_bytes"), 0), beat_bytes)


def _can_coalesce(current, event):
    if (
        current["port"] != event["port"]
        or current["direction"] != event["direction"]
    ):
        return False
    event_offset = parse_int(event.get("offset_bytes"))
    last_offset = parse_int(current.get("last_offset_bytes"))
    beat_bytes = parse_int(current["axi"].get("beat_bytes"), 1)
    max_beats = parse_int(current["burst"].get("max_length_beats"), 1)
    physical_start = parse_int(current.get("physical_start_offset_bytes"), 0)
    beat_count = parse_int(current["axi"].get("beat_count"), 1)
    if event_offset is None or last_offset is None or event_offset <= last_offset:
        return False
    event_beat = _event_beat_start(event, beat_bytes)
    current_end = physical_start + beat_count * beat_bytes
    return (
        physical_start <= event_offset < current_end
        or event_beat == current_end
        and beat_count < max_beats
    )


def _new_transaction(seed, burst_id, interfaces, access_site):
    element_bytes = parse_int(seed.get("bytes"), 1)
    attrs = interfaces.get(seed["port"], {})
    width_bits = _axi_data_width_bits(seed["port"], interfaces)
    beat_bytes = width_bits // 8 if width_bits else element_bytes
    elements_per_beat = max(1, beat_bytes // element_bytes)
    max_length = _max_burst_beats(
        seed["port"], seed["direction"], interfaces
    )
    offset = parse_int(seed.get("offset_bytes"), 0)
    physical_start = align_down(offset, beat_bytes)
    return {
        "transaction_id": f"pending:{burst_id}",
        "access_site": seed.get("access_site", ""),
        "access_sites": [seed.get("access_site", "")],
        "port": seed.get("port", ""),
        "bundle": seed.get("bundle", ""),
        "direction": seed.get("direction", ""),
        "loop": seed.get("loop", ""),
        "static_pattern": seed.get("static_pattern", ""),
        "first_trace_event_index": seed.get("trace_event_index", ""),
        "last_trace_event_index": seed.get("trace_event_index", ""),
        "first_element": seed.get("element_index", ""),
        "last_element": seed.get("element_index", ""),
        "element_count": 0,
        "elements": [],
        "covered_trace_event_indices": [],
        "first_offset_bytes": seed.get("offset_bytes", ""),
        "last_offset_bytes": seed.get("offset_bytes", ""),
        "bytes_per_element": element_bytes,
        "physical_start_offset_bytes": physical_start,
        "physical_end_offset_bytes": physical_start + beat_bytes,
        "physical_length_bytes": beat_bytes,
        "useful_bytes": 0,
        "unused_bytes": beat_bytes,
        "bandwidth_utilization": 0.0,
        "inference_model": {
            "source": (
                "HLS interface metadata, static access pattern, and dynamic LLVM "
                "IR logical memory trace; no RTL simulation or waveform input"
            ),
            "beat_alignment": "floor(offset / beat_bytes) * beat_bytes",
            "coalescing_rule": (
                "compatible access sites, same port/direction, increasing logical "
                "offsets, same physical beat or next consecutive AXI beat, "
                "bounded by max_read/write_burst_length"
            ),
        },
        "lightningsim_model": {
            "request_increment_bytes": beat_bytes,
            "request_count": 0,
            "request_range": {"offset": physical_start, "length": beat_bytes},
            "rctl_burst_count": 1,
            "max_rctl_depth": 16,
        },
        "axi": {
            "data_width_bits": width_bits or "",
            "beat_bytes": beat_bytes,
            "beat_count": 1,
            "source_elements_per_beat": elements_per_beat,
            "address_size_log2_bytes": _axi_size_log2(beat_bytes),
            "arlen_or_awlen": 0,
        },
        "interface": {
            "num_read_outstanding": parse_int(attrs.get("num_read_outstanding")),
            "num_write_outstanding": parse_int(attrs.get("num_write_outstanding")),
            "max_read_burst_length": parse_int(attrs.get("max_read_burst_length")),
            "max_write_burst_length": parse_int(attrs.get("max_write_burst_length")),
        },
        "burst": {
            "kind": "single",
            "length_beats": 1,
            "max_length_beats": max_length,
            "max_source_elements": max_length * elements_per_beat,
        },
        "coalescing_reason": (
            "inferred from HLS M_AXI width/burst metadata and IR trace offsets"
        ),
        "confidence": (
            "hls_metadata_plus_ir_trace"
            if access_site.get("burst_candidate")
            else "hls_metadata_plus_ir_trace_conservative"
        ),
    }


def _refresh(transaction):
    beat_bytes = parse_int(transaction["axi"].get("beat_bytes"), 1)
    physical_start = parse_int(transaction.get("physical_start_offset_bytes"), 0)
    beat_starts = {
        align_down(parse_int(offset, 0), beat_bytes)
        for offset in transaction.get("_logical_offsets", [])
    }
    beat_count = max(1, len(beat_starts))
    physical_length = beat_count * beat_bytes
    useful_bytes = transaction["element_count"] * parse_int(
        transaction.get("bytes_per_element"), 1
    )
    transaction.update(
        {
            "physical_end_offset_bytes": physical_start + physical_length,
            "physical_length_bytes": physical_length,
            "useful_bytes": useful_bytes,
            "unused_bytes": max(0, physical_length - useful_bytes),
            "bandwidth_utilization": (
                round(useful_bytes / physical_length, 6)
                if physical_length
                else 0.0
            ),
        }
    )
    transaction["axi"]["beat_count"] = beat_count
    transaction["axi"]["arlen_or_awlen"] = beat_count - 1
    transaction["burst"]["length_beats"] = beat_count
    transaction["burst"]["kind"] = (
        "axi_burst"
        if beat_count > 1
        else "widened_single_beat"
        if transaction["element_count"] > 1
        else "single_element"
    )
    model = transaction["lightningsim_model"]
    model["request_count"] = beat_count
    model["request_range"] = {
        "offset": physical_start,
        "length": physical_length,
    }
    model["rctl_burst_count"] = _axi_range_burst_count(
        physical_start, physical_length
    )


def _add_event(transaction, event):
    transaction["last_trace_event_index"] = event.get("trace_event_index", "")
    transaction["last_element"] = event.get("element_index", "")
    transaction["last_offset_bytes"] = event.get("offset_bytes", "")
    transaction["element_count"] += 1
    transaction["elements"].append(event_element_label(event))
    transaction["covered_trace_event_indices"].append(
        event.get("trace_event_index", "")
    )
    access_site = event.get("access_site", "")
    if access_site and access_site not in transaction["access_sites"]:
        transaction["access_sites"].append(access_site)
    transaction.setdefault("_logical_offsets", []).append(
        event.get("offset_bytes", 0)
    )
    first = parse_int(transaction.get("first_element"), 0)
    last = parse_int(transaction.get("last_element"), first)
    port = transaction.get("port", "")
    transaction["element_range_label"] = (
        f"{port}[{first}]" if first == last else f"{port}[{first}..{last}]"
    )
    _refresh(transaction)


def _finalize(transactions):
    per_port_direction_counts = defaultdict(int)
    for transaction in sorted(transactions, key=transaction_sort_key):
        port = transaction.get("port", "")
        direction = transaction.get("direction", "")
        key = (port, direction)
        transaction["transaction_id"] = make_transaction_id(
            port, per_port_direction_counts[key], direction
        )
        per_port_direction_counts[key] += 1
        transaction.pop("_logical_offsets", None)


def build_inferred_physical_axi_transactions(report, events, interfaces):
    access_by_id = access_sites_by_id(report)
    grouped = defaultdict(list)
    for event in events:
        grouped[(event.get("port", ""), event.get("direction", ""))].append(event)

    transactions = []
    for site_events in (events for _key, events in sorted(grouped.items())):
        current = None
        for event in sorted(site_events, key=event_sort_key):
            access_site = access_by_id.get(event.get("access_site", ""), {})
            if current is None or not _can_coalesce(current, event):
                current = _new_transaction(
                    event, len(transactions), interfaces, access_site
                )
                transactions.append(current)
            _add_event(current, event)

    transactions.sort(key=transaction_sort_key)
    _finalize(transactions)
    by_trace_event = {
        trace_index: transaction["transaction_id"]
        for transaction in transactions
        for trace_index in transaction["covered_trace_event_indices"]
    }
    for event in events:
        event["transaction_id"] = by_trace_event.get(
            event.get("trace_event_index"), ""
        )
    return {
        "schema": "hls.inferred_physical_axi_transactions.v1",
        "source": (
            "Inferred physical AXI transactions from static HLS metadata and "
            "dynamic LLVM IR logical accesses; RTL simulation/waveforms are not "
            "used as input"
        ),
        "counts": {
            "axi_transactions": len(transactions),
            "skipped_access_sites": 0,
        },
        "axi_transactions": transactions,
        "skipped_access_sites": [],
    }


def build_bandwidth_utilization_summary(transactions):
    fields = {
        "transaction_count": 0,
        "logical_element_count": 0,
        "useful_bytes": 0,
        "transferred_bytes": 0,
        "unused_bytes": 0,
        "read_transactions": 0,
        "write_transactions": 0,
    }
    by_port = defaultdict(lambda: dict(fields))
    total = dict(fields)
    for transaction in transactions:
        entry = by_port[transaction.get("port", "")]
        transferred = parse_int(transaction.get("physical_length_bytes"), 0)
        useful = parse_int(transaction.get("useful_bytes"), 0)
        unused = parse_int(
            transaction.get("unused_bytes"), max(0, transferred - useful)
        )
        for target in (entry, total):
            target["transaction_count"] += 1
            target["logical_element_count"] += parse_int(
                transaction.get("element_count"), 0
            )
            target["useful_bytes"] += useful
            target["transferred_bytes"] += transferred
            target["unused_bytes"] += unused
        direction_key = f"{transaction.get('direction')}_transactions"
        entry[direction_key] += 1
        total[direction_key] += 1
    for entry in list(by_port.values()) + [total]:
        entry["bandwidth_utilization"] = (
            round(entry["useful_bytes"] / entry["transferred_bytes"], 6)
            if entry["transferred_bytes"]
            else 0.0
        )
    return {
        "schema": "hls.bandwidth_utilization_summary.v1",
        "source": "inferred_physical_axi_transactions",
        "total": total,
        "ports": dict(sorted(by_port.items())),
    }
