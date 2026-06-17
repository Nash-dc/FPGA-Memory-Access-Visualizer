open_project -reset component_matmul_full_contiguous
set_top matmul_full_contiguous
add_files matmul_full_contiguous.cpp
add_files -tb matmul_full_contiguous_test.cpp

open_solution -reset hls -flow_target vivado
set_part {xcvu9p-flga2104-2-i}
create_clock -period 5 -name default
config_interface -m_axi_alignment_byte_size 64 -m_axi_max_widen_bitwidth 512

csynth_design
cosim_design -trace_level all
exit
