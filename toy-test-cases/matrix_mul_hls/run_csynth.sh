#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${script_dir}"

if [[ -f /data/2025.1/Vitis/settings64.sh ]]; then
  set +u
  source /data/2025.1/Vitis/settings64.sh
  set -u
fi

if command -v vitis-run >/dev/null 2>&1; then
  exec vitis-run --mode hls --tcl run_hls.tcl
fi

if command -v vitis_hls >/dev/null 2>&1; then
  exec vitis_hls -f run_hls.tcl
fi

printf 'ERROR: neither vitis-run nor vitis_hls is available in PATH.\n' >&2
printf 'Source the AMD Vitis settings script, then rerun this command.\n' >&2
exit 1
