# Trace-first Off-chip Memory Transaction Analysis for Vitis HLS

This repository builds a trace-first analysis flow for Vitis HLS kernels.  The
main goal is to understand how top-level off-chip memory arguments are accessed,
how accesses depend on each other, and how those accesses can be visualized as
logical memory events and inferred AXI burst transactions.

The project combines three sources of information:

1. Static LLVM IR analysis from custom C++ LLVM passes.
2. Dynamic LLVM IR execution traces from an instrumented host run.
3. Vitis HLS metadata such as AXI interface width, burst limits, loop II,
   DATAFLOW process information, and FIFO depths.

The analysis is transaction-dependency oriented.  It is not intended to be an
RTL cycle-accurate simulator.  When the timeline shows `issue_order`,
`complete_order`, or capacity annotations, those values are relative ordering
slots used to visualize scheduling and dependencies.  RTL co-simulation is used
only to validate the inferred graph and timing relationships.

## High-level Flow

The current flow is:

```text
Vitis HLS project
  |
  | produces .bc, top-io-fe.xml, csynth.xml, schedule XML
  v
MemoryAccessPass C++ LLVM pass
  |
  | static JSON report:
  | Results/pass-reports/<project>/memory_access_report.json
  v
TopLevelMemoryTracePass C++ LLVM pass
  |
  | instruments host LLVM IR and writes a site manifest
  v
Instrumented host executable
  |
  | runtime trace:
  | Results/trace-timeline/<project>/top_level_memory_trace.tsv
  v
Python trace-first builder
  |
  | reconstructs logical accesses, physical AXI transactions,
  | transaction dependencies, relative timing, and HTML visualization
  v
Results/trace-timeline/<project>/final/
```

The important idea is that the dynamic IR trace is the source of truth for what
actually executed.  Static LLVM and HLS metadata explain those dynamic events
and give enough physical information to group them into inferred AXI
transactions.

## Repository Layout

```text
pass-dev/
  C++ LLVM legacy passes and trace runtime.

python-tools/
  Python analysis, transaction reconstruction, dependency graph generation,
  timing annotation, HTML rendering, and project runners.

toy-test-cases/
  Vitis HLS example projects used to test and validate the analysis.

Results/
  Generated analysis outputs.  This directory is produced by the tools.

src/hls-llvm-project/
  Vitis/LLVM toolchain checkout or build used by the analysis commands.
```

## What the C++ Passes Do

The C++ code in `pass-dev/` is responsible for working directly on LLVM IR.
There are two main LLVM passes:

1. `MemoryAccessPass`
2. `TopLevelMemoryTracePass`

They solve different problems.

### MemoryAccessPass

Source files:

```text
pass-dev/MemoryAccessPass.cpp
pass-dev/AnalysisDriver.cpp
pass-dev/MemoryAnalysis.cpp
pass-dev/InterproceduralAnalysis.cpp
pass-dev/ReportPrinter.cpp
pass-dev/IRUtils.cpp
pass-dev/PragmaParser.cpp
```

Build output:

```text
pass-dev/build/libMemoryAccessPass.so
```

LLVM invocation:

```bash
src/hls-llvm-project/hls-build/bin/opt \
  --load=pass-dev/build/libMemoryAccessPass.so \
  --mem-access-pass \
  <vitis-hls-autopilot-db>/<top>.bc \
  -disable-output \
  > Results/pass-reports/<project>/memory_access_report.json
```

`MemoryAccessPass` is a static analysis pass.  It does not execute the program
and it does not insert instrumentation.  It scans the Vitis HLS LLVM bitcode and
prints a JSON report.

The pass uses LLVM analyses such as:

```text
ScalarEvolution
LoopInfo
LLVM instruction inspection
interprocedural call traversal
```

It extracts:

- top-level function names
- top-level pointer arguments
- likely `m_axi` off-chip ports
- load/store sites that access top-level arguments
- access direction: read, write, atomic, or call/mem intrinsic
- source instruction text and source location when available
- access element type and byte width
- approximate access pattern: sequential, strided, constant, or unresolved
- loop metadata and loop nesting
- local buffer accesses
- local buffer RAW/WAR-style relationships
- static dependency edges between access sites
- interprocedural access records when top-level arguments are passed into helper
  functions

The JSON output is called:

```text
memory_access_report.json
```

That report is static metadata.  It says "these access sites exist and they
probably have these properties."  It does not by itself tell us the exact
runtime order or exact number of executed accesses.  The dynamic trace provides
that.

### TopLevelMemoryTracePass

Source files:

```text
pass-dev/TopLevelMemoryTracePass.cpp
pass-dev/TopLevelMemoryTraceRuntime.cpp
```

Build output:

```text
pass-dev/build/libTopLevelMemoryTracePass.so
```

This pass instruments LLVM IR that is compiled and run as a host executable.
Its job is to record actual memory accesses during execution.

Typical invocation:

```bash
src/hls-llvm-project/hls-build/bin/opt \
  --load=pass-dev/build/libTopLevelMemoryTracePass.so \
  --top-level-memory-trace-pass \
  --top-level-memory-trace-root=<top_function_name> \
  --top-level-memory-trace-manifest=Results/trace-timeline/<project>/top_level_memory_sites.tsv \
  Results/trace-timeline/<project>/top.host.bc \
  -o Results/trace-timeline/<project>/top.instrumented.bc
```

The pass inserts calls to runtime functions such as:

```text
__hlslitesim_trace_top_level_memory
__hlslitesim_push_arg_context
__hlslitesim_map_arg_context
__hlslitesim_pop_arg_context
__hlslitesim_register_root_context
```

Those functions are implemented in:

```text
pass-dev/TopLevelMemoryTraceRuntime.cpp
```

The instrumentation pass also writes a manifest:

```text
top_level_memory_sites.tsv
```

The manifest maps each instrumentation site id to:

- function name
- basic block
- event kind
- argument name
- argument index
- access size
- pointer expression
- LLVM instruction text

When the instrumented executable runs, the runtime writes:

```text
top_level_memory_trace.tsv
```

That trace contains actual dynamic events:

- event order
- site id
- top-level argument context
- pointer address
- byte offset
- access size
- read/write direction

This is why the project is "trace-first": the trace tells the Python tools what
really happened in the executed testbench.

## What LLVM IR Does in This Project

LLVM IR is the common representation that connects Vitis HLS, the C++ passes,
and the Python analysis.

There are two kinds of IR involved:

1. Vitis HLS internal bitcode from `.autopilot/db/*.bc`
2. Host-compiled LLVM bitcode generated from the C++ source for tracing

### Vitis HLS Bitcode

Vitis HLS produces LLVM bitcode in directories such as:

```text
toy-test-cases/<project>/component_*/hls/.autopilot/db/<top>.bc
```

`MemoryAccessPass` runs on this bitcode.  This bitcode contains HLS-specific
lowering and metadata.  It is useful for static access analysis because it
reflects how Vitis understands the kernel.

### Host LLVM Bitcode

For dynamic tracing, the Python runner compiles the C++ kernel source into host
LLVM bitcode:

```bash
clang++ -emit-llvm -c <kernel>.cpp -o top.host.bc
```

Then `TopLevelMemoryTracePass` instruments that host bitcode:

```text
top.host.bc
  -> top.instrumented.bc
  -> top.instrumented.o
  -> trace_test executable
```

The resulting executable is linked with:

```text
TopLevelMemoryTraceRuntime.o
testbench.o
```

Running that executable gives the dynamic trace.

### Why IR Instead of Source Text

The pass works at LLVM IR level because:

- load/store operations are explicit
- pointer operands can be inspected directly
- ScalarEvolution can describe loop-based pointer expressions
- function calls and argument forwarding can be traced
- the same infrastructure can be used on Vitis HLS-generated bitcode
- instrumentation can be inserted automatically before/after memory operations

Source code tells us intent.  IR tells us what memory operations the compiler
actually sees.

## What the Python Tools Do

The Python code in `python-tools/` is the final analysis and visualization
layer.

Important entry points:

```text
python-tools/run/run_trace_memory_analysis.py
python-tools/run/build_trace_memory_timeline.py
python-tools/run/validate_physical_axi_inference.py
```

Important library modules:

```text
python-tools/src/hls_memory_analysis/hls_metadata.py
python-tools/src/hls_memory_analysis/logical_access.py
python-tools/src/hls_memory_analysis/physical_axi.py
python-tools/src/hls_memory_analysis/transaction_dependencies.py
python-tools/src/hls_memory_analysis/timeline_timing.py
python-tools/src/hls_memory_analysis/timeline_exports.py
python-tools/src/hls_memory_analysis/project_catalog.py
```

### run_trace_memory_analysis.py

This is the main orchestration script.  It can:

1. Build the C++ LLVM passes.
2. Run `MemoryAccessPass` and save `memory_access_report.json`.
3. Compile source C++ into host LLVM bitcode.
4. Run `TopLevelMemoryTracePass`.
5. Compile and link the instrumented executable.
6. Run the testbench to produce `top_level_memory_trace.tsv`.
7. Call `build_trace_memory_timeline.py`.
8. Write all final outputs to `Results/`.

Default run:

```bash
cd /data/hls-dev
PYTHONDONTWRITEBYTECODE=1 python3 python-tools/run/run_trace_memory_analysis.py --clean
```

Run one project from a config:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 python-tools/run/run_trace_memory_analysis.py \
  --skip-build \
  --config toy-test-cases/read_write_depth2/trace_project.json
```

`--clean` removes old generated results under:

```text
Results/pass-reports/
Results/trace-timeline/
```

Project-local RTL evidence directories are preserved across `--clean`:

```text
Results/trace-timeline/<project>/RTL/
```

Use this directory for waveform screenshots or notes that should stay next to
the generated transaction timeline.

### build_trace_memory_timeline.py

This is the final analysis builder.  It consumes:

```text
top_level_memory_trace.tsv
top_level_memory_sites.tsv
memory_access_report.json
top-io-fe.xml
csynth.xml
schedule XML files when available
```

Then it produces:

```text
summary.json
element_timeline.tsv
logical_access_graph.json
transactions.tsv
transaction_dependency_graph.json
inferred_physical_axi_transactions.json
bandwidth_utilization_summary.json
transaction_timeline.html
```

The builder performs several stages.

#### Stage 1: Merge HLS Metadata

Implemented mainly in:

```text
hls_metadata.py
timeline_timing.py
```

The builder parses:

- `top-io-fe.xml` for top-level AXI interface information
- `csynth.xml` for loop II, pipeline depth, DATAFLOW processes, and FIFO depth
- schedule XML files for access-to-loop information when available

This gives the Python layer access to facts like:

```text
port data width
max read burst length
max write burst length
max widen bitwidth
loop PipelineII
loop PipelineDepth
FIFO StaticDepth
```

#### Stage 2: Build Dynamic Trace Events

Implemented in:

```text
hls_metadata.py
```

The builder joins:

```text
top_level_memory_trace.tsv
top_level_memory_sites.tsv
memory_access_report.json
interface XML
schedule XML
```

The result is a list of normalized memory events.  Each event has:

- dynamic trace order
- access site id
- source instruction
- function and loop context
- top-level port
- bundle
- direction
- element index
- byte offset
- access size

This is the element-level timeline.

#### Stage 3: Build the Logical Access Graph

Implemented in:

```text
logical_access.py
```

The logical graph is built from dynamic events and static dependency metadata.
It keeps event-level relationships such as:

- value flow dependencies
- control dependencies
- dynamic same-port RAW dependencies
- local access relationships from the static report

Logical accesses are source-level element operations.  They are not yet AXI
bursts.

#### Stage 4: Infer Physical AXI Transactions

Implemented in:

```text
physical_axi.py
```

The physical transaction inference groups dynamic element events into inferred
AXI bursts.  It uses:

- port name
- direction
- byte offsets
- source element size
- AXI data width
- max burst length
- beat alignment
- sequential/coalescing rules

For example, if the AXI data width is 512 bits and the source element is a
32-bit integer, one AXI beat can carry:

```text
512 / 32 = 16 source elements
```

If the max burst length is 8 beats, one inferred burst can carry:

```text
8 * 16 = 128 source elements
```

The output is:

```text
inferred_physical_axi_transactions.json
transactions.tsv
```

Each transaction records:

- transaction id
- port and bundle
- read/write direction
- byte address
- physical byte length
- AXI beat count
- ARLEN/AWLEN-like length
- source element range
- covered dynamic trace events
- inferred timing metadata

#### Stage 5: Build the Transaction Dependency Graph

Implemented in:

```text
transaction_dependencies.py
```

This stage lifts event-level dependencies to transaction-level dependencies.

Examples:

```text
logical read element -> logical write element
```

becomes:

```text
read transaction -> write transaction
```

The graph includes several dependency types:

- `dynamic_memory_raw`: dynamic read-after-write overlap on the same memory
  location
- `control_dependency`: branch/control relationship exposed by the static pass
- value-flow dependencies from LLVM def-use relationships
- `local_buffer_phase_order`: non-DATAFLOW local-buffer phase order where HLS
  may issue widened read bursts before write bursts through the same local
  buffer
- `stream_channel`: inferred DATAFLOW producer-consumer stream relationship

For DATAFLOW stream cases, the graph also records capacity annotations when
enough HLS metadata exists:

```json
"capacity_constraint": {
  "channel": "stream_U",
  "fifo_static_depth": 2,
  "producer_loop_ii": 1,
  "consumer_loop_ii": 4,
  "tokens_in_transaction": 128,
  "producer_faster_than_consumer": true,
  "backpressure_expected": true,
  "first_full_after_tokens": 3
}
```

This is not modeled as a normal value dependency.  It is a bounded FIFO capacity
constraint.  It means the producer transaction can be throttled by downstream
consumer progress.

#### Stage 6: Annotate Relative Timing

Implemented in:

```text
timeline_timing.py
```

This stage assigns relative ordering fields:

```text
issue_order
complete_order
timeline_lane
timing_model
```

These values are used for visualization.  They are not exact RTL cycle counts.

The timing model considers:

- transaction dependencies
- per-lane ordering
- AXI beat count
- `num_read_outstanding` and `num_write_outstanding` interface limits
- DATAFLOW process overlap
- loop II when available
- FIFO capacity backpressure when available
- non-DATAFLOW local-buffer phase order when widened reads feed widened writes

For normal non-stream projects, no FIFO capacity constraints are invented.

For a non-DATAFLOW pipelined loop with widened reads feeding widened writes
through a local buffer, the graph can contain `local_buffer_phase_order` edges.
These edges are not element data dependencies.  They model an HLS scheduling
choice where the read burst group is issued first and the write burst group is
issued later.  In that case:

```text
read transaction spacing  ~= 1 issue slot when PipelineII=1 and reads are not backpressured
write transaction spacing ~= useful elements per write transaction * PipelineII
```

In `max_widen_port_width`, this inference places the four read requests close
together and spaces the four write requests by the widened write burst
formation window.  RTL co-simulation is used only to validate this inference;
waveforms are not consumed by the builder.

For DATAFLOW stream projects:

- `read_i -> write_i` stream edges are inferred by matching local transaction
  ordinal per port.
- If FIFO depth and loop II are known, the graph can flag bounded FIFO
  backpressure.
- If the producer is faster than the consumer and the transaction token count
  exceeds FIFO depth, producer reads are annotated as backpressure-limited.

The FIFO backpressure model is used only for relative transaction ordering.  It
uses the FIFO depth and producer/consumer II to decide whether producer read
transactions should be spaced out because the FIFO will become full:

```text
tokens = 128
fifo_depth = 2
producer_ii = 1
consumer_ii = 4
```

The important conclusion is:

```text
producer read transaction is capacity-throttled by a slower consumer
```

For AXI read request spacing, the model uses `num_read_outstanding`:

```text
num_read_outstanding = 1
  same-port read transactions are spaced apart because only one read request
  can be in flight.

num_read_outstanding > 1
  same-port read transactions may issue close together unless another
  dependency or backpressure constraint applies.
```

#### Stage 7: Export HTML and TSV/JSON Reports

Implemented in:

```text
timeline_exports.py
```

The HTML output is:

```text
transaction_timeline.html
```

It shows:

- one lane per port/direction in DATAFLOW cases
- read transactions in blue
- write transactions in red
- dependency arrows
- order edges
- transaction details on click
- incoming capacity constraints
- producer backpressure model
- AXI outstanding request limits

The HTML is intentionally self-contained so it can be opened directly in a
browser.

## Output Files

For each project, the final output directory is:

```text
Results/trace-timeline/<project>/final/
```

Important files:

```text
summary.json
```

High-level summary: project name, counts, input files, interface metadata,
pipeline metadata, and assumptions.

```text
element_timeline.tsv
```

One row per dynamic off-chip memory event.  Raw instrumentation may see
`s_axilite` scalar references such as `res` in `read_only`, but final timeline
events are filtered to ports listed as `m_axi` in the pass report.

```text
logical_access_graph.json
```

Event-level dependency graph.

```text
inferred_physical_axi_transactions.json
```

Inferred AXI burst transactions plus timing annotations.

```text
transactions.tsv
```

Readable tabular transaction summary.

```text
transaction_dependency_graph.json
```

Transaction-level dependency graph.

```text
bandwidth_utilization_summary.json
```

Useful bytes, transferred bytes, unused bytes, and bandwidth utilization.

```text
transaction_timeline.html
```

Interactive visualization.

## Example: read_write

Project:

```text
toy-test-cases/read_write/
```

The kernel has two DATAFLOW streams:

```cpp
hls::stream<int, DEPTH> stream[2];
read(mem_0, 0, stream[0]);
read(mem_1, BLOCK_LENGTH, stream[1]);
write(mem_0, N * 2 + 0, stream[0]);
write(mem_1, N * 2 + BLOCK_LENGTH, stream[1]);
```

Conceptually:

```text
mem_0 read process -> stream[0] -> mem_0 write process
mem_1 read process -> stream[1] -> mem_1 write process
```

The Python graph infers:

```text
txn_mem_0_read_0 -> txn_mem_0_write_0
txn_mem_0_read_1 -> txn_mem_0_write_1
...
txn_mem_1_read_0 -> txn_mem_1_write_0
txn_mem_1_read_1 -> txn_mem_1_write_1
...
```

When FIFO depth is large enough, the graph has stream dependencies but no
capacity backpressure:

```text
stream_edges = 16
backpressure_edges = 0
```

## Example: read_write_depth2

Project:

```text
toy-test-cases/read_write_depth2/
```

This is the same structure as `read_write`, but the stream depth is reduced:

```cpp
#define DEPTH 2
```

The write loop is slower:

```cpp
#pragma HLS pipeline II=4
mem[off + j] = in_stream.read();
```

The producer read loop is faster:

```cpp
#pragma HLS pipeline II=1
out_stream.write(mem[off + j]);
```

The builder reads FIFO depth from `csynth.xml`:

```text
stream_U   StaticDepth = 2
stream_1_U StaticDepth = 2
```

It also reads loop II:

```text
producer II = 1
consumer II = 4
```

For a transaction block of 128 tokens:

```text
tokens = 128
fifo depth = 2
producer faster than consumer = true
tokens > depth = true
```

Therefore:

```text
backpressure_expected = true
```

Evaluation after the latest run:

```text
read_write_depth2:
  stream_edges = 16
  backpressure_edges = 16
```

This is the non-RTL inference expected for `DEPTH=2`: the read process can be
blocked by a full FIFO before the first write transaction becomes ready.

## Example: read_only

Project:

```text
toy-test-cases/read_only/
```

This case reads two `m_axi` arrays into DATAFLOW streams and computes a dot
product into scalar `res`:

```cpp
#pragma HLS interface m_axi port=mem_0 bundle=mem_0 depth=4096
#pragma HLS interface m_axi port=mem_1 bundle=mem_1 depth=4096
#pragma HLS interface s_axilite port=res
```

Only `mem_0` and `mem_1` are off-chip `m_axi` ports.  The scalar `res` may
appear in the raw IR trace because it is an `int&`, but it is filtered out of
the final off-chip timeline because it is `s_axilite`.

This project is the clean validation case for read outstanding behavior:

```text
num_read_outstanding = 16
  read transactions on the same port are placed close together.

num_read_outstanding = 1
  read transactions on the same port are spaced apart.
```

For the latest generated metadata, `read_only` has:

```text
txns = 8
ports = mem_0, mem_1
stream_edges = 0
backpressure_edges = 0
```

## What the Tool Does Not Do

This project does not claim to replace RTL simulation.

It does not model exactly:

- every RTL cycle
- exact `ARVALID`/`AWVALID` timestamps
- every channel handshake
- memory controller behavior
- DDR/HBM latency
- full Vitis scheduling internals

Instead, it models:

- which off-chip accesses happened
- how logical events group into inferred AXI transactions
- which transactions depend on which other transactions
- whether DATAFLOW stream capacity can throttle producer transactions
- a relative transaction ordering suitable for visualization and traffic
  generation experiments

## Common Commands

Build passes and run the default project catalog:

```bash
cd /data/hls-dev
PYTHONDONTWRITEBYTECODE=1 python3 python-tools/run/run_trace_memory_analysis.py --clean
```

Run `read_write`:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 python-tools/run/run_trace_memory_analysis.py \
  --skip-build \
  --config toy-test-cases/read_write/trace_project.json
```

Run `read_write_depth2`:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 python-tools/run/run_trace_memory_analysis.py \
  --skip-build \
  --config toy-test-cases/read_write_depth2/trace_project.json
```

Run unit tests:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest python-tools/tests/test_transaction_timeline_golden.py
```

Summarize generated graphs:

```bash
python3 - <<'PY'
import json
from pathlib import Path

root = Path("Results/trace-timeline")
for final in sorted(root.glob("*/final")):
    graph_path = final / "transaction_dependency_graph.json"
    tx_path = final / "inferred_physical_axi_transactions.json"
    if not graph_path.exists() or not tx_path.exists():
        continue
    graph = json.loads(graph_path.read_text())
    txns = json.loads(tx_path.read_text())["axi_transactions"]
    counts = graph.get("counts", {})
    print(
        final.parent.name,
        "txns=", len(txns),
        "stream_edges=", counts.get("stream_channel_edges", 0),
        "backpressure_edges=",
        counts.get("stream_capacity_backpressure_edges", 0),
    )
PY
```

## Latest Evaluation Snapshot

After the latest full rerun:

```text
array_partition_block_cyclic: txns=48,  stream_edges=0,  backpressure_edges=0
array_partition_complete:    txns=48,  stream_edges=0,  backpressure_edges=0
burst_rw:                     txns=16,  stream_edges=0,  backpressure_edges=0
matrix_mul_full_contiguous:   txns=48,  stream_edges=0,  backpressure_edges=0
matrix_mul_hls:               txns=96,  stream_edges=0,  backpressure_edges=0
matrix_mul_row_col_hls:       txns=768, stream_edges=0,  backpressure_edges=0
max_widen_port_width:         txns=8,   stream_edges=0,  backpressure_edges=0
read_only:                    txns=8,   stream_edges=0,  backpressure_edges=0
vector_mul_shared_bundle_hls: txns=12,  stream_edges=0,  backpressure_edges=0
read_write:                   txns=32,  stream_edges=16, backpressure_edges=0
read_write_depth2:            txns=32,  stream_edges=16, backpressure_edges=16
```

This is the expected behavior:

- ordinary non-stream projects do not get stream capacity constraints
- `read_only` has only `mem_0` and `mem_1` off-chip transactions; `res` is
  excluded because it is `s_axilite`
- `read_write` gets stream transaction dependencies but no FIFO backpressure
- `read_write_depth2` gets both stream dependencies and bounded FIFO
  backpressure annotations

## Design Principle

The project is conservative:

- If there is no DATAFLOW stream evidence, it does not invent stream edges.
- If there is no FIFO depth metadata, it does not invent capacity backpressure.
- If loop II is unavailable, the backpressure inference falls back to a
  conservative no-backpressure assumption.
- RTL or co-simulation waveforms are validation inputs only.  If validation
  disagrees with the inferred graph, inspect the LLVM/HLS metadata for a
  missing non-RTL signal; otherwise document the case as a limitation.

The dependency graph should be valid with co-simulation results in the following
sense: no transaction should be shown as issued before the transactions required
by its data/control/capacity constraints are ready.  The exact cycle at which a
transaction appears in RTL is outside the scope of this Python timing model.
