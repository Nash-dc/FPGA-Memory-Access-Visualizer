open_project test_proj
add_files kernel.cpp
set_top mem_test_kernel
open_solution "sol1" -flow_target vitis

set ::LLVM_CUSTOM_CMD "$LLVM_CUSTOM_OPT \
  -load /data/hls-dev/pass-dev/build/libMemoryAccessPass.so \
  -mem-access-pass \
  $LLVM_CUSTOM_INPUT -o $LLVM_CUSTOM_OUTPUT"

csim_design
csynth_design
exit
