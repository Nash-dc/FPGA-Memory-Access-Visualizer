# Matrix Multiply HLS Test Project

This is a minimal Vitis HLS test case for off-chip memory analysis:

```cpp
c[row][col] = sum(a[row][k] * b[k][col])
```

The kernel multiplies two 16x16 row-major matrices. The three top-level arrays
use separate AXI master bundles with `max_widen_bitwidth=512`; matrix load and
store loops are pipelined for contiguous AXI bursts, and the on-chip
dot-product loop processes 4 lanes per cycle.

Run C synthesis only:

```bash
cd /data/hls-dev/toy-test-cases/matrix_mul_hls
./run_csynth.sh
```

The expected HLS database is generated under:

```text
component_matrix_mul/hls/.autopilot/db/
```

Useful outputs after synthesis:

```text
component_matrix_mul/hls/.autopilot/db/burst.xml
component_matrix_mul/hls/.autopilot/db/*.sched.adb
component_matrix_mul/hls/.autopilot/db/*.sched.adb.xml
component_matrix_mul/hls/syn/report/csynth.rpt
```
