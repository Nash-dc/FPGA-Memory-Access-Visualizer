#include "PragmaParser.h"

#include "IRUtils.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/InstrTypes.h"

using namespace llvm;

namespace hls_mem {

static std::string inputText(OperandBundleUse Bundle, unsigned Index) {
  if (Index >= Bundle.Inputs.size())
    return "unknown";
  std::string Text = getValueText(Bundle.Inputs[Index].get());
  return Text.empty() ? "unknown" : Text;
}

static void collectM_axiPragma(FunctionMemoryReport &Report,
                               OperandBundleUse Bundle) {
  if (Bundle.Inputs.empty())
    return;

  const Argument *Arg = getBaseArgument(Bundle.Inputs[0].get());
  if (!Arg)
    return;

  AxiPortInfo Port;
  Port.Name = getValueName(Arg);
  Port.Arg = Arg;
  Port.Bundle = inputText(Bundle, 1);
  Port.Offset = inputText(Bundle, 3);
  Port.SignalName = inputText(Bundle, 4);
  Port.Channel = inputText(Bundle, 11);
  if (Bundle.Inputs.size() > 2) {
    if (const ConstantInt *Depth =
            dyn_cast<ConstantInt>(Bundle.Inputs[2].get()))
      Port.Depth = Depth->getSExtValue();
  }
  Report.AxiPorts[Arg] = Port;
}

static void collectArrayPartitionPragma(FunctionMemoryReport &Report,
                                        OperandBundleUse Bundle) {
  if (Bundle.Inputs.empty())
    return;

  Value *Base = Bundle.Inputs[0].get()->stripPointerCasts();
  AllocaInst *AI = dyn_cast<AllocaInst>(Base);
  if (!AI)
    return;

  LocalBufferInfo &Buffer = Report.LocalBuffers[AI];
  Buffer.Name = getValueName(AI);
  Buffer.Alloca = AI;
  Buffer.PartitionKind = inputText(Bundle, 1);
  if (Buffer.PartitionKind == "0")
    Buffer.PartitionKind = "cyclic";
  else if (Buffer.PartitionKind == "1")
    Buffer.PartitionKind = "block";
  else if (Buffer.PartitionKind == "2")
    Buffer.PartitionKind = "complete";

  if (Bundle.Inputs.size() > 2) {
    if (const ConstantInt *Factor =
            dyn_cast<ConstantInt>(Bundle.Inputs[2].get()))
      Buffer.PartitionFactor = Factor->getSExtValue();
  }
  if (Bundle.Inputs.size() > 3) {
    if (const ConstantInt *Dim =
            dyn_cast<ConstantInt>(Bundle.Inputs[3].get()))
      Buffer.PartitionDim = Dim->getSExtValue();
  }
}

void collectPragmas(FunctionMemoryReport &Report, Instruction &Inst) {
  CallInst *CI = dyn_cast<CallInst>(&Inst);
  if (!CI)
    return;

  for (unsigned I = 0; I < CI->getNumOperandBundles(); ++I) {
    OperandBundleUse Bundle = CI->getOperandBundleAt(I);
    StringRef Tag = Bundle.getTagName();
    if (Tag == "xlx_m_axi")
      collectM_axiPragma(Report, Bundle);
    else if (Tag == "xlx_array_partition")
      collectArrayPartitionPragma(Report, Bundle);
  }
}

} // namespace hls_mem
