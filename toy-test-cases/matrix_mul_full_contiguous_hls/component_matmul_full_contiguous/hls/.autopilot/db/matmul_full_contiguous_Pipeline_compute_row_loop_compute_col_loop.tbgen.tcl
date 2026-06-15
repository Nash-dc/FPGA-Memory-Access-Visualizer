set moduleName matmul_full_contiguous_Pipeline_compute_row_loop_compute_col_loop
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
set cdfgNum 6
set C_modelName {matmul_full_contiguous_Pipeline_compute_row_loop_compute_col_loop}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict A_local { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict A_local_1 { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict A_local_2 { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict A_local_3 { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict A_local_4 { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict A_local_5 { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict A_local_6 { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict A_local_7 { MEM_WIDTH 32 MEM_SIZE 128 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_1 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_2 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_3 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_4 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_5 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_6 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_7 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_8 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_9 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_10 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_11 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_12 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_13 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_14 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_16 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict B_local_15 { MEM_WIDTH 32 MEM_SIZE 64 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict C_local { MEM_WIDTH 32 MEM_SIZE 1024 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
set C_modelArgList {
	{ A_local int 32 regular {array 32 { 1 1 } 1 1 }  }
	{ A_local_1 int 32 regular {array 32 { 1 1 } 1 1 }  }
	{ A_local_2 int 32 regular {array 32 { 1 1 } 1 1 }  }
	{ A_local_3 int 32 regular {array 32 { 1 1 } 1 1 }  }
	{ A_local_4 int 32 regular {array 32 { 1 1 } 1 1 }  }
	{ A_local_5 int 32 regular {array 32 { 1 1 } 1 1 }  }
	{ A_local_6 int 32 regular {array 32 { 1 1 } 1 1 }  }
	{ A_local_7 int 32 regular {array 32 { 1 1 } 1 1 }  }
	{ B_local_load int 32 regular  }
	{ B_local_1_load int 32 regular  }
	{ B_local_2_load int 32 regular  }
	{ B_local_3_load int 32 regular  }
	{ B_local_4_load int 32 regular  }
	{ B_local_5_load int 32 regular  }
	{ B_local_6_load int 32 regular  }
	{ B_local_7_load int 32 regular  }
	{ B_local_8_load int 32 regular  }
	{ B_local_9_load int 32 regular  }
	{ B_local_10_load int 32 regular  }
	{ B_local_11_load int 32 regular  }
	{ B_local_12_load int 32 regular  }
	{ B_local_13_load int 32 regular  }
	{ B_local_14_load int 32 regular  }
	{ B_local_15_load int 32 regular  }
	{ B_local int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_1 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_2 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_3 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_4 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_5 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_6 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_7 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_8 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_9 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_10 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_11 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_12 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_13 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_14 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_16 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ B_local_15 int 32 regular {array 16 { 1 1 } 1 1 }  }
	{ C_local int 32 regular {array 256 { 0 3 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "A_local", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "A_local_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "A_local_2", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "A_local_3", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "A_local_4", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "A_local_5", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "A_local_6", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "A_local_7", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_1_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_2_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_3_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_4_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_5_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_6_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_7_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_8_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_9_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_10_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_11_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_12_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_13_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_14_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_15_load", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_2", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_3", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_4", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_5", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_6", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_7", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_8", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_9", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_10", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_11", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_12", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_13", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_14", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_16", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "B_local_15", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "C_local", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 176
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ A_local_address0 sc_out sc_lv 5 signal 0 } 
	{ A_local_ce0 sc_out sc_logic 1 signal 0 } 
	{ A_local_q0 sc_in sc_lv 32 signal 0 } 
	{ A_local_address1 sc_out sc_lv 5 signal 0 } 
	{ A_local_ce1 sc_out sc_logic 1 signal 0 } 
	{ A_local_q1 sc_in sc_lv 32 signal 0 } 
	{ A_local_1_address0 sc_out sc_lv 5 signal 1 } 
	{ A_local_1_ce0 sc_out sc_logic 1 signal 1 } 
	{ A_local_1_q0 sc_in sc_lv 32 signal 1 } 
	{ A_local_1_address1 sc_out sc_lv 5 signal 1 } 
	{ A_local_1_ce1 sc_out sc_logic 1 signal 1 } 
	{ A_local_1_q1 sc_in sc_lv 32 signal 1 } 
	{ A_local_2_address0 sc_out sc_lv 5 signal 2 } 
	{ A_local_2_ce0 sc_out sc_logic 1 signal 2 } 
	{ A_local_2_q0 sc_in sc_lv 32 signal 2 } 
	{ A_local_2_address1 sc_out sc_lv 5 signal 2 } 
	{ A_local_2_ce1 sc_out sc_logic 1 signal 2 } 
	{ A_local_2_q1 sc_in sc_lv 32 signal 2 } 
	{ A_local_3_address0 sc_out sc_lv 5 signal 3 } 
	{ A_local_3_ce0 sc_out sc_logic 1 signal 3 } 
	{ A_local_3_q0 sc_in sc_lv 32 signal 3 } 
	{ A_local_3_address1 sc_out sc_lv 5 signal 3 } 
	{ A_local_3_ce1 sc_out sc_logic 1 signal 3 } 
	{ A_local_3_q1 sc_in sc_lv 32 signal 3 } 
	{ A_local_4_address0 sc_out sc_lv 5 signal 4 } 
	{ A_local_4_ce0 sc_out sc_logic 1 signal 4 } 
	{ A_local_4_q0 sc_in sc_lv 32 signal 4 } 
	{ A_local_4_address1 sc_out sc_lv 5 signal 4 } 
	{ A_local_4_ce1 sc_out sc_logic 1 signal 4 } 
	{ A_local_4_q1 sc_in sc_lv 32 signal 4 } 
	{ A_local_5_address0 sc_out sc_lv 5 signal 5 } 
	{ A_local_5_ce0 sc_out sc_logic 1 signal 5 } 
	{ A_local_5_q0 sc_in sc_lv 32 signal 5 } 
	{ A_local_5_address1 sc_out sc_lv 5 signal 5 } 
	{ A_local_5_ce1 sc_out sc_logic 1 signal 5 } 
	{ A_local_5_q1 sc_in sc_lv 32 signal 5 } 
	{ A_local_6_address0 sc_out sc_lv 5 signal 6 } 
	{ A_local_6_ce0 sc_out sc_logic 1 signal 6 } 
	{ A_local_6_q0 sc_in sc_lv 32 signal 6 } 
	{ A_local_6_address1 sc_out sc_lv 5 signal 6 } 
	{ A_local_6_ce1 sc_out sc_logic 1 signal 6 } 
	{ A_local_6_q1 sc_in sc_lv 32 signal 6 } 
	{ A_local_7_address0 sc_out sc_lv 5 signal 7 } 
	{ A_local_7_ce0 sc_out sc_logic 1 signal 7 } 
	{ A_local_7_q0 sc_in sc_lv 32 signal 7 } 
	{ A_local_7_address1 sc_out sc_lv 5 signal 7 } 
	{ A_local_7_ce1 sc_out sc_logic 1 signal 7 } 
	{ A_local_7_q1 sc_in sc_lv 32 signal 7 } 
	{ B_local_load sc_in sc_lv 32 signal 8 } 
	{ B_local_1_load sc_in sc_lv 32 signal 9 } 
	{ B_local_2_load sc_in sc_lv 32 signal 10 } 
	{ B_local_3_load sc_in sc_lv 32 signal 11 } 
	{ B_local_4_load sc_in sc_lv 32 signal 12 } 
	{ B_local_5_load sc_in sc_lv 32 signal 13 } 
	{ B_local_6_load sc_in sc_lv 32 signal 14 } 
	{ B_local_7_load sc_in sc_lv 32 signal 15 } 
	{ B_local_8_load sc_in sc_lv 32 signal 16 } 
	{ B_local_9_load sc_in sc_lv 32 signal 17 } 
	{ B_local_10_load sc_in sc_lv 32 signal 18 } 
	{ B_local_11_load sc_in sc_lv 32 signal 19 } 
	{ B_local_12_load sc_in sc_lv 32 signal 20 } 
	{ B_local_13_load sc_in sc_lv 32 signal 21 } 
	{ B_local_14_load sc_in sc_lv 32 signal 22 } 
	{ B_local_15_load sc_in sc_lv 32 signal 23 } 
	{ B_local_address0 sc_out sc_lv 4 signal 24 } 
	{ B_local_ce0 sc_out sc_logic 1 signal 24 } 
	{ B_local_q0 sc_in sc_lv 32 signal 24 } 
	{ B_local_address1 sc_out sc_lv 4 signal 24 } 
	{ B_local_ce1 sc_out sc_logic 1 signal 24 } 
	{ B_local_q1 sc_in sc_lv 32 signal 24 } 
	{ B_local_1_address0 sc_out sc_lv 4 signal 25 } 
	{ B_local_1_ce0 sc_out sc_logic 1 signal 25 } 
	{ B_local_1_q0 sc_in sc_lv 32 signal 25 } 
	{ B_local_1_address1 sc_out sc_lv 4 signal 25 } 
	{ B_local_1_ce1 sc_out sc_logic 1 signal 25 } 
	{ B_local_1_q1 sc_in sc_lv 32 signal 25 } 
	{ B_local_2_address0 sc_out sc_lv 4 signal 26 } 
	{ B_local_2_ce0 sc_out sc_logic 1 signal 26 } 
	{ B_local_2_q0 sc_in sc_lv 32 signal 26 } 
	{ B_local_2_address1 sc_out sc_lv 4 signal 26 } 
	{ B_local_2_ce1 sc_out sc_logic 1 signal 26 } 
	{ B_local_2_q1 sc_in sc_lv 32 signal 26 } 
	{ B_local_3_address0 sc_out sc_lv 4 signal 27 } 
	{ B_local_3_ce0 sc_out sc_logic 1 signal 27 } 
	{ B_local_3_q0 sc_in sc_lv 32 signal 27 } 
	{ B_local_3_address1 sc_out sc_lv 4 signal 27 } 
	{ B_local_3_ce1 sc_out sc_logic 1 signal 27 } 
	{ B_local_3_q1 sc_in sc_lv 32 signal 27 } 
	{ B_local_4_address0 sc_out sc_lv 4 signal 28 } 
	{ B_local_4_ce0 sc_out sc_logic 1 signal 28 } 
	{ B_local_4_q0 sc_in sc_lv 32 signal 28 } 
	{ B_local_4_address1 sc_out sc_lv 4 signal 28 } 
	{ B_local_4_ce1 sc_out sc_logic 1 signal 28 } 
	{ B_local_4_q1 sc_in sc_lv 32 signal 28 } 
	{ B_local_5_address0 sc_out sc_lv 4 signal 29 } 
	{ B_local_5_ce0 sc_out sc_logic 1 signal 29 } 
	{ B_local_5_q0 sc_in sc_lv 32 signal 29 } 
	{ B_local_5_address1 sc_out sc_lv 4 signal 29 } 
	{ B_local_5_ce1 sc_out sc_logic 1 signal 29 } 
	{ B_local_5_q1 sc_in sc_lv 32 signal 29 } 
	{ B_local_6_address0 sc_out sc_lv 4 signal 30 } 
	{ B_local_6_ce0 sc_out sc_logic 1 signal 30 } 
	{ B_local_6_q0 sc_in sc_lv 32 signal 30 } 
	{ B_local_6_address1 sc_out sc_lv 4 signal 30 } 
	{ B_local_6_ce1 sc_out sc_logic 1 signal 30 } 
	{ B_local_6_q1 sc_in sc_lv 32 signal 30 } 
	{ B_local_7_address0 sc_out sc_lv 4 signal 31 } 
	{ B_local_7_ce0 sc_out sc_logic 1 signal 31 } 
	{ B_local_7_q0 sc_in sc_lv 32 signal 31 } 
	{ B_local_7_address1 sc_out sc_lv 4 signal 31 } 
	{ B_local_7_ce1 sc_out sc_logic 1 signal 31 } 
	{ B_local_7_q1 sc_in sc_lv 32 signal 31 } 
	{ B_local_8_address0 sc_out sc_lv 4 signal 32 } 
	{ B_local_8_ce0 sc_out sc_logic 1 signal 32 } 
	{ B_local_8_q0 sc_in sc_lv 32 signal 32 } 
	{ B_local_8_address1 sc_out sc_lv 4 signal 32 } 
	{ B_local_8_ce1 sc_out sc_logic 1 signal 32 } 
	{ B_local_8_q1 sc_in sc_lv 32 signal 32 } 
	{ B_local_9_address0 sc_out sc_lv 4 signal 33 } 
	{ B_local_9_ce0 sc_out sc_logic 1 signal 33 } 
	{ B_local_9_q0 sc_in sc_lv 32 signal 33 } 
	{ B_local_9_address1 sc_out sc_lv 4 signal 33 } 
	{ B_local_9_ce1 sc_out sc_logic 1 signal 33 } 
	{ B_local_9_q1 sc_in sc_lv 32 signal 33 } 
	{ B_local_10_address0 sc_out sc_lv 4 signal 34 } 
	{ B_local_10_ce0 sc_out sc_logic 1 signal 34 } 
	{ B_local_10_q0 sc_in sc_lv 32 signal 34 } 
	{ B_local_10_address1 sc_out sc_lv 4 signal 34 } 
	{ B_local_10_ce1 sc_out sc_logic 1 signal 34 } 
	{ B_local_10_q1 sc_in sc_lv 32 signal 34 } 
	{ B_local_11_address0 sc_out sc_lv 4 signal 35 } 
	{ B_local_11_ce0 sc_out sc_logic 1 signal 35 } 
	{ B_local_11_q0 sc_in sc_lv 32 signal 35 } 
	{ B_local_11_address1 sc_out sc_lv 4 signal 35 } 
	{ B_local_11_ce1 sc_out sc_logic 1 signal 35 } 
	{ B_local_11_q1 sc_in sc_lv 32 signal 35 } 
	{ B_local_12_address0 sc_out sc_lv 4 signal 36 } 
	{ B_local_12_ce0 sc_out sc_logic 1 signal 36 } 
	{ B_local_12_q0 sc_in sc_lv 32 signal 36 } 
	{ B_local_12_address1 sc_out sc_lv 4 signal 36 } 
	{ B_local_12_ce1 sc_out sc_logic 1 signal 36 } 
	{ B_local_12_q1 sc_in sc_lv 32 signal 36 } 
	{ B_local_13_address0 sc_out sc_lv 4 signal 37 } 
	{ B_local_13_ce0 sc_out sc_logic 1 signal 37 } 
	{ B_local_13_q0 sc_in sc_lv 32 signal 37 } 
	{ B_local_13_address1 sc_out sc_lv 4 signal 37 } 
	{ B_local_13_ce1 sc_out sc_logic 1 signal 37 } 
	{ B_local_13_q1 sc_in sc_lv 32 signal 37 } 
	{ B_local_14_address0 sc_out sc_lv 4 signal 38 } 
	{ B_local_14_ce0 sc_out sc_logic 1 signal 38 } 
	{ B_local_14_q0 sc_in sc_lv 32 signal 38 } 
	{ B_local_14_address1 sc_out sc_lv 4 signal 38 } 
	{ B_local_14_ce1 sc_out sc_logic 1 signal 38 } 
	{ B_local_14_q1 sc_in sc_lv 32 signal 38 } 
	{ B_local_16_address0 sc_out sc_lv 4 signal 39 } 
	{ B_local_16_ce0 sc_out sc_logic 1 signal 39 } 
	{ B_local_16_q0 sc_in sc_lv 32 signal 39 } 
	{ B_local_16_address1 sc_out sc_lv 4 signal 39 } 
	{ B_local_16_ce1 sc_out sc_logic 1 signal 39 } 
	{ B_local_16_q1 sc_in sc_lv 32 signal 39 } 
	{ B_local_15_address0 sc_out sc_lv 4 signal 40 } 
	{ B_local_15_ce0 sc_out sc_logic 1 signal 40 } 
	{ B_local_15_q0 sc_in sc_lv 32 signal 40 } 
	{ B_local_15_address1 sc_out sc_lv 4 signal 40 } 
	{ B_local_15_ce1 sc_out sc_logic 1 signal 40 } 
	{ B_local_15_q1 sc_in sc_lv 32 signal 40 } 
	{ C_local_address0 sc_out sc_lv 8 signal 41 } 
	{ C_local_ce0 sc_out sc_logic 1 signal 41 } 
	{ C_local_we0 sc_out sc_logic 1 signal 41 } 
	{ C_local_d0 sc_out sc_lv 32 signal 41 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "A_local_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local", "role": "address0" }} , 
 	{ "name": "A_local_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local", "role": "ce0" }} , 
 	{ "name": "A_local_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local", "role": "q0" }} , 
 	{ "name": "A_local_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local", "role": "address1" }} , 
 	{ "name": "A_local_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local", "role": "ce1" }} , 
 	{ "name": "A_local_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local", "role": "q1" }} , 
 	{ "name": "A_local_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_1", "role": "address0" }} , 
 	{ "name": "A_local_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_1", "role": "ce0" }} , 
 	{ "name": "A_local_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_1", "role": "q0" }} , 
 	{ "name": "A_local_1_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_1", "role": "address1" }} , 
 	{ "name": "A_local_1_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_1", "role": "ce1" }} , 
 	{ "name": "A_local_1_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_1", "role": "q1" }} , 
 	{ "name": "A_local_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_2", "role": "address0" }} , 
 	{ "name": "A_local_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_2", "role": "ce0" }} , 
 	{ "name": "A_local_2_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_2", "role": "q0" }} , 
 	{ "name": "A_local_2_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_2", "role": "address1" }} , 
 	{ "name": "A_local_2_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_2", "role": "ce1" }} , 
 	{ "name": "A_local_2_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_2", "role": "q1" }} , 
 	{ "name": "A_local_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_3", "role": "address0" }} , 
 	{ "name": "A_local_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_3", "role": "ce0" }} , 
 	{ "name": "A_local_3_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_3", "role": "q0" }} , 
 	{ "name": "A_local_3_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_3", "role": "address1" }} , 
 	{ "name": "A_local_3_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_3", "role": "ce1" }} , 
 	{ "name": "A_local_3_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_3", "role": "q1" }} , 
 	{ "name": "A_local_4_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_4", "role": "address0" }} , 
 	{ "name": "A_local_4_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_4", "role": "ce0" }} , 
 	{ "name": "A_local_4_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_4", "role": "q0" }} , 
 	{ "name": "A_local_4_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_4", "role": "address1" }} , 
 	{ "name": "A_local_4_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_4", "role": "ce1" }} , 
 	{ "name": "A_local_4_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_4", "role": "q1" }} , 
 	{ "name": "A_local_5_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_5", "role": "address0" }} , 
 	{ "name": "A_local_5_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_5", "role": "ce0" }} , 
 	{ "name": "A_local_5_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_5", "role": "q0" }} , 
 	{ "name": "A_local_5_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_5", "role": "address1" }} , 
 	{ "name": "A_local_5_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_5", "role": "ce1" }} , 
 	{ "name": "A_local_5_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_5", "role": "q1" }} , 
 	{ "name": "A_local_6_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_6", "role": "address0" }} , 
 	{ "name": "A_local_6_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_6", "role": "ce0" }} , 
 	{ "name": "A_local_6_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_6", "role": "q0" }} , 
 	{ "name": "A_local_6_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_6", "role": "address1" }} , 
 	{ "name": "A_local_6_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_6", "role": "ce1" }} , 
 	{ "name": "A_local_6_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_6", "role": "q1" }} , 
 	{ "name": "A_local_7_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_7", "role": "address0" }} , 
 	{ "name": "A_local_7_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_7", "role": "ce0" }} , 
 	{ "name": "A_local_7_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_7", "role": "q0" }} , 
 	{ "name": "A_local_7_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "A_local_7", "role": "address1" }} , 
 	{ "name": "A_local_7_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_local_7", "role": "ce1" }} , 
 	{ "name": "A_local_7_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_local_7", "role": "q1" }} , 
 	{ "name": "B_local_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_load", "role": "default" }} , 
 	{ "name": "B_local_1_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_1_load", "role": "default" }} , 
 	{ "name": "B_local_2_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_2_load", "role": "default" }} , 
 	{ "name": "B_local_3_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_3_load", "role": "default" }} , 
 	{ "name": "B_local_4_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_4_load", "role": "default" }} , 
 	{ "name": "B_local_5_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_5_load", "role": "default" }} , 
 	{ "name": "B_local_6_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_6_load", "role": "default" }} , 
 	{ "name": "B_local_7_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_7_load", "role": "default" }} , 
 	{ "name": "B_local_8_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_8_load", "role": "default" }} , 
 	{ "name": "B_local_9_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_9_load", "role": "default" }} , 
 	{ "name": "B_local_10_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_10_load", "role": "default" }} , 
 	{ "name": "B_local_11_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_11_load", "role": "default" }} , 
 	{ "name": "B_local_12_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_12_load", "role": "default" }} , 
 	{ "name": "B_local_13_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_13_load", "role": "default" }} , 
 	{ "name": "B_local_14_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_14_load", "role": "default" }} , 
 	{ "name": "B_local_15_load", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_15_load", "role": "default" }} , 
 	{ "name": "B_local_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local", "role": "address0" }} , 
 	{ "name": "B_local_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local", "role": "ce0" }} , 
 	{ "name": "B_local_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local", "role": "q0" }} , 
 	{ "name": "B_local_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local", "role": "address1" }} , 
 	{ "name": "B_local_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local", "role": "ce1" }} , 
 	{ "name": "B_local_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local", "role": "q1" }} , 
 	{ "name": "B_local_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_1", "role": "address0" }} , 
 	{ "name": "B_local_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_1", "role": "ce0" }} , 
 	{ "name": "B_local_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_1", "role": "q0" }} , 
 	{ "name": "B_local_1_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_1", "role": "address1" }} , 
 	{ "name": "B_local_1_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_1", "role": "ce1" }} , 
 	{ "name": "B_local_1_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_1", "role": "q1" }} , 
 	{ "name": "B_local_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_2", "role": "address0" }} , 
 	{ "name": "B_local_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_2", "role": "ce0" }} , 
 	{ "name": "B_local_2_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_2", "role": "q0" }} , 
 	{ "name": "B_local_2_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_2", "role": "address1" }} , 
 	{ "name": "B_local_2_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_2", "role": "ce1" }} , 
 	{ "name": "B_local_2_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_2", "role": "q1" }} , 
 	{ "name": "B_local_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_3", "role": "address0" }} , 
 	{ "name": "B_local_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_3", "role": "ce0" }} , 
 	{ "name": "B_local_3_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_3", "role": "q0" }} , 
 	{ "name": "B_local_3_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_3", "role": "address1" }} , 
 	{ "name": "B_local_3_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_3", "role": "ce1" }} , 
 	{ "name": "B_local_3_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_3", "role": "q1" }} , 
 	{ "name": "B_local_4_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_4", "role": "address0" }} , 
 	{ "name": "B_local_4_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_4", "role": "ce0" }} , 
 	{ "name": "B_local_4_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_4", "role": "q0" }} , 
 	{ "name": "B_local_4_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_4", "role": "address1" }} , 
 	{ "name": "B_local_4_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_4", "role": "ce1" }} , 
 	{ "name": "B_local_4_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_4", "role": "q1" }} , 
 	{ "name": "B_local_5_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_5", "role": "address0" }} , 
 	{ "name": "B_local_5_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_5", "role": "ce0" }} , 
 	{ "name": "B_local_5_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_5", "role": "q0" }} , 
 	{ "name": "B_local_5_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_5", "role": "address1" }} , 
 	{ "name": "B_local_5_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_5", "role": "ce1" }} , 
 	{ "name": "B_local_5_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_5", "role": "q1" }} , 
 	{ "name": "B_local_6_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_6", "role": "address0" }} , 
 	{ "name": "B_local_6_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_6", "role": "ce0" }} , 
 	{ "name": "B_local_6_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_6", "role": "q0" }} , 
 	{ "name": "B_local_6_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_6", "role": "address1" }} , 
 	{ "name": "B_local_6_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_6", "role": "ce1" }} , 
 	{ "name": "B_local_6_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_6", "role": "q1" }} , 
 	{ "name": "B_local_7_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_7", "role": "address0" }} , 
 	{ "name": "B_local_7_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_7", "role": "ce0" }} , 
 	{ "name": "B_local_7_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_7", "role": "q0" }} , 
 	{ "name": "B_local_7_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_7", "role": "address1" }} , 
 	{ "name": "B_local_7_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_7", "role": "ce1" }} , 
 	{ "name": "B_local_7_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_7", "role": "q1" }} , 
 	{ "name": "B_local_8_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_8", "role": "address0" }} , 
 	{ "name": "B_local_8_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_8", "role": "ce0" }} , 
 	{ "name": "B_local_8_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_8", "role": "q0" }} , 
 	{ "name": "B_local_8_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_8", "role": "address1" }} , 
 	{ "name": "B_local_8_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_8", "role": "ce1" }} , 
 	{ "name": "B_local_8_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_8", "role": "q1" }} , 
 	{ "name": "B_local_9_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_9", "role": "address0" }} , 
 	{ "name": "B_local_9_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_9", "role": "ce0" }} , 
 	{ "name": "B_local_9_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_9", "role": "q0" }} , 
 	{ "name": "B_local_9_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_9", "role": "address1" }} , 
 	{ "name": "B_local_9_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_9", "role": "ce1" }} , 
 	{ "name": "B_local_9_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_9", "role": "q1" }} , 
 	{ "name": "B_local_10_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_10", "role": "address0" }} , 
 	{ "name": "B_local_10_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_10", "role": "ce0" }} , 
 	{ "name": "B_local_10_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_10", "role": "q0" }} , 
 	{ "name": "B_local_10_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_10", "role": "address1" }} , 
 	{ "name": "B_local_10_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_10", "role": "ce1" }} , 
 	{ "name": "B_local_10_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_10", "role": "q1" }} , 
 	{ "name": "B_local_11_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_11", "role": "address0" }} , 
 	{ "name": "B_local_11_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_11", "role": "ce0" }} , 
 	{ "name": "B_local_11_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_11", "role": "q0" }} , 
 	{ "name": "B_local_11_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_11", "role": "address1" }} , 
 	{ "name": "B_local_11_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_11", "role": "ce1" }} , 
 	{ "name": "B_local_11_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_11", "role": "q1" }} , 
 	{ "name": "B_local_12_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_12", "role": "address0" }} , 
 	{ "name": "B_local_12_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_12", "role": "ce0" }} , 
 	{ "name": "B_local_12_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_12", "role": "q0" }} , 
 	{ "name": "B_local_12_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_12", "role": "address1" }} , 
 	{ "name": "B_local_12_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_12", "role": "ce1" }} , 
 	{ "name": "B_local_12_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_12", "role": "q1" }} , 
 	{ "name": "B_local_13_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_13", "role": "address0" }} , 
 	{ "name": "B_local_13_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_13", "role": "ce0" }} , 
 	{ "name": "B_local_13_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_13", "role": "q0" }} , 
 	{ "name": "B_local_13_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_13", "role": "address1" }} , 
 	{ "name": "B_local_13_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_13", "role": "ce1" }} , 
 	{ "name": "B_local_13_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_13", "role": "q1" }} , 
 	{ "name": "B_local_14_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_14", "role": "address0" }} , 
 	{ "name": "B_local_14_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_14", "role": "ce0" }} , 
 	{ "name": "B_local_14_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_14", "role": "q0" }} , 
 	{ "name": "B_local_14_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_14", "role": "address1" }} , 
 	{ "name": "B_local_14_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_14", "role": "ce1" }} , 
 	{ "name": "B_local_14_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_14", "role": "q1" }} , 
 	{ "name": "B_local_16_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_16", "role": "address0" }} , 
 	{ "name": "B_local_16_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_16", "role": "ce0" }} , 
 	{ "name": "B_local_16_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_16", "role": "q0" }} , 
 	{ "name": "B_local_16_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_16", "role": "address1" }} , 
 	{ "name": "B_local_16_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_16", "role": "ce1" }} , 
 	{ "name": "B_local_16_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_16", "role": "q1" }} , 
 	{ "name": "B_local_15_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_15", "role": "address0" }} , 
 	{ "name": "B_local_15_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_15", "role": "ce0" }} , 
 	{ "name": "B_local_15_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_15", "role": "q0" }} , 
 	{ "name": "B_local_15_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_local_15", "role": "address1" }} , 
 	{ "name": "B_local_15_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_local_15", "role": "ce1" }} , 
 	{ "name": "B_local_15_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_local_15", "role": "q1" }} , 
 	{ "name": "C_local_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "C_local", "role": "address0" }} , 
 	{ "name": "C_local_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local", "role": "ce0" }} , 
 	{ "name": "C_local_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_local", "role": "we0" }} , 
 	{ "name": "C_local_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_local", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
	matmul_full_contiguous_Pipeline_compute_row_loop_compute_col_loop {
		A_local {Type I LastRead 3 FirstWrite -1}
		A_local_1 {Type I LastRead 3 FirstWrite -1}
		A_local_2 {Type I LastRead 3 FirstWrite -1}
		A_local_3 {Type I LastRead 3 FirstWrite -1}
		A_local_4 {Type I LastRead 3 FirstWrite -1}
		A_local_5 {Type I LastRead 3 FirstWrite -1}
		A_local_6 {Type I LastRead 2 FirstWrite -1}
		A_local_7 {Type I LastRead 2 FirstWrite -1}
		B_local_load {Type I LastRead 0 FirstWrite -1}
		B_local_1_load {Type I LastRead 0 FirstWrite -1}
		B_local_2_load {Type I LastRead 0 FirstWrite -1}
		B_local_3_load {Type I LastRead 0 FirstWrite -1}
		B_local_4_load {Type I LastRead 0 FirstWrite -1}
		B_local_5_load {Type I LastRead 0 FirstWrite -1}
		B_local_6_load {Type I LastRead 0 FirstWrite -1}
		B_local_7_load {Type I LastRead 0 FirstWrite -1}
		B_local_8_load {Type I LastRead 0 FirstWrite -1}
		B_local_9_load {Type I LastRead 0 FirstWrite -1}
		B_local_10_load {Type I LastRead 0 FirstWrite -1}
		B_local_11_load {Type I LastRead 0 FirstWrite -1}
		B_local_12_load {Type I LastRead 0 FirstWrite -1}
		B_local_13_load {Type I LastRead 0 FirstWrite -1}
		B_local_14_load {Type I LastRead 0 FirstWrite -1}
		B_local_15_load {Type I LastRead 0 FirstWrite -1}
		B_local {Type I LastRead 3 FirstWrite -1}
		B_local_1 {Type I LastRead 3 FirstWrite -1}
		B_local_2 {Type I LastRead 3 FirstWrite -1}
		B_local_3 {Type I LastRead 3 FirstWrite -1}
		B_local_4 {Type I LastRead 3 FirstWrite -1}
		B_local_5 {Type I LastRead 3 FirstWrite -1}
		B_local_6 {Type I LastRead 3 FirstWrite -1}
		B_local_7 {Type I LastRead 3 FirstWrite -1}
		B_local_8 {Type I LastRead 3 FirstWrite -1}
		B_local_9 {Type I LastRead 3 FirstWrite -1}
		B_local_10 {Type I LastRead 3 FirstWrite -1}
		B_local_11 {Type I LastRead 3 FirstWrite -1}
		B_local_12 {Type I LastRead 3 FirstWrite -1}
		B_local_13 {Type I LastRead 3 FirstWrite -1}
		B_local_14 {Type I LastRead 3 FirstWrite -1}
		B_local_16 {Type I LastRead 3 FirstWrite -1}
		B_local_15 {Type I LastRead 3 FirstWrite -1}
		C_local {Type O LastRead -1 FirstWrite 5}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "262", "Max" : "262"}
	, {"Name" : "Interval", "Min" : "262", "Max" : "262"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	A_local { ap_memory {  { A_local_address0 mem_address 1 5 }  { A_local_ce0 mem_ce 1 1 }  { A_local_q0 mem_dout 0 32 }  { A_local_address1 MemPortADDR2 1 5 }  { A_local_ce1 MemPortCE2 1 1 }  { A_local_q1 MemPortDOUT2 0 32 } } }
	A_local_1 { ap_memory {  { A_local_1_address0 mem_address 1 5 }  { A_local_1_ce0 mem_ce 1 1 }  { A_local_1_q0 mem_dout 0 32 }  { A_local_1_address1 MemPortADDR2 1 5 }  { A_local_1_ce1 MemPortCE2 1 1 }  { A_local_1_q1 MemPortDOUT2 0 32 } } }
	A_local_2 { ap_memory {  { A_local_2_address0 mem_address 1 5 }  { A_local_2_ce0 mem_ce 1 1 }  { A_local_2_q0 mem_dout 0 32 }  { A_local_2_address1 MemPortADDR2 1 5 }  { A_local_2_ce1 MemPortCE2 1 1 }  { A_local_2_q1 MemPortDOUT2 0 32 } } }
	A_local_3 { ap_memory {  { A_local_3_address0 mem_address 1 5 }  { A_local_3_ce0 mem_ce 1 1 }  { A_local_3_q0 mem_dout 0 32 }  { A_local_3_address1 MemPortADDR2 1 5 }  { A_local_3_ce1 MemPortCE2 1 1 }  { A_local_3_q1 MemPortDOUT2 0 32 } } }
	A_local_4 { ap_memory {  { A_local_4_address0 mem_address 1 5 }  { A_local_4_ce0 mem_ce 1 1 }  { A_local_4_q0 mem_dout 0 32 }  { A_local_4_address1 MemPortADDR2 1 5 }  { A_local_4_ce1 MemPortCE2 1 1 }  { A_local_4_q1 MemPortDOUT2 0 32 } } }
	A_local_5 { ap_memory {  { A_local_5_address0 mem_address 1 5 }  { A_local_5_ce0 mem_ce 1 1 }  { A_local_5_q0 mem_dout 0 32 }  { A_local_5_address1 MemPortADDR2 1 5 }  { A_local_5_ce1 MemPortCE2 1 1 }  { A_local_5_q1 MemPortDOUT2 0 32 } } }
	A_local_6 { ap_memory {  { A_local_6_address0 mem_address 1 5 }  { A_local_6_ce0 mem_ce 1 1 }  { A_local_6_q0 mem_dout 0 32 }  { A_local_6_address1 MemPortADDR2 1 5 }  { A_local_6_ce1 MemPortCE2 1 1 }  { A_local_6_q1 MemPortDOUT2 0 32 } } }
	A_local_7 { ap_memory {  { A_local_7_address0 mem_address 1 5 }  { A_local_7_ce0 mem_ce 1 1 }  { A_local_7_q0 mem_dout 0 32 }  { A_local_7_address1 MemPortADDR2 1 5 }  { A_local_7_ce1 MemPortCE2 1 1 }  { A_local_7_q1 MemPortDOUT2 0 32 } } }
	B_local_load { ap_none {  { B_local_load in_data 0 32 } } }
	B_local_1_load { ap_none {  { B_local_1_load in_data 0 32 } } }
	B_local_2_load { ap_none {  { B_local_2_load in_data 0 32 } } }
	B_local_3_load { ap_none {  { B_local_3_load in_data 0 32 } } }
	B_local_4_load { ap_none {  { B_local_4_load in_data 0 32 } } }
	B_local_5_load { ap_none {  { B_local_5_load in_data 0 32 } } }
	B_local_6_load { ap_none {  { B_local_6_load in_data 0 32 } } }
	B_local_7_load { ap_none {  { B_local_7_load in_data 0 32 } } }
	B_local_8_load { ap_none {  { B_local_8_load in_data 0 32 } } }
	B_local_9_load { ap_none {  { B_local_9_load in_data 0 32 } } }
	B_local_10_load { ap_none {  { B_local_10_load in_data 0 32 } } }
	B_local_11_load { ap_none {  { B_local_11_load in_data 0 32 } } }
	B_local_12_load { ap_none {  { B_local_12_load in_data 0 32 } } }
	B_local_13_load { ap_none {  { B_local_13_load in_data 0 32 } } }
	B_local_14_load { ap_none {  { B_local_14_load in_data 0 32 } } }
	B_local_15_load { ap_none {  { B_local_15_load in_data 0 32 } } }
	B_local { ap_memory {  { B_local_address0 mem_address 1 4 }  { B_local_ce0 mem_ce 1 1 }  { B_local_q0 mem_dout 0 32 }  { B_local_address1 MemPortADDR2 1 4 }  { B_local_ce1 MemPortCE2 1 1 }  { B_local_q1 MemPortDOUT2 0 32 } } }
	B_local_1 { ap_memory {  { B_local_1_address0 mem_address 1 4 }  { B_local_1_ce0 mem_ce 1 1 }  { B_local_1_q0 mem_dout 0 32 }  { B_local_1_address1 MemPortADDR2 1 4 }  { B_local_1_ce1 MemPortCE2 1 1 }  { B_local_1_q1 MemPortDOUT2 0 32 } } }
	B_local_2 { ap_memory {  { B_local_2_address0 mem_address 1 4 }  { B_local_2_ce0 mem_ce 1 1 }  { B_local_2_q0 mem_dout 0 32 }  { B_local_2_address1 MemPortADDR2 1 4 }  { B_local_2_ce1 MemPortCE2 1 1 }  { B_local_2_q1 MemPortDOUT2 0 32 } } }
	B_local_3 { ap_memory {  { B_local_3_address0 mem_address 1 4 }  { B_local_3_ce0 mem_ce 1 1 }  { B_local_3_q0 mem_dout 0 32 }  { B_local_3_address1 MemPortADDR2 1 4 }  { B_local_3_ce1 MemPortCE2 1 1 }  { B_local_3_q1 MemPortDOUT2 0 32 } } }
	B_local_4 { ap_memory {  { B_local_4_address0 mem_address 1 4 }  { B_local_4_ce0 mem_ce 1 1 }  { B_local_4_q0 mem_dout 0 32 }  { B_local_4_address1 MemPortADDR2 1 4 }  { B_local_4_ce1 MemPortCE2 1 1 }  { B_local_4_q1 MemPortDOUT2 0 32 } } }
	B_local_5 { ap_memory {  { B_local_5_address0 mem_address 1 4 }  { B_local_5_ce0 mem_ce 1 1 }  { B_local_5_q0 mem_dout 0 32 }  { B_local_5_address1 MemPortADDR2 1 4 }  { B_local_5_ce1 MemPortCE2 1 1 }  { B_local_5_q1 MemPortDOUT2 0 32 } } }
	B_local_6 { ap_memory {  { B_local_6_address0 mem_address 1 4 }  { B_local_6_ce0 mem_ce 1 1 }  { B_local_6_q0 mem_dout 0 32 }  { B_local_6_address1 MemPortADDR2 1 4 }  { B_local_6_ce1 MemPortCE2 1 1 }  { B_local_6_q1 MemPortDOUT2 0 32 } } }
	B_local_7 { ap_memory {  { B_local_7_address0 mem_address 1 4 }  { B_local_7_ce0 mem_ce 1 1 }  { B_local_7_q0 mem_dout 0 32 }  { B_local_7_address1 MemPortADDR2 1 4 }  { B_local_7_ce1 MemPortCE2 1 1 }  { B_local_7_q1 MemPortDOUT2 0 32 } } }
	B_local_8 { ap_memory {  { B_local_8_address0 mem_address 1 4 }  { B_local_8_ce0 mem_ce 1 1 }  { B_local_8_q0 mem_dout 0 32 }  { B_local_8_address1 MemPortADDR2 1 4 }  { B_local_8_ce1 MemPortCE2 1 1 }  { B_local_8_q1 MemPortDOUT2 0 32 } } }
	B_local_9 { ap_memory {  { B_local_9_address0 mem_address 1 4 }  { B_local_9_ce0 mem_ce 1 1 }  { B_local_9_q0 mem_dout 0 32 }  { B_local_9_address1 MemPortADDR2 1 4 }  { B_local_9_ce1 MemPortCE2 1 1 }  { B_local_9_q1 MemPortDOUT2 0 32 } } }
	B_local_10 { ap_memory {  { B_local_10_address0 mem_address 1 4 }  { B_local_10_ce0 mem_ce 1 1 }  { B_local_10_q0 mem_dout 0 32 }  { B_local_10_address1 MemPortADDR2 1 4 }  { B_local_10_ce1 MemPortCE2 1 1 }  { B_local_10_q1 MemPortDOUT2 0 32 } } }
	B_local_11 { ap_memory {  { B_local_11_address0 mem_address 1 4 }  { B_local_11_ce0 mem_ce 1 1 }  { B_local_11_q0 mem_dout 0 32 }  { B_local_11_address1 MemPortADDR2 1 4 }  { B_local_11_ce1 MemPortCE2 1 1 }  { B_local_11_q1 MemPortDOUT2 0 32 } } }
	B_local_12 { ap_memory {  { B_local_12_address0 mem_address 1 4 }  { B_local_12_ce0 mem_ce 1 1 }  { B_local_12_q0 mem_dout 0 32 }  { B_local_12_address1 MemPortADDR2 1 4 }  { B_local_12_ce1 MemPortCE2 1 1 }  { B_local_12_q1 MemPortDOUT2 0 32 } } }
	B_local_13 { ap_memory {  { B_local_13_address0 mem_address 1 4 }  { B_local_13_ce0 mem_ce 1 1 }  { B_local_13_q0 mem_dout 0 32 }  { B_local_13_address1 MemPortADDR2 1 4 }  { B_local_13_ce1 MemPortCE2 1 1 }  { B_local_13_q1 MemPortDOUT2 0 32 } } }
	B_local_14 { ap_memory {  { B_local_14_address0 mem_address 1 4 }  { B_local_14_ce0 mem_ce 1 1 }  { B_local_14_q0 mem_dout 0 32 }  { B_local_14_address1 MemPortADDR2 1 4 }  { B_local_14_ce1 MemPortCE2 1 1 }  { B_local_14_q1 MemPortDOUT2 0 32 } } }
	B_local_16 { ap_memory {  { B_local_16_address0 mem_address 1 4 }  { B_local_16_ce0 mem_ce 1 1 }  { B_local_16_q0 mem_dout 0 32 }  { B_local_16_address1 MemPortADDR2 1 4 }  { B_local_16_ce1 MemPortCE2 1 1 }  { B_local_16_q1 MemPortDOUT2 0 32 } } }
	B_local_15 { ap_memory {  { B_local_15_address0 mem_address 1 4 }  { B_local_15_ce0 mem_ce 1 1 }  { B_local_15_q0 mem_dout 0 32 }  { B_local_15_address1 MemPortADDR2 1 4 }  { B_local_15_ce1 MemPortCE2 1 1 }  { B_local_15_q1 MemPortDOUT2 0 32 } } }
	C_local { ap_memory {  { C_local_address0 mem_address 1 8 }  { C_local_ce0 mem_ce 1 1 }  { C_local_we0 mem_we 1 1 }  { C_local_d0 mem_din 1 32 } } }
}
