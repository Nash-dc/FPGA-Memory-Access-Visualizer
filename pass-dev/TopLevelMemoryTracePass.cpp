#include "llvm/ADT/DenseMap.h"
#include "llvm/IR/Argument.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/raw_ostream.h"

#include <map>
#include <memory>
#include <set>
#include <system_error>
#include <vector>

using namespace llvm;

namespace {

cl::opt<std::string> ManifestPath(
    "top-level-memory-trace-manifest",
    cl::init("top_level_memory_sites.tsv"),
    cl::desc("Path for the top-level argument memory instrumentation manifest"));

cl::list<std::string> TraceRoots(
    "top-level-memory-trace-root",
    cl::desc("Top function name to trace. May be repeated."));

struct TopLevelMemoryTracePass : public ModulePass {
  static char ID;

  TopLevelMemoryTracePass() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    LLVMContext &Context = M.getContext();
    TraceFunction = M.getOrInsertFunction(
        "__hlslitesim_trace_top_level_memory",
        FunctionType::get(
            Type::getVoidTy(Context),
            {
                Type::getInt8PtrTy(Context),
                Type::getInt8PtrTy(Context),
                Type::getInt32Ty(Context),
                Type::getInt8PtrTy(Context),
                Type::getInt32Ty(Context),
                Type::getInt64Ty(Context),
                Type::getInt32Ty(Context),
            },
            false));
    PushContextFunction = M.getOrInsertFunction(
        "__hlslitesim_push_arg_context",
        FunctionType::get(Type::getVoidTy(Context),
                          {Type::getInt8PtrTy(Context)}, false));
    MapContextArgFunction = M.getOrInsertFunction(
        "__hlslitesim_map_arg_context",
        FunctionType::get(
            Type::getVoidTy(Context),
            {
                Type::getInt32Ty(Context),
                Type::getInt8PtrTy(Context),
                Type::getInt8PtrTy(Context),
                Type::getInt32Ty(Context),
                Type::getInt8PtrTy(Context),
                Type::getInt64Ty(Context),
            },
            false));
    PopContextFunction = M.getOrInsertFunction(
        "__hlslitesim_pop_arg_context",
        FunctionType::get(Type::getVoidTy(Context), {}, false));
    RegisterRootFunction = M.getOrInsertFunction(
        "__hlslitesim_register_root_context",
        FunctionType::get(Type::getVoidTy(Context),
                          {Type::getInt8PtrTy(Context)}, false));

    std::error_code EC;
    Manifest = std::make_unique<raw_fd_ostream>(
        ManifestPath, EC, sys::fs::F_Text);
    if (EC) {
      errs() << "[top-level-memory-trace] cannot open " << ManifestPath
             << ": " << EC.message() << "\n";
      Manifest.reset();
    } else {
      *Manifest << "site_id\tfunction\tbasic_block\tevent\targument"
                   "\targument_index\tbytes\tpointer\tinstruction\n";
    }

    collectInstrumentableFunctions(M);

    bool Modified = false;
    for (Function &F : M) {
      if (!isTraceable(F))
        continue;
      if (!shouldInstrumentFunction(F))
        continue;
      Modified |= instrumentFunction(F);
    }
    Manifest.reset();
    return Modified;
  }

private:
  Constant *TraceFunction = nullptr;
  Constant *PushContextFunction = nullptr;
  Constant *MapContextArgFunction = nullptr;
  Constant *PopContextFunction = nullptr;
  Constant *RegisterRootFunction = nullptr;
  std::unique_ptr<raw_fd_ostream> Manifest;
  std::set<const Function *> RootFunctions;
  std::set<const Function *> InstrumentableFunctions;
  std::map<const Function *, std::set<unsigned>> TrackedArgsByFunction;
  unsigned NextSiteID = 0;

  bool isTraceable(const Function &F) const {
    return !F.isDeclaration() &&
           !F.getName().startswith("_ssdm_op_") &&
           !F.getName().startswith("__hlslitesim_");
  }

  bool functionMatchesRoot(const Function &F, StringRef Root) const {
    if (Root.empty())
      return false;
    return F.getName() == Root || F.getName().contains(Root);
  }

  bool shouldInstrumentFunction(const Function &F) const {
    if (TraceRoots.empty())
      return true;
    return InstrumentableFunctions.count(&F);
  }

  bool isTrackedArgument(const Function &F, const Argument *Arg) const {
    if (!Arg)
      return false;
    if (TraceRoots.empty())
      return true;
    auto It = TrackedArgsByFunction.find(&F);
    if (It == TrackedArgsByFunction.end())
      return false;
    return It->second.count(Arg->getArgNo());
  }

  bool markTrackedArgument(Function &F, unsigned ArgNo) {
    InstrumentableFunctions.insert(&F);
    return TrackedArgsByFunction[&F].insert(ArgNo).second;
  }

  Function *calledFunction(Instruction &Inst) const {
    if (auto *Call = dyn_cast<CallInst>(&Inst))
      return Call->getCalledFunction();
    if (auto *Invoke = dyn_cast<InvokeInst>(&Inst))
      return Invoke->getCalledFunction();
    return nullptr;
  }

  unsigned numCallArguments(Instruction &Inst) const {
    if (auto *Call = dyn_cast<CallInst>(&Inst))
      return Call->getNumArgOperands();
    if (auto *Invoke = dyn_cast<InvokeInst>(&Inst))
      return Invoke->getNumArgOperands();
    return 0;
  }

  Value *callArgument(Instruction &Inst, unsigned Index) const {
    if (auto *Call = dyn_cast<CallInst>(&Inst))
      return Call->getArgOperand(Index);
    if (auto *Invoke = dyn_cast<InvokeInst>(&Inst))
      return Invoke->getArgOperand(Index);
    return nullptr;
  }

  void seedRootFunctions(Module &M, std::vector<Function *> &Worklist) {
    if (TraceRoots.empty()) {
      for (Function &F : M)
        if (isTraceable(F))
          InstrumentableFunctions.insert(&F);
      return;
    }

    for (Function &F : M) {
      if (!isTraceable(F))
        continue;
      bool IsRoot = false;
      for (const std::string &Root : TraceRoots) {
        if (functionMatchesRoot(F, Root)) {
          IsRoot = true;
          break;
        }
      }
      if (!IsRoot)
        continue;
      RootFunctions.insert(&F);

      bool AddedAny = false;
      for (Argument &Arg : F.args()) {
        if (!Arg.getType()->isPointerTy())
          continue;
        AddedAny |= markTrackedArgument(F, Arg.getArgNo());
      }
      if (AddedAny)
        Worklist.push_back(&F);
    }
  }

  void collectInstrumentableFunctions(Module &M) {
    std::vector<Function *> Worklist;
    seedRootFunctions(M, Worklist);
    for (unsigned I = 0; I < Worklist.size(); ++I) {
      Function *Caller = Worklist[I];
      if (!Caller)
        continue;
      DenseMap<const AllocaInst *, Argument *> Spills =
          collectArgumentSpills(*Caller);
      for (BasicBlock &BB : *Caller) {
        for (Instruction &Inst : BB) {
          Function *Callee = calledFunction(Inst);
          if (!Callee)
            continue;
          if (!shouldTrackCallContext(Callee))
            continue;

          bool AddedCallee = false;
          unsigned ArgCount =
              std::min<unsigned>(numCallArguments(Inst), Callee->arg_size());
          for (unsigned ArgIndex = 0; ArgIndex < ArgCount; ++ArgIndex) {
            Argument *Formal = Callee->getArg(ArgIndex);
            if (!Formal->getType()->isPointerTy())
              continue;
            Argument *CallerArgument =
                findBaseArgument(callArgument(Inst, ArgIndex), Spills);
            if (!isTrackedArgument(*Caller, CallerArgument))
              continue;
            AddedCallee |= markTrackedArgument(*Callee, Formal->getArgNo());
          }
          if (AddedCallee)
            Worklist.push_back(Callee);
        }
      }
    }
  }

  DenseMap<const AllocaInst *, Argument *> collectArgumentSpills(Function &F) {
    DenseMap<const AllocaInst *, Argument *> Spills;
    for (BasicBlock &BB : F) {
      for (Instruction &I : BB) {
        auto *Store = dyn_cast<StoreInst>(&I);
        if (!Store)
          continue;
        auto *Arg =
            dyn_cast<Argument>(Store->getValueOperand()->stripPointerCasts());
        auto *Slot =
            dyn_cast<AllocaInst>(Store->getPointerOperand()->stripPointerCasts());
        if (Arg && Slot && Arg->getType()->isPointerTy())
          Spills[Slot] = Arg;
      }
    }
    return Spills;
  }

  Argument *findBaseArgument(
      Value *V, const DenseMap<const AllocaInst *, Argument *> &Spills) const {
    if (!V)
      return nullptr;
    V = V->stripPointerCasts();
    if (auto *Arg = dyn_cast<Argument>(V))
      return Arg->getType()->isPointerTy() ? Arg : nullptr;
    if (auto *GEP = dyn_cast<GetElementPtrInst>(V))
      return findBaseArgument(GEP->getPointerOperand(), Spills);
    if (auto *Load = dyn_cast<LoadInst>(V)) {
      auto *Slot =
          dyn_cast<AllocaInst>(Load->getPointerOperand()->stripPointerCasts());
      auto It = Slot ? Spills.find(Slot) : Spills.end();
      return It == Spills.end() ? nullptr : It->second;
    }
    if (auto *Select = dyn_cast<SelectInst>(V)) {
      Argument *TrueArg = findBaseArgument(Select->getTrueValue(), Spills);
      Argument *FalseArg = findBaseArgument(Select->getFalseValue(), Spills);
      return TrueArg == FalseArg ? TrueArg : nullptr;
    }
    if (auto *Phi = dyn_cast<PHINode>(V)) {
      Argument *Base = nullptr;
      for (Value *Incoming : Phi->incoming_values()) {
        Argument *IncomingBase = findBaseArgument(Incoming, Spills);
        if (!IncomingBase)
          return nullptr;
        if (Base && Base != IncomingBase)
          return nullptr;
        Base = IncomingBase;
      }
      return Base;
    }
    return nullptr;
  }

  bool instrumentFunction(Function &F) {
    const DataLayout &Layout = F.getParent()->getDataLayout();
    DenseMap<const AllocaInst *, Argument *> Spills = collectArgumentSpills(F);
    std::vector<Instruction *> Accesses;
    std::vector<Instruction *> Calls;
    for (BasicBlock &BB : F) {
      for (Instruction &I : BB) {
        if (isa<LoadInst>(&I) || isa<StoreInst>(&I) ||
            isa<MemTransferInst>(&I) || isa<MemSetInst>(&I))
          Accesses.push_back(&I);
        if (isa<CallInst>(&I) || isa<InvokeInst>(&I))
          Calls.push_back(&I);
      }
    }

    bool Modified = false;
    if (RootFunctions.count(&F)) {
      IRBuilder<> EntryBuilder(&*F.getEntryBlock().getFirstInsertionPt());
      EntryBuilder.CreateCall(RegisterRootFunction,
                              {EntryBuilder.CreateGlobalStringPtr(F.getName())});
      Modified = true;
    }
    for (Instruction *Call : Calls)
      Modified |= instrumentCallContext(F, *Call, Spills);

    for (Instruction *I : Accesses) {
      if (auto *MT = dyn_cast<MemTransferInst>(I)) {
        Modified |= instrumentPointerAccess(F, *I, MT->getSource(),
                                            MT->getLength(), "arg_read",
                                            Spills);
        Modified |= instrumentPointerAccess(F, *I, MT->getDest(),
                                            MT->getLength(), "arg_write",
                                            Spills);
        continue;
      }

      if (auto *MS = dyn_cast<MemSetInst>(I)) {
        Modified |= instrumentPointerAccess(F, *I, MS->getDest(),
                                            MS->getLength(), "arg_write",
                                            Spills);
        continue;
      }

      Value *Pointer = nullptr;
      Type *AccessType = nullptr;
      StringRef Event;
      if (auto *Load = dyn_cast<LoadInst>(I)) {
        Pointer = Load->getPointerOperand();
        AccessType = Load->getType();
        Event = "arg_read";
      } else {
        auto *Store = cast<StoreInst>(I);
        Pointer = Store->getPointerOperand();
        AccessType = Store->getValueOperand()->getType();
        Event = "arg_write";
      }

      Argument *Arg = findBaseArgument(Pointer, Spills);
      if (!Arg)
        continue;
      if (!isTrackedArgument(F, Arg))
        continue;

      uint64_t Bytes = Layout.getTypeStoreSize(AccessType);
      if (!Bytes)
        continue;

      IRBuilder<> Builder(I);
      Modified |= emitTraceCall(F, *I, Pointer, Arg, Event,
                                Builder.getInt32(Bytes), Bytes);
    }
    return Modified;
  }

  bool instrumentPointerAccess(
      Function &F, Instruction &Inst, Value *Pointer, Value *Length,
      StringRef Event,
      const DenseMap<const AllocaInst *, Argument *> &Spills) {
    Argument *Arg = findBaseArgument(Pointer, Spills);
    if (!isTrackedArgument(F, Arg))
      return false;

    IRBuilder<> Builder(&Inst);
    Value *Bytes = Length;
    if (!Bytes)
      return false;
    if (Bytes->getType()->isIntegerTy(32)) {
      // already the runtime ABI type
    } else if (Bytes->getType()->isIntegerTy()) {
      Bytes = Builder.CreateIntCast(Bytes, Builder.getInt32Ty(), false);
    } else {
      return false;
    }

    uint64_t ManifestBytes = 0;
    if (auto *ConstantBytes = dyn_cast<ConstantInt>(Length))
      ManifestBytes = ConstantBytes->getZExtValue();
    return emitTraceCall(F, Inst, Pointer, Arg, Event, Bytes, ManifestBytes);
  }

  bool emitTraceCall(Function &F, Instruction &Inst, Value *Pointer,
                     Argument *Arg, StringRef Event, Value *BytesValue,
                     uint64_t ManifestBytes) {
    if (!Arg || !Pointer || !BytesValue)
      return false;
    unsigned SiteID = NextSiteID++;
    IRBuilder<> Builder(&Inst);
    Value *PointerInt = Builder.CreatePtrToInt(Pointer, Builder.getInt64Ty());
    Value *BaseInt = Builder.CreatePtrToInt(Arg, Builder.getInt64Ty());
    Value *ByteOffset = Builder.CreateSub(PointerInt, BaseInt);
    Builder.CreateCall(
        TraceFunction,
        {
            Builder.CreateGlobalStringPtr(Event),
            Builder.CreateGlobalStringPtr(F.getName()),
            Builder.getInt32(SiteID),
            Builder.CreateGlobalStringPtr(argumentName(*Arg)),
            Builder.getInt32(Arg->getArgNo()),
            ByteOffset,
            BytesValue,
        });
    writeManifestLine(SiteID, F, Inst, Event, *Arg, ManifestBytes, Pointer);
    return true;
  }

  bool shouldTrackCallContext(const Function *Callee) const {
    if (!Callee || Callee->isDeclaration())
      return false;
    if (Callee->isIntrinsic())
      return false;
    if (Callee->getName().startswith("llvm.") ||
        Callee->getName().startswith("__hlslitesim_"))
      return false;
    return true;
  }

  bool instrumentCallContext(
      Function &Caller, Instruction &Call,
      const DenseMap<const AllocaInst *, Argument *> &Spills) {
    Function *Callee = calledFunction(Call);
    if (!shouldTrackCallContext(Callee))
      return false;
    if (!shouldInstrumentFunction(*Callee))
      return false;

    struct Mapping {
      unsigned FormalIndex;
      std::string FormalName;
      Argument *CallerArgument;
      Value *ActualOffset;
    };

    const DataLayout &Layout = Caller.getParent()->getDataLayout();
    std::vector<Mapping> Mappings;
    unsigned ArgCount =
        std::min<unsigned>(numCallArguments(Call), Callee->arg_size());
    for (unsigned I = 0; I < ArgCount; ++I) {
      Argument *Formal = Callee->getArg(I);
      if (!Formal->getType()->isPointerTy())
        continue;

      Value *Actual = callArgument(Call, I);
      Argument *CallerArgument = findBaseArgument(Actual, Spills);
      if (!isTrackedArgument(Caller, CallerArgument))
        continue;

      IRBuilder<> OffsetBuilder(&Call);
      Value *ActualInt =
          OffsetBuilder.CreatePtrToInt(Actual, OffsetBuilder.getInt64Ty());
      Value *BaseInt =
          OffsetBuilder.CreatePtrToInt(CallerArgument, OffsetBuilder.getInt64Ty());
      Value *ActualOffset = OffsetBuilder.CreateSub(ActualInt, BaseInt);
      (void)Layout;
      Mappings.push_back(
          {I, argumentName(*Formal), CallerArgument, ActualOffset});
    }

    if (Mappings.empty())
      return false;

    IRBuilder<> Before(&Call);
    Before.CreateCall(PushContextFunction,
                      {Before.CreateGlobalStringPtr(Callee->getName())});
    for (const Mapping &Map : Mappings) {
      Before.CreateCall(
          MapContextArgFunction,
          {
              Before.getInt32(Map.FormalIndex),
              Before.CreateGlobalStringPtr(Map.FormalName),
              Before.CreateGlobalStringPtr(Caller.getName()),
              Before.getInt32(Map.CallerArgument->getArgNo()),
              Before.CreateGlobalStringPtr(argumentName(*Map.CallerArgument)),
              Map.ActualOffset,
          });
    }

    Instruction *After = Call.getNextNode();
    if (!After)
      return true;
    IRBuilder<> AfterBuilder(After);
    AfterBuilder.CreateCall(PopContextFunction, {});
    return true;
  }

  std::string argumentName(const Argument &Arg) const {
    if (Arg.hasName())
      return Arg.getName().str();
    return "arg" + std::to_string(Arg.getArgNo());
  }

  std::string text(Value *V) const {
    std::string Result;
    raw_string_ostream Stream(Result);
    V->print(Stream);
    Stream.flush();
    for (char &C : Result) {
      if (C == '\t' || C == '\n' || C == '\r')
        C = ' ';
    }
    return Result;
  }

  void writeManifestLine(unsigned SiteID, const Function &F,
                         const Instruction &I, StringRef Event,
                         const Argument &Arg, uint64_t Bytes, Value *Pointer) {
    if (!Manifest)
      return;
    *Manifest << SiteID << "\t" << F.getName() << "\t"
              << I.getParent()->getName() << "\t" << Event << "\t"
              << argumentName(Arg) << "\t" << Arg.getArgNo() << "\t"
              << Bytes << "\t" << text(Pointer) << "\t"
              << text(const_cast<Instruction *>(&I)) << "\n";
  }
};

} // namespace

char TopLevelMemoryTracePass::ID = 0;
static RegisterPass<TopLevelMemoryTracePass>
    X("top-level-memory-trace-pass",
      "Instrument memory accesses derived from pointer arguments");
