#ifndef ANALYSIS_DRIVER_H
#define ANALYSIS_DRIVER_H

#include "MemoryAnalysis.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"

#include <set>
#include <string>

namespace hls_mem {

using FunctionNameSet = std::set<std::string>;

FunctionNameSet collectTopFunctions(llvm::Module &M);
bool shouldAnalyzeFunction(const llvm::Function &F, const FunctionNameSet &TopFunctions);
FunctionMemoryReport analyzeFunction(llvm::Function &F, llvm::ScalarEvolution *SE,
                                     llvm::LoopInfo *LI);

} // namespace hls_mem

#endif
