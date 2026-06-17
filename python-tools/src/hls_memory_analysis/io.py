#!/usr/bin/env python3
import csv
import json


def load_json(path):
    with path.open() as file:
        return json.load(file)


def read_tsv(path):
    with path.open() as file:
        return list(csv.DictReader(file, delimiter="\t"))


def read_trace(path):
    fields = [
        "event",
        "function",
        "site_id",
        "argument",
        "argument_index",
        "byte_offset",
        "bytes",
    ]
    rows = []
    with path.open() as file:
        for line in file:
            values = line.rstrip("\n").split("\t")
            if values != [""]:
                rows.append(dict(zip(fields, values)))
    return rows


def write_json(path, value):
    path.write_text(json.dumps(value, indent=2) + "\n")


def write_tsv(path, rows):
    if not rows:
        path.write_text("")
        return
    with path.open("w", newline="") as file:
        writer = csv.DictWriter(
            file, list(rows[0]), delimiter="\t", extrasaction="ignore"
        )
        writer.writeheader()
        writer.writerows(rows)
