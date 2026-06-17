#include "AnalysisDriver.h"

#include "PragmaParser.h"

#include "llvm/IR/Attributes.h"
#include "llvm/IR/Instructions.h"

using namespace llvm;

namespace hls_mem {

FunctionNameSet collectTopFunctions(Module &M) 
{
  FunctionNameSet TopFunctions;
  for (Function &F : M) {
    if (F.isDeclaration())
      continue;
    if (F.hasFnAttribute("fpga.top.func"))
      TopFunctions.insert(F.getName().str());
  }
  return TopFunctions;
}

static bool hasPointerArgument(const Function &F) 
{
  for (const Argument &Arg : F.args()) {
    if (Arg.getType()->isPointerTy())
      return true;
  }
  return false;
}

bool shouldAnalyzeFunction(const Function &F, const FunctionNameSet &TopFunctions) 
{
  if (F.isDeclaration())
    return false;
  if (!TopFunctions.empty() && !TopFunctions.count(F.getName().str()))
    return false;
  return hasPointerArgument(F);
}

static std::string getDisplayFunctionName(const Function &F) 
{
  if (F.hasFnAttribute("fpga.demangled.name"))
    return F.getFnAttribute("fpga.demangled.name").getValueAsString().str();
  if (F.hasFnAttribute("fpga.top.func"))
    return F.getFnAttribute("fpga.top.func").getValueAsString().str();
  return F.getName().str();
}

static FunctionMemoryReport initializeReport(Function &F) 
{
  FunctionMemoryReport Report;
  Report.FunctionName = F.getName().str();
  Report.DisplayFunctionName = getDisplayFunctionName(F);
  return Report;
}

static void collectInterfaceAndSpillInfo(FunctionMemoryReport &Report, Function &F) 
{
  for (BasicBlock &BB : F) {
    for (Instruction &Inst : BB) {
      collectPragmas(Report, Inst);
      collectArgumentSpill(Report, Inst);
    }
  }
}

static void collectMemoryAccesses(FunctionMemoryReport &Report, Function &F,
                                  ScalarEvolution *SE, llvm::LoopInfo *LI)
{
  for (BasicBlock &BB : F) {
    for (Instruction &Inst : BB)
      collectMemoryAccess(Report, Inst, SE, LI);
  }
}

FunctionMemoryReport analyzeFunction(Function &F, ScalarEvolution *SE, llvm::LoopInfo *LI) 
{
  FunctionMemoryReport Report = initializeReport(F);
  collectInterfaceAndSpillInfo(Report, F);
  collectMemoryAccesses(Report, F, SE, LI);
  collectDependencyEdges(Report, F);
  return Report;
}

}
