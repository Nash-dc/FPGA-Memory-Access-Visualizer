set moduleName matrix_mul_Pipeline_compute_row_loop_compute_col_loop
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
set C_modelName {matrix_mul_Pipeline_compute_row_loop_compute_col_loop}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict A_tile { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict A_tile_1 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict A_tile_2 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict A_tile_3 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict C_local { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict C_local_1 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict C_local_2 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict C_local_3 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
dict set ap_memory_interface_dict B_tile { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_tile_1 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_tile_2 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_tile_3 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ A_tile int 32 regular {array 16 { 1 3 } 1 1 }  }
	{ A_tile_1 int 32 regular {array 16 { 1 3 } 1 1 }  }
	{ A_tile_2 int 32 regular {array 16 { 1 3 } 1 1 }  }
	{ A_tile_3 int 32 regular {array 16 { 1 3 } 1 1 }  }
	{ C_local int 32 regular {array 64 { 0 1 } 1 1 }  }
	{ C_local_1 int 32 regular {array 64 { 0 1 } 1 1 }  }
	{ C_local_2 int 32 regular {array 64 { 0 1 } 1 1 }  }
	{ C_local_3 int 32 regular {array 64 { 0 1 } 1 1 }  }
	{ B_tile int 32 regular {array 16 { 1 3 } 1 1 }  }
	{ B_tile_1 int 32 regular {array 16 { 1 3 } 1 1 }  }
	{ B_tile_2 int 32 regular {array 16 { 1 3 } 1 1 }  }
	{ B_tile_3 int 32 regular {array 16 { 1 3 } 1 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "A_tile", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "A_tile_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "A_tile_2", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "A_tile_3", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "C_local", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "C_local_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "C_local_2", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "C_local_3", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "B_tile", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_tile_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_tile_2", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_tile_3", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 58
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ A_tile_address0 sc_out sc_lv 4 signal 0 } 
	{ A_tile_ce0 sc_out sc_logic 1 signal 0 } 
	{ A_tile_q0 sc_in sc_lv 32 signal 0 } 
	{ A_tile_1_address0 sc_out sc_lv 4 signal 1 } 
	{ A_tile_1_ce0 sc_out sc_logic 1 signal 1 } 
	{ A_tile_1_q0 sc_in sc_lv 32 signal 1 } 
	{ A_tile_2_address0 sc_out sc_lv 4 signal 2 } 
	{ A_tile_2_ce0 sc_out sc_logic 1 signal 2 } 
	{ A_tile_2_q0 sc_in sc_lv 32 signal 2 } 
	{ A_tile_3_address0 sc_out sc_lv 4 signal 3 } 
	{ A_tile_3_ce0 sc_out sc_logic 1 signal 3 } 
	{ A_tile_3_q0 sc_in sc_lv 32 signal 3 } 
	{ C_local_address0 sc_out sc_lv 6 signal 4 } 
	{ C_local_ce0 sc_out sc_logic 1 signal 4 } 
	{ C_local_we0 sc_out sc_logic 1 signal 4 } 
	{ C_local_d0 sc_out sc_lv 32 signal 4 } 
	{ C_local_address1 sc_out sc_lv 6 signal 4 } 
	{ C_local_ce1 sc_out sc_logic 1 signal 4 } 
	{ C_local_q1 sc_in sc_lv 32 signal 4 } 
	{ C_local_1_address0 sc_out sc_lv 6 signal 5 } 
	{ C_local_1_ce0 sc_out sc_logic 1 signal 5 } 
	{ C_local_1_we0 sc_out sc_logic 1 signal 5 } 
	{ C_local_1_d0 sc_out sc_lv 32 signal 5 } 
	{ C_local_1_address1 sc_out sc_lv 6 signal 5 } 
	{ C_local_1_ce1 sc_out sc_logic 1 signal 5 } 
	{ C_local_1_q1 sc_in sc_lv 32 signal 5 } 
	{ C_local_2_address0 sc_out sc_lv 6 signal 6 } 
	{ C_local_2_ce0 sc_out sc_logic 1 signal 6 } 
	{ C_local_2_we0 sc_out sc_logic 1 signal 6 } 
	{ C_local_2_d0 sc_out sc_lv 32 signal 6 } 
	{ C_local_2_address1 sc_out sc_lv 6 signal 6 } 
	{ C_local_2_ce1 sc_out sc_logic 1 signal 6 } 
	{ C_local_2_q1 sc_in sc_lv 32 signal 6 } 
	{ C_local_3_address0 sc_out sc_lv 6 signal 7 } 
	{ C_local_3_ce0 sc_out sc_logic 1 signal 7 } 
	{ C_local_3_we0 sc_out sc_logic 1 signal 7 } 
	{ C_local_3_d0 sc_out sc_lv 32 signal 7 } 
	{ C_local_3_address1 sc_out sc_lv 6 signal 7 } 
	{ C_local_3_ce1 sc_out sc_logic 1 signal 7 } 
	{ C_local_3_q1 sc_in sc_lv 32 signal 7 } 
	{ B_tile_address0 sc_out sc_lv 4 signal 8 } 
	{ B_tile_ce0 sc_out sc_logic 1 signal 8 } 
	{ B_tile_q0 sc_in sc_lv 32 signal 8 } 
	{ B_tile_1_address0 sc_out sc_lv 4 signal 9 } 
	{ B_tile_1_ce0 sc_out sc_logic 1 signal 9 } 
	{ B_tile_1_q0 sc_in sc_lv 32 signal 9 } 
	{ B_tile_2_address0 sc_out sc_lv 4 signal 10 } 
	{ B_tile_2_ce0 sc_out sc_logic 1 signal 10 } 
	{ B_tile_2_q0 sc_in sc_lv 32 signal 10 } 
	{ B_tile_3_address0 sc_out sc_lv 4 signal 11 } 
	{ B_tile_3_ce0 sc_out sc_logic 1 signal 11 } 
	{ B_tile_3_q0 sc_in sc_lv 32 signal 11 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "A_tile_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "A_tile", "role": "address0" }} , 
 	{ "name": "A_tile_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_tile", "role": "ce0" }} , 
 	{ "name": "A_tile_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_tile", "role": "q0" }} , 
 	{ "name": "A_tile_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "A_tile_1", "role": "address0" }} , 
 	{ "name": "A_tile_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_tile_1", "role": "ce0" }} , 
 	{ "name": "A_tile_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_tile_1", "role": "q0" }} , 
 	{ "name": "A_tile_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "A_tile_2", "role": "address0" }} , 
 	{ "name": "A_tile_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_tile_2", "role": "ce0" }} , 
 	{ "name": "A_tile_2_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_tile_2", "role": "q0" }} , 
 	{ "name": "A_tile_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "A_tile_3", "role": "address0" }} , 
 	{ "name": "A_tile_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_tile_3", "role": "ce0" }} , 
 	{ "name": "A_tile_3_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_tile_3", "role": "q0" }} , 
 	{ "name": "C_local_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "C_local", "role": "address0" }} , 
 	{ "name": "C_local_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local", "role": "ce0" }} , 
 	{ "name": "C_local_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local", "role": "we0" }} , 
 	{ "name": "C_local_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local", "role": "d0" }} , 
 	{ "name": "C_local_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "C_local", "role": "address1" }} , 
 	{ "name": "C_local_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local", "role": "ce1" }} , 
 	{ "name": "C_local_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local", "role": "q1" }} , 
 	{ "name": "C_local_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "C_local_1", "role": "address0" }} , 
 	{ "name": "C_local_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_1", "role": "ce0" }} , 
 	{ "name": "C_local_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_1", "role": "we0" }} , 
 	{ "name": "C_local_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local_1", "role": "d0" }} , 
 	{ "name": "C_local_1_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "C_local_1", "role": "address1" }} , 
 	{ "name": "C_local_1_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_1", "role": "ce1" }} , 
 	{ "name": "C_local_1_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local_1", "role": "q1" }} , 
 	{ "name": "C_local_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "C_local_2", "role": "address0" }} , 
 	{ "name": "C_local_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_2", "role": "ce0" }} , 
 	{ "name": "C_local_2_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_2", "role": "we0" }} , 
 	{ "name": "C_local_2_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local_2", "role": "d0" }} , 
 	{ "name": "C_local_2_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "C_local_2", "role": "address1" }} , 
 	{ "name": "C_local_2_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_2", "role": "ce1" }} , 
 	{ "name": "C_local_2_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local_2", "role": "q1" }} , 
 	{ "name": "C_local_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "C_local_3", "role": "address0" }} , 
 	{ "name": "C_local_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_3", "role": "ce0" }} , 
 	{ "name": "C_local_3_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_3", "role": "we0" }} , 
 	{ "name": "C_local_3_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local_3", "role": "d0" }} , 
 	{ "name": "C_local_3_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "C_local_3", "role": "address1" }} , 
 	{ "name": "C_local_3_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local_3", "role": "ce1" }} , 
 	{ "name": "C_local_3_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local_3", "role": "q1" }} , 
 	{ "name": "B_tile_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_tile", "role": "address0" }} , 
 	{ "name": "B_tile_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_tile", "role": "ce0" }} , 
 	{ "name": "B_tile_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_tile", "role": "q0" }} , 
 	{ "name": "B_tile_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_tile_1", "role": "address0" }} , 
 	{ "name": "B_tile_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_tile_1", "role": "ce0" }} , 
 	{ "name": "B_tile_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_tile_1", "role": "q0" }} , 
 	{ "name": "B_tile_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_tile_2", "role": "address0" }} , 
 	{ "name": "B_tile_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_tile_2", "role": "ce0" }} , 
 	{ "name": "B_tile_2_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_tile_2", "role": "q0" }} , 
 	{ "name": "B_tile_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_tile_3", "role": "address0" }} , 
 	{ "name": "B_tile_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_tile_3", "role": "ce0" }} , 
 	{ "name": "B_tile_3_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_tile_3", "role": "q0" }}  ]}

set ArgLastReadFirstWriteLatency {
	matrix_mul_Pipeline_compute_row_loop_compute_col_loop {
		A_tile {Type I LastRead 0 FirstWrite -1}
		A_tile_1 {Type I LastRead 0 FirstWrite -1}
		A_tile_2 {Type I LastRead 0 FirstWrite -1}
		A_tile_3 {Type I LastRead 0 FirstWrite -1}
		C_local {Type IO LastRead 2 FirstWrite 3}
		C_local_1 {Type IO LastRead 2 FirstWrite 3}
		C_local_2 {Type IO LastRead 2 FirstWrite 3}
		C_local_3 {Type IO LastRead 2 FirstWrite 3}
		B_tile {Type I LastRead 0 FirstWrite -1}
		B_tile_1 {Type I LastRead 0 FirstWrite -1}
		B_tile_2 {Type I LastRead 0 FirstWrite -1}
		B_tile_3 {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "260", "Max" : "260"}
	, {"Name" : "Interval", "Min" : "260", "Max" : "260"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	A_tile { ap_memory {  { A_tile_address0 mem_address 1 4 }  { A_tile_ce0 mem_ce 1 1 }  { A_tile_q0 mem_dout 0 32 } } }
	A_tile_1 { ap_memory {  { A_tile_1_address0 mem_address 1 4 }  { A_tile_1_ce0 mem_ce 1 1 }  { A_tile_1_q0 mem_dout 0 32 } } }
	A_tile_2 { ap_memory {  { A_tile_2_address0 mem_address 1 4 }  { A_tile_2_ce0 mem_ce 1 1 }  { A_tile_2_q0 mem_dout 0 32 } } }
	A_tile_3 { ap_memory {  { A_tile_3_address0 mem_address 1 4 }  { A_tile_3_ce0 mem_ce 1 1 }  { A_tile_3_q0 mem_dout 0 32 } } }
	C_local { ap_memory {  { C_local_address0 mem_address 1 6 }  { C_local_ce0 mem_ce 1 1 }  { C_local_we0 mem_we 1 1 }  { C_local_d0 mem_din 1 32 }  { C_local_address1 MemPortADDR2 1 6 }  { C_local_ce1 MemPortCE2 1 1 }  { C_local_q1 MemPortDOUT2 0 32 } } }
	C_local_1 { ap_memory {  { C_local_1_address0 mem_address 1 6 }  { C_local_1_ce0 mem_ce 1 1 }  { C_local_1_we0 mem_we 1 1 }  { C_local_1_d0 mem_din 1 32 }  { C_local_1_address1 MemPortADDR2 1 6 }  { C_local_1_ce1 MemPortCE2 1 1 }  { C_local_1_q1 MemPortDOUT2 0 32 } } }
	C_local_2 { ap_memory {  { C_local_2_address0 mem_address 1 6 }  { C_local_2_ce0 mem_ce 1 1 }  { C_local_2_we0 mem_we 1 1 }  { C_local_2_d0 mem_din 1 32 }  { C_local_2_address1 MemPortADDR2 1 6 }  { C_local_2_ce1 MemPortCE2 1 1 }  { C_local_2_q1 MemPortDOUT2 0 32 } } }
	C_local_3 { ap_memory {  { C_local_3_address0 mem_address 1 6 }  { C_local_3_ce0 mem_ce 1 1 }  { C_local_3_we0 mem_we 1 1 }  { C_local_3_d0 mem_din 1 32 }  { C_local_3_address1 MemPortADDR2 1 6 }  { C_local_3_ce1 MemPortCE2 1 1 }  { C_local_3_q1 MemPortDOUT2 0 32 } } }
	B_tile { ap_memory {  { B_tile_address0 mem_address 1 4 }  { B_tile_ce0 mem_ce 1 1 }  { B_tile_q0 mem_dout 0 32 } } }
	B_tile_1 { ap_memory {  { B_tile_1_address0 mem_address 1 4 }  { B_tile_1_ce0 mem_ce 1 1 }  { B_tile_1_q0 mem_dout 0 32 } } }
	B_tile_2 { ap_memory {  { B_tile_2_address0 mem_address 1 4 }  { B_tile_2_ce0 mem_ce 1 1 }  { B_tile_2_q0 mem_dout 0 32 } } }
	B_tile_3 { ap_memory {  { B_tile_3_address0 mem_address 1 4 }  { B_tile_3_ce0 mem_ce 1 1 }  { B_tile_3_q0 mem_dout 0 32 } } }
}
