set moduleName merge_sort_offchip_hls
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
set cdfgNum 6
set C_modelName {merge_sort_offchip_hls}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ gmem_in int 64 regular {axi_master 0}  }
	{ gmem_scratch_a int 32 regular {axi_master 2}  }
	{ gmem_scratch_b int 32 regular {axi_master 2}  }
	{ gmem_out int 512 regular {axi_master 1}  }
	{ in_r int 64 regular {axi_slave 0}  }
	{ scratch_a int 64 regular {axi_slave 0}  }
	{ scratch_b int 64 regular {axi_slave 0}  }
	{ out_r int 64 regular {axi_slave 0}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "gmem_in", "interface" : "axi_master", "bitwidth" : 64, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "in_r","offset": { "type": "dynamic","port_name": "in_r","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "gmem_scratch_a", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READWRITE", "bitSlice":[ {"cElement": [{"cName": "scratch_a","offset": { "type": "dynamic","port_name": "scratch_a","bundle": "control"},"direction": "READWRITE"}]}]} , 
 	{ "Name" : "gmem_scratch_b", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READWRITE", "bitSlice":[ {"cElement": [{"cName": "scratch_b","offset": { "type": "dynamic","port_name": "scratch_b","bundle": "control"},"direction": "READWRITE"}]}]} , 
 	{ "Name" : "gmem_out", "interface" : "axi_master", "bitwidth" : 512, "direction" : "WRITEONLY", "bitSlice":[ {"cElement": [{"cName": "out_r","offset": { "type": "dynamic","port_name": "out_r","bundle": "control"},"direction": "WRITEONLY"}]}]} , 
 	{ "Name" : "in_r", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":27}} , 
 	{ "Name" : "scratch_a", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":28}, "offset_end" : {"in":39}} , 
 	{ "Name" : "scratch_b", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":40}, "offset_end" : {"in":51}} , 
 	{ "Name" : "out_r", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":52}, "offset_end" : {"in":63}} ]}
# RTL Port declarations: 
set portNum 200
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ m_axi_gmem_in_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem_in_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem_in_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_gmem_in_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem_in_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_gmem_in_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem_in_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem_in_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem_in_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem_in_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem_in_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem_in_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem_in_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem_in_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem_in_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem_in_WDATA sc_out sc_lv 64 signal 0 } 
	{ m_axi_gmem_in_WSTRB sc_out sc_lv 8 signal 0 } 
	{ m_axi_gmem_in_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem_in_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem_in_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem_in_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem_in_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem_in_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_gmem_in_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem_in_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_gmem_in_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem_in_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem_in_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem_in_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem_in_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem_in_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem_in_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem_in_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem_in_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem_in_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem_in_RDATA sc_in sc_lv 64 signal 0 } 
	{ m_axi_gmem_in_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem_in_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem_in_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem_in_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_gmem_in_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem_in_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem_in_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_gmem_in_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem_in_BUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem_scratch_a_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem_scratch_a_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem_scratch_a_AWADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_gmem_scratch_a_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem_scratch_a_AWLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_gmem_scratch_a_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem_scratch_a_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem_scratch_a_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem_scratch_a_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_scratch_a_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem_scratch_a_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_scratch_a_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_scratch_a_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem_scratch_a_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem_scratch_a_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem_scratch_a_WDATA sc_out sc_lv 32 signal 1 } 
	{ m_axi_gmem_scratch_a_WSTRB sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_scratch_a_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem_scratch_a_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem_scratch_a_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem_scratch_a_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem_scratch_a_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem_scratch_a_ARADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_gmem_scratch_a_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem_scratch_a_ARLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_gmem_scratch_a_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem_scratch_a_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem_scratch_a_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem_scratch_a_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_scratch_a_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem_scratch_a_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_scratch_a_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem_scratch_a_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem_scratch_a_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem_scratch_a_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem_scratch_a_RDATA sc_in sc_lv 32 signal 1 } 
	{ m_axi_gmem_scratch_a_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem_scratch_a_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem_scratch_a_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem_scratch_a_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_gmem_scratch_a_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem_scratch_a_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem_scratch_a_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_gmem_scratch_a_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem_scratch_a_BUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem_scratch_b_AWVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem_scratch_b_AWREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem_scratch_b_AWADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_gmem_scratch_b_AWID sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem_scratch_b_AWLEN sc_out sc_lv 8 signal 2 } 
	{ m_axi_gmem_scratch_b_AWSIZE sc_out sc_lv 3 signal 2 } 
	{ m_axi_gmem_scratch_b_AWBURST sc_out sc_lv 2 signal 2 } 
	{ m_axi_gmem_scratch_b_AWLOCK sc_out sc_lv 2 signal 2 } 
	{ m_axi_gmem_scratch_b_AWCACHE sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_scratch_b_AWPROT sc_out sc_lv 3 signal 2 } 
	{ m_axi_gmem_scratch_b_AWQOS sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_scratch_b_AWREGION sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_scratch_b_AWUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem_scratch_b_WVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem_scratch_b_WREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem_scratch_b_WDATA sc_out sc_lv 32 signal 2 } 
	{ m_axi_gmem_scratch_b_WSTRB sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_scratch_b_WLAST sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem_scratch_b_WID sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem_scratch_b_WUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem_scratch_b_ARVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem_scratch_b_ARREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem_scratch_b_ARADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_gmem_scratch_b_ARID sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem_scratch_b_ARLEN sc_out sc_lv 8 signal 2 } 
	{ m_axi_gmem_scratch_b_ARSIZE sc_out sc_lv 3 signal 2 } 
	{ m_axi_gmem_scratch_b_ARBURST sc_out sc_lv 2 signal 2 } 
	{ m_axi_gmem_scratch_b_ARLOCK sc_out sc_lv 2 signal 2 } 
	{ m_axi_gmem_scratch_b_ARCACHE sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_scratch_b_ARPROT sc_out sc_lv 3 signal 2 } 
	{ m_axi_gmem_scratch_b_ARQOS sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_scratch_b_ARREGION sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem_scratch_b_ARUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem_scratch_b_RVALID sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem_scratch_b_RREADY sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem_scratch_b_RDATA sc_in sc_lv 32 signal 2 } 
	{ m_axi_gmem_scratch_b_RLAST sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem_scratch_b_RID sc_in sc_lv 1 signal 2 } 
	{ m_axi_gmem_scratch_b_RUSER sc_in sc_lv 1 signal 2 } 
	{ m_axi_gmem_scratch_b_RRESP sc_in sc_lv 2 signal 2 } 
	{ m_axi_gmem_scratch_b_BVALID sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem_scratch_b_BREADY sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem_scratch_b_BRESP sc_in sc_lv 2 signal 2 } 
	{ m_axi_gmem_scratch_b_BID sc_in sc_lv 1 signal 2 } 
	{ m_axi_gmem_scratch_b_BUSER sc_in sc_lv 1 signal 2 } 
	{ m_axi_gmem_out_AWVALID sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem_out_AWREADY sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem_out_AWADDR sc_out sc_lv 64 signal 3 } 
	{ m_axi_gmem_out_AWID sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem_out_AWLEN sc_out sc_lv 8 signal 3 } 
	{ m_axi_gmem_out_AWSIZE sc_out sc_lv 3 signal 3 } 
	{ m_axi_gmem_out_AWBURST sc_out sc_lv 2 signal 3 } 
	{ m_axi_gmem_out_AWLOCK sc_out sc_lv 2 signal 3 } 
	{ m_axi_gmem_out_AWCACHE sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem_out_AWPROT sc_out sc_lv 3 signal 3 } 
	{ m_axi_gmem_out_AWQOS sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem_out_AWREGION sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem_out_AWUSER sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem_out_WVALID sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem_out_WREADY sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem_out_WDATA sc_out sc_lv 512 signal 3 } 
	{ m_axi_gmem_out_WSTRB sc_out sc_lv 64 signal 3 } 
	{ m_axi_gmem_out_WLAST sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem_out_WID sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem_out_WUSER sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem_out_ARVALID sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem_out_ARREADY sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem_out_ARADDR sc_out sc_lv 64 signal 3 } 
	{ m_axi_gmem_out_ARID sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem_out_ARLEN sc_out sc_lv 8 signal 3 } 
	{ m_axi_gmem_out_ARSIZE sc_out sc_lv 3 signal 3 } 
	{ m_axi_gmem_out_ARBURST sc_out sc_lv 2 signal 3 } 
	{ m_axi_gmem_out_ARLOCK sc_out sc_lv 2 signal 3 } 
	{ m_axi_gmem_out_ARCACHE sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem_out_ARPROT sc_out sc_lv 3 signal 3 } 
	{ m_axi_gmem_out_ARQOS sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem_out_ARREGION sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem_out_ARUSER sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem_out_RVALID sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem_out_RREADY sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem_out_RDATA sc_in sc_lv 512 signal 3 } 
	{ m_axi_gmem_out_RLAST sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem_out_RID sc_in sc_lv 1 signal 3 } 
	{ m_axi_gmem_out_RUSER sc_in sc_lv 1 signal 3 } 
	{ m_axi_gmem_out_RRESP sc_in sc_lv 2 signal 3 } 
	{ m_axi_gmem_out_BVALID sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem_out_BREADY sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem_out_BRESP sc_in sc_lv 2 signal 3 } 
	{ m_axi_gmem_out_BID sc_in sc_lv 1 signal 3 } 
	{ m_axi_gmem_out_BUSER sc_in sc_lv 1 signal 3 } 
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
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"merge_sort_offchip_hls","role":"start","value":"0","valid_bit":"0"},{"name":"merge_sort_offchip_hls","role":"continue","value":"0","valid_bit":"4"},{"name":"merge_sort_offchip_hls","role":"auto_start","value":"0","valid_bit":"7"},{"name":"in_r","role":"data","value":"16"},{"name":"scratch_a","role":"data","value":"28"},{"name":"scratch_b","role":"data","value":"40"},{"name":"out_r","role":"data","value":"52"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[{"name":"merge_sort_offchip_hls","role":"start","value":"0","valid_bit":"0"},{"name":"merge_sort_offchip_hls","role":"done","value":"0","valid_bit":"1"},{"name":"merge_sort_offchip_hls","role":"idle","value":"0","valid_bit":"2"},{"name":"merge_sort_offchip_hls","role":"ready","value":"0","valid_bit":"3"},{"name":"merge_sort_offchip_hls","role":"auto_start","value":"0","valid_bit":"7"}] },
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
 	{ "name": "m_axi_gmem_in_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem_in_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem_in_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem_in_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem_in_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem_in_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem_in_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem_in_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem_in_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem_in_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem_in_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem_in_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem_in_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem_in_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem_in_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem_in_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_in", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem_in_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_in", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem_in_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem_in_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "WID" }} , 
 	{ "name": "m_axi_gmem_in_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem_in_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem_in_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem_in_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem_in_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem_in_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem_in_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem_in_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem_in_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem_in_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem_in_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem_in_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem_in_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem_in_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem_in_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem_in_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem_in_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_in", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem_in_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem_in_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "RID" }} , 
 	{ "name": "m_axi_gmem_in_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem_in_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_in", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem_in_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem_in_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem_in_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_in", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem_in_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "BID" }} , 
 	{ "name": "m_axi_gmem_in_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_in", "role": "BUSER" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem_scratch_a_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem_scratch_a_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem_scratch_a_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem_scratch_a_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem_scratch_a_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem_scratch_a_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem_scratch_a_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "WID" }} , 
 	{ "name": "m_axi_gmem_scratch_a_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem_scratch_a_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem_scratch_a_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem_scratch_a_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem_scratch_a_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem_scratch_a_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem_scratch_a_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "RID" }} , 
 	{ "name": "m_axi_gmem_scratch_a_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem_scratch_a_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem_scratch_a_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem_scratch_a_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem_scratch_a_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem_scratch_a_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "BID" }} , 
 	{ "name": "m_axi_gmem_scratch_a_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_a", "role": "BUSER" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem_scratch_b_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem_scratch_b_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem_scratch_b_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem_scratch_b_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem_scratch_b_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem_scratch_b_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem_scratch_b_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "WID" }} , 
 	{ "name": "m_axi_gmem_scratch_b_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem_scratch_b_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem_scratch_b_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem_scratch_b_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem_scratch_b_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem_scratch_b_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem_scratch_b_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "RID" }} , 
 	{ "name": "m_axi_gmem_scratch_b_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem_scratch_b_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem_scratch_b_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem_scratch_b_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem_scratch_b_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem_scratch_b_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "BID" }} , 
 	{ "name": "m_axi_gmem_scratch_b_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_scratch_b", "role": "BUSER" }} , 
 	{ "name": "m_axi_gmem_out_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem_out_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem_out_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem_out_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem_out_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem_out_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem_out_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem_out_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem_out_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem_out_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem_out_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem_out_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem_out_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem_out_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem_out_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem_out_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem_out", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem_out_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_out", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem_out_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem_out_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "WID" }} , 
 	{ "name": "m_axi_gmem_out_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem_out_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem_out_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem_out_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem_out_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem_out_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem_out_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem_out_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem_out_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem_out_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem_out_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem_out_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem_out_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem_out_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem_out_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem_out_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem_out_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem_out", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem_out_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem_out_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "RID" }} , 
 	{ "name": "m_axi_gmem_out_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem_out_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_out", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem_out_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem_out_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem_out_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem_out", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem_out_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "BID" }} , 
 	{ "name": "m_axi_gmem_out_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem_out", "role": "BUSER" }}  ]}

set ArgLastReadFirstWriteLatency {
	merge_sort_offchip_hls {
		gmem_in {Type I LastRead 1 FirstWrite -1}
		gmem_scratch_a {Type IO LastRead 18 FirstWrite -1}
		gmem_scratch_b {Type IO LastRead 14 FirstWrite 12}
		gmem_out {Type O LastRead 27 FirstWrite 2}
		in_r {Type I LastRead 0 FirstWrite -1}
		scratch_a {Type I LastRead 0 FirstWrite -1}
		scratch_b {Type I LastRead 0 FirstWrite -1}
		out_r {Type I LastRead 0 FirstWrite -1}}
	merge_sort_offchip_hls_Pipeline_copy_input_to_scratch_a {
		gmem_scratch_a {Type O LastRead -1 FirstWrite 3}
		gmem_in {Type I LastRead 1 FirstWrite -1}
		sext_ln21_1 {Type I LastRead 0 FirstWrite -1}
		sext_ln21 {Type I LastRead 0 FirstWrite -1}}
	merge_sort_offchip_hls_Pipeline_merge_element_loop {
		indvars_iv14 {Type I LastRead 0 FirstWrite -1}
		mid {Type I LastRead 0 FirstWrite -1}
		left_1 {Type I LastRead 0 FirstWrite -1}
		gmem_scratch_b {Type IO LastRead 14 FirstWrite 12}
		right_r {Type I LastRead 0 FirstWrite -1}
		gmem_scratch_a {Type IO LastRead 18 FirstWrite 16}
		scratch_b {Type I LastRead 0 FirstWrite -1}
		source_is_a {Type I LastRead 0 FirstWrite -1}
		scratch_a {Type I LastRead 0 FirstWrite -1}}
	merge_sort_offchip_hls_Pipeline_copy_result_to_out {
		gmem_out {Type O LastRead -1 FirstWrite 2}
		gmem_scratch_a {Type I LastRead 1 FirstWrite -1}
		sext_ln21_1 {Type I LastRead 0 FirstWrite -1}
		sext_ln72 {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	gmem_in { m_axi {  { m_axi_gmem_in_AWVALID VALID 1 1 }  { m_axi_gmem_in_AWREADY READY 0 1 }  { m_axi_gmem_in_AWADDR ADDR 1 64 }  { m_axi_gmem_in_AWID ID 1 1 }  { m_axi_gmem_in_AWLEN SIZE 1 8 }  { m_axi_gmem_in_AWSIZE BURST 1 3 }  { m_axi_gmem_in_AWBURST LOCK 1 2 }  { m_axi_gmem_in_AWLOCK CACHE 1 2 }  { m_axi_gmem_in_AWCACHE PROT 1 4 }  { m_axi_gmem_in_AWPROT QOS 1 3 }  { m_axi_gmem_in_AWQOS REGION 1 4 }  { m_axi_gmem_in_AWREGION USER 1 4 }  { m_axi_gmem_in_AWUSER DATA 1 1 }  { m_axi_gmem_in_WVALID VALID 1 1 }  { m_axi_gmem_in_WREADY READY 0 1 }  { m_axi_gmem_in_WDATA FIFONUM 1 64 }  { m_axi_gmem_in_WSTRB STRB 1 8 }  { m_axi_gmem_in_WLAST LAST 1 1 }  { m_axi_gmem_in_WID ID 1 1 }  { m_axi_gmem_in_WUSER DATA 1 1 }  { m_axi_gmem_in_ARVALID VALID 1 1 }  { m_axi_gmem_in_ARREADY READY 0 1 }  { m_axi_gmem_in_ARADDR ADDR 1 64 }  { m_axi_gmem_in_ARID ID 1 1 }  { m_axi_gmem_in_ARLEN SIZE 1 8 }  { m_axi_gmem_in_ARSIZE BURST 1 3 }  { m_axi_gmem_in_ARBURST LOCK 1 2 }  { m_axi_gmem_in_ARLOCK CACHE 1 2 }  { m_axi_gmem_in_ARCACHE PROT 1 4 }  { m_axi_gmem_in_ARPROT QOS 1 3 }  { m_axi_gmem_in_ARQOS REGION 1 4 }  { m_axi_gmem_in_ARREGION USER 1 4 }  { m_axi_gmem_in_ARUSER DATA 1 1 }  { m_axi_gmem_in_RVALID VALID 0 1 }  { m_axi_gmem_in_RREADY READY 1 1 }  { m_axi_gmem_in_RDATA FIFONUM 0 64 }  { m_axi_gmem_in_RLAST LAST 0 1 }  { m_axi_gmem_in_RID ID 0 1 }  { m_axi_gmem_in_RUSER DATA 0 1 }  { m_axi_gmem_in_RRESP RESP 0 2 }  { m_axi_gmem_in_BVALID VALID 0 1 }  { m_axi_gmem_in_BREADY READY 1 1 }  { m_axi_gmem_in_BRESP RESP 0 2 }  { m_axi_gmem_in_BID ID 0 1 }  { m_axi_gmem_in_BUSER DATA 0 1 } } }
	gmem_scratch_a { m_axi {  { m_axi_gmem_scratch_a_AWVALID VALID 1 1 }  { m_axi_gmem_scratch_a_AWREADY READY 0 1 }  { m_axi_gmem_scratch_a_AWADDR ADDR 1 64 }  { m_axi_gmem_scratch_a_AWID ID 1 1 }  { m_axi_gmem_scratch_a_AWLEN SIZE 1 8 }  { m_axi_gmem_scratch_a_AWSIZE BURST 1 3 }  { m_axi_gmem_scratch_a_AWBURST LOCK 1 2 }  { m_axi_gmem_scratch_a_AWLOCK CACHE 1 2 }  { m_axi_gmem_scratch_a_AWCACHE PROT 1 4 }  { m_axi_gmem_scratch_a_AWPROT QOS 1 3 }  { m_axi_gmem_scratch_a_AWQOS REGION 1 4 }  { m_axi_gmem_scratch_a_AWREGION USER 1 4 }  { m_axi_gmem_scratch_a_AWUSER DATA 1 1 }  { m_axi_gmem_scratch_a_WVALID VALID 1 1 }  { m_axi_gmem_scratch_a_WREADY READY 0 1 }  { m_axi_gmem_scratch_a_WDATA FIFONUM 1 32 }  { m_axi_gmem_scratch_a_WSTRB STRB 1 4 }  { m_axi_gmem_scratch_a_WLAST LAST 1 1 }  { m_axi_gmem_scratch_a_WID ID 1 1 }  { m_axi_gmem_scratch_a_WUSER DATA 1 1 }  { m_axi_gmem_scratch_a_ARVALID VALID 1 1 }  { m_axi_gmem_scratch_a_ARREADY READY 0 1 }  { m_axi_gmem_scratch_a_ARADDR ADDR 1 64 }  { m_axi_gmem_scratch_a_ARID ID 1 1 }  { m_axi_gmem_scratch_a_ARLEN SIZE 1 8 }  { m_axi_gmem_scratch_a_ARSIZE BURST 1 3 }  { m_axi_gmem_scratch_a_ARBURST LOCK 1 2 }  { m_axi_gmem_scratch_a_ARLOCK CACHE 1 2 }  { m_axi_gmem_scratch_a_ARCACHE PROT 1 4 }  { m_axi_gmem_scratch_a_ARPROT QOS 1 3 }  { m_axi_gmem_scratch_a_ARQOS REGION 1 4 }  { m_axi_gmem_scratch_a_ARREGION USER 1 4 }  { m_axi_gmem_scratch_a_ARUSER DATA 1 1 }  { m_axi_gmem_scratch_a_RVALID VALID 0 1 }  { m_axi_gmem_scratch_a_RREADY READY 1 1 }  { m_axi_gmem_scratch_a_RDATA FIFONUM 0 32 }  { m_axi_gmem_scratch_a_RLAST LAST 0 1 }  { m_axi_gmem_scratch_a_RID ID 0 1 }  { m_axi_gmem_scratch_a_RUSER DATA 0 1 }  { m_axi_gmem_scratch_a_RRESP RESP 0 2 }  { m_axi_gmem_scratch_a_BVALID VALID 0 1 }  { m_axi_gmem_scratch_a_BREADY READY 1 1 }  { m_axi_gmem_scratch_a_BRESP RESP 0 2 }  { m_axi_gmem_scratch_a_BID ID 0 1 }  { m_axi_gmem_scratch_a_BUSER DATA 0 1 } } }
	gmem_scratch_b { m_axi {  { m_axi_gmem_scratch_b_AWVALID VALID 1 1 }  { m_axi_gmem_scratch_b_AWREADY READY 0 1 }  { m_axi_gmem_scratch_b_AWADDR ADDR 1 64 }  { m_axi_gmem_scratch_b_AWID ID 1 1 }  { m_axi_gmem_scratch_b_AWLEN SIZE 1 8 }  { m_axi_gmem_scratch_b_AWSIZE BURST 1 3 }  { m_axi_gmem_scratch_b_AWBURST LOCK 1 2 }  { m_axi_gmem_scratch_b_AWLOCK CACHE 1 2 }  { m_axi_gmem_scratch_b_AWCACHE PROT 1 4 }  { m_axi_gmem_scratch_b_AWPROT QOS 1 3 }  { m_axi_gmem_scratch_b_AWQOS REGION 1 4 }  { m_axi_gmem_scratch_b_AWREGION USER 1 4 }  { m_axi_gmem_scratch_b_AWUSER DATA 1 1 }  { m_axi_gmem_scratch_b_WVALID VALID 1 1 }  { m_axi_gmem_scratch_b_WREADY READY 0 1 }  { m_axi_gmem_scratch_b_WDATA FIFONUM 1 32 }  { m_axi_gmem_scratch_b_WSTRB STRB 1 4 }  { m_axi_gmem_scratch_b_WLAST LAST 1 1 }  { m_axi_gmem_scratch_b_WID ID 1 1 }  { m_axi_gmem_scratch_b_WUSER DATA 1 1 }  { m_axi_gmem_scratch_b_ARVALID VALID 1 1 }  { m_axi_gmem_scratch_b_ARREADY READY 0 1 }  { m_axi_gmem_scratch_b_ARADDR ADDR 1 64 }  { m_axi_gmem_scratch_b_ARID ID 1 1 }  { m_axi_gmem_scratch_b_ARLEN SIZE 1 8 }  { m_axi_gmem_scratch_b_ARSIZE BURST 1 3 }  { m_axi_gmem_scratch_b_ARBURST LOCK 1 2 }  { m_axi_gmem_scratch_b_ARLOCK CACHE 1 2 }  { m_axi_gmem_scratch_b_ARCACHE PROT 1 4 }  { m_axi_gmem_scratch_b_ARPROT QOS 1 3 }  { m_axi_gmem_scratch_b_ARQOS REGION 1 4 }  { m_axi_gmem_scratch_b_ARREGION USER 1 4 }  { m_axi_gmem_scratch_b_ARUSER DATA 1 1 }  { m_axi_gmem_scratch_b_RVALID VALID 0 1 }  { m_axi_gmem_scratch_b_RREADY READY 1 1 }  { m_axi_gmem_scratch_b_RDATA FIFONUM 0 32 }  { m_axi_gmem_scratch_b_RLAST LAST 0 1 }  { m_axi_gmem_scratch_b_RID ID 0 1 }  { m_axi_gmem_scratch_b_RUSER DATA 0 1 }  { m_axi_gmem_scratch_b_RRESP RESP 0 2 }  { m_axi_gmem_scratch_b_BVALID VALID 0 1 }  { m_axi_gmem_scratch_b_BREADY READY 1 1 }  { m_axi_gmem_scratch_b_BRESP RESP 0 2 }  { m_axi_gmem_scratch_b_BID ID 0 1 }  { m_axi_gmem_scratch_b_BUSER DATA 0 1 } } }
	gmem_out { m_axi {  { m_axi_gmem_out_AWVALID VALID 1 1 }  { m_axi_gmem_out_AWREADY READY 0 1 }  { m_axi_gmem_out_AWADDR ADDR 1 64 }  { m_axi_gmem_out_AWID ID 1 1 }  { m_axi_gmem_out_AWLEN SIZE 1 8 }  { m_axi_gmem_out_AWSIZE BURST 1 3 }  { m_axi_gmem_out_AWBURST LOCK 1 2 }  { m_axi_gmem_out_AWLOCK CACHE 1 2 }  { m_axi_gmem_out_AWCACHE PROT 1 4 }  { m_axi_gmem_out_AWPROT QOS 1 3 }  { m_axi_gmem_out_AWQOS REGION 1 4 }  { m_axi_gmem_out_AWREGION USER 1 4 }  { m_axi_gmem_out_AWUSER DATA 1 1 }  { m_axi_gmem_out_WVALID VALID 1 1 }  { m_axi_gmem_out_WREADY READY 0 1 }  { m_axi_gmem_out_WDATA FIFONUM 1 512 }  { m_axi_gmem_out_WSTRB STRB 1 64 }  { m_axi_gmem_out_WLAST LAST 1 1 }  { m_axi_gmem_out_WID ID 1 1 }  { m_axi_gmem_out_WUSER DATA 1 1 }  { m_axi_gmem_out_ARVALID VALID 1 1 }  { m_axi_gmem_out_ARREADY READY 0 1 }  { m_axi_gmem_out_ARADDR ADDR 1 64 }  { m_axi_gmem_out_ARID ID 1 1 }  { m_axi_gmem_out_ARLEN SIZE 1 8 }  { m_axi_gmem_out_ARSIZE BURST 1 3 }  { m_axi_gmem_out_ARBURST LOCK 1 2 }  { m_axi_gmem_out_ARLOCK CACHE 1 2 }  { m_axi_gmem_out_ARCACHE PROT 1 4 }  { m_axi_gmem_out_ARPROT QOS 1 3 }  { m_axi_gmem_out_ARQOS REGION 1 4 }  { m_axi_gmem_out_ARREGION USER 1 4 }  { m_axi_gmem_out_ARUSER DATA 1 1 }  { m_axi_gmem_out_RVALID VALID 0 1 }  { m_axi_gmem_out_RREADY READY 1 1 }  { m_axi_gmem_out_RDATA FIFONUM 0 512 }  { m_axi_gmem_out_RLAST LAST 0 1 }  { m_axi_gmem_out_RID ID 0 1 }  { m_axi_gmem_out_RUSER DATA 0 1 }  { m_axi_gmem_out_RRESP RESP 0 2 }  { m_axi_gmem_out_BVALID VALID 0 1 }  { m_axi_gmem_out_BREADY READY 1 1 }  { m_axi_gmem_out_BRESP RESP 0 2 }  { m_axi_gmem_out_BID ID 0 1 }  { m_axi_gmem_out_BUSER DATA 0 1 } } }
}

set maxi_interface_dict [dict create]
dict set maxi_interface_dict gmem_in { CHANNEL_NUM 0 BUNDLE gmem_in NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_ONLY}
dict set maxi_interface_dict gmem_out { CHANNEL_NUM 0 BUNDLE gmem_out NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE WRITE_ONLY}
dict set maxi_interface_dict gmem_scratch_a { CHANNEL_NUM 0 BUNDLE gmem_scratch_a NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_WRITE}
dict set maxi_interface_dict gmem_scratch_b { CHANNEL_NUM 0 BUNDLE gmem_scratch_b NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_WRITE}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ gmem_in 1 }
	{ gmem_scratch_a 1 }
	{ gmem_scratch_b 1 }
	{ gmem_out 1 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ gmem_in 1 }
	{ gmem_scratch_a 1 }
	{ gmem_scratch_b 1 }
	{ gmem_out 1 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
