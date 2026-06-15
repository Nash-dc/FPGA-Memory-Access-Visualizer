open_project -reset component_vector_mul_shared_bundle
set_top vector_mul
add_files vector_mul.cpp
add_files -tb vector_mul_test.cpp

open_solution -reset hls -flow_target vivado
set_part {xcvu9p-flga2104-2-i}
create_clock -period 5 -name default

csynth_design
exit
