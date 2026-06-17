#!/usr/bin/env python3
import argparse
import json
import os
import shutil
import subprocess
import sys
from pathlib import Path

SOURCE_ROOT = Path(__file__).resolve().parents[1] / "src"
if str(SOURCE_ROOT) not in sys.path:
    sys.path.insert(0, str(SOURCE_ROOT))

from hls_memory_analysis.project_catalog import DEFAULT_PROJECTS


def repo_root():
    return Path(__file__).resolve().parents[2]


def resolve_path(value):
    path = Path(value)
    if path.is_absolute():
        return path
    return repo_root() / path


def run(cmd, *, cwd=None, env=None, stdout_path=None, log_prefix=None):
    if log_prefix:
        print(log_prefix)
    if stdout_path:
        stdout_path.parent.mkdir(parents=True, exist_ok=True)
        with stdout_path.open("w") as stdout_file:
            result = subprocess.run(
                cmd,
                cwd=cwd or repo_root(),
                env=env,
                text=True,
                stdout=stdout_file,
                stderr=subprocess.PIPE,
            )
    else:
        result = subprocess.run(
            cmd,
            cwd=cwd or repo_root(),
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
    if result.returncode != 0:
        raise RuntimeError(
            "command failed with exit code {}\n{}\n{}".format(
                result.returncode, " ".join(map(str, cmd)), result.stderr
            )
        )
    if result.stdout:
        print(result.stdout, end="")
    if result.stderr:
        print(result.stderr, end="", file=sys.stderr)
    return result


def maybe_run(cmd, *, cwd=None, env=None):
    return subprocess.run(
        cmd,
        cwd=cwd or repo_root(),
        env=env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )


def load_projects(config_path):
    if not config_path:
        return DEFAULT_PROJECTS
    with Path(config_path).open() as file:
        data = json.load(file)
    if isinstance(data, list):
        return data
    return data.get("projects", [])


def validate_project(project):
    required = ["name", "source", "testbench", "report_bc", "interface_xml"]
    missing = [key for key in required if not project.get(key)]
    if missing:
        raise ValueError(f"{project.get('name', '<unnamed>')}: missing {missing}")
    for key in ["source", "testbench", "report_bc", "interface_xml"]:
        path = resolve_path(project[key])
        if not path.exists():
            raise FileNotFoundError(f"{project['name']}: {key} not found: {path}")


def clean_outputs(out_root):
    for child in ["pass-reports", "trace-timeline"]:
        path = out_root / child
        if path.exists():
            shutil.rmtree(path)


def build_passes(llvm_pass_dir):
    run(["cmake", "-S", str(llvm_pass_dir), "-B", str(llvm_pass_dir / "build")])
    run(
        [
            "cmake",
            "--build",
            str(llvm_pass_dir / "build"),
            "--target",
            "MemoryAccessPass",
            "TopLevelMemoryTracePass",
            "-j2",
        ]
    )


def compile_args(project):
    standard = project.get("cxx_standard", "c++14")
    args = [f"-std={standard}"]
    for include_dir in project.get("include_dirs", []):
        args.extend(["-I", str(resolve_path(include_dir))])
    for define in project.get("defines", []):
        args.append(f"-D{define}")
    return args


def schedule_xml_paths(project):
    configured = project.get("schedule_xml", [])
    if configured:
        return [resolve_path(path) for path in configured]
    db_dir = resolve_path(project["report_bc"]).parent
    return sorted(db_dir.glob("*.sched.adb.xml"))


def csynth_xml_paths(project):
    configured = project.get("csynth_xml", [])
    if configured:
        return [resolve_path(path) for path in configured]
    report_bc = resolve_path(project["report_bc"])
    hls_dir = report_bc.parents[2]
    report_dir = hls_dir / "syn" / "report"
    preferred = report_dir / "csynth.xml"
    if preferred.exists():
        return [preferred]
    return sorted(report_dir.glob("*_csynth.xml"))


def run_project(project, paths):
    validate_project(project)
    name = project["name"]
    print(f"\n== {name} ==")

    report_dir = paths["out_root"] / "pass-reports" / name
    trace_dir = paths["out_root"] / "trace-timeline" / name
    final_dir = trace_dir / "final"
    report_dir.mkdir(parents=True, exist_ok=True)
    final_dir.mkdir(parents=True, exist_ok=True)

    report = report_dir / "memory_access_report.json"
    host_bc = trace_dir / "top.host.bc"
    instrumented_bc = trace_dir / "top.instrumented.bc"
    instrumented_o = trace_dir / "top.instrumented.o"
    runtime_o = trace_dir / "TopLevelMemoryTraceRuntime.o"
    test_o = trace_dir / "test.o"
    exe = trace_dir / "trace_test"
    manifest = trace_dir / "top_level_memory_sites.tsv"
    trace = trace_dir / "top_level_memory_trace.tsv"

    run(
        [
            str(paths["llvm_bin"] / "opt"),
            f"--load={paths['pass_build'] / 'libMemoryAccessPass.so'}",
            "--mem-access-pass",
            str(resolve_path(project["report_bc"])),
            "-disable-output",
        ],
        stdout_path=report,
        log_prefix="LLVM memory access report",
    )
    with report.open() as report_file:
        report_data = json.load(report_file)
    trace_roots = project.get("trace_roots") or [report_data.get("function", "")]
    trace_root_args = [
        f"--top-level-memory-trace-root={root}"
        for root in trace_roots
        if root
    ]
    run(
        [
            str(paths["llvm_bin"] / "clang++"),
            *compile_args(project),
            "-emit-llvm",
            "-c",
            str(resolve_path(project["source"])),
            "-o",
            str(host_bc),
        ],
        log_prefix="host LLVM bitcode",
    )
    run(
        [
            str(paths["llvm_bin"] / "opt"),
            f"--load={paths['pass_build'] / 'libTopLevelMemoryTracePass.so'}",
            "--top-level-memory-trace-pass",
            f"--top-level-memory-trace-manifest={manifest}",
            *trace_root_args,
            str(host_bc),
            "-o",
            str(instrumented_bc),
        ],
        log_prefix="IR instrumentation",
    )
    run(
        [
            str(paths["llvm_bin"] / "clang++"),
            "-c",
            str(instrumented_bc),
            "-o",
            str(instrumented_o),
        ],
        log_prefix="instrumented object",
    )
    run(
        [
            "g++",
            project.get("host_cxx_standard", "-std=c++14"),
            "-c",
            str(paths["pass_dir"] / "TopLevelMemoryTraceRuntime.cpp"),
            "-o",
            str(runtime_o),
        ],
        log_prefix="trace runtime object",
    )
    run(
        [
            "g++",
            project.get("host_cxx_standard", "-std=c++14"),
            "-c",
            str(resolve_path(project["testbench"])),
            *sum(
                (["-I", str(resolve_path(include_dir))]
                 for include_dir in project.get("include_dirs", [])),
                [],
            ),
            "-o",
            str(test_o),
        ],
        log_prefix="testbench object",
    )

    link_cmd = [
        "g++",
        *project.get("link_flags", []),
        str(instrumented_o),
        str(runtime_o),
        str(test_o),
        "-o",
        str(exe),
    ]
    result = maybe_run(link_cmd)
    if result.returncode != 0 and "-no-pie" not in link_cmd:
        link_cmd.insert(1, "-no-pie")
        result = maybe_run(link_cmd)
    if result.returncode != 0:
        raise RuntimeError(
            "link failed for {}\n{}\n{}".format(name, result.stdout, result.stderr)
        )
    if result.stderr:
        print(result.stderr, end="", file=sys.stderr)

    env = os.environ.copy()
    env["HLSLITESIM_TOP_LEVEL_MEMORY_TRACE_FILE"] = str(trace)
    test_result = maybe_run([str(exe)], env=env)
    (trace_dir / "test_stdout.log").write_text(test_result.stdout)
    (trace_dir / "test_stderr.log").write_text(test_result.stderr)
    if test_result.returncode != 0:
        raise RuntimeError(
            "test failed for {}\n{}\n{}".format(
                name, test_result.stdout, test_result.stderr
            )
        )
    print("host test passed")

    run(
        [
            sys.executable,
            str(paths["run_dir"] / "build_trace_memory_timeline.py"),
            "--trace",
            str(trace),
            "--manifest",
            str(manifest),
            "--report",
            str(report),
            "--interface-xml",
            str(resolve_path(project["interface_xml"])),
            "--schedule-xml",
            *[str(path) for path in schedule_xml_paths(project)],
            "--csynth-xml",
            *[str(path) for path in csynth_xml_paths(project)],
            "--out-dir",
            str(final_dir),
        ],
        log_prefix="trace-first timeline",
    )
    return final_dir / "summary.json"


def summarize(summary_paths):
    print("\n== summary ==")
    for path in summary_paths:
        with path.open() as file:
            summary = json.load(file)
        counts = summary["counts"]
        project = path.parents[1].name
        print(
            "{}: trace_events={} element_events={} axi_transactions={} access_sites={}".format(
                project,
                counts["trace_events"],
                counts["element_events"],
                counts["axi_transactions"],
                counts["access_sites_from_pass_report"],
            )
        )


def main():
    parser = argparse.ArgumentParser(
        description="Run trace-first memory analysis for configured HLS projects."
    )
    parser.add_argument("--config", type=Path, help="JSON file with a projects list.")
    parser.add_argument(
        "--project",
        action="append",
        help="Project name to run. Repeat to select multiple projects.",
    )
    parser.add_argument("--out-root", type=Path, default=repo_root() / "Results")
    parser.add_argument("--clean", action="store_true")
    parser.add_argument("--skip-build", action="store_true")
    args = parser.parse_args()

    projects = load_projects(args.config)
    if args.project:
        selected = set(args.project)
        projects = [project for project in projects if project.get("name") in selected]
    if not projects:
        raise SystemExit("no projects selected")

    out_root = args.out_root if args.out_root.is_absolute() else repo_root() / args.out_root
    if args.clean:
        clean_outputs(out_root)

    paths = {
        "out_root": out_root,
        "pass_dir": repo_root() / "pass-dev",
        "pass_build": repo_root() / "pass-dev" / "build",
        "run_dir": repo_root() / "python-tools" / "run",
        "llvm_bin": repo_root() / "src" / "hls-llvm-project" / "hls-build" / "bin",
    }

    if not args.skip_build:
        build_passes(paths["pass_dir"])

    summaries = []
    failures = []
    for project in projects:
        try:
            summaries.append(run_project(project, paths))
        except Exception as exc:
            failures.append((project.get("name", "<unnamed>"), str(exc)))
            print(f"FAILED {project.get('name', '<unnamed>')}: {exc}", file=sys.stderr)

    summarize(summaries)
    if failures:
        print("\n== failures ==", file=sys.stderr)
        for name, reason in failures:
            print(f"{name}: {reason}", file=sys.stderr)
        raise SystemExit(1)


if __name__ == "__main__":
    main()
