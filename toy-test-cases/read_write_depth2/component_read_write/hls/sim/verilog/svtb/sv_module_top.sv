//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
//Tool Version Limit: 2025.05
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================

`ifndef SV_MODULE_TOP_SV
`define SV_MODULE_TOP_SV


`timescale 1ns/1ps


`include "uvm_macros.svh"
import uvm_pkg::*;
import file_agent_pkg::*;
import read_write_subsystem_pkg::*;
`include "read_write_subsys_test_sequence_lib.sv"
`include "read_write_test_lib.sv"


module sv_module_top;


    misc_interface              misc_if ( .clock(apatb_read_write_top.AESL_clock), .reset(apatb_read_write_top.AESL_reset) );
    assign misc_if.dut2tb_ap_ready = apatb_read_write_top.AESL_inst_read_write.ap_ready;
    assign misc_if.dut2tb_ap_done_kernel = apatb_read_write_top.AESL_inst_read_write.ap_done;
    initial begin
        uvm_config_db #(virtual misc_interface)::set(null, "uvm_test_top.top_env.*", "misc_if", misc_if);
    end


    axi_if #(64,64,8,3,1)  axi_mem_0_if (.clk  (apatb_read_write_top.AESL_clock), .rst(apatb_read_write_top.AESL_reset));
    assign axi_mem_0_if.AWVALID = apatb_read_write_top.mem_0_AWVALID;
    assign apatb_read_write_top.mem_0_AWREADY = axi_mem_0_if.AWREADY;
    assign axi_mem_0_if.AWADDR = apatb_read_write_top.mem_0_AWADDR;
    assign axi_mem_0_if.AWID = apatb_read_write_top.mem_0_AWID;
    assign axi_mem_0_if.AWLEN = apatb_read_write_top.mem_0_AWLEN;
    assign axi_mem_0_if.AWSIZE = apatb_read_write_top.mem_0_AWSIZE;
    assign axi_mem_0_if.AWBURST = apatb_read_write_top.mem_0_AWBURST;
    assign axi_mem_0_if.AWLOCK = apatb_read_write_top.mem_0_AWLOCK;
    assign axi_mem_0_if.AWCACHE = apatb_read_write_top.mem_0_AWCACHE;
    assign axi_mem_0_if.AWPROT = apatb_read_write_top.mem_0_AWPROT;
    assign axi_mem_0_if.AWQOS = apatb_read_write_top.mem_0_AWQOS;
    assign axi_mem_0_if.AWREGION = apatb_read_write_top.mem_0_AWREGION;
    assign axi_mem_0_if.AWUSER = apatb_read_write_top.mem_0_AWUSER;
    assign axi_mem_0_if.WVALID = apatb_read_write_top.mem_0_WVALID;
    assign apatb_read_write_top.mem_0_WREADY = axi_mem_0_if.WREADY;
    assign axi_mem_0_if.WDATA = apatb_read_write_top.mem_0_WDATA;
    assign axi_mem_0_if.WSTRB = apatb_read_write_top.mem_0_WSTRB;
    assign axi_mem_0_if.WLAST = apatb_read_write_top.mem_0_WLAST;
    assign axi_mem_0_if.WID = apatb_read_write_top.mem_0_WID;
    assign axi_mem_0_if.WUSER = apatb_read_write_top.mem_0_WUSER;
    assign axi_mem_0_if.ARVALID = apatb_read_write_top.mem_0_ARVALID;
    assign apatb_read_write_top.mem_0_ARREADY = axi_mem_0_if.ARREADY;
    assign axi_mem_0_if.ARADDR = apatb_read_write_top.mem_0_ARADDR;
    assign axi_mem_0_if.ARID = apatb_read_write_top.mem_0_ARID;
    assign axi_mem_0_if.ARLEN = apatb_read_write_top.mem_0_ARLEN;
    assign axi_mem_0_if.ARSIZE = apatb_read_write_top.mem_0_ARSIZE;
    assign axi_mem_0_if.ARBURST = apatb_read_write_top.mem_0_ARBURST;
    assign axi_mem_0_if.ARLOCK = apatb_read_write_top.mem_0_ARLOCK;
    assign axi_mem_0_if.ARCACHE = apatb_read_write_top.mem_0_ARCACHE;
    assign axi_mem_0_if.ARPROT = apatb_read_write_top.mem_0_ARPROT;
    assign axi_mem_0_if.ARQOS = apatb_read_write_top.mem_0_ARQOS;
    assign axi_mem_0_if.ARREGION = apatb_read_write_top.mem_0_ARREGION;
    assign axi_mem_0_if.ARUSER = apatb_read_write_top.mem_0_ARUSER;
    assign apatb_read_write_top.mem_0_RVALID = axi_mem_0_if.RVALID;
    assign axi_mem_0_if.RREADY = apatb_read_write_top.mem_0_RREADY;
    assign apatb_read_write_top.mem_0_RDATA = axi_mem_0_if.RDATA;
    assign apatb_read_write_top.mem_0_RLAST = axi_mem_0_if.RLAST;
    assign apatb_read_write_top.mem_0_RID = axi_mem_0_if.RID;
    assign apatb_read_write_top.mem_0_RUSER = axi_mem_0_if.RUSER;
    assign apatb_read_write_top.mem_0_RRESP = axi_mem_0_if.RRESP;
    assign apatb_read_write_top.mem_0_BVALID = axi_mem_0_if.BVALID;
    assign axi_mem_0_if.BREADY = apatb_read_write_top.mem_0_BREADY;
    assign apatb_read_write_top.mem_0_BRESP = axi_mem_0_if.BRESP;
    assign apatb_read_write_top.mem_0_BID = axi_mem_0_if.BID;
    assign apatb_read_write_top.mem_0_BUSER = axi_mem_0_if.BUSER;
    initial begin
        uvm_config_db #( virtual axi_if#(64,64,8,3,1) )::set(null, "uvm_test_top.top_env.axi_master_mem_0.*", "vif", axi_mem_0_if);
    end


    axi_if #(64,64,8,3,1)  axi_mem_1_if (.clk  (apatb_read_write_top.AESL_clock), .rst(apatb_read_write_top.AESL_reset));
    assign axi_mem_1_if.AWVALID = apatb_read_write_top.mem_1_AWVALID;
    assign apatb_read_write_top.mem_1_AWREADY = axi_mem_1_if.AWREADY;
    assign axi_mem_1_if.AWADDR = apatb_read_write_top.mem_1_AWADDR;
    assign axi_mem_1_if.AWID = apatb_read_write_top.mem_1_AWID;
    assign axi_mem_1_if.AWLEN = apatb_read_write_top.mem_1_AWLEN;
    assign axi_mem_1_if.AWSIZE = apatb_read_write_top.mem_1_AWSIZE;
    assign axi_mem_1_if.AWBURST = apatb_read_write_top.mem_1_AWBURST;
    assign axi_mem_1_if.AWLOCK = apatb_read_write_top.mem_1_AWLOCK;
    assign axi_mem_1_if.AWCACHE = apatb_read_write_top.mem_1_AWCACHE;
    assign axi_mem_1_if.AWPROT = apatb_read_write_top.mem_1_AWPROT;
    assign axi_mem_1_if.AWQOS = apatb_read_write_top.mem_1_AWQOS;
    assign axi_mem_1_if.AWREGION = apatb_read_write_top.mem_1_AWREGION;
    assign axi_mem_1_if.AWUSER = apatb_read_write_top.mem_1_AWUSER;
    assign axi_mem_1_if.WVALID = apatb_read_write_top.mem_1_WVALID;
    assign apatb_read_write_top.mem_1_WREADY = axi_mem_1_if.WREADY;
    assign axi_mem_1_if.WDATA = apatb_read_write_top.mem_1_WDATA;
    assign axi_mem_1_if.WSTRB = apatb_read_write_top.mem_1_WSTRB;
    assign axi_mem_1_if.WLAST = apatb_read_write_top.mem_1_WLAST;
    assign axi_mem_1_if.WID = apatb_read_write_top.mem_1_WID;
    assign axi_mem_1_if.WUSER = apatb_read_write_top.mem_1_WUSER;
    assign axi_mem_1_if.ARVALID = apatb_read_write_top.mem_1_ARVALID;
    assign apatb_read_write_top.mem_1_ARREADY = axi_mem_1_if.ARREADY;
    assign axi_mem_1_if.ARADDR = apatb_read_write_top.mem_1_ARADDR;
    assign axi_mem_1_if.ARID = apatb_read_write_top.mem_1_ARID;
    assign axi_mem_1_if.ARLEN = apatb_read_write_top.mem_1_ARLEN;
    assign axi_mem_1_if.ARSIZE = apatb_read_write_top.mem_1_ARSIZE;
    assign axi_mem_1_if.ARBURST = apatb_read_write_top.mem_1_ARBURST;
    assign axi_mem_1_if.ARLOCK = apatb_read_write_top.mem_1_ARLOCK;
    assign axi_mem_1_if.ARCACHE = apatb_read_write_top.mem_1_ARCACHE;
    assign axi_mem_1_if.ARPROT = apatb_read_write_top.mem_1_ARPROT;
    assign axi_mem_1_if.ARQOS = apatb_read_write_top.mem_1_ARQOS;
    assign axi_mem_1_if.ARREGION = apatb_read_write_top.mem_1_ARREGION;
    assign axi_mem_1_if.ARUSER = apatb_read_write_top.mem_1_ARUSER;
    assign apatb_read_write_top.mem_1_RVALID = axi_mem_1_if.RVALID;
    assign axi_mem_1_if.RREADY = apatb_read_write_top.mem_1_RREADY;
    assign apatb_read_write_top.mem_1_RDATA = axi_mem_1_if.RDATA;
    assign apatb_read_write_top.mem_1_RLAST = axi_mem_1_if.RLAST;
    assign apatb_read_write_top.mem_1_RID = axi_mem_1_if.RID;
    assign apatb_read_write_top.mem_1_RUSER = axi_mem_1_if.RUSER;
    assign apatb_read_write_top.mem_1_RRESP = axi_mem_1_if.RRESP;
    assign apatb_read_write_top.mem_1_BVALID = axi_mem_1_if.BVALID;
    assign axi_mem_1_if.BREADY = apatb_read_write_top.mem_1_BREADY;
    assign apatb_read_write_top.mem_1_BRESP = axi_mem_1_if.BRESP;
    assign apatb_read_write_top.mem_1_BID = axi_mem_1_if.BID;
    assign apatb_read_write_top.mem_1_BUSER = axi_mem_1_if.BUSER;
    initial begin
        uvm_config_db #( virtual axi_if#(64,64,8,3,1) )::set(null, "uvm_test_top.top_env.axi_master_mem_1.*", "vif", axi_mem_1_if);
    end


    axi_if #(6,4,4,3,1)  axi_control_if (.clk  (apatb_read_write_top.AESL_clock), .rst(apatb_read_write_top.AESL_reset));
    assign apatb_read_write_top.control_AWADDR = axi_control_if.AWADDR;
    assign apatb_read_write_top.control_AWVALID = axi_control_if.AWVALID;
    assign axi_control_if.AWREADY = apatb_read_write_top.control_AWREADY;
    assign apatb_read_write_top.control_WVALID = axi_control_if.WVALID;
    assign axi_control_if.WREADY = apatb_read_write_top.control_WREADY;
    assign apatb_read_write_top.control_WDATA = axi_control_if.WDATA;
    assign apatb_read_write_top.control_WSTRB = axi_control_if.WSTRB;
    assign apatb_read_write_top.control_ARADDR = axi_control_if.ARADDR;
    assign apatb_read_write_top.control_ARVALID = axi_control_if.ARVALID;
    assign axi_control_if.ARREADY = apatb_read_write_top.control_ARREADY;
    assign axi_control_if.RVALID = apatb_read_write_top.control_RVALID;
    assign apatb_read_write_top.control_RREADY = axi_control_if.RREADY;
    assign axi_control_if.RDATA = apatb_read_write_top.control_RDATA;
    assign axi_control_if.RRESP = apatb_read_write_top.control_RRESP;
    assign axi_control_if.BVALID = apatb_read_write_top.control_BVALID;
    assign apatb_read_write_top.control_BREADY = axi_control_if.BREADY;
    assign axi_control_if.BRESP = apatb_read_write_top.control_BRESP;
    assign axi_control_if.BID = 0;
    assign axi_control_if.RID = 0;
    assign axi_control_if.RLAST = 1;
    initial begin
        uvm_config_db #( virtual axi_if#(6,4,4,3,1) )::set(null, "uvm_test_top.top_env.axi_lite_control.*", "vif", axi_control_if);
    end


    initial begin
        run_test();
    end
endmodule
`endif
