#include "InterproceduralAnalysis.h"

#include "IRUtils.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"

#include <set>

using namespace llvm;

namespace hls_mem {
namespace {

class InterproceduralAccessCollector {
public:
  explicit InterproceduralAccessCollector(ModulePass &Pass) : Pass(Pass) {}

  void collect(FunctionMemoryReport &Report, Function &TopFunction) {
    ArgumentAliasMap EmptyAliases;
    collectCalleeAccesses(Report, TopFunction, EmptyAliases,
                          Report.ArgSpillSlots, 0);
    collectDependencyEdges(Report, TopFunction);
  }

private:
  ModulePass &Pass;
  std::set<const Function *> ActiveFunctions;

  static bool shouldDescendIntoCallee(const Function *Callee) {
    if (!Callee || Callee->isDeclaration())
      return false;
    if (Callee->isIntrinsic())
      return false;
    if (Callee->getName().startswith("llvm."))
      return false;
    return true;
  }

  static ArgumentSpillSlotMap collectSpillSlots(Function &F) {
    FunctionMemoryReport Scratch;
    for (BasicBlock &BB : F) {
      for (Instruction &Inst : BB)
        collectArgumentSpill(Scratch, Inst);
    }
    return Scratch.ArgSpillSlots;
  }

  static const Argument *
  mapActualToTopArgument(Value *Actual,
                         const ArgumentSpillSlotMap &CallerSpills,
                         const ArgumentAliasMap &CallerAliases,
                         const FunctionMemoryReport &TopReport) {
    const Argument *Arg = getBaseArgument(Actual, CallerSpills);
    if (!Arg)
      return nullptr;

    auto AliasIt = CallerAliases.find(Arg);
    if (AliasIt != CallerAliases.end())
      Arg = AliasIt->second;

    if (!Arg || !TopReport.AxiPorts.count(Arg))
      return nullptr;
    return Arg;
  }

  static bool buildCalleeAliases(FunctionMemoryReport &TopReport, CallInst &CI,
                                 Function &Callee,
                                 const ArgumentAliasMap &CallerAliases,
                                 const ArgumentSpillSlotMap &CallerSpills,
                                 ArgumentAliasMap &CalleeAliases) {
    unsigned ArgCount =
        std::min<unsigned>(CI.getNumArgOperands(), Callee.arg_size());
    for (unsigned I = 0; I < ArgCount; ++I) {
      Argument *Formal = Callee.getArg(I);
      if (!Formal->getType()->isPointerTy())
        continue;

      const Argument *TopArg = mapActualToTopArgument(
          CI.getArgOperand(I), CallerSpills, CallerAliases, TopReport);
      if (TopArg)
        CalleeAliases[Formal] = TopArg;
    }

    return !CalleeAliases.empty();
  }

  void collectCalleeAccesses(FunctionMemoryReport &TopReport, Function &Caller,
                             const ArgumentAliasMap &CallerAliases,
                             const ArgumentSpillSlotMap &CallerSpills,
                             unsigned Depth) {
    if (Depth > 8)
      return;

    for (BasicBlock &BB : Caller) {
      for (Instruction &Inst : BB) {
        CallInst *CI = dyn_cast<CallInst>(&Inst);
        if (!CI)
          continue;

        Function *Callee = CI->getCalledFunction();
        if (!shouldDescendIntoCallee(Callee))
          continue;

        ArgumentAliasMap CalleeAliases;
        if (!buildCalleeAliases(TopReport, *CI, *Callee, CallerAliases,
                                CallerSpills, CalleeAliases))
          continue;

        collectFunctionBodyInContext(TopReport, *Callee, CalleeAliases,
                                     Depth + 1);
      }
    }
  }

  void collectFunctionBodyInContext(FunctionMemoryReport &TopReport,
                                    Function &F,
                                    const ArgumentAliasMap &Aliases,
                                    unsigned Depth) {
    if (Depth > 8)
      return;
    if (!ActiveFunctions.insert(&F).second)
      return;

    ScalarEvolution *SE = &Pass.getAnalysis<ScalarEvolutionWrapperPass>(F).getSE();
    llvm::LoopInfo *LI = &Pass.getAnalysis<LoopInfoWrapperPass>(F).getLoopInfo();
    ArgumentSpillSlotMap Spills = collectSpillSlots(F);

    for (BasicBlock &BB : F) {
      for (Instruction &Inst : BB) {
        collectMemoryAccess(TopReport, Inst, SE, LI, &Aliases, &Spills);
      }
    }

    collectDependencyEdges(TopReport, F, false);
    collectCalleeAccesses(TopReport, F, Aliases, Spills, Depth);
    ActiveFunctions.erase(&F);
  }
};

} // namespace

void collectInterproceduralAccesses(ModulePass &Pass,
                                    FunctionMemoryReport &Report,
                                    Function &TopFunction) {
  InterproceduralAccessCollector(Pass).collect(Report, TopFunction);
}

} // namespace hls_mem
