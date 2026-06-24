set ModuleHierarchy {[{
"Name" : "read_only", "RefName" : "read_only","ID" : "0","Type" : "dataflow",
"SubInsts" : [
	{"Name" : "p_loc_channel_U", "RefName" : "Block_entry_proc","ID" : "1","Type" : "sequential"},
	{"Name" : "Loop_VITIS_LOOP_72_1_proc_U0", "RefName" : "Loop_VITIS_LOOP_72_1_proc","ID" : "2","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_72_1","RefName" : "VITIS_LOOP_72_1","ID" : "3","Type" : "pipeline"},]},
	{"Name" : "Loop_VITIS_LOOP_76_2_proc_U0", "RefName" : "Loop_VITIS_LOOP_76_2_proc","ID" : "4","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_76_2","RefName" : "VITIS_LOOP_76_2","ID" : "5","Type" : "pipeline"},]},
	{"Name" : "sum_U0", "RefName" : "sum","ID" : "6","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_38_1","RefName" : "VITIS_LOOP_38_1","ID" : "7","Type" : "pipeline"},]},]
}]}