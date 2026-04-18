#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Value.h"
#include "llvm/Support/raw_ostream.h"
#include <map>
#include <string>
#include <set>

using namespace llvm;

static Value* getUnderlyingPointer(Value *V) {
    V = V->stripPointerCasts();
    while (V) {
        if (isa<Argument>(V)) return V;
        if (auto *GEP = dyn_cast<GetElementPtrInst>(V)) {
            V = GEP->getPointerOperand()->stripPointerCasts();
        } else if (auto *Sel = dyn_cast<SelectInst>(V)) {
            V = Sel->getTrueValue()->stripPointerCasts();
        } else if (auto *PHI = dyn_cast<PHINode>(V)) {
            if (PHI->getNumIncomingValues() > 0)
                V = PHI->getIncomingValue(0)->stripPointerCasts();
            else break;
        } else {
            break;
        }
    }
    return nullptr;
}

struct MemoryAccessPass : public FunctionPass {
    static char ID;
    MemoryAccessPass() : FunctionPass(ID) {}

    bool runOnFunction(Function &F) override {
        bool hasPtrArg = false;
        for (auto &Arg : F.args())
            if (Arg.getType()->isPointerTy()) { hasPtrArg = true; break; }
        if (!hasPtrArg) return false;

        errs() << "\n" << std::string(60, '=') << "\n";
        errs() << "[MemAccessPass] Analyzing kernel: " << F.getName().str() << "\n";

        struct AccessInfo { int reads = 0, writes = 0; std::string pattern = "unknown"; };
        std::map<std::string, AccessInfo> stats;

        for (auto &BB : F) {
            for (auto &I : BB) {
                Value *ptrOp = nullptr;
                bool isWrite = false;

                if (auto *LI = dyn_cast<LoadInst>(&I)) {
                    ptrOp = LI->getPointerOperand();
                } else if (auto *SI = dyn_cast<StoreInst>(&I)) {
                    ptrOp = SI->getPointerOperand();
                    isWrite = true;
                }

                if (!ptrOp) continue;

                Value *baseArg = getUnderlyingPointer(ptrOp);
                if (baseArg && isa<Argument>(baseArg)) {
                    auto *Arg = cast<Argument>(baseArg);
                    std::string argName = Arg->getName().str();
                    if (argName.empty()) argName = "arg" + std::to_string(Arg->getArgNo());

                    std::string pat = "scalar";
                    if (auto *GEP = dyn_cast<GetElementPtrInst>(ptrOp)) {
                        bool hasVarIdx = false;
                        for (unsigned i = 1; i < GEP->getNumOperands(); ++i) {
                            if (!isa<Constant>(GEP->getOperand(i))) { hasVarIdx = true; break; }
                        }
                        pat = hasVarIdx ? "loop_stride" : "constant_offset";
                    }

                    if (isWrite) { stats[argName].writes++; stats[argName].pattern = pat; }
                    else         { stats[argName].reads++;  stats[argName].pattern = pat; }

                    errs() << "  [" << (isWrite ? "WRITE" : "READ") << "] " << argName
                           << " (pattern: " << pat << ")\n";
                }
            }
        }

        errs() << "\n--- SUMMARY ---\n";
        for (auto &kv : stats) {
            errs() << "ARG [" << kv.first << "]: READ=" << kv.second.reads
                   << ", WRITE=" << kv.second.writes << ", PATTERN=" << kv.second.pattern << "\n";
        }
        errs() << std::string(60, '=') << "\n";
        return false;
    }
};

char MemoryAccessPass::ID = 0;
static RegisterPass<MemoryAccessPass> X("mem-access-pass", "HLS Off-chip Memory Access Analyzer", false, true);
