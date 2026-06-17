#include "AnalysisDriver.h"
#include "InterproceduralAnalysis.h"
#include "ReportPrinter.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"

using namespace llvm;
using namespace hls_mem;

namespace {

struct MemoryAccessPass : public ModulePass {
  static char ID;
  FunctionNameSet TopFunctions;

  MemoryAccessPass() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    TopFunctions = collectTopFunctions(M);

    for (Function &F : M) {
      if (!shouldAnalyzeFunction(F, TopFunctions))
        continue;

      ScalarEvolution *SE = &getAnalysis<ScalarEvolutionWrapperPass>(F).getSE();
      llvm::LoopInfo *LI = &getAnalysis<LoopInfoWrapperPass>(F).getLoopInfo();

      FunctionMemoryReport Report = analyzeFunction(F, SE, LI);
      collectInterproceduralAccesses(*this, Report, F);
      printReport(Report);
    }

    return false;
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<ScalarEvolutionWrapperPass>();
    AU.addRequired<LoopInfoWrapperPass>();
    AU.setPreservesAll();
  }
};

} // namespace

char MemoryAccessPass::ID = 0;
static RegisterPass<MemoryAccessPass>
    X("mem-access-pass", "HLS Off-chip Memory Access Analyzer", false, true);
