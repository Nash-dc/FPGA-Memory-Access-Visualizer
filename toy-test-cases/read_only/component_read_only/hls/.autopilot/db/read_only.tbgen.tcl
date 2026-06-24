set moduleName read_only
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set isPipelined_legacy 0
set pipeline_type dataflow
set FunctionProtocol ap_ctrl_chain
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 7
set C_modelName {read_only}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ mem_0 int 512 regular {axi_master 0}  }
	{ mem_1 int 512 regular {axi_master 0}  }
	{ mem_0_r int 64 regular {axi_slave 0}  }
	{ mem_1_r int 64 regular {axi_slave 0}  }
	{ res int 32 regular {axi_slave 2}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "mem_0", "interface" : "axi_master", "bitwidth" : 512, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "mem_0_r","offset": { "type": "dynamic","port_name": "mem_0_r","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "mem_1", "interface" : "axi_master", "bitwidth" : 512, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "mem_1_r","offset": { "type": "dynamic","port_name": "mem_1_r","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "mem_0_r", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":27}} , 
 	{ "Name" : "mem_1_r", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":28}, "offset_end" : {"in":39}} , 
 	{ "Name" : "res", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READWRITE", "offset" : {"in":40, "out":48}, "offset_end" : {"in":47, "out":55}} ]}
# RTL Port declarations: 
set portNum 110
set portList { 
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
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
	{ m_axi_mem_0_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_mem_0_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_mem_0_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_mem_0_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_mem_0_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_mem_0_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_mem_0_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_mem_0_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_mem_0_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_mem_0_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_mem_0_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_mem_0_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_mem_0_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_mem_0_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_mem_0_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_mem_0_WDATA sc_out sc_lv 512 signal 0 } 
	{ m_axi_mem_0_WSTRB sc_out sc_lv 64 signal 0 } 
	{ m_axi_mem_0_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_mem_0_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_mem_0_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_mem_0_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_mem_0_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_mem_0_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_mem_0_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_mem_0_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_mem_0_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_mem_0_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_mem_0_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_mem_0_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_mem_0_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_mem_0_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_mem_0_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_mem_0_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_mem_0_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_mem_0_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_mem_0_RDATA sc_in sc_lv 512 signal 0 } 
	{ m_axi_mem_0_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_mem_0_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_mem_0_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_mem_0_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_mem_0_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_mem_0_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_mem_0_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_mem_0_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_mem_0_BUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_mem_1_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_mem_1_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_mem_1_AWADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_mem_1_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_mem_1_AWLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_mem_1_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_mem_1_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_mem_1_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_mem_1_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_mem_1_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_mem_1_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_mem_1_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_mem_1_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_mem_1_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_mem_1_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_mem_1_WDATA sc_out sc_lv 512 signal 1 } 
	{ m_axi_mem_1_WSTRB sc_out sc_lv 64 signal 1 } 
	{ m_axi_mem_1_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_mem_1_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_mem_1_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_mem_1_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_mem_1_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_mem_1_ARADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_mem_1_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_mem_1_ARLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_mem_1_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_mem_1_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_mem_1_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_mem_1_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_mem_1_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_mem_1_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_mem_1_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_mem_1_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_mem_1_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_mem_1_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_mem_1_RDATA sc_in sc_lv 512 signal 1 } 
	{ m_axi_mem_1_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_mem_1_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_mem_1_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_mem_1_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_mem_1_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_mem_1_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_mem_1_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_mem_1_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_mem_1_BUSER sc_in sc_lv 1 signal 1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"read_only","role":"start","value":"0","valid_bit":"0"},{"name":"read_only","role":"continue","value":"0","valid_bit":"4"},{"name":"read_only","role":"auto_start","value":"0","valid_bit":"7"},{"name":"mem_0_r","role":"data","value":"16"},{"name":"mem_1_r","role":"data","value":"28"},{"name":"res","role":"data","value":"40"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[{"name":"read_only","role":"start","value":"0","valid_bit":"0"},{"name":"read_only","role":"done","value":"0","valid_bit":"1"},{"name":"read_only","role":"idle","value":"0","valid_bit":"2"},{"name":"read_only","role":"ready","value":"0","valid_bit":"3"},{"name":"read_only","role":"auto_start","value":"0","valid_bit":"7"},{"name":"res","role":"data","value":"48"}] },
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
 	{ "name": "m_axi_mem_0_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "AWVALID" }} , 
 	{ "name": "m_axi_mem_0_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "AWREADY" }} , 
 	{ "name": "m_axi_mem_0_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_0", "role": "AWADDR" }} , 
 	{ "name": "m_axi_mem_0_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "AWID" }} , 
 	{ "name": "m_axi_mem_0_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "mem_0", "role": "AWLEN" }} , 
 	{ "name": "m_axi_mem_0_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "mem_0", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_mem_0_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "mem_0", "role": "AWBURST" }} , 
 	{ "name": "m_axi_mem_0_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "mem_0", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_mem_0_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "mem_0", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_mem_0_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "mem_0", "role": "AWPROT" }} , 
 	{ "name": "m_axi_mem_0_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "mem_0", "role": "AWQOS" }} , 
 	{ "name": "m_axi_mem_0_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "mem_0", "role": "AWREGION" }} , 
 	{ "name": "m_axi_mem_0_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "AWUSER" }} , 
 	{ "name": "m_axi_mem_0_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "WVALID" }} , 
 	{ "name": "m_axi_mem_0_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "WREADY" }} , 
 	{ "name": "m_axi_mem_0_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "mem_0", "role": "WDATA" }} , 
 	{ "name": "m_axi_mem_0_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_0", "role": "WSTRB" }} , 
 	{ "name": "m_axi_mem_0_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "WLAST" }} , 
 	{ "name": "m_axi_mem_0_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "WID" }} , 
 	{ "name": "m_axi_mem_0_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "WUSER" }} , 
 	{ "name": "m_axi_mem_0_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "ARVALID" }} , 
 	{ "name": "m_axi_mem_0_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "ARREADY" }} , 
 	{ "name": "m_axi_mem_0_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_0", "role": "ARADDR" }} , 
 	{ "name": "m_axi_mem_0_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "ARID" }} , 
 	{ "name": "m_axi_mem_0_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "mem_0", "role": "ARLEN" }} , 
 	{ "name": "m_axi_mem_0_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "mem_0", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_mem_0_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "mem_0", "role": "ARBURST" }} , 
 	{ "name": "m_axi_mem_0_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "mem_0", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_mem_0_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "mem_0", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_mem_0_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "mem_0", "role": "ARPROT" }} , 
 	{ "name": "m_axi_mem_0_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "mem_0", "role": "ARQOS" }} , 
 	{ "name": "m_axi_mem_0_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "mem_0", "role": "ARREGION" }} , 
 	{ "name": "m_axi_mem_0_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "ARUSER" }} , 
 	{ "name": "m_axi_mem_0_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "RVALID" }} , 
 	{ "name": "m_axi_mem_0_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "RREADY" }} , 
 	{ "name": "m_axi_mem_0_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "mem_0", "role": "RDATA" }} , 
 	{ "name": "m_axi_mem_0_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "RLAST" }} , 
 	{ "name": "m_axi_mem_0_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "RID" }} , 
 	{ "name": "m_axi_mem_0_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "RUSER" }} , 
 	{ "name": "m_axi_mem_0_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "mem_0", "role": "RRESP" }} , 
 	{ "name": "m_axi_mem_0_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "BVALID" }} , 
 	{ "name": "m_axi_mem_0_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "BREADY" }} , 
 	{ "name": "m_axi_mem_0_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "mem_0", "role": "BRESP" }} , 
 	{ "name": "m_axi_mem_0_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "BID" }} , 
 	{ "name": "m_axi_mem_0_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_0", "role": "BUSER" }} , 
 	{ "name": "m_axi_mem_1_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "AWVALID" }} , 
 	{ "name": "m_axi_mem_1_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "AWREADY" }} , 
 	{ "name": "m_axi_mem_1_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_1", "role": "AWADDR" }} , 
 	{ "name": "m_axi_mem_1_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "AWID" }} , 
 	{ "name": "m_axi_mem_1_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "mem_1", "role": "AWLEN" }} , 
 	{ "name": "m_axi_mem_1_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "mem_1", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_mem_1_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "mem_1", "role": "AWBURST" }} , 
 	{ "name": "m_axi_mem_1_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "mem_1", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_mem_1_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "mem_1", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_mem_1_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "mem_1", "role": "AWPROT" }} , 
 	{ "name": "m_axi_mem_1_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "mem_1", "role": "AWQOS" }} , 
 	{ "name": "m_axi_mem_1_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "mem_1", "role": "AWREGION" }} , 
 	{ "name": "m_axi_mem_1_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "AWUSER" }} , 
 	{ "name": "m_axi_mem_1_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "WVALID" }} , 
 	{ "name": "m_axi_mem_1_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "WREADY" }} , 
 	{ "name": "m_axi_mem_1_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "mem_1", "role": "WDATA" }} , 
 	{ "name": "m_axi_mem_1_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_1", "role": "WSTRB" }} , 
 	{ "name": "m_axi_mem_1_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "WLAST" }} , 
 	{ "name": "m_axi_mem_1_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "WID" }} , 
 	{ "name": "m_axi_mem_1_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "WUSER" }} , 
 	{ "name": "m_axi_mem_1_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "ARVALID" }} , 
 	{ "name": "m_axi_mem_1_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "ARREADY" }} , 
 	{ "name": "m_axi_mem_1_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mem_1", "role": "ARADDR" }} , 
 	{ "name": "m_axi_mem_1_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "ARID" }} , 
 	{ "name": "m_axi_mem_1_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "mem_1", "role": "ARLEN" }} , 
 	{ "name": "m_axi_mem_1_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "mem_1", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_mem_1_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "mem_1", "role": "ARBURST" }} , 
 	{ "name": "m_axi_mem_1_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "mem_1", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_mem_1_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "mem_1", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_mem_1_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "mem_1", "role": "ARPROT" }} , 
 	{ "name": "m_axi_mem_1_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "mem_1", "role": "ARQOS" }} , 
 	{ "name": "m_axi_mem_1_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "mem_1", "role": "ARREGION" }} , 
 	{ "name": "m_axi_mem_1_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "ARUSER" }} , 
 	{ "name": "m_axi_mem_1_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "RVALID" }} , 
 	{ "name": "m_axi_mem_1_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "RREADY" }} , 
 	{ "name": "m_axi_mem_1_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "mem_1", "role": "RDATA" }} , 
 	{ "name": "m_axi_mem_1_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "RLAST" }} , 
 	{ "name": "m_axi_mem_1_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "RID" }} , 
 	{ "name": "m_axi_mem_1_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "RUSER" }} , 
 	{ "name": "m_axi_mem_1_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "mem_1", "role": "RRESP" }} , 
 	{ "name": "m_axi_mem_1_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "BVALID" }} , 
 	{ "name": "m_axi_mem_1_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "BREADY" }} , 
 	{ "name": "m_axi_mem_1_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "mem_1", "role": "BRESP" }} , 
 	{ "name": "m_axi_mem_1_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "BID" }} , 
 	{ "name": "m_axi_mem_1_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "mem_1", "role": "BUSER" }}  ]}

set ArgLastReadFirstWriteLatency {
	read_only {
		mem_0 {Type I LastRead 72 FirstWrite -1}
		mem_1 {Type I LastRead 72 FirstWrite -1}
		mem_0_r {Type I LastRead 0 FirstWrite -1}
		mem_1_r {Type I LastRead 0 FirstWrite -1}
		res {Type IO LastRead 0 FirstWrite 9}}
	Loop_VITIS_LOOP_72_1_proc {
		mem_0_r {Type I LastRead 0 FirstWrite -1}
		mem_0 {Type I LastRead 72 FirstWrite -1}
		stream_0 {Type O LastRead -1 FirstWrite 73}}
	Block_entry_proc {
		mem_1_r {Type I LastRead 0 FirstWrite -1}}
	Loop_VITIS_LOOP_76_2_proc {
		p_read {Type I LastRead 0 FirstWrite -1}
		mem_1 {Type I LastRead 72 FirstWrite -1}
		stream_1 {Type O LastRead -1 FirstWrite 73}}
	sum {
		stream_0 {Type I LastRead 1 FirstWrite -1}
		stream_1 {Type I LastRead 1 FirstWrite -1}
		res {Type IO LastRead 0 FirstWrite 9}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "4175", "Max" : "4175"}
	, {"Name" : "Interval", "Min" : "4102", "Max" : "4102"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	mem_0 { m_axi {  { m_axi_mem_0_AWVALID VALID 1 1 }  { m_axi_mem_0_AWREADY READY 0 1 }  { m_axi_mem_0_AWADDR ADDR 1 64 }  { m_axi_mem_0_AWID ID 1 1 }  { m_axi_mem_0_AWLEN SIZE 1 8 }  { m_axi_mem_0_AWSIZE BURST 1 3 }  { m_axi_mem_0_AWBURST LOCK 1 2 }  { m_axi_mem_0_AWLOCK CACHE 1 2 }  { m_axi_mem_0_AWCACHE PROT 1 4 }  { m_axi_mem_0_AWPROT QOS 1 3 }  { m_axi_mem_0_AWQOS REGION 1 4 }  { m_axi_mem_0_AWREGION USER 1 4 }  { m_axi_mem_0_AWUSER DATA 1 1 }  { m_axi_mem_0_WVALID VALID 1 1 }  { m_axi_mem_0_WREADY READY 0 1 }  { m_axi_mem_0_WDATA FIFONUM 1 512 }  { m_axi_mem_0_WSTRB STRB 1 64 }  { m_axi_mem_0_WLAST LAST 1 1 }  { m_axi_mem_0_WID ID 1 1 }  { m_axi_mem_0_WUSER DATA 1 1 }  { m_axi_mem_0_ARVALID VALID 1 1 }  { m_axi_mem_0_ARREADY READY 0 1 }  { m_axi_mem_0_ARADDR ADDR 1 64 }  { m_axi_mem_0_ARID ID 1 1 }  { m_axi_mem_0_ARLEN SIZE 1 8 }  { m_axi_mem_0_ARSIZE BURST 1 3 }  { m_axi_mem_0_ARBURST LOCK 1 2 }  { m_axi_mem_0_ARLOCK CACHE 1 2 }  { m_axi_mem_0_ARCACHE PROT 1 4 }  { m_axi_mem_0_ARPROT QOS 1 3 }  { m_axi_mem_0_ARQOS REGION 1 4 }  { m_axi_mem_0_ARREGION USER 1 4 }  { m_axi_mem_0_ARUSER DATA 1 1 }  { m_axi_mem_0_RVALID VALID 0 1 }  { m_axi_mem_0_RREADY READY 1 1 }  { m_axi_mem_0_RDATA FIFONUM 0 512 }  { m_axi_mem_0_RLAST LAST 0 1 }  { m_axi_mem_0_RID ID 0 1 }  { m_axi_mem_0_RUSER DATA 0 1 }  { m_axi_mem_0_RRESP RESP 0 2 }  { m_axi_mem_0_BVALID VALID 0 1 }  { m_axi_mem_0_BREADY READY 1 1 }  { m_axi_mem_0_BRESP RESP 0 2 }  { m_axi_mem_0_BID ID 0 1 }  { m_axi_mem_0_BUSER DATA 0 1 } } }
	mem_1 { m_axi {  { m_axi_mem_1_AWVALID VALID 1 1 }  { m_axi_mem_1_AWREADY READY 0 1 }  { m_axi_mem_1_AWADDR ADDR 1 64 }  { m_axi_mem_1_AWID ID 1 1 }  { m_axi_mem_1_AWLEN SIZE 1 8 }  { m_axi_mem_1_AWSIZE BURST 1 3 }  { m_axi_mem_1_AWBURST LOCK 1 2 }  { m_axi_mem_1_AWLOCK CACHE 1 2 }  { m_axi_mem_1_AWCACHE PROT 1 4 }  { m_axi_mem_1_AWPROT QOS 1 3 }  { m_axi_mem_1_AWQOS REGION 1 4 }  { m_axi_mem_1_AWREGION USER 1 4 }  { m_axi_mem_1_AWUSER DATA 1 1 }  { m_axi_mem_1_WVALID VALID 1 1 }  { m_axi_mem_1_WREADY READY 0 1 }  { m_axi_mem_1_WDATA FIFONUM 1 512 }  { m_axi_mem_1_WSTRB STRB 1 64 }  { m_axi_mem_1_WLAST LAST 1 1 }  { m_axi_mem_1_WID ID 1 1 }  { m_axi_mem_1_WUSER DATA 1 1 }  { m_axi_mem_1_ARVALID VALID 1 1 }  { m_axi_mem_1_ARREADY READY 0 1 }  { m_axi_mem_1_ARADDR ADDR 1 64 }  { m_axi_mem_1_ARID ID 1 1 }  { m_axi_mem_1_ARLEN SIZE 1 8 }  { m_axi_mem_1_ARSIZE BURST 1 3 }  { m_axi_mem_1_ARBURST LOCK 1 2 }  { m_axi_mem_1_ARLOCK CACHE 1 2 }  { m_axi_mem_1_ARCACHE PROT 1 4 }  { m_axi_mem_1_ARPROT QOS 1 3 }  { m_axi_mem_1_ARQOS REGION 1 4 }  { m_axi_mem_1_ARREGION USER 1 4 }  { m_axi_mem_1_ARUSER DATA 1 1 }  { m_axi_mem_1_RVALID VALID 0 1 }  { m_axi_mem_1_RREADY READY 1 1 }  { m_axi_mem_1_RDATA FIFONUM 0 512 }  { m_axi_mem_1_RLAST LAST 0 1 }  { m_axi_mem_1_RID ID 0 1 }  { m_axi_mem_1_RUSER DATA 0 1 }  { m_axi_mem_1_RRESP RESP 0 2 }  { m_axi_mem_1_BVALID VALID 0 1 }  { m_axi_mem_1_BREADY READY 1 1 }  { m_axi_mem_1_BRESP RESP 0 2 }  { m_axi_mem_1_BID ID 0 1 }  { m_axi_mem_1_BUSER DATA 0 1 } } }
}

set maxi_interface_dict [dict create]
dict set maxi_interface_dict mem_0 { CHANNEL_NUM 0 BUNDLE mem_0 NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_ONLY}
dict set maxi_interface_dict mem_1 { CHANNEL_NUM 0 BUNDLE mem_1 NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_ONLY}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ mem_0 64 }
	{ mem_1 64 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ mem_0 64 }
	{ mem_1 64 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
