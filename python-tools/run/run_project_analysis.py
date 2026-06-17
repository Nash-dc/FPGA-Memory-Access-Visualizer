#!/usr/bin/env python3
"""Run the complete trace-first analysis using only a project name."""

import subprocess
import sys
from pathlib import Path


def main():
    if len(sys.argv) != 2:
        raise SystemExit(
            f"usage: {Path(sys.argv[0]).name} <project_name>"
        )

    root = Path(__file__).resolve().parents[2]
    runner = root / "python-tools" / "run" / "run_trace_memory_analysis.py"
    project_name = sys.argv[1]
    project_config = (
        root / "toy-test-cases" / project_name / "trace_project.json"
    )

    command = [sys.executable, str(runner)]
    if project_config.exists():
        command.extend(["--config", str(project_config)])
    else:
        command.extend(["--project", project_name])

    raise SystemExit(subprocess.run(command, cwd=root).returncode)


if __name__ == "__main__":
    main()
