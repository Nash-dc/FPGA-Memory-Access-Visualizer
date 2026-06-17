#ifndef PRAGMA_PARSER_H
#define PRAGMA_PARSER_H

#include "MemoryAnalysis.h"
#include "llvm/IR/Instructions.h"

namespace hls_mem {

void collectPragmas(FunctionMemoryReport &Report, llvm::Instruction &Inst);

} // namespace hls_mem

#endif
