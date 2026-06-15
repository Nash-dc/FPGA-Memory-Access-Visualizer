set moduleName merge_sort_hls_Pipeline_merge_a_to_b_loop
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
set cdfgNum 7
set C_modelName {merge_sort_hls_Pipeline_merge_a_to_b_loop}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict buffer_b { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict buffer_a { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ indvars_iv16 int 64 regular  }
	{ k_4 int 32 regular  }
	{ j_7 int 32 regular  }
	{ right_r int 32 regular  }
	{ buffer_b int 32 regular {array 64 { 0 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 } 0 1 }  }
	{ buffer_a int 32 regular {array 64 { 1 1 1 3 3 3 3 3 3 3 3 3 3 3 3 3 3 } 1 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "indvars_iv16", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "k_4", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "j_7", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "right_r", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "buffer_b", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "buffer_a", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 23
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ indvars_iv16 sc_in sc_lv 64 signal 0 } 
	{ k_4 sc_in sc_lv 32 signal 1 } 
	{ j_7 sc_in sc_lv 32 signal 2 } 
	{ right_r sc_in sc_lv 32 signal 3 } 
	{ buffer_b_address0 sc_out sc_lv 6 signal 4 } 
	{ buffer_b_ce0 sc_out sc_logic 1 signal 4 } 
	{ buffer_b_we0 sc_out sc_logic 1 signal 4 } 
	{ buffer_b_d0 sc_out sc_lv 32 signal 4 } 
	{ buffer_a_address0 sc_out sc_lv 6 signal 5 } 
	{ buffer_a_ce0 sc_out sc_logic 1 signal 5 } 
	{ buffer_a_q0 sc_in sc_lv 32 signal 5 } 
	{ buffer_a_address1 sc_out sc_lv 6 signal 5 } 
	{ buffer_a_ce1 sc_out sc_logic 1 signal 5 } 
	{ buffer_a_q1 sc_in sc_lv 32 signal 5 } 
	{ buffer_a_address2 sc_out sc_lv 6 signal 5 } 
	{ buffer_a_ce2 sc_out sc_logic 1 signal 5 } 
	{ buffer_a_q2 sc_in sc_lv 32 signal 5 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "indvars_iv16", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "indvars_iv16", "role": "default" }} , 
 	{ "name": "k_4", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "k_4", "role": "default" }} , 
 	{ "name": "j_7", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "j_7", "role": "default" }} , 
 	{ "name": "right_r", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "right_r", "role": "default" }} , 
 	{ "name": "buffer_b_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "buffer_b", "role": "address0" }} , 
 	{ "name": "buffer_b_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "buffer_b", "role": "ce0" }} , 
 	{ "name": "buffer_b_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "buffer_b", "role": "we0" }} , 
 	{ "name": "buffer_b_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "buffer_b", "role": "d0" }} , 
 	{ "name": "buffer_a_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "buffer_a", "role": "address0" }} , 
 	{ "name": "buffer_a_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "buffer_a", "role": "ce0" }} , 
 	{ "name": "buffer_a_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "buffer_a", "role": "q0" }} , 
 	{ "name": "buffer_a_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "buffer_a", "role": "address1" }} , 
 	{ "name": "buffer_a_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "buffer_a", "role": "ce1" }} , 
 	{ "name": "buffer_a_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "buffer_a", "role": "q1" }} , 
 	{ "name": "buffer_a_address2", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "buffer_a", "role": "address2" }} , 
 	{ "name": "buffer_a_ce2", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "buffer_a", "role": "ce2" }} , 
 	{ "name": "buffer_a_q2", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "buffer_a", "role": "q2" }}  ]}

set ArgLastReadFirstWriteLatency {
	merge_sort_hls_Pipeline_merge_a_to_b_loop {
		indvars_iv16 {Type I LastRead 0 FirstWrite -1}
		k_4 {Type I LastRead 0 FirstWrite -1}
		j_7 {Type I LastRead 0 FirstWrite -1}
		right_r {Type I LastRead 0 FirstWrite -1}
		buffer_b {Type O LastRead -1 FirstWrite 3}
		buffer_a {Type I LastRead 3 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "-1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	indvars_iv16 { ap_none {  { indvars_iv16 in_data 0 64 } } }
	k_4 { ap_none {  { k_4 in_data 0 32 } } }
	j_7 { ap_none {  { j_7 in_data 0 32 } } }
	right_r { ap_none {  { right_r in_data 0 32 } } }
	buffer_b { ap_memory {  { buffer_b_address0 mem_address 1 6 }  { buffer_b_ce0 mem_ce 1 1 }  { buffer_b_we0 mem_we 1 1 }  { buffer_b_d0 mem_din 1 32 } } }
	buffer_a { ap_memory {  { buffer_a_address0 mem_address 1 6 }  { buffer_a_ce0 mem_ce 1 1 }  { buffer_a_q0 mem_dout 0 32 }  { buffer_a_address1 MemPortADDR2 1 6 }  { buffer_a_ce1 MemPortCE2 1 1 }  { buffer_a_q1 MemPortDOUT2 0 32 }  { buffer_a_address2 MemPortADDR2 1 6 }  { buffer_a_ce2 MemPortCE2 1 1 }  { buffer_a_q2 MemPortDOUT2 0 32 } } }
}
