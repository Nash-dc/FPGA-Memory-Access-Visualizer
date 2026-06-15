set moduleName matrix_mul
set isTopModule 1
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
set cdfgNum 8
set C_modelName {matrix_mul}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ gmem_a int 128 regular {axi_master 0}  }
	{ gmem_b int 512 regular {axi_master 0}  }
	{ gmem_c int 512 regular {axi_master 1}  }
	{ a int 64 regular {axi_slave 0}  }
	{ b int 64 regular {axi_slave 0}  }
	{ c int 64 regular {axi_slave 0}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "gmem_a", "interface" : "axi_master", "bitwidth" : 128, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "a","offset": { "type": "dynamic","port_name": "a","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "gmem_b", "interface" : "axi_master", "bitwidth" : 512, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "b","offset": { "type": "dynamic","port_name": "b","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "gmem_c", "interface" : "axi_master", "bitwidth" : 512, "direction" : "WRITEONLY", "bitSlice":[ {"cElement": [{"cName": "c","offset": { "type": "dynamic","port_name": "c","bundle": "control"},"direction": "WRITEONLY"}]}]} , 
 	{ "Name" : "a", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":27}} , 
 	{ "Name" : "b", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":28}, "offset_end" : {"in":39}} , 
 	{ "Name" : "c", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":40}, "offset_end" : {"in":51}} ]}
# RTL Port declarations: 
set portNum 155
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ m_axi_gmem_a_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem_a_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem_a_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_gmem_a_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem_a_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_gmem_a_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem_a_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem_a_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem_a_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem_a_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem_a_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem_a_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem_a_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem_a_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem_a_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem_a_WDATA sc_out sc_lv 128 signal 0 } 
	{ m_axi_gmem_a_WSTRB sc_out sc_lv 16 signal 0 } 
	{ m_axi_gmem_a_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem_a_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem_a_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem_a_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem_a_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem_a_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_gmem_a_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem_a_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_gmem_a_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem_a_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem_a_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem_a_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem_a_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem_a_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem_a_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem_a_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem_a_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem_a_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem_a_RDATA sc_in sc_lv 128 signal 0 } 
	{ m_axi_gmem_a_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem_a_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem_a_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem_a_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_gmem_a_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem_a_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem_a_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_gmem_a_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem_a_BUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem_b_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem_b_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem_b_AWADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_gmem_b_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem_b_AWLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_gmem_b_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem_b_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem_b_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem_b_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_b_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem_b_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_b_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_b_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem_b_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem_b_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem_b_WDATA sc_out sc_lv 512 signal 1 } 
	{ m_axi_gmem_b_WSTRB sc_out sc_lv 64 signal 1 } 
	{ m_axi_gmem_b_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem_b_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem_b_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem_b_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem_b_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem_b_ARADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_gmem_b_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem_b_ARLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_gmem_b_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem_b_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem_b_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem_b_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_b_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem_b_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_b_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_b_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem_b_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem_b_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem_b_RDATA sc_in sc_lv 512 signal 1 } 
	{ m_axi_gmem_b_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem_b_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem_b_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem_b_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_gmem_b_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem_b_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem_b_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_gmem_b_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem_b_BUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem_c_AWVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem_c_AWREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem_c_AWADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_gmem_c_AWID sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem_c_AWLEN sc_out sc_lv 8 signal 2 } 
	{ m_axi_gmem_c_AWSIZE sc_out sc_lv 3 signal 2 } 
	{ m_axi_gmem_c_AWBURST sc_out sc_lv 2 signal 2 } 
	{ m_axi_gmem_c_AWLOCK sc_out sc_lv 2 signal 2 } 
	{ m_axi_gmem_c_AWCACHE sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_c_AWPROT sc_out sc_lv 3 signal 2 } 
	{ m_axi_gmem_c_AWQOS sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_c_AWREGION sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_c_AWUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem_c_WVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem_c_WREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem_c_WDATA sc_out sc_lv 512 signal 2 } 
	{ m_axi_gmem_c_WSTRB sc_out sc_lv 64 signal 2 } 
	{ m_axi_gmem_c_WLAST sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem_c_WID sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem_c_WUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem_c_ARVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem_c_ARREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem_c_ARADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_gmem_c_ARID sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem_c_ARLEN sc_out sc_lv 8 signal 2 } 
	{ m_axi_gmem_c_ARSIZE sc_out sc_lv 3 signal 2 } 
	{ m_axi_gmem_c_ARBURST sc_out sc_lv 2 signal 2 } 
	{ m_axi_gmem_c_ARLOCK sc_out sc_lv 2 signal 2 } 
	{ m_axi_gmem_c_ARCACHE sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_c_ARPROT sc_out sc_lv 3 signal 2 } 
	{ m_axi_gmem_c_ARQOS sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_c_ARREGION sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_c_ARUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem_c_RVALID sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem_c_RREADY sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem_c_RDATA sc_in sc_lv 512 signal 2 } 
	{ m_axi_gmem_c_RLAST sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem_c_RID sc_in sc_lv 1 signal 2 } 
	{ m_axi_gmem_c_RUSER sc_in sc_lv 1 signal 2 } 
	{ m_axi_gmem_c_RRESP sc_in sc_lv 2 signal 2 } 
	{ m_axi_gmem_c_BVALID sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem_c_BREADY sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem_c_BRESP sc_in sc_lv 2 signal 2 } 
	{ m_axi_gmem_c_BID sc_in sc_lv 1 signal 2 } 
	{ m_axi_gmem_c_BUSER sc_in sc_lv 1 signal 2 } 
	{ s_axi_control_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_AWADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_control_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_control_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_ARADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_control_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_control_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_control_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_BRESP sc_out sc_lv 2 signal -1 } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"matrix_mul","role":"start","value":"0","valid_bit":"0"},{"name":"matrix_mul","role":"continue","value":"0","valid_bit":"4"},{"name":"matrix_mul","role":"auto_start","value":"0","valid_bit":"7"},{"name":"a","role":"data","value":"16"},{"name":"b","role":"data","value":"28"},{"name":"c","role":"data","value":"40"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[{"name":"matrix_mul","role":"start","value":"0","valid_bit":"0"},{"name":"matrix_mul","role":"done","value":"0","valid_bit":"1"},{"name":"matrix_mul","role":"idle","value":"0","valid_bit":"2"},{"name":"matrix_mul","role":"ready","value":"0","valid_bit":"3"},{"name":"matrix_mul","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_control_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARVALID" } },
	{ "name": "s_axi_control_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARREADY" } },
	{ "name": "s_axi_control_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RVALID" } },
	{ "name": "s_axi_control_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RREADY" } },
	{ "name": "s_axi_control_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "RDATA" } },
	{ "name": "s_axi_control_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "RRESP" } },
	{ "name": "s_axi_control_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BVALID" } },
	{ "name": "s_axi_control_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BREADY" } },
	{ "name": "s_axi_control_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "BRESP" } },
	{ "name": "interrupt", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "interrupt" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "m_axi_gmem_a_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem_a_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem_a_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem_a_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem_a_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem_a_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem_a_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem_a_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem_a_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem_a_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem_a_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem_a_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem_a_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem_a_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem_a_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem_a_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":128, "type": "signal", "bundle":{"name": "gmem_a", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem_a_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "gmem_a", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem_a_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem_a_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "WID" }} , 
 	{ "name": "m_axi_gmem_a_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem_a_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem_a_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem_a_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem_a_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem_a_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem_a_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem_a_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem_a_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem_a_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem_a_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem_a_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem_a_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem_a_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem_a_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem_a_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem_a_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":128, "type": "signal", "bundle":{"name": "gmem_a", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem_a_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem_a_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "RID" }} , 
 	{ "name": "m_axi_gmem_a_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem_a_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_a", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem_a_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem_a_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem_a_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_a", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem_a_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "BID" }} , 
 	{ "name": "m_axi_gmem_a_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_a", "role": "BUSER" }} , 
 	{ "name": "m_axi_gmem_b_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem_b_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem_b_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem_b_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem_b_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem_b_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem_b_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem_b_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem_b_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem_b_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem_b_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem_b_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem_b_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem_b_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem_b_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem_b_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem_b", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem_b_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_b", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem_b_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem_b_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "WID" }} , 
 	{ "name": "m_axi_gmem_b_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem_b_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem_b_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem_b_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem_b_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem_b_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem_b_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem_b_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem_b_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem_b_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem_b_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem_b_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem_b_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem_b_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem_b_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem_b_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem_b_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem_b", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem_b_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem_b_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "RID" }} , 
 	{ "name": "m_axi_gmem_b_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem_b_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_b", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem_b_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem_b_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem_b_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_b", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem_b_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "BID" }} , 
 	{ "name": "m_axi_gmem_b_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_b", "role": "BUSER" }} , 
 	{ "name": "m_axi_gmem_c_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem_c_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem_c_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem_c_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem_c_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem_c_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem_c_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem_c_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem_c_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem_c_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem_c_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem_c_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem_c_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem_c_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem_c_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem_c_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem_c", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem_c_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_c", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem_c_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem_c_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "WID" }} , 
 	{ "name": "m_axi_gmem_c_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem_c_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem_c_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem_c_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem_c_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem_c_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem_c_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem_c_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem_c_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem_c_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem_c_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem_c_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem_c_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem_c_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem_c_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem_c_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem_c_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem_c", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem_c_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem_c_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "RID" }} , 
 	{ "name": "m_axi_gmem_c_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem_c_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_c", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem_c_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem_c_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem_c_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_c", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem_c_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "BID" }} , 
 	{ "name": "m_axi_gmem_c_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_c", "role": "BUSER" }}  ]}

set ArgLastReadFirstWriteLatency {
	matrix_mul {
		gmem_a {Type I LastRead 9 FirstWrite -1}
		gmem_b {Type I LastRead 2 FirstWrite -1}
		gmem_c {Type O LastRead 14 FirstWrite 2}
		a {Type I LastRead 1 FirstWrite -1}
		b {Type I LastRead 1 FirstWrite -1}
		c {Type I LastRead 1 FirstWrite -1}}
	matrix_mul_Pipeline_init_c_loop_init_c_col_loop {
		C_local {Type O LastRead -1 FirstWrite 0}
		C_local_1 {Type O LastRead -1 FirstWrite 0}
		C_local_2 {Type O LastRead -1 FirstWrite 0}
		C_local_3 {Type O LastRead -1 FirstWrite 0}}
	matrix_mul_Pipeline_load_a_tile_row_loop_load_a_tile_lane_loop {
		gmem_a {Type I LastRead 9 FirstWrite -1}
		A_tile {Type O LastRead -1 FirstWrite 10}
		A_tile_1 {Type O LastRead -1 FirstWrite 10}
		A_tile_2 {Type O LastRead -1 FirstWrite 10}
		A_tile_3 {Type O LastRead -1 FirstWrite 10}
		empty {Type I LastRead 0 FirstWrite -1}
		a {Type I LastRead 0 FirstWrite -1}}
	matrix_mul_Pipeline_load_b_tile_lane_loop_load_b_tile_col_loop {
		gmem_b {Type I LastRead 1 FirstWrite -1}
		B_tile_3 {Type O LastRead -1 FirstWrite 2}
		B_tile_2 {Type O LastRead -1 FirstWrite 2}
		B_tile_1 {Type O LastRead -1 FirstWrite 2}
		B_tile {Type O LastRead -1 FirstWrite 2}
		sext_ln36 {Type I LastRead 0 FirstWrite -1}}
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
		B_tile_3 {Type I LastRead 0 FirstWrite -1}}
	matrix_mul_Pipeline_store_c_loop {
		gmem_c {Type O LastRead -1 FirstWrite 2}
		sext_ln77 {Type I LastRead 0 FirstWrite -1}
		C_local {Type I LastRead 0 FirstWrite -1}
		C_local_1 {Type I LastRead 0 FirstWrite -1}
		C_local_2 {Type I LastRead 0 FirstWrite -1}
		C_local_3 {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1895", "Max" : "1895"}
	, {"Name" : "Interval", "Min" : "1896", "Max" : "1896"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	gmem_a { m_axi {  { m_axi_gmem_a_AWVALID VALID 1 1 }  { m_axi_gmem_a_AWREADY READY 0 1 }  { m_axi_gmem_a_AWADDR ADDR 1 64 }  { m_axi_gmem_a_AWID ID 1 1 }  { m_axi_gmem_a_AWLEN SIZE 1 8 }  { m_axi_gmem_a_AWSIZE BURST 1 3 }  { m_axi_gmem_a_AWBURST LOCK 1 2 }  { m_axi_gmem_a_AWLOCK CACHE 1 2 }  { m_axi_gmem_a_AWCACHE PROT 1 4 }  { m_axi_gmem_a_AWPROT QOS 1 3 }  { m_axi_gmem_a_AWQOS REGION 1 4 }  { m_axi_gmem_a_AWREGION USER 1 4 }  { m_axi_gmem_a_AWUSER DATA 1 1 }  { m_axi_gmem_a_WVALID VALID 1 1 }  { m_axi_gmem_a_WREADY READY 0 1 }  { m_axi_gmem_a_WDATA FIFONUM 1 128 }  { m_axi_gmem_a_WSTRB STRB 1 16 }  { m_axi_gmem_a_WLAST LAST 1 1 }  { m_axi_gmem_a_WID ID 1 1 }  { m_axi_gmem_a_WUSER DATA 1 1 }  { m_axi_gmem_a_ARVALID VALID 1 1 }  { m_axi_gmem_a_ARREADY READY 0 1 }  { m_axi_gmem_a_ARADDR ADDR 1 64 }  { m_axi_gmem_a_ARID ID 1 1 }  { m_axi_gmem_a_ARLEN SIZE 1 8 }  { m_axi_gmem_a_ARSIZE BURST 1 3 }  { m_axi_gmem_a_ARBURST LOCK 1 2 }  { m_axi_gmem_a_ARLOCK CACHE 1 2 }  { m_axi_gmem_a_ARCACHE PROT 1 4 }  { m_axi_gmem_a_ARPROT QOS 1 3 }  { m_axi_gmem_a_ARQOS REGION 1 4 }  { m_axi_gmem_a_ARREGION USER 1 4 }  { m_axi_gmem_a_ARUSER DATA 1 1 }  { m_axi_gmem_a_RVALID VALID 0 1 }  { m_axi_gmem_a_RREADY READY 1 1 }  { m_axi_gmem_a_RDATA FIFONUM 0 128 }  { m_axi_gmem_a_RLAST LAST 0 1 }  { m_axi_gmem_a_RID ID 0 1 }  { m_axi_gmem_a_RUSER DATA 0 1 }  { m_axi_gmem_a_RRESP RESP 0 2 }  { m_axi_gmem_a_BVALID VALID 0 1 }  { m_axi_gmem_a_BREADY READY 1 1 }  { m_axi_gmem_a_BRESP RESP 0 2 }  { m_axi_gmem_a_BID ID 0 1 }  { m_axi_gmem_a_BUSER DATA 0 1 } } }
	gmem_b { m_axi {  { m_axi_gmem_b_AWVALID VALID 1 1 }  { m_axi_gmem_b_AWREADY READY 0 1 }  { m_axi_gmem_b_AWADDR ADDR 1 64 }  { m_axi_gmem_b_AWID ID 1 1 }  { m_axi_gmem_b_AWLEN SIZE 1 8 }  { m_axi_gmem_b_AWSIZE BURST 1 3 }  { m_axi_gmem_b_AWBURST LOCK 1 2 }  { m_axi_gmem_b_AWLOCK CACHE 1 2 }  { m_axi_gmem_b_AWCACHE PROT 1 4 }  { m_axi_gmem_b_AWPROT QOS 1 3 }  { m_axi_gmem_b_AWQOS REGION 1 4 }  { m_axi_gmem_b_AWREGION USER 1 4 }  { m_axi_gmem_b_AWUSER DATA 1 1 }  { m_axi_gmem_b_WVALID VALID 1 1 }  { m_axi_gmem_b_WREADY READY 0 1 }  { m_axi_gmem_b_WDATA FIFONUM 1 512 }  { m_axi_gmem_b_WSTRB STRB 1 64 }  { m_axi_gmem_b_WLAST LAST 1 1 }  { m_axi_gmem_b_WID ID 1 1 }  { m_axi_gmem_b_WUSER DATA 1 1 }  { m_axi_gmem_b_ARVALID VALID 1 1 }  { m_axi_gmem_b_ARREADY READY 0 1 }  { m_axi_gmem_b_ARADDR ADDR 1 64 }  { m_axi_gmem_b_ARID ID 1 1 }  { m_axi_gmem_b_ARLEN SIZE 1 8 }  { m_axi_gmem_b_ARSIZE BURST 1 3 }  { m_axi_gmem_b_ARBURST LOCK 1 2 }  { m_axi_gmem_b_ARLOCK CACHE 1 2 }  { m_axi_gmem_b_ARCACHE PROT 1 4 }  { m_axi_gmem_b_ARPROT QOS 1 3 }  { m_axi_gmem_b_ARQOS REGION 1 4 }  { m_axi_gmem_b_ARREGION USER 1 4 }  { m_axi_gmem_b_ARUSER DATA 1 1 }  { m_axi_gmem_b_RVALID VALID 0 1 }  { m_axi_gmem_b_RREADY READY 1 1 }  { m_axi_gmem_b_RDATA FIFONUM 0 512 }  { m_axi_gmem_b_RLAST LAST 0 1 }  { m_axi_gmem_b_RID ID 0 1 }  { m_axi_gmem_b_RUSER DATA 0 1 }  { m_axi_gmem_b_RRESP RESP 0 2 }  { m_axi_gmem_b_BVALID VALID 0 1 }  { m_axi_gmem_b_BREADY READY 1 1 }  { m_axi_gmem_b_BRESP RESP 0 2 }  { m_axi_gmem_b_BID ID 0 1 }  { m_axi_gmem_b_BUSER DATA 0 1 } } }
	gmem_c { m_axi {  { m_axi_gmem_c_AWVALID VALID 1 1 }  { m_axi_gmem_c_AWREADY READY 0 1 }  { m_axi_gmem_c_AWADDR ADDR 1 64 }  { m_axi_gmem_c_AWID ID 1 1 }  { m_axi_gmem_c_AWLEN SIZE 1 8 }  { m_axi_gmem_c_AWSIZE BURST 1 3 }  { m_axi_gmem_c_AWBURST LOCK 1 2 }  { m_axi_gmem_c_AWLOCK CACHE 1 2 }  { m_axi_gmem_c_AWCACHE PROT 1 4 }  { m_axi_gmem_c_AWPROT QOS 1 3 }  { m_axi_gmem_c_AWQOS REGION 1 4 }  { m_axi_gmem_c_AWREGION USER 1 4 }  { m_axi_gmem_c_AWUSER DATA 1 1 }  { m_axi_gmem_c_WVALID VALID 1 1 }  { m_axi_gmem_c_WREADY READY 0 1 }  { m_axi_gmem_c_WDATA FIFONUM 1 512 }  { m_axi_gmem_c_WSTRB STRB 1 64 }  { m_axi_gmem_c_WLAST LAST 1 1 }  { m_axi_gmem_c_WID ID 1 1 }  { m_axi_gmem_c_WUSER DATA 1 1 }  { m_axi_gmem_c_ARVALID VALID 1 1 }  { m_axi_gmem_c_ARREADY READY 0 1 }  { m_axi_gmem_c_ARADDR ADDR 1 64 }  { m_axi_gmem_c_ARID ID 1 1 }  { m_axi_gmem_c_ARLEN SIZE 1 8 }  { m_axi_gmem_c_ARSIZE BURST 1 3 }  { m_axi_gmem_c_ARBURST LOCK 1 2 }  { m_axi_gmem_c_ARLOCK CACHE 1 2 }  { m_axi_gmem_c_ARCACHE PROT 1 4 }  { m_axi_gmem_c_ARPROT QOS 1 3 }  { m_axi_gmem_c_ARQOS REGION 1 4 }  { m_axi_gmem_c_ARREGION USER 1 4 }  { m_axi_gmem_c_ARUSER DATA 1 1 }  { m_axi_gmem_c_RVALID VALID 0 1 }  { m_axi_gmem_c_RREADY READY 1 1 }  { m_axi_gmem_c_RDATA FIFONUM 0 512 }  { m_axi_gmem_c_RLAST LAST 0 1 }  { m_axi_gmem_c_RID ID 0 1 }  { m_axi_gmem_c_RUSER DATA 0 1 }  { m_axi_gmem_c_RRESP RESP 0 2 }  { m_axi_gmem_c_BVALID VALID 0 1 }  { m_axi_gmem_c_BREADY READY 1 1 }  { m_axi_gmem_c_BRESP RESP 0 2 }  { m_axi_gmem_c_BID ID 0 1 }  { m_axi_gmem_c_BUSER DATA 0 1 } } }
}

set maxi_interface_dict [dict create]
dict set maxi_interface_dict gmem_a { CHANNEL_NUM 0 BUNDLE gmem_a NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 1 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_ONLY}
dict set maxi_interface_dict gmem_b { CHANNEL_NUM 0 BUNDLE gmem_b NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 1 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_ONLY}
dict set maxi_interface_dict gmem_c { CHANNEL_NUM 0 BUNDLE gmem_c NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 1 READ_WRITE_MODE WRITE_ONLY}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ gmem_a 1 }
	{ gmem_b 1 }
	{ gmem_c 1 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ gmem_a 1 }
	{ gmem_b 1 }
	{ gmem_c 1 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
