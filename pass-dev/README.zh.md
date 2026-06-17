# MemoryAccessPass 详细说明

`pass-dev` 实现了一个面向 Vitis HLS LLVM IR 的自定义 LLVM legacy pass。它的目标不是模拟完整 RTL 行为，而是在 Vitis HLS 生成的 bitcode 中提取 off-chip memory 访问、top-level `m_axi` 端口、本地 buffer、loop/tripcount、访问模式和 burst 候选关系。

当前 pass 注册名为：

```text
-mem-access-pass
```

典型输出包含：

- `m_axi_ports`：top-level off-chip AXI master 端口
- `local_buffers`：函数内部本地数组/buffer，例如 `A`、`B`、`C`
- `off_chip_accesses`：对 top-level `m_axi` argument 的 load/store
- `local_accesses`：对本地数组的 load/store

## 设计目标

HLS 工具能快速反馈片上 pipeline、II、latency 等信息，但 off-chip memory 行为通常要等综合、实现或更重的仿真流程才能看清。这个 pass 的目标是从 Vitis HLS LLVM IR 里尽早提取下面这些信息：

- 哪些 top-level argument 是 off-chip memory port
- 每个 port 属于哪个 `bundle`
- 每个 port 的 `depth`
- 哪些 load/store 访问了 off-chip port
- 访问是 `READ` 还是 `WRITE`
- 访问 index 是什么
- 访问所在 loop 和 loop nest 是什么
- loop tripcount 和 total tripcount 是多少
- 访问模式是 sequential、strided、affine 还是 indirect
- 访问是否是 burst candidate
- off-chip 数据是否先搬到 local buffer
- local buffer 是否参与 compute loop
- compute loop 读写了哪些 local buffer

## 当前能力概览

以 `array_partition_block_cyclic` 为例，源码中的主要访问阶段是：

```text
in1 -> readA -> A
in2 -> readB -> B
A, B -> loop2 / lreorder1 / lreorder2 / lreorder3 -> C
C -> writeC -> out_r
```

当前 pass 输出结构化的 port、off-chip access 和 local access 记录，后续 timeline 脚本可以用这些记录与 Vitis HLS report 组合，估算 transaction 和 element-level 时间线。

```text
off_chip_accesses:
  in1 read  loop=readA  n=256  sequential  stride=4B
  in2 read  loop=readB  n=256  sequential  stride=4B
  out_r write loop=writeC n=256 sequential stride=4B

local_accesses:
  A/B/C read/write records with loop context, index expression, pattern, and tripcount
```

其中：

- `n=256` / `n=4096` 是 estimated access count
- `seq` 表示 sequential access
- `4B` 表示 stride 为 4 bytes
- `burst?` 表示源码访问模式是 burst candidate，但没有从 HLS report 确认最终一定生成 burst
- `row` 表示 row-contiguous local buffer access
- `col stride 16` 表示 local buffer 按 16 个元素 stride 访问

## 目录结构

```text
pass-dev/
  CMakeLists.txt
  MemoryAccessPass.cpp
  AnalysisDriver.h/.cpp
  InterproceduralAnalysis.h/.cpp
  MemoryAnalysis.h/.cpp
  IRUtils.h/.cpp
  PragmaParser.h/.cpp
  ReportPrinter.h/.cpp
  README.zh.md
```

核心职责划分：

```text
MemoryAccessPass.cpp
  ModulePass entry point，选择 top function，调用分析和打印。

AnalysisDriver.cpp
  单函数分析 driver，初始化 FunctionMemoryReport，收集 pragma、spill slot、memory access。

InterproceduralAnalysis.cpp
  收集 helper/callee 内的访问，并把 alias 到 top-level argument 的访问合并回 top report。

PragmaParser.cpp
  解析 Vitis HLS 在 llvm.sideeffect operand bundle 中编码的 pragma。

MemoryAnalysis.cpp
  提取 off-chip/local load/store、index、loop、tripcount、access pattern、burst candidate。

IRUtils.cpp
  处理 base pointer 追踪、argument 恢复、SCEV-based access pattern 辅助分类。

ReportPrinter.cpp
  输出 JSON-like report。
```

## 构建方式

当前工程依赖本地 HLS LLVM build：

```text
/data/hls-dev/src/hls-llvm-project/hls-build
```

构建命令：

```sh
cmake -S pass-dev -B pass-dev/build
cmake --build pass-dev/build
```

输出动态库：

```text
pass-dev/build/libMemoryAccessPass.so
```

## 运行方式

### 1. 运行 Vitis HLS 生成 bitcode

先正常运行 Vitis HLS example，让 `.autopilot/db/*.bc` 生成出来。

例如 `array_partition_block_cyclic` 的 bitcode 路径是：

```text
third_party/Vitis-HLS-Introductory-Examples/Array/array_partition_block_cyclic/component_array_partition_block_cyclic/hls/.autopilot/db/matmul_partition.bc
```

### 2. 使用 opt 加载 pass

```sh
/data/hls-dev/src/hls-llvm-project/hls-build/bin/opt \
  -load /data/hls-dev/pass-dev/build/libMemoryAccessPass.so \
  -mem-access-pass -disable-output \
  third_party/Vitis-HLS-Introductory-Examples/Array/array_partition_block_cyclic/component_array_partition_block_cyclic/hls/.autopilot/db/matmul_partition.bc \
  > array_partition_block_cyclic_report.json \
  2> array_partition_block_cyclic_debug.err
```

注意：pass 的 JSON report 写到 `stdout`，debug/function list 写到 `stderr`。

### 3. 渲染 memory graph

默认生成短横向宽度的纵向图：

```sh```

如果需要横向布局：

```sh```

如果需要完整标签：

```sh```

## top function 识别

入口逻辑在 `MemoryAccessPass.cpp` 和 `AnalysisDriver.cpp`。

pass 会扫描 module 中所有函数。如果函数带有 Vitis HLS top function 相关属性，就认为它是 HLS top：

```text
fpga.top.func
fpga.demangled.name
```

如果 module 中存在 top function，pass 只分析这些 top function。这样可以避免 helper 函数被单独输出成独立 report。

输出函数名优先级：

```text
fpga.demangled.name
fpga.top.func
LLVM IR function name
```

例如 mangled name：

```text
_Z16matmul_partitionPiS_S_ii
```

输出时会显示为：

```text
matmul_partition
```

## pragma 解析

实现位置：

```text
PragmaParser.cpp
```

Vitis HLS 会把很多 pragma 编码进 `llvm.sideeffect` 的 operand bundle 中，例如：

```llvm
call void @llvm.sideeffect()
  [ "xlx_m_axi"(i32* %in1, ..., i64 256, ...) ]
```

当前 pass 解析的重点 pragma：

### `xlx_m_axi`

对应 C/C++：

```cpp
#pragma HLS INTERFACE m_axi port = in1 depth = 256 bundle = gmem0
```

提取字段：

```text
port
bundle
depth
offset
signal_name
channel
```

报告位置：

```json
"m_axi_ports": [
  {
    "name": "in1",
    "bundle": "gmem0",
    "channel": "unknown",
    "offset": "slave",
    "signal_name": "unknown",
    "depth": 256
  }
]
```

说明：

- `bundle` 是 Vitis HLS 里把多个 `m_axi` port 绑定到同一个或不同 AXI interface 的名字
- `depth` 是 HLS 假设该 pointer port 对应 buffer 的元素数量，不是 byte 数
- 当前不再输出 `bank`，因为 graph 只需要 `bundle` 即可

### `xlx_array_partition`

对应 C/C++：

```cpp
#pragma HLS ARRAY_PARTITION variable = A dim = 1 cyclic factor = 16
#pragma HLS ARRAY_PARTITION variable = B dim = 1 block factor = 16
```

pass 会把它挂到本地 buffer：

```json
"local_buffers": [
  {
    "name": "A",
    "element_type": "i32",
    "elements": 256,
    "array_partition": "cyclic",
    "partition_factor": 16,
    "partition_dim": 1
  },
  {
    "name": "B",
    "element_type": "i32",
    "elements": 256,
    "array_partition": "block",
    "partition_factor": 16,
    "partition_dim": 1
  }
]
```

当前解析的 partition kind 映射：

```text
0 -> cyclic
1 -> block
2 -> complete
```

## 参数 spill slot 追踪

实现位置：

```text
MemoryAnalysis.cpp
IRUtils.cpp
```

Vitis HLS IR 中 top-level pointer argument 经常被先存入本地 alloca：

```llvm
%in1.addr = alloca i32*
store i32* %in1, i32** %in1.addr
...
%15 = load i32*, i32** %in1.addr
%arrayidx = getelementptr inbounds i32, i32* %15, i64 %idxprom
%17 = load i32, i32* %arrayidx
```

pass 会记录：

```text
%in1.addr -> %in1
%in2.addr -> %in2
%out_r.addr -> %out_r
```

后续追踪 pointer base 时，如果遇到从 `%in1.addr` load 出来的 pointer，就能恢复到真正的 top-level argument `%in1`。

## base pointer 追踪

实现位置：

```text
IRUtils.cpp:getBaseArgument()
MemoryAnalysis.cpp:getBaseLocalAlloca()
```

off-chip 访问需要追踪到 top-level `Argument`。

local buffer 访问需要追踪到本地 `AllocaInst`。

当前支持：

- `getelementptr`
- `GEPOperator`
- `bitcast`
- `addrspacecast`
- argument spill slot load
- `select`
- `phi`

如果 pointer base 最终能解析到 `m_axi` argument，就进入 `off_chip_accesses`。

如果 pointer base 最终能解析到本地数组 alloca，例如 `%A`、`%B`、`%C`，就进入 `local_accesses`。

如果 pointer alias 太复杂，pass 会保守输出 `unknown` 或忽略该访问。

## off-chip access 提取

实现位置：

```text
MemoryAnalysis.cpp:collectMemoryAccess()
MemoryAnalysis.cpp:addOffChipAccess()
```

当前识别：

| LLVM instruction | 类型 | operation |
| --- | --- | --- |
| `LoadInst` | `READ` | `load` |
| `StoreInst` | `WRITE` | `store` |
| `AtomicRMWInst` | `READ_WRITE` | `atomicrmw` |
| `AtomicCmpXchgInst` | `READ_WRITE` | `cmpxchg` |
| `MemTransferInst` / `memcpy` | source `READ`, destination `WRITE` | `memcpy.src` / `memcpy.dst` |
| `MemTransferInst` / `memmove` | source `READ`, destination `WRITE` | `memmove.src` / `memmove.dst` |
| `MemSetInst` | `WRITE` | `memset` |

只有满足下面条件才进入 `off_chip_accesses`：

1. pointer operand 能追踪回 function argument
2. 该 argument 被 `xlx_m_axi` pragma 识别为 off-chip port

示例：

```cpp
out_r[itr] = C[i * MAX_DIM + j];
```

会产生：

```json
{
  "type": "WRITE",
  "port": "out_r",
  "bundle": "unknown",
  "base": "out_r",
  "index": "itr73",
  "operation": "store",
  "pattern": "sequential",
  "loop": "writeC",
  "tripcount": 256,
  "total_tripcount": 256,
  "element_type": "i32",
  "stride_elements": 1,
  "stride_bytes": 4,
  "burst_candidate": true,
  "burst_confirmed_by_report": "unknown",
  "burst_length": "unknown"
}
```

## local access 提取

实现位置：

```text
MemoryAnalysis.cpp:addLocalAccess()
```

本地数组访问不会被放入 `off_chip_accesses`，但会进入 `local_accesses`：

```json
{
  "type": "READ",
  "buffer": "B",
  "index": "((k * 16) + j38)",
  "operation": "load",
  "pattern": "strided",
  "access_detail": "column_stride_16",
  "stride_elements": 16,
  "loop": "lreorder3",
  "tripcount": 16,
  "total_tripcount": 4096
}
```

`local_accesses` 的作用是给 graph 提供片上数据流和访问强度：

- `A` 被 compute loop 读取多少次
- `B` 是 row-contiguous 还是 column stride
- `C` 在哪个 loop 被写入
- local buffer 的流量是否比 off-chip 流量大

## index 表达式提取

实现位置：

```text
MemoryAnalysis.cpp:describeIndex()
```

pass 会尝试恢复 GEP 中的 index 表达式。

例如：

```cpp
A[i * MAX_DIM + k]
B[k * MAX_DIM + j]
out_r[itr]
```

可能输出：

```text
A index     = ((i33 * 16) + k)
B index     = ((k * 16) + j38)
out_r index = itr73
```

处理步骤：

1. 找到 GEP 最后一个非常量 index
2. 去掉简单 cast：`sext`、`zext`、`trunc`
3. 如果 index 来自 `load`，尝试用 alloca 名字
4. 如果 index 是简单二元表达式，递归输出 `+`、`-`、`*`
5. 如果有 debug metadata，尝试恢复源代码变量名
6. 失败则退回 LLVM SSA 名字或 `unknown`

注意：当前 index 表达式恢复是 best-effort，不是完整 symbolic algebra。

## access pattern 分类

相关实现：

```text
IRUtils.cpp:classifyPointer()
MemoryAnalysis.cpp:refineAccessPattern()
```

当前 pattern：

| pattern | 含义 |
| --- | --- |
| `scalar` | 直接通过 pointer 访问，无 GEP |
| `constant_offset` | GEP index 全是常量 |
| `affine` | 能看出是 affine 表达式，但 stride 不确定 |
| `sequential` | 连续访问，stride 为 1 element |
| `strided` | affine/规律访问，但不是 unit stride |
| `indirect` | index 数据相关或无法证明规律 |
| `burst` | memcpy/memmove 这类显式 burst-like intrinsic |
| `memset` | memset |
| `unknown` | 无法分类 |

### 为什么 `in1[itr]` 是 sequential

源码：

```cpp
for (int itr = 0; itr < dim * dim; itr++) {
    A[...] = in1[itr];
}
```

IR 里 `itr` 可能是从 alloca load 出来的变量。pass 会识别这种模式：

```llvm
%itr = alloca i32
...
%x = load i32, i32* %itr
...
%inc = add i32 %x, 1
store i32 %inc, i32* %itr
```

因此：

```text
index = itr
pattern = sequential
stride_elements = 1
stride_bytes = 4
burst_candidate = true
```

### 为什么 `scratch[selected]` 是 indirect

如果 index 是从数据计算出来的变量，例如 selection sort 中的 `selected`，它不是简单 induction variable，也不是可证明 affine stride。

因此：

```text
pattern = indirect
burst_candidate = false
```

## burst 字段语义

当前报告使用：

```json
"burst_candidate": true,
"burst_confirmed_by_report": "unknown"
```

含义：

- `burst_candidate=true`：从源码/IR 访问模式看，它适合形成 burst
- `burst_candidate=false`：访问模式不适合 burst，或者无法证明适合 burst
- `burst_confirmed_by_report=unknown`：当前 pass 没有读取 Vitis synthesis report，因此不知道 HLS 最终是否真的生成 burst transaction

示例：

```text
in1[itr]   -> sequential -> burst_candidate=true
in2[itr]   -> sequential -> burst_candidate=true
out_r[itr] -> sequential -> burst_candidate=true
scratch[selected] -> indirect -> burst_candidate=false
```

## loop 和 tripcount

实现位置：

```text
MemoryAnalysis.cpp:extractLoopNest()
MemoryAnalysis.cpp:fillTripCountFromScalarEvolution()
```

pass 会提取：

- `loop`：当前访问所在的最内层 loop
- `loop_nest`：从外到内的 loop 列表
- `tripcount`：当前最内层 loop 的 avg tripcount
- `total_tripcount`：loop nest 中所有已知 avg tripcount 的乘积

tripcount 来源优先级：

1. Vitis `llvm.loop.tripcount` metadata
2. LLVM ScalarEvolution 的 small constant tripcount
3. loop header 中简单整数比较的常量边界，例如 `k < 16`
4. 否则输出 `unknown`

例如 `array_partition_block_cyclic`：

```cpp
for (int x = 0; x < rep_count; x++)      // loop2, pragma says 1
  for (int i = 0; i < dim; i++)          // lreorder1, tripcount 16
    for (int j = 0; j < dim; j++)        // lreorder2, tripcount 16
      for (int k = 0; k < MAX_DIM; k++)  // lreorder3, inferred 16
```

报告中 compute loop：

```json
{
  "loop": "lreorder3",
  "tripcount": 16,
  "loop_nest": [
    {"name": "loop2", "tripcount": 1},
    {"name": "lreorder1", "tripcount": 16},
    {"name": "lreorder2", "tripcount": 16},
    {"name": "lreorder3", "tripcount": 16}
  ],
  "total_tripcount": 4096
}
```

## JSON report 字段说明

### 顶层字段

```json
{
  "function": "matmul_partition",
  "m_axi_ports": [],
  "local_buffers": [],
  "off_chip_accesses": [],
  "local_accesses": []
}
```

### `m_axi_ports`

```json
{
  "name": "in1",
  "bundle": "unknown",
  "channel": "unknown",
  "offset": "unknown",
  "signal_name": "unknown",
  "depth": 256
}
```

字段说明：

| 字段 | 含义 |
| --- | --- |
| `name` | C/C++ top function argument 名字 |
| `bundle` | HLS `m_axi` bundle 名 |
| `channel` | HLS channel 信息，如果 IR 中没有则 `unknown` |
| `offset` | interface offset |
| `signal_name` | 端口 signal name |
| `depth` | pragma 中声明的元素数量 |

### `local_buffers`

```json
{
  "name": "A",
  "element_type": "i32",
  "elements": 256,
  "array_partition": "cyclic",
  "partition_factor": 16,
  "partition_dim": 1
}
```

字段说明：

| 字段 | 含义 |
| --- | --- |
| `name` | 本地数组名 |
| `element_type` | 元素类型 |
| `elements` | 数组元素数量 |
| `array_partition` | `none` / `cyclic` / `block` / `complete` |
| `partition_factor` | partition factor |
| `partition_dim` | partition dim |

### `off_chip_accesses`

```json
{
  "id": "access:0",
  "sequence": 0,
  "type": "READ",
  "port": "in1",
  "bundle": "unknown",
  "channel": "unknown",
  "base": "in1",
  "index": "itr",
  "operation": "load",
  "pattern": "sequential",
  "source_function": "_Z16matmul_partitionPiS_S_ii",
  "loop": "readA",
  "tripcount": 256,
  "loop_nest": [{"name": "readA", "tripcount": 256}],
  "total_tripcount": 256,
  "element_type": "i32",
  "stride_elements": 1,
  "stride_bytes": 4,
  "burst_candidate": true,
  "burst_confirmed_by_report": "unknown",
  "burst_length": "unknown"
}
```

关键字段：

| 字段 | 含义 |
| --- | --- |
| `type` | `READ` / `WRITE` / `READ_WRITE` |
| `port` | m_axi port 名 |
| `bundle` | AXI bundle |
| `index` | GEP index 表达式 |
| `pattern` | access pattern |
| `loop` | 最内层 loop |
| `tripcount` | 最内层 loop tripcount |
| `total_tripcount` | loop nest 总迭代次数 |
| `stride_elements` | 每次访问 stride 的元素数 |
| `stride_bytes` | 每次访问 stride 的 byte 数 |
| `burst_candidate` | 是否适合 burst |
| `burst_confirmed_by_report` | 是否从 HLS report 确认 burst，目前通常是 `unknown` |

### `local_accesses`

```json
{
  "id": "local_access:3",
  "sequence": 3,
  "type": "READ",
  "buffer": "B",
  "index": "((k * 16) + j38)",
  "operation": "load",
  "pattern": "strided",
  "access_detail": "column_stride_16",
  "stride_elements": 16,
  "source_function": "_Z16matmul_partitionPiS_S_ii",
  "loop": "lreorder3",
  "tripcount": 16,
  "loop_nest": [
    {"name": "loop2", "tripcount": 1},
    {"name": "lreorder1", "tripcount": 16},
    {"name": "lreorder2", "tripcount": 16},
    {"name": "lreorder3", "tripcount": 16}
  ],
  "total_tripcount": 4096
}
```

`access_detail` 当前可能输出：

| 值 | 含义 |
| --- | --- |
| `row_contiguous` | 内层变化下是连续访问 |
| `column_stride_N` | 内层变化下以 N 个元素为 stride |
| `affine` | affine，但无法归类为 row/column |
| `partitioned_affine` | 带 partition 的 affine 访问 |
| `unknown` | 无法判断 |

## 例子：array_partition_block_cyclic

源码核心：

```cpp
readA:
for (int itr = 0, i = 0, j = 0; itr < dim * dim; itr++, j++) {
    A[i * MAX_DIM + j] = in1[itr];
}

readB:
for (int itr = 0, i = 0, j = 0; itr < dim * dim; itr++, j++) {
    B[i * MAX_DIM + j] = in2[itr];
}

loop2:
for (int x = 0; x < rep_count; x++) {
  lreorder1:
  for (int i = 0; i < dim; i++) {
    lreorder2:
    for (int j = 0; j < dim; j++) {
      int result = 0;
      lreorder3:
      for (int k = 0; k < MAX_DIM; k++) {
        result += A[i * MAX_DIM + k] * B[k * MAX_DIM + j];
      }
      C[i * MAX_DIM + j] = result;
    }
  }
}

writeC:
for (int itr = 0, i = 0, j = 0; itr < dim * dim; itr++, j++) {
    out_r[itr] = C[i * MAX_DIM + j];
}
```

pass 当前识别：

```text
off-chip:
  in1   READ   sequential  stride=4 bytes  count=256  burst_candidate=true
  in2   READ   sequential  stride=4 bytes  count=256  burst_candidate=true
  out_r WRITE  sequential  stride=4 bytes  count=256  burst_candidate=true

local:
  A WRITE  row_contiguous     count=256
  B WRITE  row_contiguous     count=256
  A READ   row_contiguous     count=4096
  B READ   column_stride_16   count=4096
  C WRITE  row_contiguous     count=256
  C READ   row_contiguous     count=256
```

解释：

- `in1[itr]`、`in2[itr]`、`out_r[itr]` 是连续 off-chip 访问
- `A[i * 16 + k]` 在内层 `k` 变化时连续
- `B[k * 16 + j]` 在内层 `k` 变化时 stride 为 16
- compute loop 总迭代次数是 `1 * 16 * 16 * 16 = 4096`
- off-chip traffic 是 256 + 256 + 256 次
- compute 阶段主要压力在 local buffer，不是 DRAM

## 例子：sort_external_access

该项目包含 helper function，例如：

```cpp
read_ext(...)
write_ext(...)
swap_ext(...)
```

当前 pass 可以识别：

- `data` bundle `gmem0`
- `scratch` bundle `gmem1`
- `copy_in` 中的 sequential read/write
- `copy_out` 中的 sequential read/write
- `selection_inner` 中的 `scratch[j]` sequential 访问
- `scratch[selected]` indirect 访问
- helper function 中无法还原 call-site loop 的访问保守标为 `loop=unknown`

需要注意：helper/callee access 的 call-site source order 仍然是已知限制之一。如果要完全 source-order correct，需要进一步做 call-site recursive scanning。

## 验证命令

### 构建

```sh
cmake --build pass-dev/build
```

### array_partition_block_cyclic

```sh
/data/hls-dev/src/hls-llvm-project/hls-build/bin/opt \
  -load /data/hls-dev/pass-dev/build/libMemoryAccessPass.so \
  -mem-access-pass -disable-output \
  third_party/Vitis-HLS-Introductory-Examples/Array/array_partition_block_cyclic/component_array_partition_block_cyclic/hls/.autopilot/db/matmul_partition.bc \
  > array_partition_block_cyclic_report.json \
  2> array_partition_block_cyclic_debug.err
```

### sort_external_access

```sh
/data/hls-dev/src/hls-llvm-project/hls-build/bin/opt \
  -load /data/hls-dev/pass-dev/build/libMemoryAccessPass.so \
  -mem-access-pass -disable-output \
  third_party/Vitis-HLS-Introductory-Examples/Interface/Memory/sort_external_access/component_sort_external_access/hls/.autopilot/db/sort_external_access.bc \
  > sort_external_access_report.json \
  2> sort_external_access_debug.err
```

### vector_mul

```sh
/data/hls-dev/src/hls-llvm-project/hls-build/bin/opt \
  -load /data/hls-dev/pass-dev/build/libMemoryAccessPass.so \
  -mem-access-pass toy-test-cases/case_06_vector_mul.ll \
  -S -o /dev/null \
  > vector_mul_report.json \
  2> vector_mul_debug.err
```

## 当前已验证行为

最近一次验证：

```text
cmake --build pass-dev/build
array_partition_block_cyclic
sort_external_access
vector_mul
python3 -m json.tool array_partition_block_cyclic_report.json
```

结果：

```text
构建通过
三个测试均能生成 JSON report
报告中不再出现 bank 字段
array_partition_block_cyclic 的 off-chip access 正确识别为 sequential burst candidate
array_partition_block_cyclic 的 lreorder3 tripcount 正确推断为 16
array_partition_block_cyclic 的 compute total_tripcount 正确为 4096
sort_external_access 中 selected/index 等数据相关访问保持 indirect
```

## 已知限制

当前实现仍然是静态、轻量级、best-effort 分析。

主要限制：

- 不是完整 HLS simulator，不保证等价于最终 RTL traffic
- `burst_candidate=true` 只表示源码/IR 模式适合 burst，不代表 HLS 最终一定生成 burst
- `burst_confirmed_by_report` 目前通常是 `unknown`，因为 pass 尚未读取 Vitis synthesis report
- index 表达式恢复不是完整 symbolic algebra
- local access 的 `row_contiguous` / `column_stride_N` 是启发式判断
- helper/callee access 的 source-order 仍不完全精确
- interprocedural/inlined helper 的 loop context 有时会丢失，可能输出 `loop=unknown`
- 复杂 pointer alias、函数返回 pointer、多源 phi/select 混合时可能无法可靠解析
- array partition 只解析常见 `xlx_array_partition` operand bundle 格式
- 对更复杂多维数组 layout 的 bank/partition 效果没有完整建模
- `total_tripcount` 只在 loop nest tripcount 都已知时可靠
- `memcpy`/`memmove`/`memset` 有基本支持，但 intrinsic 访问的语义仍然比较粗

## 建议后续改进

按优先级：

1. 做 call-site recursive scanning，让 helper function 的访问按调用点顺序合并到 top-level report。
2. 读取 Vitis HLS synthesis/report，填充 `burst_confirmed_by_report`。
3. 增强 affine expression parser，输出更结构化的 index，例如 `base + i * 16 + k`。
4. 对 local buffer reuse 做更明确的统计，例如 `A[i,k] reused across j`、`B[k,j] reused across i`。
5. 增加 traffic generator 后端，把 `off_chip_accesses` 和 timeline transaction 转换成可仿真的 traffic instruction。
6. 增加单元测试或 golden JSON，覆盖 sequential、strided、indirect、helper call、array partition、nested loops。
