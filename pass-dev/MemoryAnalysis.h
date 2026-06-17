#ifndef MEMORY_ANALYSIS_H
#define MEMORY_ANALYSIS_H

#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/Argument.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"

#include <map>
#include <set>
#include <string>
#include <vector>

namespace hls_mem {

using ArgumentAliasMap = std::map<const llvm::Argument *, const llvm::Argument *>;
using ArgumentSpillSlotMap =
    std::map<const llvm::AllocaInst *, const llvm::Argument *>;

enum class AccessKind {
  Read,
  Write,
  ReadWrite
};

enum class AccessPattern {
  Unknown,
  Scalar,
  ConstantOffset,
  Affine,
  Sequential,
  Strided,
  Indirect,
  Burst,
  MemSet
};

struct AxiPortInfo {
  std::string Name;
  std::string Bundle = "unknown";
  std::string Channel = "unknown";
  std::string Offset = "unknown";
  std::string SignalName = "unknown";
  long long Depth = -1;
  const llvm::Argument *Arg = nullptr;
};

struct LoopInfo {
  std::string Name = "unknown";
  long long MinTripCount = -1;
  long long MaxTripCount = -1;
  long long AvgTripCount = -1;
};

struct OffChipAccessRecord {
  std::string Id;
  unsigned Sequence = 0;
  std::string Type;
  std::string Port;
  std::string Bundle = "unknown";
  std::string Channel = "unknown";
  std::string Base;
  std::string Index = "unknown";
  std::string Operation;
  std::string Pattern = "unknown";
  std::string SourceFunction;
  LoopInfo Loop;
  std::vector<LoopInfo> LoopNest;
  long long TotalTripCount = -1;
  std::string ElementType = "unknown";
  long long StrideElements = -1;
  uint64_t StrideBytes = 0;
  long long BurstLength = -1;
  bool BurstCandidate = false;
  std::string BurstConfirmedByReport = "unknown";
  bool IsBurst = false;
};

struct LocalBufferInfo {
  std::string Name;
  std::string ElementType = "unknown";
  long long ElementCount = -1;
  std::string PartitionKind = "none";
  long long PartitionFactor = -1;
  long long PartitionDim = -1;
  const llvm::AllocaInst *Alloca = nullptr;
};

struct LocalAccessRecord {
  std::string Id;
  unsigned Sequence = 0;
  std::string Type;
  std::string Buffer;
  std::string Index = "unknown";
  std::string Operation;
  std::string Pattern = "unknown";
  std::string AccessDetail = "unknown";
  long long StrideElements = -1;
  std::string SourceFunction;
  LoopInfo Loop;
  std::vector<LoopInfo> LoopNest;
  long long TotalTripCount = -1;
};

struct DependencyEdgeRecord {
  std::string Id;
  std::string SourceId;
  std::string TargetId;
  std::string Kind;
  std::string Via = "";
  std::string Reason;
  std::string SourceRole;
  std::string TargetRole;
  std::string SourceIndex = "";
  std::string TargetIndex = "";
};

struct FunctionMemoryReport {
  std::string FunctionName;
  std::string DisplayFunctionName;
  ArgumentSpillSlotMap ArgSpillSlots;
  std::map<const llvm::Argument *, AxiPortInfo> AxiPorts;
  std::map<const llvm::AllocaInst *, LocalBufferInfo> LocalBuffers;
  std::vector<OffChipAccessRecord> OffChipAccesses;
  std::vector<LocalAccessRecord> LocalAccesses;
  std::map<const llvm::Instruction *, std::string> OffChipAccessIds;
  std::map<const llvm::Instruction *, std::string> LocalAccessIds;
  std::vector<DependencyEdgeRecord> DependencyEdges;
  unsigned NextAccessSequence = 0;
};

std::string getAccessKindName(AccessKind Kind);
std::string getPatternName(AccessPattern Pattern);
void collectMemoryAccess(FunctionMemoryReport &Report, llvm::Instruction &Inst,
                         llvm::ScalarEvolution *SE,
                         llvm::LoopInfo *LI,
                         const ArgumentAliasMap *ArgAliases = nullptr,
                         const ArgumentSpillSlotMap *ArgSpillSlots = nullptr);

void collectArgumentSpill(FunctionMemoryReport &Report, llvm::Instruction &Inst);
void collectDependencyEdges(FunctionMemoryReport &Report, llvm::Function &F);
void collectDependencyEdges(FunctionMemoryReport &Report, llvm::Function &F,
                            bool IncludeLocalBufferRawEdges);

} // namespace hls_mem

#endif
