#ifndef IR_UTILS_H
#define IR_UTILS_H

#include "MemoryAnalysis.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/IR/Argument.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Value.h"

#include <map>
#include <string>

namespace hls_mem {

std::string getValueName(const llvm::Value *V);
std::string getValueText(const llvm::Value *V);
std::string getInstructionLocation(const llvm::Instruction &Inst);

const llvm::Argument *getBaseArgument(llvm::Value *V);
const llvm::Argument *
getBaseArgument(llvm::Value *V,
                const std::map<const llvm::AllocaInst *,
                               const llvm::Argument *> &ArgSpillSlots);
AccessPattern classifyPointer(llvm::Value *Ptr, llvm::ScalarEvolution *SE);

} // namespace hls_mem

#endif
