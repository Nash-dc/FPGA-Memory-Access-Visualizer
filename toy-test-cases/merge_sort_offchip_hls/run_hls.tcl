open_project -reset component_merge_sort_offchip
set_top merge_sort_offchip_hls
add_files merge_sort_offchip.cpp
add_files -tb merge_sort_offchip_test.cpp

open_solution -reset hls -flow_target vivado
set_part {xcvu9p-flga2104-2-i}
create_clock -period 5 -name default
config_interface -m_axi_alignment_byte_size 64 -m_axi_max_widen_bitwidth 512

csynth_design
exit
