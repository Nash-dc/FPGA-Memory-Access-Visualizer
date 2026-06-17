# MemoryAccessPass

The maintained documentation for this pass is currently:

```text
pass-dev/README.zh.md
```

It describes the current ModulePass implementation, Vitis HLS pragma decoding,
off-chip `m_axi` access extraction, local buffer analysis, loop/tripcount
recovery, burst-candidate classification, and memory graph rendering.

Quick build:

```sh
cmake -S pass-dev -B pass-dev/build
cmake --build pass-dev/build
```

Quick run:

```sh
/data/hls-dev/src/hls-llvm-project/hls-build/bin/opt \
  -load /data/hls-dev/pass-dev/build/libMemoryAccessPass.so \
  -mem-access-pass -disable-output \
  <kernel.bc> > report.json 2> debug.err
```
