set moduleName sum
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set isPipelined_legacy 0
set pipeline_type none
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
set C_modelName {sum}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ stream_0 int 32 regular {fifo 0 volatile }  }
	{ stream_1 int 32 regular {fifo 0 volatile }  }
	{ res int 32 regular {pointer 2}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "stream_0", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "stream_1", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "res", "interface" : "wire", "bitwidth" : 32, "direction" : "READWRITE"} ]}
# RTL Port declarations: 
set portNum 20
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ stream_0_dout sc_in sc_lv 32 signal 0 } 
	{ stream_0_empty_n sc_in sc_logic 1 signal 0 } 
	{ stream_0_read sc_out sc_logic 1 signal 0 } 
	{ stream_0_num_data_valid sc_in sc_lv 3 signal 0 } 
	{ stream_0_fifo_cap sc_in sc_lv 3 signal 0 } 
	{ stream_1_dout sc_in sc_lv 32 signal 1 } 
	{ stream_1_empty_n sc_in sc_logic 1 signal 1 } 
	{ stream_1_read sc_out sc_logic 1 signal 1 } 
	{ stream_1_num_data_valid sc_in sc_lv 3 signal 1 } 
	{ stream_1_fifo_cap sc_in sc_lv 3 signal 1 } 
	{ res_i sc_in sc_lv 32 signal 2 } 
	{ res_o sc_out sc_lv 32 signal 2 } 
	{ res_o_ap_vld sc_out sc_logic 1 outvld 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "stream_0_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "stream_0", "role": "dout" }} , 
 	{ "name": "stream_0_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_0", "role": "empty_n" }} , 
 	{ "name": "stream_0_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_0", "role": "read" }} , 
 	{ "name": "stream_0_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "stream_0", "role": "num_data_valid" }} , 
 	{ "name": "stream_0_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "stream_0", "role": "fifo_cap" }} , 
 	{ "name": "stream_1_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "stream_1", "role": "dout" }} , 
 	{ "name": "stream_1_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_1", "role": "empty_n" }} , 
 	{ "name": "stream_1_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "stream_1", "role": "read" }} , 
 	{ "name": "stream_1_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "stream_1", "role": "num_data_valid" }} , 
 	{ "name": "stream_1_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "stream_1", "role": "fifo_cap" }} , 
 	{ "name": "res_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "res", "role": "i" }} , 
 	{ "name": "res_o", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "res", "role": "o" }} , 
 	{ "name": "res_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "res", "role": "o_ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	sum {
		stream_0 {Type I LastRead 1 FirstWrite -1}
		stream_1 {Type I LastRead 1 FirstWrite -1}
		res {Type IO LastRead 0 FirstWrite 9}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "4101", "Max" : "4101"}
	, {"Name" : "Interval", "Min" : "4101", "Max" : "4101"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	stream_0 { ap_fifo {  { stream_0_dout fifo_data_in 0 32 }  { stream_0_empty_n fifo_status 0 1 }  { stream_0_read fifo_port_we 1 1 }  { stream_0_num_data_valid fifo_status_num_data_valid 0 3 }  { stream_0_fifo_cap fifo_update 0 3 } } }
	stream_1 { ap_fifo {  { stream_1_dout fifo_data_in 0 32 }  { stream_1_empty_n fifo_status 0 1 }  { stream_1_read fifo_port_we 1 1 }  { stream_1_num_data_valid fifo_status_num_data_valid 0 3 }  { stream_1_fifo_cap fifo_update 0 3 } } }
	res { ap_ovld {  { res_i in_data 0 32 }  { res_o out_data 1 32 }  { res_o_ap_vld out_vld 1 1 } } }
}
