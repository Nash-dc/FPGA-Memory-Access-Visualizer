#ifndef INTERPROCEDURAL_ANALYSIS_H
#define INTERPROCEDURAL_ANALYSIS_H

#include "MemoryAnalysis.h"

#include "llvm/Pass.h"

namespace hls_mem {

void collectInterproceduralAccesses(llvm::ModulePass &Pass,
                                    FunctionMemoryReport &Report,
                                    llvm::Function &TopFunction);

} // namespace hls_mem

#endif
