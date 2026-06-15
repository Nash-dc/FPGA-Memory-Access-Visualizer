set ModuleHierarchy {[{
"Name" : "matrix_mul", "RefName" : "matrix_mul","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_matrix_mul_Pipeline_init_c_loop_init_c_col_loop_fu_197", "RefName" : "matrix_mul_Pipeline_init_c_loop_init_c_col_loop","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "init_c_loop_init_c_col_loop","RefName" : "init_c_loop_init_c_col_loop","ID" : "2","Type" : "pipeline"},]},
	{"Name" : "grp_matrix_mul_Pipeline_store_c_loop_fu_248", "RefName" : "matrix_mul_Pipeline_store_c_loop","ID" : "3","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "store_c_loop","RefName" : "store_c_loop","ID" : "4","Type" : "pipeline"},]},],
"SubLoops" : [
	{"Name" : "k_tile_loop","RefName" : "k_tile_loop","ID" : "5","Type" : "no",
	"SubInsts" : [
	{"Name" : "grp_matrix_mul_Pipeline_load_a_tile_row_loop_load_a_tile_lane_loop_fu_209", "RefName" : "matrix_mul_Pipeline_load_a_tile_row_loop_load_a_tile_lane_loop","ID" : "6","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "load_a_tile_row_loop_load_a_tile_lane_loop","RefName" : "load_a_tile_row_loop_load_a_tile_lane_loop","ID" : "7","Type" : "pipeline"},]},
	{"Name" : "grp_matrix_mul_Pipeline_load_b_tile_lane_loop_load_b_tile_col_loop_fu_221", "RefName" : "matrix_mul_Pipeline_load_b_tile_lane_loop_load_b_tile_col_loop","ID" : "8","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "load_b_tile_lane_loop_load_b_tile_col_loop","RefName" : "load_b_tile_lane_loop_load_b_tile_col_loop","ID" : "9","Type" : "pipeline"},]},
	{"Name" : "grp_matrix_mul_Pipeline_compute_row_loop_compute_col_loop_fu_232", "RefName" : "matrix_mul_Pipeline_compute_row_loop_compute_col_loop","ID" : "10","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "compute_row_loop_compute_col_loop","RefName" : "compute_row_loop_compute_col_loop","ID" : "11","Type" : "pipeline"},]},]},]
}]}