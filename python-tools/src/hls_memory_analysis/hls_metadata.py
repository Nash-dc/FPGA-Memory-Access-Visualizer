#!/usr/bin/env python3
import xml.etree.ElementTree as ET
from collections import defaultdict

from .common import access_sites_by_id, parse_int


def parse_interfaces(path):
    interfaces = {}
    if path is None or not path.exists():
        return interfaces
    root = ET.parse(path).getroot()
    for arg in root.iter("arg"):
        name = arg.attrib.get("src_name")
        if not name:
            continue
        for hw in arg.findall("hw"):
            if hw.attrib.get("hw_interface") != "MAXI":
                continue
            merged = {
                "src_bitwidth": arg.attrib.get("src_bitwidth", ""),
                "bundle": hw.attrib.get("hw_name", ""),
                "hw_bitwidth": hw.attrib.get("hw_bitwidth", ""),
            }
            for constraint in hw.findall("constraint"):
                if constraint.attrib.get("mode") == "m_axi":
                    merged.update(constraint.attrib)
            interfaces[name] = merged
    return interfaces


def merge_csynth_interfaces(interfaces, csynth):
    for port, metadata in csynth.get("interfaces", {}).items():
        attrs = interfaces.setdefault(port, {})
        if metadata.get("data_width_bits"):
            attrs["final_bitwidth"] = str(metadata["data_width_bits"])
        for key in (
            "max_read_burst_length",
            "max_write_burst_length",
            "num_read_outstanding",
            "num_write_outstanding",
            "max_widen_bitwidth",
        ):
            if metadata.get(key) is not None:
                attrs[key] = str(metadata[key])


def schedule_identifiers(report):
    identifiers = {}
    for port in report.get("m_axi_ports", []):
        name = port.get("name")
        if not name:
            continue
        values = [port.get("bundle"), f"gmem_{name}"]
        if len(name) > 2:
            values.append(name)
        identifiers[name] = list(dict.fromkeys(value for value in values if value))
    return identifiers


def _operation_text(operation):
    return " ".join((node.text or "").strip() for node in operation.iter("Node"))


def _operation_kind(text, direction):
    lowered = text.lower()
    if "m_axi" not in lowered:
        return None
    if direction == "read":
        if "readreq" in lowered:
            return "read_request"
        if "_op_read.m_axi" in lowered or " read " in lowered:
            return "read_data"
    else:
        if "writereq" in lowered:
            return "write_request"
        if "writeresp" in lowered:
            return "write_response"
        if "_op_write.m_axi" in lowered or " write " in lowered:
            return "write_data"
    return None


def _schedule_record(path, module_name, operation, text, kind):
    return {
        "module": module_name,
        "file": str(path),
        "state": operation.attrib.get("st_id", ""),
        "stage": operation.attrib.get("stage", ""),
        "latency": operation.attrib.get("lat", ""),
        "operation_id": operation.attrib.get("id", ""),
        "operation_kind": kind,
        "operation_text": " ".join(text.split())[:240],
    }


def _record_sort_key(record):
    return (
        parse_int(record.get("state"), 1_000_000),
        parse_int(record.get("stage"), 1_000_000),
        parse_int(record.get("operation_id"), 1_000_000),
    )


def parse_schedule_xml(paths, port_identifiers):
    schedules = defaultdict(lambda: {"request": [], "data": [], "response": []})
    for path in paths or []:
        if path is None or not path.exists():
            continue
        root = ET.parse(path).getroot()
        module_name = root.findtext("name", default=path.stem)
        for operation in root.iter("operation"):
            text = _operation_text(operation)
            if not text:
                continue
            for port, identifiers in port_identifiers.items():
                if not any(identifier in text for identifier in identifiers):
                    continue
                for direction in ("read", "write"):
                    kind = _operation_kind(text, direction)
                    if not kind:
                        continue
                    bucket = (
                        "request"
                        if kind.endswith("request")
                        else "response"
                        if kind.endswith("response")
                        else "data"
                    )
                    schedules[(port, direction)][bucket].append(
                        _schedule_record(path, module_name, operation, text, kind)
                    )
    return {
        key: {
            name: sorted(records, key=_record_sort_key)[0]
            for name, records in groups.items()
            if records
        }
        for key, groups in schedules.items()
    }


def _schedule_for_event(schedules, port, direction):
    info = schedules.get((port, direction), {})
    return info.get("request") or info.get("data", {}), info.get("data", {})


def build_trace_events(trace_rows, manifest_rows, report, interfaces, schedules):
    sites_by_port = defaultdict(list)
    sites_by_function_port = defaultdict(list)
    sites_by_id = access_sites_by_id(report)
    for site in report.get("off_chip_accesses", []):
        direction = str(site.get("type", "")).lower()
        if direction == "read_write":
            directions = ("read", "write")
        else:
            directions = (direction,)
        for candidate_direction in directions:
            sites_by_port[(site.get("port"), candidate_direction)].append(site)
            sites_by_function_port[
                (
                    site.get("source_function", ""),
                    site.get("port"),
                    candidate_direction,
                )
            ].append(site)
    ports = {port.get("name"): port for port in report.get("m_axi_ports", [])}
    manifest = {row["site_id"]: row for row in manifest_rows}
    seen_labels = defaultdict(int)
    events = []

    def matches_site(site, port, direction):
        if not site:
            return False
        site_direction = str(site.get("type", "")).lower()
        return site.get("port") == port and (
            site_direction == direction or site_direction == "read_write"
        )

    def select_site(row, port, direction):
        site = sites_by_id.get(f"access:{row['site_id']}")
        if matches_site(site, port, direction):
            return site
        function_candidates = sites_by_function_port.get(
            (row.get("function", ""), port, direction), []
        )
        if function_candidates:
            return function_candidates[0]
        port_candidates = sites_by_port.get((port, direction), [])
        if port_candidates:
            return port_candidates[0]
        return site or {}

    for event_index, row in enumerate(trace_rows):
        direction = "read" if row["event"].endswith("read") else "write"
        port = row["argument"]
        element_bytes = parse_int(row["bytes"], 1)
        byte_offset = parse_int(row["byte_offset"], 0)
        element_index = byte_offset // element_bytes if element_bytes else 0
        site = select_site(row, port, direction)
        request_schedule, data_schedule = _schedule_for_event(
            schedules, port, direction
        )
        label = f"{port}[{element_index}]"
        duplicate = seen_labels[label]
        seen_labels[label] += 1
        if duplicate:
            label = f"{label}#{duplicate}"
        site_manifest = manifest.get(row["site_id"], {})
        events.append(
            {
                "element_event_id": label,
                "trace_event_index": event_index,
                "transaction_id": "",
                "access_site": site.get("id", ""),
                "port": port,
                "bundle": site.get("bundle")
                or ports.get(port, {}).get("bundle", ""),
                "direction": direction,
                "element_index": element_index,
                "offset_bytes": byte_offset,
                "bytes": element_bytes,
                "function": row["function"],
                "site_id": row["site_id"],
                "basic_block": site_manifest.get("basic_block", ""),
                "loop": site.get("loop", ""),
                "source_function": site.get("source_function", ""),
                "static_pattern": site.get("pattern", ""),
                "source_instruction": site_manifest.get("instruction", ""),
                "hls_request_module": request_schedule.get("module", ""),
                "hls_request_operation_kind": request_schedule.get(
                    "operation_kind", ""
                ),
                "hls_data_state": data_schedule.get("state", ""),
                "timeline_source": "ir_trace+pass_metadata",
            }
        )
    return events
