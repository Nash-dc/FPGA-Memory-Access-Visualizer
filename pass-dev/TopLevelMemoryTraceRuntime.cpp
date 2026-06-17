#include <cstdio>
#include <cstdlib>
#include <set>
#include <string>
#include <vector>

namespace {

struct ArgumentContext {
  unsigned formal_index = 0;
  std::string formal_name;
  std::string top_argument;
  unsigned top_argument_index = 0;
  unsigned long long base_offset = 0;
};

struct CallContext {
  std::string function;
  std::vector<ArgumentContext> arguments;
};

static std::vector<CallContext> &contextStack() {
  static thread_local std::vector<CallContext> stack;
  return stack;
}

static std::set<std::string> &rootFunctions() {
  static std::set<std::string> roots;
  return roots;
}

static bool isRootFunction(const char *function) {
  return rootFunctions().count(function ? function : "") != 0;
}

static const ArgumentContext *findMapping(const char *function,
                                          unsigned argument_index) {
  std::vector<CallContext> &stack = contextStack();
  for (auto frame = stack.rbegin(); frame != stack.rend(); ++frame) {
    if (frame->function != (function ? function : ""))
      continue;
    for (const ArgumentContext &argument : frame->arguments) {
      if (argument.formal_index == argument_index)
        return &argument;
    }
  }
  return nullptr;
}

static bool hasContextFrame(const char *function) {
  std::vector<CallContext> &stack = contextStack();
  for (auto frame = stack.rbegin(); frame != stack.rend(); ++frame) {
    if (frame->function == (function ? function : ""))
      return true;
  }
  return false;
}

static bool resolveTopArgument(const char *function, unsigned argument_index,
                               const char *argument,
                               unsigned long long byte_offset,
                               std::string &resolved_argument,
                               unsigned &resolved_argument_index,
                               unsigned long long &resolved_byte_offset) {
  const ArgumentContext *mapping = findMapping(function, argument_index);
  if (!mapping) {
    if (hasContextFrame(function))
      return false;
    if (!isRootFunction(function))
      return false;
    resolved_argument = argument ? argument : "";
    resolved_argument_index = argument_index;
    resolved_byte_offset = byte_offset;
    return true;
  }

  resolved_argument = mapping->top_argument;
  resolved_argument_index = mapping->top_argument_index;
  resolved_byte_offset = mapping->base_offset + byte_offset;
  return true;
}

} // namespace

extern "C" void __hlslitesim_register_root_context(const char *root_function) {
  if (root_function && *root_function)
    rootFunctions().insert(root_function);
}

extern "C" void __hlslitesim_push_arg_context(const char *callee_function) {
  CallContext frame;
  frame.function = callee_function ? callee_function : "";
  contextStack().push_back(frame);
}

extern "C" void __hlslitesim_map_arg_context(
    unsigned formal_index,
    const char *formal_name,
    const char *caller_function,
    unsigned caller_argument_index,
    const char *caller_argument,
    unsigned long long actual_base_offset) {
  std::vector<CallContext> &stack = contextStack();
  if (stack.empty())
    return;

  std::string top_argument;
  unsigned top_argument_index = caller_argument_index;
  unsigned long long top_offset = actual_base_offset;
  const ArgumentContext *caller_mapping =
      findMapping(caller_function, caller_argument_index);
  if (caller_mapping) {
    top_argument = caller_mapping->top_argument;
    top_argument_index = caller_mapping->top_argument_index;
    top_offset = caller_mapping->base_offset + actual_base_offset;
  } else if (isRootFunction(caller_function)) {
    top_argument = caller_argument ? caller_argument : "";
  } else {
    return;
  }

  ArgumentContext argument;
  argument.formal_index = formal_index;
  argument.formal_name = formal_name ? formal_name : "";
  argument.top_argument = top_argument;
  argument.top_argument_index = top_argument_index;
  argument.base_offset = top_offset;
  stack.back().arguments.push_back(argument);
}

extern "C" void __hlslitesim_pop_arg_context() {
  std::vector<CallContext> &stack = contextStack();
  if (!stack.empty())
    stack.pop_back();
}

extern "C" void __hlslitesim_trace_top_level_memory(
    const char *event,
    const char *function,
    unsigned site_id,
    const char *argument,
    unsigned argument_index,
    unsigned long long byte_offset,
    unsigned bytes) {
  static FILE *file = nullptr;
  static bool initialized = false;

  if (!initialized) {
    initialized = true;
    const char *path = std::getenv("HLSLITESIM_TOP_LEVEL_MEMORY_TRACE_FILE");
    if (path && *path)
      file = std::fopen(path, "w");
  }

  if (!file)
    return;

  std::string resolved_argument;
  unsigned resolved_argument_index = argument_index;
  unsigned long long resolved_byte_offset = byte_offset;
  if (!resolveTopArgument(function, argument_index, argument, byte_offset,
                          resolved_argument, resolved_argument_index,
                          resolved_byte_offset))
    return;

  std::fprintf(file, "%s\t%s\t%u\t%s\t%u\t%llu\t%u\n", event, function,
               site_id, resolved_argument.c_str(), resolved_argument_index,
               resolved_byte_offset, bytes);
}
