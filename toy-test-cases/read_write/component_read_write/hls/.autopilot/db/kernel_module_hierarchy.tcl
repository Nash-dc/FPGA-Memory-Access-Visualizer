set ModuleHierarchy {[{
"Name" : "read_write", "RefName" : "read_write","ID" : "0","Type" : "dataflow",
"SubInsts" : [
	{"Name" : "read_U0", "RefName" : "read_r","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_9_1_VITIS_LOOP_11_2","RefName" : "VITIS_LOOP_9_1_VITIS_LOOP_11_2","ID" : "2","Type" : "pipeline"},]},
	{"Name" : "read_1_U0", "RefName" : "read_1","ID" : "3","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_9_1_VITIS_LOOP_11_2","RefName" : "VITIS_LOOP_9_1_VITIS_LOOP_11_2","ID" : "4","Type" : "pipeline"},]},
	{"Name" : "write_U0", "RefName" : "write_r","ID" : "5","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_24_1_VITIS_LOOP_26_2","RefName" : "VITIS_LOOP_24_1_VITIS_LOOP_26_2","ID" : "6","Type" : "pipeline"},]},
	{"Name" : "write_2_U0", "RefName" : "write_2","ID" : "7","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_24_1_VITIS_LOOP_26_2","RefName" : "VITIS_LOOP_24_1_VITIS_LOOP_26_2","ID" : "8","Type" : "pipeline"},]},]
}]}