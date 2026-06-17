#!/usr/bin/env python3
import re


def parse_int(value, default=None):
    try:
        return int(value)
    except (TypeError, ValueError):
        return default


def align_down(value, alignment):
    if not alignment:
        return value
    return (value // alignment) * alignment


def make_transaction_id(port, index, direction=""):
    clean = re.sub(r"[^0-9A-Za-z_]+", "_", str(port)).strip("_")
    clean_direction = re.sub(r"[^0-9A-Za-z_]+", "_", str(direction)).strip("_")
    parts = ["txn"]
    if clean:
        parts.append(clean)
    if clean_direction:
        parts.append(clean_direction)
    parts.append(str(index))
    return "_".join(parts)


def access_sites_by_id(report):
    return {site.get("id", ""): site for site in report.get("off_chip_accesses", [])}


def event_sort_key(event):
    return parse_int(event.get("trace_event_index"), 0)


def event_element_label(event):
    return f"{event.get('port', '')}[{event.get('element_index', '')}]"


def transaction_sort_key(transaction):
    return (
        parse_int(transaction.get("first_trace_event_index"), 0),
        parse_int(transaction.get("last_trace_event_index"), 0),
        str(transaction.get("transaction_id", "")),
    )
