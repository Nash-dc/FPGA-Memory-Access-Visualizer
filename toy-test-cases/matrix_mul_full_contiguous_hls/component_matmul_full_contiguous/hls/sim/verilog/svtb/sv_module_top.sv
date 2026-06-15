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
import matmul_full_contiguous_subsystem_pkg::*;
`include "matmul_full_contiguous_subsys_test_sequence_lib.sv"
`include "matmul_full_contiguous_test_lib.sv"


module sv_module_top;


    misc_interface              misc_if ( .clock(apatb_matmul_full_contiguous_top.AESL_clock), .reset(apatb_matmul_full_contiguous_top.AESL_reset) );
    assign misc_if.dut2tb_ap_ready = apatb_matmul_full_contiguous_top.AESL_inst_matmul_full_contiguous.ap_ready;
    assign misc_if.dut2tb_ap_done_kernel = apatb_matmul_full_contiguous_top.AESL_inst_matmul_full_contiguous.ap_done;
    initial begin
        uvm_config_db #(virtual misc_interface)::set(null, "uvm_test_top.top_env.*", "misc_if", misc_if);
    end


    axi_if #(64,64,8,3,1)  axi_gmem_a_if (.clk  (apatb_matmul_full_contiguous_top.AESL_clock), .rst(apatb_matmul_full_contiguous_top.AESL_reset));
    assign axi_gmem_a_if.AWVALID = apatb_matmul_full_contiguous_top.gmem_a_AWVALID;
    assign apatb_matmul_full_contiguous_top.gmem_a_AWREADY = axi_gmem_a_if.AWREADY;
    assign axi_gmem_a_if.AWADDR = apatb_matmul_full_contiguous_top.gmem_a_AWADDR;
    assign axi_gmem_a_if.AWID = apatb_matmul_full_contiguous_top.gmem_a_AWID;
    assign axi_gmem_a_if.AWLEN = apatb_matmul_full_contiguous_top.gmem_a_AWLEN;
    assign axi_gmem_a_if.AWSIZE = apatb_matmul_full_contiguous_top.gmem_a_AWSIZE;
    assign axi_gmem_a_if.AWBURST = apatb_matmul_full_contiguous_top.gmem_a_AWBURST;
    assign axi_gmem_a_if.AWLOCK = apatb_matmul_full_contiguous_top.gmem_a_AWLOCK;
    assign axi_gmem_a_if.AWCACHE = apatb_matmul_full_contiguous_top.gmem_a_AWCACHE;
    assign axi_gmem_a_if.AWPROT = apatb_matmul_full_contiguous_top.gmem_a_AWPROT;
    assign axi_gmem_a_if.AWQOS = apatb_matmul_full_contiguous_top.gmem_a_AWQOS;
    assign axi_gmem_a_if.AWREGION = apatb_matmul_full_contiguous_top.gmem_a_AWREGION;
    assign axi_gmem_a_if.AWUSER = apatb_matmul_full_contiguous_top.gmem_a_AWUSER;
    assign axi_gmem_a_if.WVALID = apatb_matmul_full_contiguous_top.gmem_a_WVALID;
    assign apatb_matmul_full_contiguous_top.gmem_a_WREADY = axi_gmem_a_if.WREADY;
    assign axi_gmem_a_if.WDATA = apatb_matmul_full_contiguous_top.gmem_a_WDATA;
    assign axi_gmem_a_if.WSTRB = apatb_matmul_full_contiguous_top.gmem_a_WSTRB;
    assign axi_gmem_a_if.WLAST = apatb_matmul_full_contiguous_top.gmem_a_WLAST;
    assign axi_gmem_a_if.WID = apatb_matmul_full_contiguous_top.gmem_a_WID;
    assign axi_gmem_a_if.WUSER = apatb_matmul_full_contiguous_top.gmem_a_WUSER;
    assign axi_gmem_a_if.ARVALID = apatb_matmul_full_contiguous_top.gmem_a_ARVALID;
    assign apatb_matmul_full_contiguous_top.gmem_a_ARREADY = axi_gmem_a_if.ARREADY;
    assign axi_gmem_a_if.ARADDR = apatb_matmul_full_contiguous_top.gmem_a_ARADDR;
    assign axi_gmem_a_if.ARID = apatb_matmul_full_contiguous_top.gmem_a_ARID;
    assign axi_gmem_a_if.ARLEN = apatb_matmul_full_contiguous_top.gmem_a_ARLEN;
    assign axi_gmem_a_if.ARSIZE = apatb_matmul_full_contiguous_top.gmem_a_ARSIZE;
    assign axi_gmem_a_if.ARBURST = apatb_matmul_full_contiguous_top.gmem_a_ARBURST;
    assign axi_gmem_a_if.ARLOCK = apatb_matmul_full_contiguous_top.gmem_a_ARLOCK;
    assign axi_gmem_a_if.ARCACHE = apatb_matmul_full_contiguous_top.gmem_a_ARCACHE;
    assign axi_gmem_a_if.ARPROT = apatb_matmul_full_contiguous_top.gmem_a_ARPROT;
    assign axi_gmem_a_if.ARQOS = apatb_matmul_full_contiguous_top.gmem_a_ARQOS;
    assign axi_gmem_a_if.ARREGION = apatb_matmul_full_contiguous_top.gmem_a_ARREGION;
    assign axi_gmem_a_if.ARUSER = apatb_matmul_full_contiguous_top.gmem_a_ARUSER;
    assign apatb_matmul_full_contiguous_top.gmem_a_RVALID = axi_gmem_a_if.RVALID;
    assign axi_gmem_a_if.RREADY = apatb_matmul_full_contiguous_top.gmem_a_RREADY;
    assign apatb_matmul_full_contiguous_top.gmem_a_RDATA = axi_gmem_a_if.RDATA;
    assign apatb_matmul_full_contiguous_top.gmem_a_RLAST = axi_gmem_a_if.RLAST;
    assign apatb_matmul_full_contiguous_top.gmem_a_RID = axi_gmem_a_if.RID;
    assign apatb_matmul_full_contiguous_top.gmem_a_RUSER = axi_gmem_a_if.RUSER;
    assign apatb_matmul_full_contiguous_top.gmem_a_RRESP = axi_gmem_a_if.RRESP;
    assign apatb_matmul_full_contiguous_top.gmem_a_BVALID = axi_gmem_a_if.BVALID;
    assign axi_gmem_a_if.BREADY = apatb_matmul_full_contiguous_top.gmem_a_BREADY;
    assign apatb_matmul_full_contiguous_top.gmem_a_BRESP = axi_gmem_a_if.BRESP;
    assign apatb_matmul_full_contiguous_top.gmem_a_BID = axi_gmem_a_if.BID;
    assign apatb_matmul_full_contiguous_top.gmem_a_BUSER = axi_gmem_a_if.BUSER;
    initial begin
        uvm_config_db #( virtual axi_if#(64,64,8,3,1) )::set(null, "uvm_test_top.top_env.axi_master_gmem_a.*", "vif", axi_gmem_a_if);
    end


    axi_if #(64,64,8,3,1)  axi_gmem_b_if (.clk  (apatb_matmul_full_contiguous_top.AESL_clock), .rst(apatb_matmul_full_contiguous_top.AESL_reset));
    assign axi_gmem_b_if.AWVALID = apatb_matmul_full_contiguous_top.gmem_b_AWVALID;
    assign apatb_matmul_full_contiguous_top.gmem_b_AWREADY = axi_gmem_b_if.AWREADY;
    assign axi_gmem_b_if.AWADDR = apatb_matmul_full_contiguous_top.gmem_b_AWADDR;
    assign axi_gmem_b_if.AWID = apatb_matmul_full_contiguous_top.gmem_b_AWID;
    assign axi_gmem_b_if.AWLEN = apatb_matmul_full_contiguous_top.gmem_b_AWLEN;
    assign axi_gmem_b_if.AWSIZE = apatb_matmul_full_contiguous_top.gmem_b_AWSIZE;
    assign axi_gmem_b_if.AWBURST = apatb_matmul_full_contiguous_top.gmem_b_AWBURST;
    assign axi_gmem_b_if.AWLOCK = apatb_matmul_full_contiguous_top.gmem_b_AWLOCK;
    assign axi_gmem_b_if.AWCACHE = apatb_matmul_full_contiguous_top.gmem_b_AWCACHE;
    assign axi_gmem_b_if.AWPROT = apatb_matmul_full_contiguous_top.gmem_b_AWPROT;
    assign axi_gmem_b_if.AWQOS = apatb_matmul_full_contiguous_top.gmem_b_AWQOS;
    assign axi_gmem_b_if.AWREGION = apatb_matmul_full_contiguous_top.gmem_b_AWREGION;
    assign axi_gmem_b_if.AWUSER = apatb_matmul_full_contiguous_top.gmem_b_AWUSER;
    assign axi_gmem_b_if.WVALID = apatb_matmul_full_contiguous_top.gmem_b_WVALID;
    assign apatb_matmul_full_contiguous_top.gmem_b_WREADY = axi_gmem_b_if.WREADY;
    assign axi_gmem_b_if.WDATA = apatb_matmul_full_contiguous_top.gmem_b_WDATA;
    assign axi_gmem_b_if.WSTRB = apatb_matmul_full_contiguous_top.gmem_b_WSTRB;
    assign axi_gmem_b_if.WLAST = apatb_matmul_full_contiguous_top.gmem_b_WLAST;
    assign axi_gmem_b_if.WID = apatb_matmul_full_contiguous_top.gmem_b_WID;
    assign axi_gmem_b_if.WUSER = apatb_matmul_full_contiguous_top.gmem_b_WUSER;
    assign axi_gmem_b_if.ARVALID = apatb_matmul_full_contiguous_top.gmem_b_ARVALID;
    assign apatb_matmul_full_contiguous_top.gmem_b_ARREADY = axi_gmem_b_if.ARREADY;
    assign axi_gmem_b_if.ARADDR = apatb_matmul_full_contiguous_top.gmem_b_ARADDR;
    assign axi_gmem_b_if.ARID = apatb_matmul_full_contiguous_top.gmem_b_ARID;
    assign axi_gmem_b_if.ARLEN = apatb_matmul_full_contiguous_top.gmem_b_ARLEN;
    assign axi_gmem_b_if.ARSIZE = apatb_matmul_full_contiguous_top.gmem_b_ARSIZE;
    assign axi_gmem_b_if.ARBURST = apatb_matmul_full_contiguous_top.gmem_b_ARBURST;
    assign axi_gmem_b_if.ARLOCK = apatb_matmul_full_contiguous_top.gmem_b_ARLOCK;
    assign axi_gmem_b_if.ARCACHE = apatb_matmul_full_contiguous_top.gmem_b_ARCACHE;
    assign axi_gmem_b_if.ARPROT = apatb_matmul_full_contiguous_top.gmem_b_ARPROT;
    assign axi_gmem_b_if.ARQOS = apatb_matmul_full_contiguous_top.gmem_b_ARQOS;
    assign axi_gmem_b_if.ARREGION = apatb_matmul_full_contiguous_top.gmem_b_ARREGION;
    assign axi_gmem_b_if.ARUSER = apatb_matmul_full_contiguous_top.gmem_b_ARUSER;
    assign apatb_matmul_full_contiguous_top.gmem_b_RVALID = axi_gmem_b_if.RVALID;
    assign axi_gmem_b_if.RREADY = apatb_matmul_full_contiguous_top.gmem_b_RREADY;
    assign apatb_matmul_full_contiguous_top.gmem_b_RDATA = axi_gmem_b_if.RDATA;
    assign apatb_matmul_full_contiguous_top.gmem_b_RLAST = axi_gmem_b_if.RLAST;
    assign apatb_matmul_full_contiguous_top.gmem_b_RID = axi_gmem_b_if.RID;
    assign apatb_matmul_full_contiguous_top.gmem_b_RUSER = axi_gmem_b_if.RUSER;
    assign apatb_matmul_full_contiguous_top.gmem_b_RRESP = axi_gmem_b_if.RRESP;
    assign apatb_matmul_full_contiguous_top.gmem_b_BVALID = axi_gmem_b_if.BVALID;
    assign axi_gmem_b_if.BREADY = apatb_matmul_full_contiguous_top.gmem_b_BREADY;
    assign apatb_matmul_full_contiguous_top.gmem_b_BRESP = axi_gmem_b_if.BRESP;
    assign apatb_matmul_full_contiguous_top.gmem_b_BID = axi_gmem_b_if.BID;
    assign apatb_matmul_full_contiguous_top.gmem_b_BUSER = axi_gmem_b_if.BUSER;
    initial begin
        uvm_config_db #( virtual axi_if#(64,64,8,3,1) )::set(null, "uvm_test_top.top_env.axi_master_gmem_b.*", "vif", axi_gmem_b_if);
    end


    axi_if #(64,64,8,3,1)  axi_gmem_c_if (.clk  (apatb_matmul_full_contiguous_top.AESL_clock), .rst(apatb_matmul_full_contiguous_top.AESL_reset));
    assign axi_gmem_c_if.AWVALID = apatb_matmul_full_contiguous_top.gmem_c_AWVALID;
    assign apatb_matmul_full_contiguous_top.gmem_c_AWREADY = axi_gmem_c_if.AWREADY;
    assign axi_gmem_c_if.AWADDR = apatb_matmul_full_contiguous_top.gmem_c_AWADDR;
    assign axi_gmem_c_if.AWID = apatb_matmul_full_contiguous_top.gmem_c_AWID;
    assign axi_gmem_c_if.AWLEN = apatb_matmul_full_contiguous_top.gmem_c_AWLEN;
    assign axi_gmem_c_if.AWSIZE = apatb_matmul_full_contiguous_top.gmem_c_AWSIZE;
    assign axi_gmem_c_if.AWBURST = apatb_matmul_full_contiguous_top.gmem_c_AWBURST;
    assign axi_gmem_c_if.AWLOCK = apatb_matmul_full_contiguous_top.gmem_c_AWLOCK;
    assign axi_gmem_c_if.AWCACHE = apatb_matmul_full_contiguous_top.gmem_c_AWCACHE;
    assign axi_gmem_c_if.AWPROT = apatb_matmul_full_contiguous_top.gmem_c_AWPROT;
    assign axi_gmem_c_if.AWQOS = apatb_matmul_full_contiguous_top.gmem_c_AWQOS;
    assign axi_gmem_c_if.AWREGION = apatb_matmul_full_contiguous_top.gmem_c_AWREGION;
    assign axi_gmem_c_if.AWUSER = apatb_matmul_full_contiguous_top.gmem_c_AWUSER;
    assign axi_gmem_c_if.WVALID = apatb_matmul_full_contiguous_top.gmem_c_WVALID;
    assign apatb_matmul_full_contiguous_top.gmem_c_WREADY = axi_gmem_c_if.WREADY;
    assign axi_gmem_c_if.WDATA = apatb_matmul_full_contiguous_top.gmem_c_WDATA;
    assign axi_gmem_c_if.WSTRB = apatb_matmul_full_contiguous_top.gmem_c_WSTRB;
    assign axi_gmem_c_if.WLAST = apatb_matmul_full_contiguous_top.gmem_c_WLAST;
    assign axi_gmem_c_if.WID = apatb_matmul_full_contiguous_top.gmem_c_WID;
    assign axi_gmem_c_if.WUSER = apatb_matmul_full_contiguous_top.gmem_c_WUSER;
    assign axi_gmem_c_if.ARVALID = apatb_matmul_full_contiguous_top.gmem_c_ARVALID;
    assign apatb_matmul_full_contiguous_top.gmem_c_ARREADY = axi_gmem_c_if.ARREADY;
    assign axi_gmem_c_if.ARADDR = apatb_matmul_full_contiguous_top.gmem_c_ARADDR;
    assign axi_gmem_c_if.ARID = apatb_matmul_full_contiguous_top.gmem_c_ARID;
    assign axi_gmem_c_if.ARLEN = apatb_matmul_full_contiguous_top.gmem_c_ARLEN;
    assign axi_gmem_c_if.ARSIZE = apatb_matmul_full_contiguous_top.gmem_c_ARSIZE;
    assign axi_gmem_c_if.ARBURST = apatb_matmul_full_contiguous_top.gmem_c_ARBURST;
    assign axi_gmem_c_if.ARLOCK = apatb_matmul_full_contiguous_top.gmem_c_ARLOCK;
    assign axi_gmem_c_if.ARCACHE = apatb_matmul_full_contiguous_top.gmem_c_ARCACHE;
    assign axi_gmem_c_if.ARPROT = apatb_matmul_full_contiguous_top.gmem_c_ARPROT;
    assign axi_gmem_c_if.ARQOS = apatb_matmul_full_contiguous_top.gmem_c_ARQOS;
    assign axi_gmem_c_if.ARREGION = apatb_matmul_full_contiguous_top.gmem_c_ARREGION;
    assign axi_gmem_c_if.ARUSER = apatb_matmul_full_contiguous_top.gmem_c_ARUSER;
    assign apatb_matmul_full_contiguous_top.gmem_c_RVALID = axi_gmem_c_if.RVALID;
    assign axi_gmem_c_if.RREADY = apatb_matmul_full_contiguous_top.gmem_c_RREADY;
    assign apatb_matmul_full_contiguous_top.gmem_c_RDATA = axi_gmem_c_if.RDATA;
    assign apatb_matmul_full_contiguous_top.gmem_c_RLAST = axi_gmem_c_if.RLAST;
    assign apatb_matmul_full_contiguous_top.gmem_c_RID = axi_gmem_c_if.RID;
    assign apatb_matmul_full_contiguous_top.gmem_c_RUSER = axi_gmem_c_if.RUSER;
    assign apatb_matmul_full_contiguous_top.gmem_c_RRESP = axi_gmem_c_if.RRESP;
    assign apatb_matmul_full_contiguous_top.gmem_c_BVALID = axi_gmem_c_if.BVALID;
    assign axi_gmem_c_if.BREADY = apatb_matmul_full_contiguous_top.gmem_c_BREADY;
    assign apatb_matmul_full_contiguous_top.gmem_c_BRESP = axi_gmem_c_if.BRESP;
    assign apatb_matmul_full_contiguous_top.gmem_c_BID = axi_gmem_c_if.BID;
    assign apatb_matmul_full_contiguous_top.gmem_c_BUSER = axi_gmem_c_if.BUSER;
    initial begin
        uvm_config_db #( virtual axi_if#(64,64,8,3,1) )::set(null, "uvm_test_top.top_env.axi_master_gmem_c.*", "vif", axi_gmem_c_if);
    end


    axi_if #(6,4,4,3,1)  axi_control_if (.clk  (apatb_matmul_full_contiguous_top.AESL_clock), .rst(apatb_matmul_full_contiguous_top.AESL_reset));
    assign apatb_matmul_full_contiguous_top.control_AWADDR = axi_control_if.AWADDR;
    assign apatb_matmul_full_contiguous_top.control_AWVALID = axi_control_if.AWVALID;
    assign axi_control_if.AWREADY = apatb_matmul_full_contiguous_top.control_AWREADY;
    assign apatb_matmul_full_contiguous_top.control_WVALID = axi_control_if.WVALID;
    assign axi_control_if.WREADY = apatb_matmul_full_contiguous_top.control_WREADY;
    assign apatb_matmul_full_contiguous_top.control_WDATA = axi_control_if.WDATA;
    assign apatb_matmul_full_contiguous_top.control_WSTRB = axi_control_if.WSTRB;
    assign apatb_matmul_full_contiguous_top.control_ARADDR = axi_control_if.ARADDR;
    assign apatb_matmul_full_contiguous_top.control_ARVALID = axi_control_if.ARVALID;
    assign axi_control_if.ARREADY = apatb_matmul_full_contiguous_top.control_ARREADY;
    assign axi_control_if.RVALID = apatb_matmul_full_contiguous_top.control_RVALID;
    assign apatb_matmul_full_contiguous_top.control_RREADY = axi_control_if.RREADY;
    assign axi_control_if.RDATA = apatb_matmul_full_contiguous_top.control_RDATA;
    assign axi_control_if.RRESP = apatb_matmul_full_contiguous_top.control_RRESP;
    assign axi_control_if.BVALID = apatb_matmul_full_contiguous_top.control_BVALID;
    assign apatb_matmul_full_contiguous_top.control_BREADY = axi_control_if.BREADY;
    assign axi_control_if.BRESP = apatb_matmul_full_contiguous_top.control_BRESP;
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
