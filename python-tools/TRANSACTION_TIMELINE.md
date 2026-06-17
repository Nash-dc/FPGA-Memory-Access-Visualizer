# Trace-first transaction timeline

## Python module layout

Executable entry points live under `python-tools/run/`; reusable implementations
live under `python-tools/src/`.

- `run/build_trace_memory_timeline.py`: command-line orchestration;
- `src/hls_memory_analysis/io.py`: JSON, TSV, and trace file I/O;
- `src/hls_memory_analysis/common.py`: shared identifiers and integer helpers;
- `src/hls_memory_analysis/hls_metadata.py`: HLS metadata and trace annotation;
- `src/hls_memory_analysis/logical_access.py`: per-element dependency analysis;
- `src/hls_memory_analysis/physical_axi.py`: physical AXI reconstruction;
- `src/hls_memory_analysis/transaction_dependencies.py`: transaction edges;
- `src/hls_memory_analysis/timeline_timing.py`: estimated issue/completion order;
- `src/hls_memory_analysis/timeline_exports.py`: summary, TSV, and HTML output.

The analyzer combines three sources:

- The LLVM pass supplies static top-level `m_axi` ports, access sites, source
  context, symbolic indices, and candidate value/control dependencies.
- The instrumented host execution supplies the logical element accesses that
  actually executed, their concrete byte offsets, and dynamic order.
- Vitis HLS interface and csynth XML supplies synthesized AXI widths, burst
  limits, outstanding settings, loop pipeline status, and achieved II when
  available.

`logical_access_graph.json` is the detailed per-element graph.
`inferred_physical_axi_transactions.json` groups compatible logical accesses
into aligned AXI beats and bursts. `transaction_dependency_graph.json` contains
only transaction-level dependencies. Different LLVM access sites may be grouped
when their port, direction, physical addresses, and burst constraints permit it.

`issue_order` and `complete_order` in `transactions.tsv` are logical estimates,
not cycle-accurate RTL timestamps. Independent pipelined reads can issue in
consecutive slots because HLS AXI masters can support outstanding requests.
Dependent writes are placed after input completion, estimated pipeline fill,
and write-burst formation. For a scalar logical write stream, the minimum
spacing between write bursts is estimated as:

```text
max(AXI beat count, useful element count * achieved loop II)
```

For example, an II=1 loop that produces one 32-bit result per iteration needs
about 16 production cycles to fill a 16-element burst, even if the resulting
128-bit AXI transfer contains only four beats. Thus loop II=1 does not imply one
AXI write transaction per cycle. Display order alone never creates a dependency
edge.

For dynamically sequential outer-loop phases, a scalar write followed by reads
from a different loop region creates a separate `timeline_order_predecessor_id`.
The HTML draws this relation as a dashed arrow. It constrains estimated issue
order but is not added to the transaction dependency graph.

Without RTL/cosim, backpressure, arbitration, exact memory latency, and exact
request/data channel cycles cannot be known. The HTML timeline therefore
visualizes the strongest reconstruction supported by the dynamic IR trace and
post-synthesis metadata without presenting estimates as waveform truth.

## Local-buffer dependency limitation

The dynamic trace currently records concrete accesses to top-level `m_axi`
arguments. Local arrays are represented by static LLVM dependency metadata, but
their individual runtime reads and writes are not present in the trace.

This distinction matters for kernels that stage data through local buffers and
accumulate results across multiple phases. The analyzer can identify the static
path:

```text
top-level read -> local-buffer write -> local-buffer read/compute
               -> local-buffer write -> top-level write
```

However, without dynamic local-buffer events it cannot always determine which
runtime instance of an earlier top-level transaction supplied each final output
transaction. Falling back to the latest dynamic event from an access site may
produce an incomplete transaction dependency.

### `matrix_mul_hls` example

The tiled matrix multiplication executes four sequential `k0` phases:

```text
k0 = 0:  load A[:, 0..3],   load B[0..3, :],   compute C_local
k0 = 4:  load A[:, 4..7],   load B[4..7, :],   accumulate C_local
k0 = 8:  load A[:, 8..11],  load B[8..11, :],  accumulate C_local
k0 = 12: load A[:, 12..15], load B[12..15, :], accumulate C_local
finally: write C_local to c
```

All `c` transactions occurring after the four A/B loading and compute phases is
consistent with the source. The current graph may still incorrectly:

- issue A and B transactions from different `k0` phases too early;
- connect final C transactions only to the latest A/B access-site instances;
- omit the accumulated dependency through `A_tile`, `B_tile`, and `C_local`.

Therefore, the `matrix_mul_hls` graph must currently be interpreted as a
conservative off-chip transaction overview, not an exact per-output dependency
graph.

The general solution is to extend the IR instrumentation with local-buffer
events containing:

- buffer identity;
- concrete byte offset or element index;
- read/write direction;
- dynamic execution order;
- function and call context.

The final analyzer can then apply dynamic RAW tracking to local buffers and
propagate transaction provenance through:

```text
a -> A_tile -> compute -> C_local -> c
b -> B_tile -> compute -> C_local -> c
```

This extension should remain generic and must not use matrix names, loop names,
tile sizes, or access IDs as special cases.
