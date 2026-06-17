#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
pass_dir="${repo_root}/pass-dev"
llvm_bin="${repo_root}/src/hls-llvm-project/hls-build/bin"
example_dir="${repo_root}/Vitis-HLS-Introductory-Examples/Array/array_partition_block_cyclic"
output_dir="${repo_root}/tem/top-level-memory-trace"

mkdir -p "${output_dir}"

cmake -S "${pass_dir}" -B "${pass_dir}/build"
cmake --build "${pass_dir}/build" --target TopLevelMemoryTracePass -j2

"${llvm_bin}/clang++" -std=c++14 -emit-llvm -c \
  "${example_dir}/matmul_partition.cpp" \
  -o "${output_dir}/matmul_partition.host.bc"

"${llvm_bin}/opt" \
  --load="${pass_dir}/build/libTopLevelMemoryTracePass.so" \
  --top-level-memory-trace-pass \
  --top-level-memory-trace-manifest="${output_dir}/top_level_memory_sites.tsv" \
  "${output_dir}/matmul_partition.host.bc" \
  -o "${output_dir}/matmul_partition.instrumented.bc"

"${llvm_bin}/clang++" -c \
  "${output_dir}/matmul_partition.instrumented.bc" \
  -o "${output_dir}/matmul_partition.instrumented.o"
g++ -std=c++14 -c \
  "${pass_dir}/TopLevelMemoryTraceRuntime.cpp" \
  -o "${output_dir}/TopLevelMemoryTraceRuntime.o"
g++ -std=c++14 -c \
  "${example_dir}/matmul_partition_test.cpp" \
  -o "${output_dir}/matmul_partition_test.o"
g++ \
  "${output_dir}/matmul_partition.instrumented.o" \
  "${output_dir}/TopLevelMemoryTraceRuntime.o" \
  "${output_dir}/matmul_partition_test.o" \
  -o "${output_dir}/matmul_partition_test"

HLSLITESIM_TOP_LEVEL_MEMORY_TRACE_FILE="${output_dir}/top_level_memory_trace.tsv" \
  "${output_dir}/matmul_partition_test"

printf '\nTrace event counts:\n'
awk -F '\t' '
  { key = $1 " " $4; count[key]++ }
  END { for (key in count) print key, count[key] }
' "${output_dir}/top_level_memory_trace.tsv" | sort

printf '\nOutputs:\n'
printf '  %s\n' "${output_dir}/top_level_memory_sites.tsv"
printf '  %s\n' "${output_dir}/top_level_memory_trace.tsv"
