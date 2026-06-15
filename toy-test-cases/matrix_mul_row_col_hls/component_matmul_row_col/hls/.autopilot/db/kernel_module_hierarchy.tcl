set ModuleHierarchy {[{
"Name" : "matmul_row_col", "RefName" : "matmul_row_col","ID" : "0","Type" : "sequential",
"SubLoops" : [
	{"Name" : "row_loop","RefName" : "row_loop","ID" : "1","Type" : "no",
	"SubLoops" : [
	{"Name" : "col_loop","RefName" : "col_loop","ID" : "2","Type" : "no",
		"SubInsts" : [
		{"Name" : "grp_matmul_row_col_Pipeline_load_ab_loop_fu_198", "RefName" : "matmul_row_col_Pipeline_load_ab_loop","ID" : "3","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "load_ab_loop","RefName" : "load_ab_loop","ID" : "4","Type" : "pipeline"},]},
		{"Name" : "grp_matmul_row_col_Pipeline_compute_element_loop_fu_209", "RefName" : "matmul_row_col_Pipeline_compute_element_loop","ID" : "5","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "compute_element_loop","RefName" : "compute_element_loop","ID" : "6","Type" : "pipeline"},]},]},]},]
}]}