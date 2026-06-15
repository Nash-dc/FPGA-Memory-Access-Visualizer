set moduleName matrix_mul_Pipeline_init_c_loop_init_c_col_loop
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set isPipelined_legacy 1
set pipeline_type loop_auto_rewind
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 8
set C_modelName {matrix_mul_Pipeline_init_c_loop_init_c_col_loop}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict C_local { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict C_local_1 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict C_local_2 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict C_local_3 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
set C_modelArgList {
	{ C_local int 32 regular {array 64 { 0 3 } 0 1 }  }
	{ C_local_1 int 32 regular {array 64 { 0 3 } 0 1 }  }
	{ C_local_2 int 32 regular {array 64 { 0 3 } 0 1 }  }
	{ C_local_3 int 32 regular {array 64 { 0 3 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "C_local", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "C_local_1", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "C_local_2", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "C_local_3", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 22
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ C_local_address0 sc_out sc_lv 6 signal 0 } 
	{ C_local_ce0 sc_out sc_logic 1 signal 0 } 
	{ C_local_we0 sc_out sc_logic 1 signal 0 } 
	{ C_local_d0 sc_out sc_lv 32 signal 0 } 
	{ C_local_1_address0 sc_out sc_lv 6 signal 1 } 
	{ C_local_1_ce0 sc_out sc_logic 1 signal 1 } 
	{ C_local_1_we0 sc_out sc_logic 1 signal 1 } 
	{ C_local_1_d0 sc_out sc_lv 32 signal 1 } 
	{ C_local_2_address0 sc_out sc_lv 6 signal 2 } 
	{ C_local_2_ce0 sc_out sc_logic 1 signal 2 } 
	{ C_local_2_we0 sc_out sc_logic 1 signal 2 } 
	{ C_local_2_d0 sc_out sc_lv 32 signal 2 } 
	{ C_local_3_address0 sc_out sc_lv 6 signal 3 } 
	{ C_local_3_ce0 sc_out sc_logic 1 signal 3 } 
	{ C_local_3_we0 sc_out sc_logic 1 signal 3 } 
	{ C_local_3_d0 sc_out sc_lv 32 signal 3 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "C_local_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "C_local", "role": "address0" }} , 
 	{ "name": "C_local_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local", "role": "ce0" }} , 
 	{ "name": "C_local_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local", "role": "we0" }} , 
 	{ "name": "C_local_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local", "role": "d0" }} , 
 	{ "name": "C_local_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "C_local_1", "role": "address0" }} , 
 	{ "name": "C_local_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_1", "role": "ce0" }} , 
 	{ "name": "C_local_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_1", "role": "we0" }} , 
 	{ "name": "C_local_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local_1", "role": "d0" }} , 
 	{ "name": "C_local_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "C_local_2", "role": "address0" }} , 
 	{ "name": "C_local_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_2", "role": "ce0" }} , 
 	{ "name": "C_local_2_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_2", "role": "we0" }} , 
 	{ "name": "C_local_2_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local_2", "role": "d0" }} , 
 	{ "name": "C_local_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "C_local_3", "role": "address0" }} , 
 	{ "name": "C_local_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_3", "role": "ce0" }} , 
 	{ "name": "C_local_3_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_3", "role": "we0" }} , 
 	{ "name": "C_local_3_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local_3", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
	matrix_mul_Pipeline_init_c_loop_init_c_col_loop {
		C_local {Type O LastRead -1 FirstWrite 0}
		C_local_1 {Type O LastRead -1 FirstWrite 0}
		C_local_2 {Type O LastRead -1 FirstWrite 0}
		C_local_3 {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "258", "Max" : "258"}
	, {"Name" : "Interval", "Min" : "258", "Max" : "258"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	C_local { ap_memory {  { C_local_address0 mem_address 1 6 }  { C_local_ce0 mem_ce 1 1 }  { C_local_we0 mem_we 1 1 }  { C_local_d0 mem_din 1 32 } } }
	C_local_1 { ap_memory {  { C_local_1_address0 mem_address 1 6 }  { C_local_1_ce0 mem_ce 1 1 }  { C_local_1_we0 mem_we 1 1 }  { C_local_1_d0 mem_din 1 32 } } }
	C_local_2 { ap_memory {  { C_local_2_address0 mem_address 1 6 }  { C_local_2_ce0 mem_ce 1 1 }  { C_local_2_we0 mem_we 1 1 }  { C_local_2_d0 mem_din 1 32 } } }
	C_local_3 { ap_memory {  { C_local_3_address0 mem_address 1 6 }  { C_local_3_ce0 mem_ce 1 1 }  { C_local_3_we0 mem_we 1 1 }  { C_local_3_d0 mem_din 1 32 } } }
}
