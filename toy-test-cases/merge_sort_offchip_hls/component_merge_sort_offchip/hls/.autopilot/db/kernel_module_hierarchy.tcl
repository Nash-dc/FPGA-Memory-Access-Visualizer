set ModuleHierarchy {[{
"Name" : "merge_sort_offchip_hls", "RefName" : "merge_sort_offchip_hls","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_merge_sort_offchip_hls_Pipeline_copy_input_to_scratch_a_fu_232", "RefName" : "merge_sort_offchip_hls_Pipeline_copy_input_to_scratch_a","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "copy_input_to_scratch_a","RefName" : "copy_input_to_scratch_a","ID" : "2","Type" : "pipeline"},]},
	{"Name" : "grp_merge_sort_offchip_hls_Pipeline_copy_result_to_out_fu_260", "RefName" : "merge_sort_offchip_hls_Pipeline_copy_result_to_out","ID" : "3","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "copy_result_to_out","RefName" : "copy_result_to_out","ID" : "4","Type" : "pipeline"},]},],
"SubLoops" : [
	{"Name" : "merge_width_loop","RefName" : "merge_width_loop","ID" : "5","Type" : "no",
	"SubLoops" : [
	{"Name" : "merge_block_loop","RefName" : "merge_block_loop","ID" : "6","Type" : "no",
		"SubInsts" : [
		{"Name" : "grp_merge_sort_offchip_hls_Pipeline_merge_element_loop_fu_242", "RefName" : "merge_sort_offchip_hls_Pipeline_merge_element_loop","ID" : "7","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "merge_element_loop","RefName" : "merge_element_loop","ID" : "8","Type" : "pipeline"},]},]},]},]
}]}