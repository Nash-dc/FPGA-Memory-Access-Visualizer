set ModuleHierarchy {[{
"Name" : "merge_sort_hls", "RefName" : "merge_sort_hls","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_merge_sort_hls_Pipeline_load_input_loop_fu_177", "RefName" : "merge_sort_hls_Pipeline_load_input_loop","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "load_input_loop","RefName" : "load_input_loop","ID" : "2","Type" : "pipeline"},]},
	{"Name" : "grp_merge_sort_hls_Pipeline_store_output_loop_fu_209", "RefName" : "merge_sort_hls_Pipeline_store_output_loop","ID" : "3","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "store_output_loop","RefName" : "store_output_loop","ID" : "4","Type" : "pipeline"},]},],
"SubLoops" : [
	{"Name" : "merge_width_loop","RefName" : "merge_width_loop","ID" : "5","Type" : "no",
	"SubLoops" : [
	{"Name" : "merge_block_loop","RefName" : "merge_block_loop","ID" : "6","Type" : "no",
		"SubInsts" : [
		{"Name" : "grp_merge_sort_hls_Pipeline_merge_b_to_a_loop_fu_185", "RefName" : "merge_sort_hls_Pipeline_merge_b_to_a_loop","ID" : "7","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "merge_b_to_a_loop","RefName" : "merge_b_to_a_loop","ID" : "8","Type" : "pipeline"},]},
		{"Name" : "grp_merge_sort_hls_Pipeline_merge_a_to_b_loop_fu_197", "RefName" : "merge_sort_hls_Pipeline_merge_a_to_b_loop","ID" : "9","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "merge_a_to_b_loop","RefName" : "merge_a_to_b_loop","ID" : "10","Type" : "pipeline"},]},]},]},]
}]}