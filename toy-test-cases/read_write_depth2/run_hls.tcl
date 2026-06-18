set script_dir [file dirname [file normalize [info script]]]
cd $script_dir

open_component -reset component_read_write -flow_target vitis

add_files read_write.cpp
add_files read_write.h
add_files -tb tb_read_write.cpp

set_top read_write

set_part {xc7z020clg400-1}
create_clock -period 5 -name default

csynth_design
cosim_design -trace_level all
exit
