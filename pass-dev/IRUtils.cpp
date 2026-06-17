#include "IRUtils.h"

#include "llvm/ADT/APInt.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/Support/raw_ostream.h"

#include <set>

using namespace llvm;

namespace hls_mem {

std::string getValueName(const Value *V) {
  if (!V)
    return "";

  if (const Argument *Arg = dyn_cast<Argument>(V)) {
    if (Arg->hasName())
      return Arg->getName().str();
    return "arg" + std::to_string(Arg->getArgNo());
  }

  if (V->hasName())
    return V->getName().str();

  std::string Text;
  raw_string_ostream OS(Text);
  V->printAsOperand(OS, false);
  return OS.str();
}

static std::string getConstantString(const Value *V) {
  if (!V)
    return "";

  if (const ConstantDataArray *CDA = dyn_cast<ConstantDataArray>(V)) {
    if (CDA->isString())
      return CDA->getAsString().str();
  }

  if (const ConstantAggregateZero *CAZ = dyn_cast<ConstantAggregateZero>(V)) {
    if (CAZ->getType()->isArrayTy())
      return "";
  }

  if (const ConstantInt *CI = dyn_cast<ConstantInt>(V))
    return std::to_string(CI->getSExtValue());

  if (const ConstantExpr *CE = dyn_cast<ConstantExpr>(V)) {
    if (CE->getOpcode() == Instruction::BitCast ||
        CE->getOpcode() == Instruction::GetElementPtr)
      return getConstantString(CE->getOperand(0));
  }

  if (const GlobalVariable *GV = dyn_cast<GlobalVariable>(V)) {
    if (GV->hasInitializer())
      return getConstantString(GV->getInitializer());
  }

  return getValueName(V);
}

std::string getValueText(const Value *V) {
  std::string ConstText = getConstantString(V);
  if (!ConstText.empty())
    return ConstText;

  if (isa<ConstantAggregateZero>(V))
    return "";

  return getValueName(V);
}

const Argument *getBaseArgument(Value *V) {
  static const std::map<const AllocaInst *, const Argument *> EmptySpills;
  return getBaseArgument(V, EmptySpills);
}

const Argument *
getBaseArgument(Value *V,
                const std::map<const AllocaInst *, const Argument *>
                    &ArgSpillSlots) {
  if (!V)
    return nullptr;

  std::set<Value *> Seen;
  V = V->stripPointerCasts();

  while (V && Seen.insert(V).second) {
    if (Argument *Arg = dyn_cast<Argument>(V))
      return Arg;

    if (LoadInst *LI = dyn_cast<LoadInst>(V)) {
      Value *LoadPtr = LI->getPointerOperand()->stripPointerCasts();
      if (AllocaInst *AI = dyn_cast<AllocaInst>(LoadPtr)) {
        auto It = ArgSpillSlots.find(AI);
        if (It != ArgSpillSlots.end())
          return It->second;
      }
      break;
    }

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

    if (SelectInst *Sel = dyn_cast<SelectInst>(V)) {
      const Argument *TrueArg =
          getBaseArgument(Sel->getTrueValue(), ArgSpillSlots);
      const Argument *FalseArg =
          getBaseArgument(Sel->getFalseValue(), ArgSpillSlots);
      if (TrueArg && TrueArg == FalseArg)
        return TrueArg;
      return TrueArg ? TrueArg : FalseArg;
    }

    if (PHINode *PHI = dyn_cast<PHINode>(V)) {
      const Argument *FirstArg = nullptr;
      for (unsigned I = 0; I < PHI->getNumIncomingValues(); ++I) {
        const Argument *IncomingArg =
            getBaseArgument(PHI->getIncomingValue(I), ArgSpillSlots);
        if (!IncomingArg)
          continue;
        if (!FirstArg)
          FirstArg = IncomingArg;
        else if (FirstArg != IncomingArg)
          return nullptr;
      }
      return FirstArg;
    }

    break;
  }

  return nullptr;
}

static bool isConstantIndex(Value *V) {
  return isa<ConstantInt>(V) || isa<ConstantAggregateZero>(V);
}

static bool isLikelySequentialSCEV(Value *Index, ScalarEvolution *SE) {
  if (!Index || !SE)
    return false;
  if (!SE->isSCEVable(Index->getType()))
    return false;

  const SCEV *Expr = SE->getSCEV(Index);
  const SCEVAddRecExpr *AddRec = dyn_cast<SCEVAddRecExpr>(Expr);
  if (!AddRec || !AddRec->isAffine())
    return false;

  const SCEVConstant *Step =
      dyn_cast<SCEVConstant>(AddRec->getStepRecurrence(*SE));
  if (!Step)
    return false;

  return Step->getAPInt().abs() == 1;
}

static bool isStridedSCEV(Value *Index, ScalarEvolution *SE) {
  if (!Index || !SE)
    return false;
  if (!SE->isSCEVable(Index->getType()))
    return false;

  const SCEV *Expr = SE->getSCEV(Index);
  const SCEVAddRecExpr *AddRec = dyn_cast<SCEVAddRecExpr>(Expr);
  return AddRec && AddRec->isAffine();
}

AccessPattern classifyPointer(Value *Ptr, ScalarEvolution *SE) {
  if (!Ptr)
    return AccessPattern::Unknown;

  Ptr = Ptr->stripPointerCasts();

  GetElementPtrInst *InstGEP = dyn_cast<GetElementPtrInst>(Ptr);
  GEPOperator *OpGEP = dyn_cast<GEPOperator>(Ptr);

  if (!InstGEP && !OpGEP) {
    if (isa<Argument>(Ptr))
      return AccessPattern::Scalar;
    return AccessPattern::Unknown;
  }

  unsigned NumOperands =
      InstGEP ? InstGEP->getNumOperands() : OpGEP->getNumOperands();
  bool HasVariableIndex = false;
  bool HasSequentialIndex = false;
  bool HasStridedIndex = false;
  bool HasIndirectIndex = false;

  for (unsigned I = 1; I < NumOperands; ++I) {
    Value *Index = InstGEP ? InstGEP->getOperand(I) : OpGEP->getOperand(I);
    if (isConstantIndex(Index))
      continue;

    HasVariableIndex = true;

    if (isLikelySequentialSCEV(Index, SE)) {
      HasSequentialIndex = true;
      continue;
    }

    if (isStridedSCEV(Index, SE)) {
      HasStridedIndex = true;
      continue;
    }

    HasIndirectIndex = true;
  }

  if (!HasVariableIndex)
    return AccessPattern::ConstantOffset;
  if (HasIndirectIndex)
    return AccessPattern::Indirect;
  if (HasStridedIndex)
    return AccessPattern::Strided;
  if (HasSequentialIndex)
    return AccessPattern::Sequential;
  return AccessPattern::Unknown;
}

std::string getInstructionLocation(const Instruction &Inst) {
  std::string Text;
  raw_string_ostream OS(Text);
  OS << Inst.getParent()->getName() << ": ";
  Inst.print(OS);
  return OS.str();
}

} // namespace hls_mem
