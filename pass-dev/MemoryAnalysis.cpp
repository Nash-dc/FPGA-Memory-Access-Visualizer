#include "MemoryAnalysis.h"

#include "IRUtils.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Operator.h"

#include <algorithm>
#include <cctype>
#include <map>
#include <queue>
#include <set>

using namespace llvm;

namespace hls_mem {

std::string getAccessKindName(AccessKind Kind) {
  if (Kind == AccessKind::Read)
    return "READ";
  if (Kind == AccessKind::Write)
    return "WRITE";
  return "READ_WRITE";
}

std::string getPatternName(AccessPattern Pattern) {
  switch (Pattern) {
  case AccessPattern::Scalar:
    return "scalar";
  case AccessPattern::ConstantOffset:
    return "constant_offset";
  case AccessPattern::Affine:
    return "affine";
  case AccessPattern::Sequential:
    return "sequential";
  case AccessPattern::Strided:
    return "strided";
  case AccessPattern::Indirect:
    return "indirect";
  case AccessPattern::Burst:
    return "burst";
  case AccessPattern::MemSet:
    return "memset";
  default:
    return "unknown";
  }
}

void collectArgumentSpill(FunctionMemoryReport &Report, Instruction &Inst) {
  StoreInst *SI = dyn_cast<StoreInst>(&Inst);
  if (!SI)
    return;

  Value *Stored = SI->getValueOperand()->stripPointerCasts();
  Argument *Arg = dyn_cast<Argument>(Stored);
  if (!Arg || !Arg->getType()->isPointerTy())
    return;

  Value *Slot = SI->getPointerOperand()->stripPointerCasts();
  AllocaInst *AI = dyn_cast<AllocaInst>(Slot);
  if (!AI)
    return;

  Report.ArgSpillSlots[AI] = Arg;
}

static std::string cleanName(std::string Name) {
  if (!Name.empty() && Name[0] == '%')
    Name.erase(Name.begin());
  const std::string Suffix = ".addr";
  if (Name.size() > Suffix.size() &&
      Name.compare(Name.size() - Suffix.size(), Suffix.size(), Suffix) == 0)
    Name.resize(Name.size() - Suffix.size());
  return Name.empty() ? "unknown" : Name;
}

static std::string getTypeText(Type *Ty) {
  if (!Ty)
    return "unknown";
  std::string Text;
  raw_string_ostream OS(Text);
  Ty->print(OS);
  return OS.str();
}

static Value *stripIndexCasts(Value *V) 
{
  while (V) {
    if (SExtInst *I = dyn_cast<SExtInst>(V)) {
      V = I->getOperand(0);
      continue;
    }
    if (ZExtInst *I = dyn_cast<ZExtInst>(V)) {
      V = I->getOperand(0);
      continue;
    }
    if (TruncInst *I = dyn_cast<TruncInst>(V)) {
      V = I->getOperand(0);
      continue;
    }
    break;
  }
  return V;
}

static std::string getDebugNameForValue(const Function &F, const Value *Target) 
{
  if (!Target)
    return "";

  for (const BasicBlock &BB : F) {
    for (const Instruction &Inst : BB) {
      const DbgValueInst *DVI = dyn_cast<DbgValueInst>(&Inst);
      if (!DVI || DVI->getValue() != Target)
        continue;

      const DILocalVariable *Var = DVI->getVariable();
      if (Var && !Var->getName().empty())
        return Var->getName().str();
    }
  }

  return "";
}

static std::string describeIndexExpr(Value *V, const Instruction &Inst,
                                     std::set<const Value *> &Seen,
                                     unsigned Depth) {
  if (!V)
    return "unknown";
  if (Depth > 6 || !Seen.insert(V).second)
    return cleanName(getValueName(V));

  V = stripIndexCasts(V);

  if (ConstantInt *CI = dyn_cast<ConstantInt>(V))
    return std::to_string(CI->getSExtValue());

  if (LoadInst *LI = dyn_cast<LoadInst>(V)) {
    Value *LoadPtr = LI->getPointerOperand()->stripPointerCasts();
    if (AllocaInst *AI = dyn_cast<AllocaInst>(LoadPtr))
      return cleanName(getValueName(AI));
    return cleanName(getValueName(V));
  }

  if (BinaryOperator *BO = dyn_cast<BinaryOperator>(V)) {
    StringRef Op;
    switch (BO->getOpcode()) {
    case Instruction::Add:
      Op = " + ";
      break;
    case Instruction::Sub:
      Op = " - ";
      break;
    case Instruction::Mul:
      Op = " * ";
      break;
    default:
      Op = "";
      break;
    }

    if (!Op.empty()) {
      std::string LHS =
          describeIndexExpr(BO->getOperand(0), Inst, Seen, Depth + 1);
      std::string RHS =
          describeIndexExpr(BO->getOperand(1), Inst, Seen, Depth + 1);
      return "(" + LHS + Op.str() + RHS + ")";
    }
  }

  std::string DebugName =
      getDebugNameForValue(*Inst.getFunction(), V);
  if (!DebugName.empty())
    return DebugName;

  if (V->hasName())
    return cleanName(getValueName(V));
  return cleanName(getValueName(V));
}

static std::string describeIndex(Value *Ptr, const Instruction &Inst) 
{
  Value *V = Ptr ? Ptr->stripPointerCasts() : nullptr;
  GetElementPtrInst *InstGEP = dyn_cast_or_null<GetElementPtrInst>(V);
  GEPOperator *OpGEP = dyn_cast_or_null<GEPOperator>(V);
  if (!InstGEP && !OpGEP)
    return "0";

  unsigned NumOperands =
      InstGEP ? InstGEP->getNumOperands() : OpGEP->getNumOperands();
  Value *Index = nullptr;
  for (unsigned I = 1; I < NumOperands; ++I) {
    Value *Candidate = InstGEP ? InstGEP->getOperand(I) : OpGEP->getOperand(I);
    if (!isa<ConstantInt>(Candidate) && !isa<ConstantAggregateZero>(Candidate))
      Index = Candidate;
  }
  if (!Index)
    return "0";

  Value *BaseIndex = stripIndexCasts(Index);
  std::set<const Value *> Seen;
  return describeIndexExpr(BaseIndex, Inst, Seen, 0);
}

static bool isUnitConstant(Value *V) {
  if (ConstantInt *CI = dyn_cast_or_null<ConstantInt>(V))
    return CI->getSExtValue() == 1 || CI->getSExtValue() == -1;
  return false;
}

static bool usesLoadFromAlloca(Value *V, const AllocaInst *AI,
                               std::set<const Value *> &Seen) {
  if (!V || !AI || !Seen.insert(V).second)
    return false;
  V = stripIndexCasts(V);
  if (LoadInst *LI = dyn_cast<LoadInst>(V))
    return LI->getPointerOperand()->stripPointerCasts() == AI;
  if (Instruction *I = dyn_cast<Instruction>(V)) {
    for (Value *Op : I->operands()) {
      if (usesLoadFromAlloca(Op, AI, Seen))
        return true;
    }
  }
  return false;
}

static bool isIncrementOfAlloca(Value *V, const AllocaInst *AI) {
  V = stripIndexCasts(V);
  BinaryOperator *BO = dyn_cast_or_null<BinaryOperator>(V);
  if (!BO)
    return false;
  if (BO->getOpcode() != Instruction::Add &&
      BO->getOpcode() != Instruction::Sub)
    return false;

  std::set<const Value *> SeenLHS;
  std::set<const Value *> SeenRHS;
  bool LHSUsesAI = usesLoadFromAlloca(BO->getOperand(0), AI, SeenLHS);
  bool RHSUsesAI = usesLoadFromAlloca(BO->getOperand(1), AI, SeenRHS);
  return (LHSUsesAI && isUnitConstant(BO->getOperand(1))) ||
         (RHSUsesAI && BO->getOpcode() == Instruction::Add &&
          isUnitConstant(BO->getOperand(0)));
}

static bool isSequentialAllocaIndex(Value *Index) {
  Index = stripIndexCasts(Index);
  LoadInst *LI = dyn_cast_or_null<LoadInst>(Index);
  if (!LI)
    return false;
  AllocaInst *AI =
      dyn_cast<AllocaInst>(LI->getPointerOperand()->stripPointerCasts());
  if (!AI)
    return false;

  for (User *U : AI->users()) {
    StoreInst *SI = dyn_cast<StoreInst>(U);
    if (!SI || SI->getPointerOperand()->stripPointerCasts() != AI)
      continue;
    if (isIncrementOfAlloca(SI->getValueOperand(), AI))
      return true;
  }
  return false;
}

static bool isAffineIndexExpression(const std::string &Index) {
  if (Index.empty() || Index == "unknown")
    return false;
  for (char C : Index) {
    if (std::isalnum(static_cast<unsigned char>(C)) || C == '_' || C == ' ' ||
        C == '(' || C == ')' || C == '+' || C == '-' || C == '*')
      continue;
    return false;
  }
  return Index.find_first_of("abcdefghijklmnopqrstuvwxyz"
                             "ABCDEFGHIJKLMNOPQRSTUVWXYZ") !=
         std::string::npos;
}

static long long inferStrideElementsFromIndex(const std::string &Index) {
  if (!isAffineIndexExpression(Index))
    return -1;

  size_t Mul = Index.find('*');
  if (Mul == std::string::npos)
    return 1;

  size_t Pos = Mul + 1;
  while (Pos < Index.size() && Index[Pos] == ' ')
    ++Pos;
  bool Negative = false;
  if (Pos < Index.size() && Index[Pos] == '-') {
    Negative = true;
    ++Pos;
  }
  long long Value = 0;
  bool SawDigit = false;
  while (Pos < Index.size() && std::isdigit(static_cast<unsigned char>(Index[Pos]))) {
    SawDigit = true;
    Value = Value * 10 + (Index[Pos] - '0');
    ++Pos;
  }
  if (SawDigit)
    return Negative ? -Value : Value;
  return -1;
}

static long long inferInnermostStrideElementsFromIndex(const std::string &Index) {
  if (!isAffineIndexExpression(Index))
    return -1;

  size_t LastPlus = Index.rfind('+');
  if (LastPlus != std::string::npos) {
    std::string Tail = Index.substr(LastPlus + 1);
    if (Tail.find('*') == std::string::npos)
      return 1;
  }

  return inferStrideElementsFromIndex(Index);
}

static AccessPattern refineAccessPattern(Value *Ptr, const Instruction &Inst,
                                         AccessPattern Pattern) {
  if (Pattern != AccessPattern::Indirect && Pattern != AccessPattern::Unknown)
    return Pattern;

  Value *V = Ptr ? Ptr->stripPointerCasts() : nullptr;
  GetElementPtrInst *InstGEP = dyn_cast_or_null<GetElementPtrInst>(V);
  GEPOperator *OpGEP = dyn_cast_or_null<GEPOperator>(V);
  if (!InstGEP && !OpGEP)
    return Pattern;

  unsigned NumOperands =
      InstGEP ? InstGEP->getNumOperands() : OpGEP->getNumOperands();
  Value *OnlyVariableIndex = nullptr;
  unsigned VariableIndices = 0;
  for (unsigned I = 1; I < NumOperands; ++I) {
    Value *Index = InstGEP ? InstGEP->getOperand(I) : OpGEP->getOperand(I);
    if (isa<ConstantInt>(Index) || isa<ConstantAggregateZero>(Index))
      continue;
    OnlyVariableIndex = Index;
    ++VariableIndices;
  }

  if (VariableIndices == 1 && isSequentialAllocaIndex(OnlyVariableIndex))
    return AccessPattern::Sequential;

  std::string Index = describeIndex(Ptr, Inst);
  if (!isAffineIndexExpression(Index))
    return Pattern;
  if (Index.find_first_of("+-*") == std::string::npos)
    return Pattern;
  long long Stride = inferStrideElementsFromIndex(Index);
  if (Stride == 1)
    return AccessPattern::Sequential;
  if (Stride > 1)
    return AccessPattern::Strided;
  return AccessPattern::Affine;
}

static std::string inferLocalAccessDetail(const std::string &Index,
                                          AccessKind Kind,
                                          const LocalBufferInfo &Buffer) {
  long long StructuralStride = inferStrideElementsFromIndex(Index);
  if (Kind == AccessKind::Read && Buffer.PartitionKind == "block" &&
      StructuralStride > 1)
    return "column_stride_" + std::to_string(StructuralStride);

  long long Stride = inferInnermostStrideElementsFromIndex(Index);
  if (Stride == 1)
    return "row_contiguous";
  if (Stride > 1)
    return "column_stride_" + std::to_string(Stride);
  if (Buffer.PartitionFactor > 0 && Index.find("*") != std::string::npos)
    return "partitioned_affine";
  if (isAffineIndexExpression(Index))
    return "affine";
  return "unknown";
}

static MDNode *getLoopMetadataFromTerminator(const Instruction *Term) {
  if (!Term)
    return nullptr;
  return Term->getMetadata("llvm.loop");
}

static MDNode *findNearbyLoopMetadata(const Instruction &Inst) {
  const BasicBlock *BB = Inst.getParent();
  if (!BB)
    return nullptr;

  if (MDNode *LoopMD = getLoopMetadataFromTerminator(BB->getTerminator()))
    return LoopMD;

  for (const BasicBlock *Pred : predecessors(BB)) {
    if (MDNode *LoopMD = getLoopMetadataFromTerminator(Pred->getTerminator()))
      return LoopMD;
  }

  std::set<const BasicBlock *> Seen;
  std::vector<const BasicBlock *> Worklist;
  Seen.insert(BB);
  Worklist.push_back(BB);
  for (unsigned Depth = 0; Depth < 3 && !Worklist.empty(); ++Depth) {
    std::vector<const BasicBlock *> Next;
    for (const BasicBlock *Cur : Worklist) {
      for (const BasicBlock *Succ : successors(Cur)) {
        if (!Seen.insert(Succ).second)
          continue;
        if (MDNode *LoopMD =
                getLoopMetadataFromTerminator(Succ->getTerminator()))
          return LoopMD;
        Next.push_back(Succ);
      }
    }
    Worklist.swap(Next);
  }

  return nullptr;
}

static LoopInfo extractLoopInfoFromMetadata(MDNode *LoopMD) {
  LoopInfo Info;
  if (!LoopMD)
    return Info;

  for (const MDOperand &Op : LoopMD->operands()) {
    MDNode *Entry = dyn_cast_or_null<MDNode>(Op.get());
    if (!Entry || Entry->getNumOperands() == 0)
      continue;

    MDString *Key = dyn_cast_or_null<MDString>(Entry->getOperand(0).get());
    if (!Key)
      continue;

    if (Key->getString() == "llvm.loop.name" && Entry->getNumOperands() > 1) {
      if (MDString *Name =
              dyn_cast_or_null<MDString>(Entry->getOperand(1).get()))
        Info.Name = Name->getString().str();
      continue;
    }

    if (Key->getString() == "llvm.loop.tripcount" &&
        Entry->getNumOperands() > 3) {
      auto ReadTrip = [&](unsigned I) -> long long {
        ConstantAsMetadata *CAM =
            dyn_cast_or_null<ConstantAsMetadata>(Entry->getOperand(I).get());
        if (!CAM)
          return -1;
        ConstantInt *CI = dyn_cast<ConstantInt>(CAM->getValue());
        return CI ? CI->getSExtValue() : -1;
      };
      Info.MinTripCount = ReadTrip(1);
      Info.MaxTripCount = ReadTrip(2);
      Info.AvgTripCount = ReadTrip(3);
    }
  }

  return Info;
}

static LoopInfo extractLoopInfo(const Instruction &Inst) {
  return extractLoopInfoFromMetadata(findNearbyLoopMetadata(Inst));
}

static void fillTripCountFromScalarEvolution(LoopInfo &Info, llvm::Loop *L,
                                             ScalarEvolution *SE) {
  if (!L || !SE || Info.AvgTripCount >= 0)
    return;

  unsigned TripCount = SE->getSmallConstantTripCount(L);
  if (TripCount == 0) {
    BasicBlock *Header = L->getHeader();
    if (Header) {
      for (Instruction &I : *Header) {
        ICmpInst *Cmp = dyn_cast<ICmpInst>(&I);
        if (!Cmp)
          continue;
        ConstantInt *Bound = dyn_cast<ConstantInt>(Cmp->getOperand(1));
        if (!Bound)
          Bound = dyn_cast<ConstantInt>(Cmp->getOperand(0));
        if (!Bound)
          continue;
        long long Value = Bound->getSExtValue();
        if (Value > 0) {
          TripCount = static_cast<unsigned>(Value);
          break;
        }
      }
    }
  }
  if (TripCount == 0)
    return;
  Info.MinTripCount = TripCount;
  Info.MaxTripCount = TripCount;
  Info.AvgTripCount = TripCount;
}

static std::vector<LoopInfo> extractLoopNest(const Instruction &Inst,
                                             llvm::LoopInfo *LI,
                                             ScalarEvolution *SE) {
  std::vector<LoopInfo> InnerToOuter;
  if (!LI)
    return InnerToOuter;

  for (llvm::Loop *L = LI->getLoopFor(Inst.getParent()); L;
       L = L->getParentLoop()) {
    LoopInfo Info = extractLoopInfoFromMetadata(L->getLoopID());
    if (Info.Name == "unknown")
      Info.Name = L->getHeader() ? L->getHeader()->getName().str() : "unknown";
    fillTripCountFromScalarEvolution(Info, L, SE);
    InnerToOuter.push_back(Info);
  }

  return std::vector<LoopInfo>(InnerToOuter.rbegin(), InnerToOuter.rend());
}

static long long computeTotalTripCount(const std::vector<LoopInfo> &LoopNest) {
  if (LoopNest.empty())
    return -1;

  long long Total = 1;
  for (const LoopInfo &Info : LoopNest) {
    if (Info.AvgTripCount < 0)
      return -1;
    Total *= Info.AvgTripCount;
  }
  return Total;
}

static Type *getAccessElementType(const Instruction &Inst, Value *Ptr) 
{
  if (const LoadInst *LI = dyn_cast<LoadInst>(&Inst))
    return LI->getType();
  if (const StoreInst *SI = dyn_cast<StoreInst>(&Inst))
    return SI->getValueOperand()->getType();

  Value *V = Ptr ? Ptr->stripPointerCasts() : nullptr;
  if (GetElementPtrInst *GEP = dyn_cast_or_null<GetElementPtrInst>(V))
    return GEP->getSourceElementType();
  if (GEPOperator *GEP = dyn_cast_or_null<GEPOperator>(V))
    return GEP->getSourceElementType();
  return nullptr;
}

static long long getConstantLengthBytes(const Instruction &Inst) {
  if (const MemIntrinsic *MI = dyn_cast<MemIntrinsic>(&Inst)) {
    if (ConstantInt *Len = dyn_cast<ConstantInt>(MI->getLength()))
      return Len->getSExtValue();
  }
  return -1;
}

static long long computeBurstLength(const Instruction &Inst, Type *ElementTy) {
  long long Bytes = getConstantLengthBytes(Inst);
  if (Bytes < 0 || !ElementTy)
    return -1;

  uint64_t ElementBytes =
      Inst.getModule()->getDataLayout().getTypeStoreSize(ElementTy);
  if (ElementBytes == 0)
    return -1;
  return Bytes / ElementBytes;
}

static const AllocaInst *getBaseLocalAlloca(Value *Ptr) {
  if (!Ptr)
    return nullptr;

  std::set<Value *> Seen;
  Value *V = Ptr->stripPointerCasts();
  while (V && Seen.insert(V).second) {
    if (AllocaInst *AI = dyn_cast<AllocaInst>(V))
      return AI;
    if (GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(V)) {
      V = GEP->getPointerOperand()->stripPointerCasts();
      continue;
    }
    if (GEPOperator *GEP = dyn_cast<GEPOperator>(V)) {
      V = GEP->getPointerOperand()->stripPointerCasts();
      continue;
    }
    if (BitCastInst *BC = dyn_cast<BitCastInst>(V)) {
      V = BC->getOperand(0)->stripPointerCasts();
      continue;
    }
    if (AddrSpaceCastInst *ASC = dyn_cast<AddrSpaceCastInst>(V)) {
      V = ASC->getOperand(0)->stripPointerCasts();
      continue;
    }
    break;
  }
  return nullptr;
}

static bool isLocalBufferAlloca(const AllocaInst *AI) {
  if (!AI)
    return false;
  Type *Ty = AI->getAllocatedType();
  return Ty && (Ty->isArrayTy() || Ty->isVectorTy());
}

static long long getAllocaElementCount(Type *Ty) {
  if (!Ty)
    return -1;
  if (ArrayType *AT = dyn_cast<ArrayType>(Ty))
    return AT->getNumElements();
  if (isa<VectorType>(Ty))
    return -1;
  return -1;
}

static std::string getAllocaElementType(Type *Ty) {
  if (!Ty)
    return "unknown";
  if (ArrayType *AT = dyn_cast<ArrayType>(Ty))
    return getTypeText(AT->getElementType());
  if (VectorType *VT = dyn_cast<VectorType>(Ty))
    return getTypeText(VT->getElementType());
  return getTypeText(Ty);
}

static LocalBufferInfo &getOrCreateLocalBuffer(FunctionMemoryReport &Report,
                                               const AllocaInst *AI) {
  LocalBufferInfo &Buffer = Report.LocalBuffers[AI];
  if (Buffer.Name.empty())
    Buffer.Name = getValueName(AI);
  Buffer.Alloca = AI;
  if (Buffer.ElementType == "unknown")
    Buffer.ElementType = getAllocaElementType(AI->getAllocatedType());
  if (Buffer.ElementCount < 0)
    Buffer.ElementCount = getAllocaElementCount(AI->getAllocatedType());
  return Buffer;
}

static std::string addLocalAccess(FunctionMemoryReport &Report,
                                  const AllocaInst *AI, AccessKind Kind,
                                  AccessPattern Pattern,
                                  const std::string &Operation, Value *Ptr,
                                  const Instruction &Inst, llvm::LoopInfo *LI,
                                  ScalarEvolution *SE) {
  if (!isLocalBufferAlloca(AI))
    return "";

  LocalBufferInfo &Buffer = getOrCreateLocalBuffer(Report, AI);
  LocalAccessRecord Record;
  Record.Sequence = Report.LocalAccesses.size();
  Record.Id = "local_access:" + std::to_string(Record.Sequence);
  Record.Type = getAccessKindName(Kind);
  Record.Buffer = Buffer.Name;
  Record.Index = describeIndex(Ptr, Inst);
  Record.Operation = Operation;
  Record.Pattern = getPatternName(Pattern);
  Record.AccessDetail = inferLocalAccessDetail(Record.Index, Kind, Buffer);
  if (Record.AccessDetail.find("column_stride_") == 0)
    Record.StrideElements = inferStrideElementsFromIndex(Record.Index);
  else
    Record.StrideElements = inferInnermostStrideElementsFromIndex(Record.Index);
  Record.SourceFunction = Inst.getFunction() ? Inst.getFunction()->getName().str()
                                             : "unknown";
  Record.LoopNest = extractLoopNest(Inst, LI, SE);
  if (!Record.LoopNest.empty())
    Record.Loop = Record.LoopNest.back();
  else
    Record.Loop = extractLoopInfo(Inst);
  Record.TotalTripCount = computeTotalTripCount(Record.LoopNest);
  std::string Id = Record.Id;
  Report.LocalAccesses.push_back(Record);
  Report.LocalAccessIds[&Inst] = Id;
  return Id;
}

static const Argument *
resolveAccessArgument(Value *Ptr, const FunctionMemoryReport &Report,
                      const ArgumentAliasMap *ArgAliases,
                      const ArgumentSpillSlotMap *ArgSpillSlots);

static std::string addOffChipAccess(FunctionMemoryReport &Report,
                                    const Argument *Arg, AccessKind Kind,
                                    AccessPattern Pattern,
                                    const std::string &Operation, Value *Ptr,
                                    const Instruction &Inst, llvm::LoopInfo *LI,
                                    ScalarEvolution *SE)
{
  if (!Arg)
    return "";

  auto PortIt = Report.AxiPorts.find(Arg);
  if (PortIt == Report.AxiPorts.end())
    return "";

  Type *ElementTy = getAccessElementType(Inst, Ptr);

  OffChipAccessRecord Record;
  Record.Sequence = Report.NextAccessSequence++;
  Record.Id = "access:" + std::to_string(Record.Sequence);
  Record.Type = getAccessKindName(Kind);
  Record.Port = PortIt->second.Name;
  Record.Bundle = PortIt->second.Bundle;
  Record.Channel = PortIt->second.Channel;
  Record.Base = PortIt->second.Name;
  Record.Index = describeIndex(Ptr, Inst);
  Record.Operation = Operation;
  Record.Pattern = getPatternName(Pattern);
  Record.SourceFunction = Inst.getFunction() ? Inst.getFunction()->getName().str()
                                             : "unknown";
  Record.LoopNest = extractLoopNest(Inst, LI, SE);
  if (!Record.LoopNest.empty())
    Record.Loop = Record.LoopNest.back();
  else
    Record.Loop = extractLoopInfo(Inst);
  Record.TotalTripCount = computeTotalTripCount(Record.LoopNest);
  Record.ElementType = getTypeText(ElementTy);
  Record.StrideElements = inferStrideElementsFromIndex(Record.Index);
  if (ElementTy)
    Record.StrideBytes = Inst.getModule()->getDataLayout().getTypeStoreSize(ElementTy);
  if (Record.StrideElements > 0 && ElementTy)
    Record.StrideBytes *= Record.StrideElements;
  Record.BurstCandidate = Pattern == AccessPattern::Burst ||
                          Pattern == AccessPattern::Sequential ||
                          Pattern == AccessPattern::Strided;
  Record.IsBurst = Record.BurstCandidate;
  Record.BurstLength = computeBurstLength(Inst, ElementTy);
  Report.OffChipAccesses.push_back(Record);
  Report.OffChipAccessIds[&Inst] = Record.Id;
  return Record.Id;
}

static const Argument *
resolveAccessArgument(Value *Ptr, const FunctionMemoryReport &Report,
                      const ArgumentAliasMap *ArgAliases,
                      const ArgumentSpillSlotMap *ArgSpillSlots) {
  const ArgumentSpillSlotMap &Spills =
      ArgSpillSlots ? *ArgSpillSlots : Report.ArgSpillSlots;
  const Argument *Arg = getBaseArgument(Ptr, Spills);
  if (!Arg || !ArgAliases)
    return Arg;

  auto It = ArgAliases->find(Arg);
  if (It == ArgAliases->end())
    return Arg;
  return It->second;
}

void collectMemoryAccess(FunctionMemoryReport &Report, Instruction &Inst,
                         ScalarEvolution *SE, llvm::LoopInfo *Loops,
                         const ArgumentAliasMap *ArgAliases,
                         const ArgumentSpillSlotMap *ArgSpillSlots) {
  if (LoadInst *LI = dyn_cast<LoadInst>(&Inst)) {
    const Argument *Arg =
        resolveAccessArgument(LI->getPointerOperand(), Report, ArgAliases,
                              ArgSpillSlots);
    AccessPattern Pattern =
        refineAccessPattern(LI->getPointerOperand(), Inst,
                            classifyPointer(LI->getPointerOperand(), SE));
    addOffChipAccess(Report, Arg, AccessKind::Read, Pattern, "load",
                     LI->getPointerOperand(), Inst, Loops, SE);
    if (!Arg) {
      const AllocaInst *AI = getBaseLocalAlloca(LI->getPointerOperand());
      addLocalAccess(Report, AI, AccessKind::Read, Pattern, "load",
                     LI->getPointerOperand(), Inst, Loops, SE);
    }
    return;
  }

  if (StoreInst *SI = dyn_cast<StoreInst>(&Inst)) {
    const Argument *Arg =
        resolveAccessArgument(SI->getPointerOperand(), Report, ArgAliases,
                              ArgSpillSlots);
    AccessPattern Pattern =
        refineAccessPattern(SI->getPointerOperand(), Inst,
                            classifyPointer(SI->getPointerOperand(), SE));
    addOffChipAccess(Report, Arg, AccessKind::Write, Pattern, "store",
                     SI->getPointerOperand(), Inst, Loops, SE);
    if (!Arg) {
      const AllocaInst *AI = getBaseLocalAlloca(SI->getPointerOperand());
      addLocalAccess(Report, AI, AccessKind::Write, Pattern, "store",
                     SI->getPointerOperand(), Inst, Loops, SE);
    }
    return;
  }

  if (AtomicRMWInst *RMW = dyn_cast<AtomicRMWInst>(&Inst)) {
    const Argument *Arg =
        resolveAccessArgument(RMW->getPointerOperand(), Report, ArgAliases,
                              ArgSpillSlots);
    AccessPattern Pattern =
        refineAccessPattern(RMW->getPointerOperand(), Inst,
                            classifyPointer(RMW->getPointerOperand(), SE));
    addOffChipAccess(Report, Arg, AccessKind::ReadWrite, Pattern, "atomicrmw",
                     RMW->getPointerOperand(), Inst, Loops, SE);
    return;
  }

  if (AtomicCmpXchgInst *CX = dyn_cast<AtomicCmpXchgInst>(&Inst)) {
    const Argument *Arg =
        resolveAccessArgument(CX->getPointerOperand(), Report, ArgAliases,
                              ArgSpillSlots);
    AccessPattern Pattern =
        refineAccessPattern(CX->getPointerOperand(), Inst,
                            classifyPointer(CX->getPointerOperand(), SE));
    addOffChipAccess(Report, Arg, AccessKind::ReadWrite, Pattern, "cmpxchg",
                     CX->getPointerOperand(), Inst, Loops, SE);
    return;
  }

  if (MemTransferInst *MT = dyn_cast<MemTransferInst>(&Inst)) {
    const Argument *Dst =
        resolveAccessArgument(MT->getDest(), Report, ArgAliases, ArgSpillSlots);
    const Argument *Src = resolveAccessArgument(MT->getSource(), Report,
                                                ArgAliases, ArgSpillSlots);
    const char *ReadOp = isa<MemMoveInst>(MT) ? "memmove.src" : "memcpy.src";
    const char *WriteOp = isa<MemMoveInst>(MT) ? "memmove.dst" : "memcpy.dst";
    addOffChipAccess(Report, Src, AccessKind::Read, AccessPattern::Burst,
                     ReadOp, MT->getSource(), Inst, Loops, SE);
    addOffChipAccess(Report, Dst, AccessKind::Write, AccessPattern::Burst,
                     WriteOp, MT->getDest(), Inst, Loops, SE);
    return;
  }

  if (MemSetInst *MS = dyn_cast<MemSetInst>(&Inst)) {
    const Argument *Dst =
        resolveAccessArgument(MS->getDest(), Report, ArgAliases, ArgSpillSlots);
    addOffChipAccess(Report, Dst, AccessKind::Write, AccessPattern::MemSet,
                     "memset", MS->getDest(), Inst, Loops, SE);
    return;
  }
}

static std::string roleForAccessId(StringRef Id) {
  if (Id.startswith("access:"))
    return "transaction";
  if (Id.startswith("local_access:"))
    return "local_buffer_access";
  return "unknown";
}

static void addDependencyEdge(FunctionMemoryReport &Report,
                              const std::string &SourceId,
                              const std::string &TargetId,
                              const std::string &Kind,
                              const std::string &Via,
                              const std::string &Reason,
                              const std::string &SourceIndex = "",
                              const std::string &TargetIndex = "") {
  if (SourceId.empty() || TargetId.empty() || SourceId == TargetId)
    return;
  for (const DependencyEdgeRecord &Existing : Report.DependencyEdges) {
    if (Existing.SourceId == SourceId && Existing.TargetId == TargetId &&
        Existing.Kind == Kind && Existing.Via == Via)
      return;
  }

  DependencyEdgeRecord Edge;
  Edge.Id = "dep:" + std::to_string(Report.DependencyEdges.size());
  Edge.SourceId = SourceId;
  Edge.TargetId = TargetId;
  Edge.Kind = Kind;
  Edge.Via = Via;
  Edge.Reason = Reason;
  Edge.SourceRole = roleForAccessId(SourceId);
  Edge.TargetRole = roleForAccessId(TargetId);
  Edge.SourceIndex = SourceIndex;
  Edge.TargetIndex = TargetIndex;
  Report.DependencyEdges.push_back(Edge);
}

static std::string accessIdForInstruction(const FunctionMemoryReport &Report,
                                          const Instruction *Inst) {
  auto OffIt = Report.OffChipAccessIds.find(Inst);
  if (OffIt != Report.OffChipAccessIds.end())
    return OffIt->second;
  auto LocalIt = Report.LocalAccessIds.find(Inst);
  if (LocalIt != Report.LocalAccessIds.end())
    return LocalIt->second;
  return "";
}

static void collectValueSourceAccessIds(const FunctionMemoryReport &Report,
                                        Value *V,
                                        std::set<const Value *> &Seen,
                                        std::set<std::string> &Sources,
                                        const std::map<const AllocaInst *,
                                                       std::set<std::string>>
                                            &AllocaSources,
                                        unsigned Depth = 0) {
  if (!V || Depth > 64 || !Seen.insert(V).second)
    return;

  V = V->stripPointerCasts();
  if (Instruction *Inst = dyn_cast<Instruction>(V)) {
    std::string Id = accessIdForInstruction(Report, Inst);
    if (!Id.empty()) {
      Sources.insert(Id);
      return;
    }
    if (LoadInst *Load = dyn_cast<LoadInst>(Inst)) {
      const AllocaInst *AI = getBaseLocalAlloca(Load->getPointerOperand());
      auto It = AllocaSources.find(AI);
      if (It != AllocaSources.end()) {
        Sources.insert(It->second.begin(), It->second.end());
        return;
      }
    }
    for (Use &Op : Inst->operands())
      collectValueSourceAccessIds(Report, Op.get(), Seen, Sources,
                                  AllocaSources, Depth + 1);
    return;
  }

  if (ConstantExpr *CE = dyn_cast<ConstantExpr>(V)) {
    for (Use &Op : CE->operands())
      collectValueSourceAccessIds(Report, Op.get(), Seen, Sources,
                                  AllocaSources, Depth + 1);
  }
}

static void collectValueSourceAccessIdsByPriorStores(
    const FunctionMemoryReport &Report, Value *V, Instruction &Limit,
    std::set<const Value *> &Seen, std::set<std::string> &Sources,
    unsigned Depth = 0) {
  if (!V || Depth > 64 || !Seen.insert(V).second)
    return;

  V = V->stripPointerCasts();
  if (Instruction *Inst = dyn_cast<Instruction>(V)) {
    std::string Id = accessIdForInstruction(Report, Inst);
    if (!Id.empty()) {
      Sources.insert(Id);
      return;
    }

    if (LoadInst *Load = dyn_cast<LoadInst>(Inst)) {
      const AllocaInst *AI = getBaseLocalAlloca(Load->getPointerOperand());
      if (AI) {
        bool ReachedLimit = false;
        for (BasicBlock &BB : *Limit.getFunction()) {
          for (Instruction &Candidate : BB) {
            if (&Candidate == &Limit) {
              ReachedLimit = true;
              break;
            }
            StoreInst *Store = dyn_cast<StoreInst>(&Candidate);
            if (!Store || getBaseLocalAlloca(Store->getPointerOperand()) != AI)
              continue;
            collectValueSourceAccessIdsByPriorStores(
                Report, Store->getValueOperand(), Limit, Seen, Sources,
                Depth + 1);
          }
          if (ReachedLimit)
            break;
        }
        return;
      }
    }

    for (Use &Op : Inst->operands())
      collectValueSourceAccessIdsByPriorStores(Report, Op.get(), Limit, Seen,
                                               Sources, Depth + 1);
    return;
  }

  if (ConstantExpr *CE = dyn_cast<ConstantExpr>(V)) {
    for (Use &Op : CE->operands())
      collectValueSourceAccessIdsByPriorStores(Report, Op.get(), Limit, Seen,
                                               Sources, Depth + 1);
  }
}

static const LocalAccessRecord *
findLocalAccessRecord(const FunctionMemoryReport &Report, StringRef Id) {
  for (const LocalAccessRecord &Access : Report.LocalAccesses)
    if (Access.Id == Id)
      return &Access;
  return nullptr;
}

static std::string normalizeIndexName(std::string Index) {
  while (!Index.empty() && std::isdigit(static_cast<unsigned char>(Index.back())))
    Index.pop_back();
  return Index;
}

static bool localIndexMayAlias(const LocalAccessRecord &Write,
                               const LocalAccessRecord &Read) {
  if (Write.Index == "unknown" || Read.Index == "unknown")
    return true;
  if (Write.Index == Read.Index)
    return true;
  if (normalizeIndexName(Write.Index) == normalizeIndexName(Read.Index))
    return true;
  bool WriteConstant = !Write.Index.empty() &&
                       std::all_of(Write.Index.begin(), Write.Index.end(),
                                   [](char C) {
                                     return std::isdigit(
                                         static_cast<unsigned char>(C));
                                   });
  bool ReadConstant = !Read.Index.empty() &&
                      std::all_of(Read.Index.begin(), Read.Index.end(),
                                  [](char C) {
                                    return std::isdigit(
                                        static_cast<unsigned char>(C));
                                  });
  if (WriteConstant && ReadConstant)
    return false;
  return true;
}

static void collectDefUseEdges(FunctionMemoryReport &Report, Function &F) {
  std::map<const AllocaInst *, std::set<std::string>> AllocaSources;

  for (BasicBlock &BB : F) {
    for (Instruction &Inst : BB) {
      std::string TargetId = accessIdForInstruction(Report, &Inst);

      Value *ValueOperand = nullptr;
      if (StoreInst *Store = dyn_cast<StoreInst>(&Inst))
        ValueOperand = Store->getValueOperand();
      else if (AtomicRMWInst *RMW = dyn_cast<AtomicRMWInst>(&Inst))
        ValueOperand = RMW->getValOperand();
      if (!ValueOperand)
        continue;

      std::set<const Value *> Seen;
      std::set<std::string> Sources;
      collectValueSourceAccessIds(Report, ValueOperand, Seen, Sources,
                                  AllocaSources);
      if (!TargetId.empty()) {
        for (const std::string &SourceId : Sources) {
          addDependencyEdge(
              Report, SourceId, TargetId, "llvm_def_use", "ssa_value",
              "stored value operand is defined by, or computed from, the source access");
        }
      }

      if (StoreInst *Store = dyn_cast<StoreInst>(&Inst)) {
        const AllocaInst *AI = getBaseLocalAlloca(Store->getPointerOperand());
        if (AI) {
          if (!TargetId.empty())
            Sources.insert(TargetId);
          AllocaSources[AI] = Sources;
        }
      }
    }
  }
}

static void collectLocalBufferRawEdges(FunctionMemoryReport &Report) {
  std::map<std::string, std::vector<const LocalAccessRecord *>> WritesByBuffer;
  for (const LocalAccessRecord &Access : Report.LocalAccesses) {
    if (Access.Type == "WRITE")
      WritesByBuffer[Access.Buffer].push_back(&Access);
  }

  for (const LocalAccessRecord &Read : Report.LocalAccesses) {
    if (Read.Type != "READ")
      continue;
    for (const LocalAccessRecord *Write : WritesByBuffer[Read.Buffer]) {
      if (!Write || Write->Sequence >= Read.Sequence)
        continue;
      if (!localIndexMayAlias(*Write, Read))
        continue;
      addDependencyEdge(Report, Write->Id, Read.Id, "local_buffer_raw",
                        Read.Buffer,
                        "local buffer read may consume the earlier write to the same buffer",
                        Write->Index, Read.Index);
    }
  }
}

static bool isWriteAccessId(const FunctionMemoryReport &Report, StringRef Id) {
  for (const OffChipAccessRecord &Access : Report.OffChipAccesses)
    if (Access.Id == Id)
      return Access.Type == "WRITE" || Access.Type == "READ_WRITE";
  for (const LocalAccessRecord &Access : Report.LocalAccesses)
    if (Access.Id == Id)
      return Access.Type == "WRITE" || Access.Type == "READ_WRITE";
  return false;
}

static std::set<const BasicBlock *> reachableBlocksFrom(const BasicBlock *Start) {
  std::set<const BasicBlock *> Seen;
  std::queue<const BasicBlock *> Work;
  if (Start)
    Work.push(Start);

  while (!Work.empty()) {
    const BasicBlock *BB = Work.front();
    Work.pop();
    if (!BB || !Seen.insert(BB).second)
      continue;
    for (const BasicBlock *Succ : successors(BB))
      Work.push(Succ);
  }
  return Seen;
}

static std::set<const BasicBlock *>
commonReachableBlocks(const std::vector<std::set<const BasicBlock *>> &Reachable) {
  std::set<const BasicBlock *> Common;
  if (Reachable.empty())
    return Common;
  Common = Reachable.front();
  for (unsigned I = 1; I < Reachable.size(); ++I) {
    std::set<const BasicBlock *> Next;
    for (const BasicBlock *BB : Common)
      if (Reachable[I].count(BB))
        Next.insert(BB);
    Common.swap(Next);
  }
  return Common;
}

static void collectControlDependencyEdges(FunctionMemoryReport &Report,
                                          Function &F) {
  std::map<const AllocaInst *, std::set<std::string>> AllocaSources;

  for (BasicBlock &BB : F) {
    for (Instruction &Inst : BB) {
      if (BranchInst *Branch = dyn_cast<BranchInst>(&Inst)) {
        if (Branch->isConditional()) {
          std::set<const Value *> Seen;
          std::set<std::string> ConditionSources;
          collectValueSourceAccessIds(Report, Branch->getCondition(), Seen,
                                      ConditionSources, AllocaSources);
          std::set<const Value *> PriorStoreSeen;
          collectValueSourceAccessIdsByPriorStores(
              Report, Branch->getCondition(), *Branch, PriorStoreSeen,
              ConditionSources);
          if (!ConditionSources.empty()) {
            for (unsigned I = 0; I < Branch->getNumSuccessors(); ++I) {
              BasicBlock *ImmediateSucc = Branch->getSuccessor(I);
              for (Instruction &ControlledInst : *ImmediateSucc) {
                std::string TargetId =
                    accessIdForInstruction(Report, &ControlledInst);
                if (TargetId.empty() || !isWriteAccessId(Report, TargetId))
                  continue;
                for (const std::string &SourceId : ConditionSources)
                  addDependencyEdge(
                      Report, SourceId, TargetId, "control_dependency",
                      "branch_condition",
                      "memory write is control-dependent on a branch condition computed from the source access");
              }
            }

            std::vector<std::set<const BasicBlock *>> ReachableBySuccessor;
            for (unsigned I = 0; I < Branch->getNumSuccessors(); ++I)
              ReachableBySuccessor.push_back(
                  reachableBlocksFrom(Branch->getSuccessor(I)));
            std::set<const BasicBlock *> Common =
                commonReachableBlocks(ReachableBySuccessor);

            for (const std::set<const BasicBlock *> &Reachable :
                 ReachableBySuccessor) {
              for (const BasicBlock *ControlledBB : Reachable) {
                if (!ControlledBB || Common.count(ControlledBB))
                  continue;
                for (const Instruction &ControlledInst : *ControlledBB) {
                  std::string TargetId =
                      accessIdForInstruction(Report, &ControlledInst);
                  if (TargetId.empty() || !isWriteAccessId(Report, TargetId))
                    continue;
                  for (const std::string &SourceId : ConditionSources)
                    addDependencyEdge(
                        Report, SourceId, TargetId, "control_dependency",
                        "branch_condition",
                        "memory write is control-dependent on a branch condition computed from the source access");
                }
              }
            }
          }
        }
      }

      if (StoreInst *Store = dyn_cast<StoreInst>(&Inst)) {
        std::set<const Value *> Seen;
        std::set<std::string> Sources;
        collectValueSourceAccessIds(Report, Store->getValueOperand(), Seen,
                                    Sources, AllocaSources);
        const AllocaInst *AI = getBaseLocalAlloca(Store->getPointerOperand());
        if (AI) {
          std::string TargetId = accessIdForInstruction(Report, &Inst);
          if (!TargetId.empty())
            Sources.insert(TargetId);
          AllocaSources[AI] = Sources;
        }
      }
    }
  }
}

void collectDependencyEdges(FunctionMemoryReport &Report, Function &F,
                            bool IncludeLocalBufferRawEdges) {
  collectDefUseEdges(Report, F);
  collectControlDependencyEdges(Report, F);
  if (IncludeLocalBufferRawEdges)
    collectLocalBufferRawEdges(Report);
}

void collectDependencyEdges(FunctionMemoryReport &Report, Function &F) {
  collectDependencyEdges(Report, F, true);
}

} // namespace hls_mem
