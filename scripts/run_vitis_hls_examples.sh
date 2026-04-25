#!/usr/bin/env bash

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXAMPLES_DIR="${1:-$ROOT_DIR/third_party/Vitis-HLS-Introductory-Examples}"
OUT_DIR="${OUT_DIR:-$ROOT_DIR/build/vitis-hls-examples}"
CLANG="${CLANG:-$ROOT_DIR/src/hls-llvm-project/hls-build/bin/clang}"
OPT="${OPT:-$ROOT_DIR/src/hls-llvm-project/hls-build/bin/opt}"
PASS_SO="${PASS_SO:-$ROOT_DIR/pass-dev/build/libMemoryAccessPass.so}"
LIMIT="${LIMIT:-0}"
VITIS_INCLUDE="${VITIS_INCLUDE:-}"
EXTRA_CXXFLAGS="${EXTRA_CXXFLAGS:-}"

detect_vitis_includes() {
  local candidates=(
    "$VITIS_INCLUDE"
    "${XILINX_VITIS:-}/include"
    "${XILINX_HLS:-}/include"
    "${XILINX_HLS:-}/lnx64/tools/vcxx/data/include"
    "${XILINX_HLS:-}/lnx64/tools/vcxx/data/autopilot"
    "/data/2025.1/Vitis/include"
    "/data/2025.1/Vitis/common/technology/autopilot"
    "/data/2025.1/lnx64/tools/vcxx/data/include"
    "/data/2025.1/lnx64/tools/vcxx/data/autopilot"
  )

  for dir in "${candidates[@]}"; do
    if [[ -n "$dir" && -f "$dir/ap_int.h" ]]; then
      printf '%s\n' "$dir"
    fi
  done | awk '!seen[$0]++'
}

mapfile -t VITIS_INCLUDE_DIRS < <(detect_vitis_includes)

COMMON_CLANG_ARGS=(-fhls -O1 -S -emit-llvm)
for dir in "${VITIS_INCLUDE_DIRS[@]}"; do
  COMMON_CLANG_ARGS+=("-I$dir")
done

if [[ -n "$EXTRA_CXXFLAGS" ]]; then
  read -r -a EXTRA_CXXFLAGS_ARRAY <<< "$EXTRA_CXXFLAGS"
  COMMON_CLANG_ARGS+=("${EXTRA_CXXFLAGS_ARRAY[@]}")
fi

if [[ ! -d "$EXAMPLES_DIR" ]]; then
  echo "examples directory not found: $EXAMPLES_DIR" >&2
  exit 1
fi

if [[ ! -x "$CLANG" ]]; then
  echo "clang not found or not executable: $CLANG" >&2
  exit 1
fi

if [[ ! -x "$OPT" ]]; then
  echo "opt not found or not executable: $OPT" >&2
  exit 1
fi

if [[ ! -f "$PASS_SO" ]]; then
  echo "pass shared library not found: $PASS_SO" >&2
  exit 1
fi

mkdir -p "$OUT_DIR/ir" "$OUT_DIR/logs"
RESULTS="$OUT_DIR/results.tsv"

printf "status\thas_xlx_m_axi\tsource\tir\tlog\n" > "$RESULTS"

if command -v rg >/dev/null 2>&1; then
  mapfile -t SOURCES < <(
    rg -i -l '#pragma[[:space:]]+HLS[[:space:]]+INTERFACE.*m_axi|#pragma[[:space:]]+HLS[[:space:]]+interface.*m_axi' \
      --glob '*.c' --glob '*.cc' --glob '*.cpp' "$EXAMPLES_DIR" | sort
  )
else
  mapfile -t SOURCES < <(
    find "$EXAMPLES_DIR" -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' \) \
      -exec grep -IlEi '#pragma[[:space:]]+HLS[[:space:]]+INTERFACE.*m_axi|#pragma[[:space:]]+HLS[[:space:]]+interface.*m_axi' {} \; | sort
  )
fi

total=${#SOURCES[@]}
if [[ "$LIMIT" -gt 0 && "$LIMIT" -lt "$total" ]]; then
  total="$LIMIT"
fi

echo "examples: $EXAMPLES_DIR"
echo "output:   $OUT_DIR"
echo "sources:  $total"
if [[ "${#VITIS_INCLUDE_DIRS[@]}" -gt 0 ]]; then
  echo "vitis includes:"
  for dir in "${VITIS_INCLUDE_DIRS[@]}"; do
    echo "  $dir"
  done
else
  echo "vitis includes: not found"
fi
if [[ -n "$EXTRA_CXXFLAGS" ]]; then
  echo "extra flags: $EXTRA_CXXFLAGS"
fi
echo

compiled=0
compile_failed=0
pass_ok=0
pass_failed=0

for idx in "${!SOURCES[@]}"; do
  if [[ "$LIMIT" -gt 0 && "$idx" -ge "$LIMIT" ]]; then
    break
  fi

  src="${SOURCES[$idx]}"
  rel="${src#$EXAMPLES_DIR/}"
  stem="${rel%.*}"
  ir="$OUT_DIR/ir/$stem.ll"
  compile_log="$OUT_DIR/logs/${stem//\//__}.compile.log"
  pass_log="$OUT_DIR/logs/${stem//\//__}.pass.log"

  mkdir -p "$(dirname "$ir")"

  echo "[$((idx + 1))/$total] $rel"

  src_dir="$(dirname "$src")"
  if ! "$CLANG" "${COMMON_CLANG_ARGS[@]}" -c "$src" \
      -I"$src_dir" -I"$EXAMPLES_DIR" -o "$ir" > "$compile_log" 2>&1; then
    compile_failed=$((compile_failed + 1))
    printf "COMPILE_FAIL\t-\t%s\t%s\t%s\n" "$rel" "$ir" "$compile_log" >> "$RESULTS"
    echo "  compile failed"
    continue
  fi

  compiled=$((compiled + 1))

  has_m_axi="no"
  if grep -q '"xlx_m_axi"' "$ir"; then
    has_m_axi="yes"
  fi

  if "$OPT" -load "$PASS_SO" -mem-access-pass "$ir" -S -o /dev/null > "$pass_log" 2>&1; then
    pass_ok=$((pass_ok + 1))
    printf "PASS\t%s\t%s\t%s\t%s\n" "$has_m_axi" "$rel" "$ir" "$pass_log" >> "$RESULTS"
    echo "  pass ok, xlx_m_axi=$has_m_axi"
  else
    pass_failed=$((pass_failed + 1))
    printf "PASS_FAIL\t%s\t%s\t%s\t%s\n" "$has_m_axi" "$rel" "$ir" "$pass_log" >> "$RESULTS"
    echo "  pass failed, xlx_m_axi=$has_m_axi"
  fi
done

echo
echo "summary"
echo "  compiled:       $compiled"
echo "  compile_failed: $compile_failed"
echo "  pass_ok:        $pass_ok"
echo "  pass_failed:    $pass_failed"
echo "  results:        $RESULTS"
