#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${script_dir}"

if [[ -f /data/2025.1/Vitis/settings64.sh ]]; then
  set +u
  source /data/2025.1/Vitis/settings64.sh
  set -u
fi

exec vitis-run --mode hls --tcl run_hls.tcl
