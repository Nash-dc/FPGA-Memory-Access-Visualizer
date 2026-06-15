open_project -reset component_matrix_mul
set_top matrix_mul
add_files matrix_mul.cpp
add_files -tb matrix_mul_test.cpp

open_solution -reset hls -flow_target vivado
set_part {xcvu9p-flga2104-2-i}
create_clock -period 5 -name default
config_interface -m_axi_alignment_byte_size 64 -m_axi_max_widen_bitwidth 512

csynth_design
exit
