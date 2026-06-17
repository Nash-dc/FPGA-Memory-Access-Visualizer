#include "ReportPrinter.h"

#include "llvm/ADT/StringRef.h"
#include "llvm/Support/raw_ostream.h"

#include <cstdio>

using namespace llvm;

namespace hls_mem {

static std::string jsonEscape(StringRef Text) {
  std::string Out;
  for (char C : Text) {
    switch (C) {
    case '\\':
      Out += "\\\\";
      break;
    case '"':
      Out += "\\\"";
      break;
    case '\n':
      Out += "\\n";
      break;
    case '\r':
      Out += "\\r";
      break;
    case '\t':
      Out += "\\t";
      break;
    default:
      if (static_cast<unsigned char>(C) < 0x20) {
        char Buf[7];
        std::snprintf(Buf, sizeof(Buf), "\\u%04x",
                      static_cast<unsigned char>(C));
        Out += Buf;
      } else {
        Out += C;
      }
      break;
    }
  }
  return Out;
}

static void printStringField(raw_ostream &OS, StringRef Key, StringRef Value) {
  OS << "\"" << Key << "\": \"" << jsonEscape(Value) << "\"";
}

static void printMaybeNumber(raw_ostream &OS, long long Value) {
  if (Value >= 0)
    OS << Value;
  else
    OS << "\"unknown\"";
}

static std::string getTripCountKind(const LoopInfo &Loop) {
  if (Loop.MinTripCount < 0 || Loop.MaxTripCount < 0)
    return "unknown";
  if (Loop.MinTripCount == Loop.MaxTripCount)
    return "exact";
  return "runtime_dependent";
}

static void printLoopTripCounts(raw_ostream &OS, const LoopInfo &Loop) {
  OS << "\"tripcount\": ";
  printMaybeNumber(OS, Loop.AvgTripCount);
  OS << ", \"avg_tripcount\": ";
  printMaybeNumber(OS, Loop.AvgTripCount);
  OS << ", \"min_tripcount\": ";
  printMaybeNumber(OS, Loop.MinTripCount);
  OS << ", \"max_tripcount\": ";
  printMaybeNumber(OS, Loop.MaxTripCount);
  OS << ", ";
  printStringField(OS, "tripcount_kind", getTripCountKind(Loop));
}

void printReport(const FunctionMemoryReport &Report) {
  std::string FunctionName = Report.DisplayFunctionName.empty()
                                 ? Report.FunctionName
                                 : Report.DisplayFunctionName;

  outs() << "{\n";
  outs() << "  ";
  printStringField(outs(), "function", FunctionName);
  outs() << ",\n";

  outs() << "  \"m_axi_ports\": [\n";
  bool FirstPort = true;
  for (const auto &KV : Report.AxiPorts) {
    const AxiPortInfo &Port = KV.second;
    if (!FirstPort)
      outs() << ",\n";
    FirstPort = false;
    outs() << "    {";
    printStringField(outs(), "name", Port.Name);
    outs() << ", ";
    printStringField(outs(), "bundle", Port.Bundle);
    outs() << ", ";
    printStringField(outs(), "channel", Port.Channel);
    outs() << ", ";
    printStringField(outs(), "offset", Port.Offset);
    outs() << ", ";
    printStringField(outs(), "signal_name", Port.SignalName);
    outs() << ", \"depth\": ";
    printMaybeNumber(outs(), Port.Depth);
    outs() << "}";
  }
  outs() << "\n  ],\n";

  outs() << "  \"local_buffers\": [\n";
  bool FirstBuffer = true;
  for (const auto &KV : Report.LocalBuffers) {
    const LocalBufferInfo &Buffer = KV.second;
    if (!FirstBuffer)
      outs() << ",\n";
    FirstBuffer = false;
    outs() << "    {";
    printStringField(outs(), "name", Buffer.Name);
    outs() << ", ";
    printStringField(outs(), "element_type", Buffer.ElementType);
    outs() << ", \"elements\": ";
    printMaybeNumber(outs(), Buffer.ElementCount);
    outs() << ", ";
    printStringField(outs(), "array_partition", Buffer.PartitionKind);
    outs() << ", \"partition_factor\": ";
    printMaybeNumber(outs(), Buffer.PartitionFactor);
    outs() << ", \"partition_dim\": ";
    printMaybeNumber(outs(), Buffer.PartitionDim);
    outs() << "}";
  }
  outs() << "\n  ],\n";

  outs() << "  \"off_chip_accesses\": [\n";
  for (unsigned I = 0; I < Report.OffChipAccesses.size(); ++I) {
    const OffChipAccessRecord &Access = Report.OffChipAccesses[I];
    if (I)
      outs() << ",\n";
    outs() << "    {\n";
    outs() << "      ";
    printStringField(outs(), "id", Access.Id);
    outs() << ",\n      \"sequence\": " << Access.Sequence << ",\n      ";
    printStringField(outs(), "type", Access.Type);
    outs() << ",\n      ";
    printStringField(outs(), "port", Access.Port);
    outs() << ",\n      ";
    printStringField(outs(), "bundle", Access.Bundle);
    outs() << ",\n      ";
    printStringField(outs(), "channel", Access.Channel);
    outs() << ",\n      ";
    printStringField(outs(), "base", Access.Base);
    outs() << ",\n      ";
    printStringField(outs(), "index", Access.Index);
    outs() << ",\n      ";
    printStringField(outs(), "operation", Access.Operation);
    outs() << ",\n      ";
    printStringField(outs(), "pattern", Access.Pattern);
    outs() << ",\n      ";
    printStringField(outs(), "source_function", Access.SourceFunction);
    outs() << ",\n      ";
    printStringField(outs(), "loop", Access.Loop.Name);
    outs() << ",\n      ";
    printLoopTripCounts(outs(), Access.Loop);
    outs() << ",\n      \"loop_nest\": [";
    for (unsigned J = 0; J < Access.LoopNest.size(); ++J) {
      const LoopInfo &Loop = Access.LoopNest[J];
      if (J)
        outs() << ", ";
      outs() << "{";
      printStringField(outs(), "name", Loop.Name);
      outs() << ", ";
      printLoopTripCounts(outs(), Loop);
      outs() << "}";
    }
    outs() << "],\n      \"total_tripcount\": ";
    printMaybeNumber(outs(), Access.TotalTripCount);
    outs() << ",\n      ";
    printStringField(outs(), "element_type", Access.ElementType);
    outs() << ",\n      \"stride_elements\": ";
    printMaybeNumber(outs(), Access.StrideElements);
    outs() << ",\n      \"stride_bytes\": " << Access.StrideBytes;
    outs() << ",\n      \"burst_candidate\": "
           << (Access.BurstCandidate ? "true" : "false");
    outs() << ",\n      ";
    printStringField(outs(), "burst_confirmed_by_report",
                     Access.BurstConfirmedByReport);
    outs() << ",\n      \"burst_length\": ";
    printMaybeNumber(outs(), Access.BurstLength);
    outs() << "\n";
    outs() << "    }";
  }
  outs() << "\n  ],\n";

  outs() << "  \"local_accesses\": [\n";
  for (unsigned I = 0; I < Report.LocalAccesses.size(); ++I) {
    const LocalAccessRecord &Access = Report.LocalAccesses[I];
    if (I)
      outs() << ",\n";
    outs() << "    {\n";
    outs() << "      ";
    printStringField(outs(), "id", Access.Id);
    outs() << ",\n      \"sequence\": " << Access.Sequence << ",\n      ";
    printStringField(outs(), "type", Access.Type);
    outs() << ",\n      ";
    printStringField(outs(), "buffer", Access.Buffer);
    outs() << ",\n      ";
    printStringField(outs(), "index", Access.Index);
    outs() << ",\n      ";
    printStringField(outs(), "operation", Access.Operation);
    outs() << ",\n      ";
    printStringField(outs(), "pattern", Access.Pattern);
    outs() << ",\n      ";
    printStringField(outs(), "access_detail", Access.AccessDetail);
    outs() << ",\n      \"stride_elements\": ";
    printMaybeNumber(outs(), Access.StrideElements);
    outs() << ",\n      ";
    printStringField(outs(), "source_function", Access.SourceFunction);
    outs() << ",\n      ";
    printStringField(outs(), "loop", Access.Loop.Name);
    outs() << ",\n      ";
    printLoopTripCounts(outs(), Access.Loop);
    outs() << ",\n      \"loop_nest\": [";
    for (unsigned J = 0; J < Access.LoopNest.size(); ++J) {
      const LoopInfo &Loop = Access.LoopNest[J];
      if (J)
        outs() << ", ";
      outs() << "{";
      printStringField(outs(), "name", Loop.Name);
      outs() << ", ";
      printLoopTripCounts(outs(), Loop);
      outs() << "}";
    }
    outs() << "],\n      \"total_tripcount\": ";
    printMaybeNumber(outs(), Access.TotalTripCount);
    outs() << "\n    }";
  }
  outs() << "\n  ],\n";

  outs() << "  \"dependency_edges\": [\n";
  for (unsigned I = 0; I < Report.DependencyEdges.size(); ++I) {
    const DependencyEdgeRecord &Edge = Report.DependencyEdges[I];
    if (I)
      outs() << ",\n";
    outs() << "    {";
    printStringField(outs(), "id", Edge.Id);
    outs() << ", ";
    printStringField(outs(), "source_id", Edge.SourceId);
    outs() << ", ";
    printStringField(outs(), "target_id", Edge.TargetId);
    outs() << ", ";
    printStringField(outs(), "kind", Edge.Kind);
    outs() << ", ";
    printStringField(outs(), "via", Edge.Via);
    outs() << ", ";
    printStringField(outs(), "source_role", Edge.SourceRole);
    outs() << ", ";
    printStringField(outs(), "target_role", Edge.TargetRole);
    outs() << ", ";
    printStringField(outs(), "source_index", Edge.SourceIndex);
    outs() << ", ";
    printStringField(outs(), "target_index", Edge.TargetIndex);
    outs() << ", ";
    printStringField(outs(), "reason", Edge.Reason);
    outs() << "}";
  }
  outs() << "\n  ]\n";
  outs() << "}\n";
}

} // namespace hls_mem
