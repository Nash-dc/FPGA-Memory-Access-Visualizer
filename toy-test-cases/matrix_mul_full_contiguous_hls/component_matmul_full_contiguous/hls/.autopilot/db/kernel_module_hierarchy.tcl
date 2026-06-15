set ModuleHierarchy {[{
"Name" : "matmul_full_contiguous", "RefName" : "matmul_full_contiguous","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_matmul_full_contiguous_Pipeline_load_ab_full_loop_fu_438", "RefName" : "matmul_full_contiguous_Pipeline_load_ab_full_loop","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "load_ab_full_loop","RefName" : "load_ab_full_loop","ID" : "2","Type" : "pipeline"},]},
	{"Name" : "grp_matmul_full_contiguous_Pipeline_compute_row_loop_compute_col_loop_fu_473", "RefName" : "matmul_full_contiguous_Pipeline_compute_row_loop_compute_col_loop","ID" : "3","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "compute_row_loop_compute_col_loop","RefName" : "compute_row_loop_compute_col_loop","ID" : "4","Type" : "pipeline"},]},
	{"Name" : "grp_matmul_full_contiguous_Pipeline_store_c_full_loop_fu_519", "RefName" : "matmul_full_contiguous_Pipeline_store_c_full_loop","ID" : "5","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "store_c_full_loop","RefName" : "store_c_full_loop","ID" : "6","Type" : "pipeline"},]},]
}]}