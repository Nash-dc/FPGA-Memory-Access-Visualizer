// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
`timescale 1ns/1ps


`define AUTOTB_DUT      matmul_full_contiguous
`define AUTOTB_DUT_INST AESL_inst_matmul_full_contiguous
`define AUTOTB_TOP      apatb_matmul_full_contiguous_top
`define AUTOTB_LAT_RESULT_FILE "matmul_full_contiguous.result.lat.rb"
`define AUTOTB_PER_RESULT_TRANS_FILE "matmul_full_contiguous.performance.result.transaction.xml"
`define AUTOTB_TOP_INST AESL_inst_apatb_matmul_full_contiguous_top
`define AUTOTB_MAX_ALLOW_LATENCY  15000000
`define AUTOTB_CLOCK_PERIOD_DIV2 2.50

`define AESL_DEPTH_gmem_a 1
`define AESL_DEPTH_gmem_b 1
`define AESL_DEPTH_gmem_c 1
`define AESL_DEPTH_a 1
`define AESL_DEPTH_b 1
`define AESL_DEPTH_c 1
`define AUTOTB_TVIN_gmem_a  "../tv/cdatafile/c.matmul_full_contiguous.autotvin_gmem_a.dat"
`define AUTOTB_TVIN_gmem_b  "../tv/cdatafile/c.matmul_full_contiguous.autotvin_gmem_b.dat"
`define AUTOTB_TVIN_a  "../tv/cdatafile/c.matmul_full_contiguous.autotvin_a.dat"
`define AUTOTB_TVIN_b  "../tv/cdatafile/c.matmul_full_contiguous.autotvin_b.dat"
`define AUTOTB_TVIN_c  "../tv/cdatafile/c.matmul_full_contiguous.autotvin_c.dat"
`define AUTOTB_TVIN_gmem_a_out_wrapc  "../tv/rtldatafile/rtl.matmul_full_contiguous.autotvin_gmem_a.dat"
`define AUTOTB_TVIN_gmem_b_out_wrapc  "../tv/rtldatafile/rtl.matmul_full_contiguous.autotvin_gmem_b.dat"
`define AUTOTB_TVIN_a_out_wrapc  "../tv/rtldatafile/rtl.matmul_full_contiguous.autotvin_a.dat"
`define AUTOTB_TVIN_b_out_wrapc  "../tv/rtldatafile/rtl.matmul_full_contiguous.autotvin_b.dat"
`define AUTOTB_TVIN_c_out_wrapc  "../tv/rtldatafile/rtl.matmul_full_contiguous.autotvin_c.dat"
`define AUTOTB_TVOUT_gmem_c  "../tv/cdatafile/c.matmul_full_contiguous.autotvout_gmem_c.dat"
`define AUTOTB_TVOUT_gmem_c_out_wrapc  "../tv/rtldatafile/rtl.matmul_full_contiguous.autotvout_gmem_c.dat"
module `AUTOTB_TOP;

parameter AUTOTB_TRANSACTION_NUM = 1;
parameter PROGRESS_TIMEOUT = 10000000;
parameter LATENCY_ESTIMATION = 801;
parameter LENGTH_a = 1;
parameter LENGTH_b = 1;
parameter LENGTH_c = 1;
parameter LENGTH_gmem_a = 16;
parameter LENGTH_gmem_b = 16;
parameter LENGTH_gmem_c = 16;

reg AESL_clock;
reg rst;
reg dut_rst;
reg start;
reg ce;
reg tb_continue;
wire AESL_start;
wire AESL_reset;
wire AESL_ce;
wire AESL_ready;
wire AESL_idle;
wire AESL_continue;
wire AESL_done;
reg AESL_done_delay = 0;
reg AESL_done_delay2 = 0;
reg AESL_ready_delay = 0;
wire ready;
wire ready_wire;
wire [5 : 0] control_AWADDR;
wire  control_AWVALID;
wire  control_AWREADY;
wire  control_WVALID;
wire  control_WREADY;
wire [31 : 0] control_WDATA;
wire [3 : 0] control_WSTRB;
wire [5 : 0] control_ARADDR;
wire  control_ARVALID;
wire  control_ARREADY;
wire  control_RVALID;
wire  control_RREADY;
wire [31 : 0] control_RDATA;
wire [1 : 0] control_RRESP;
wire  control_BVALID;
wire  control_BREADY;
wire [1 : 0] control_BRESP;
wire  control_INTERRUPT;
wire  gmem_a_AWVALID;
wire  gmem_a_AWREADY;
wire [63 : 0] gmem_a_AWADDR;
wire [0 : 0] gmem_a_AWID;
wire [7 : 0] gmem_a_AWLEN;
wire [2 : 0] gmem_a_AWSIZE;
wire [1 : 0] gmem_a_AWBURST;
wire [1 : 0] gmem_a_AWLOCK;
wire [3 : 0] gmem_a_AWCACHE;
wire [2 : 0] gmem_a_AWPROT;
wire [3 : 0] gmem_a_AWQOS;
wire [3 : 0] gmem_a_AWREGION;
wire [0 : 0] gmem_a_AWUSER;
wire  gmem_a_WVALID;
wire  gmem_a_WREADY;
wire [511 : 0] gmem_a_WDATA;
wire [63 : 0] gmem_a_WSTRB;
wire  gmem_a_WLAST;
wire [0 : 0] gmem_a_WID;
wire [0 : 0] gmem_a_WUSER;
wire  gmem_a_ARVALID;
wire  gmem_a_ARREADY;
wire [63 : 0] gmem_a_ARADDR;
wire [0 : 0] gmem_a_ARID;
wire [7 : 0] gmem_a_ARLEN;
wire [2 : 0] gmem_a_ARSIZE;
wire [1 : 0] gmem_a_ARBURST;
wire [1 : 0] gmem_a_ARLOCK;
wire [3 : 0] gmem_a_ARCACHE;
wire [2 : 0] gmem_a_ARPROT;
wire [3 : 0] gmem_a_ARQOS;
wire [3 : 0] gmem_a_ARREGION;
wire [0 : 0] gmem_a_ARUSER;
wire  gmem_a_RVALID;
wire  gmem_a_RREADY;
wire [511 : 0] gmem_a_RDATA;
wire  gmem_a_RLAST;
wire [0 : 0] gmem_a_RID;
wire [0 : 0] gmem_a_RUSER;
wire [1 : 0] gmem_a_RRESP;
wire  gmem_a_BVALID;
wire  gmem_a_BREADY;
wire [1 : 0] gmem_a_BRESP;
wire [0 : 0] gmem_a_BID;
wire [0 : 0] gmem_a_BUSER;
wire  gmem_b_AWVALID;
wire  gmem_b_AWREADY;
wire [63 : 0] gmem_b_AWADDR;
wire [0 : 0] gmem_b_AWID;
wire [7 : 0] gmem_b_AWLEN;
wire [2 : 0] gmem_b_AWSIZE;
wire [1 : 0] gmem_b_AWBURST;
wire [1 : 0] gmem_b_AWLOCK;
wire [3 : 0] gmem_b_AWCACHE;
wire [2 : 0] gmem_b_AWPROT;
wire [3 : 0] gmem_b_AWQOS;
wire [3 : 0] gmem_b_AWREGION;
wire [0 : 0] gmem_b_AWUSER;
wire  gmem_b_WVALID;
wire  gmem_b_WREADY;
wire [511 : 0] gmem_b_WDATA;
wire [63 : 0] gmem_b_WSTRB;
wire  gmem_b_WLAST;
wire [0 : 0] gmem_b_WID;
wire [0 : 0] gmem_b_WUSER;
wire  gmem_b_ARVALID;
wire  gmem_b_ARREADY;
wire [63 : 0] gmem_b_ARADDR;
wire [0 : 0] gmem_b_ARID;
wire [7 : 0] gmem_b_ARLEN;
wire [2 : 0] gmem_b_ARSIZE;
wire [1 : 0] gmem_b_ARBURST;
wire [1 : 0] gmem_b_ARLOCK;
wire [3 : 0] gmem_b_ARCACHE;
wire [2 : 0] gmem_b_ARPROT;
wire [3 : 0] gmem_b_ARQOS;
wire [3 : 0] gmem_b_ARREGION;
wire [0 : 0] gmem_b_ARUSER;
wire  gmem_b_RVALID;
wire  gmem_b_RREADY;
wire [511 : 0] gmem_b_RDATA;
wire  gmem_b_RLAST;
wire [0 : 0] gmem_b_RID;
wire [0 : 0] gmem_b_RUSER;
wire [1 : 0] gmem_b_RRESP;
wire  gmem_b_BVALID;
wire  gmem_b_BREADY;
wire [1 : 0] gmem_b_BRESP;
wire [0 : 0] gmem_b_BID;
wire [0 : 0] gmem_b_BUSER;
wire  gmem_c_AWVALID;
wire  gmem_c_AWREADY;
wire [63 : 0] gmem_c_AWADDR;
wire [0 : 0] gmem_c_AWID;
wire [7 : 0] gmem_c_AWLEN;
wire [2 : 0] gmem_c_AWSIZE;
wire [1 : 0] gmem_c_AWBURST;
wire [1 : 0] gmem_c_AWLOCK;
wire [3 : 0] gmem_c_AWCACHE;
wire [2 : 0] gmem_c_AWPROT;
wire [3 : 0] gmem_c_AWQOS;
wire [3 : 0] gmem_c_AWREGION;
wire [0 : 0] gmem_c_AWUSER;
wire  gmem_c_WVALID;
wire  gmem_c_WREADY;
wire [511 : 0] gmem_c_WDATA;
wire [63 : 0] gmem_c_WSTRB;
wire  gmem_c_WLAST;
wire [0 : 0] gmem_c_WID;
wire [0 : 0] gmem_c_WUSER;
wire  gmem_c_ARVALID;
wire  gmem_c_ARREADY;
wire [63 : 0] gmem_c_ARADDR;
wire [0 : 0] gmem_c_ARID;
wire [7 : 0] gmem_c_ARLEN;
wire [2 : 0] gmem_c_ARSIZE;
wire [1 : 0] gmem_c_ARBURST;
wire [1 : 0] gmem_c_ARLOCK;
wire [3 : 0] gmem_c_ARCACHE;
wire [2 : 0] gmem_c_ARPROT;
wire [3 : 0] gmem_c_ARQOS;
wire [3 : 0] gmem_c_ARREGION;
wire [0 : 0] gmem_c_ARUSER;
wire  gmem_c_RVALID;
wire  gmem_c_RREADY;
wire [511 : 0] gmem_c_RDATA;
wire  gmem_c_RLAST;
wire [0 : 0] gmem_c_RID;
wire [0 : 0] gmem_c_RUSER;
wire [1 : 0] gmem_c_RRESP;
wire  gmem_c_BVALID;
wire  gmem_c_BREADY;
wire [1 : 0] gmem_c_BRESP;
wire [0 : 0] gmem_c_BID;
wire [0 : 0] gmem_c_BUSER;
integer done_cnt = 0;
integer AESL_ready_cnt = 0;
integer ready_cnt = 0;
reg ready_initial;
reg ready_initial_n;
reg ready_last_n;
reg ready_delay_last_n;
reg done_delay_last_n;
reg interface_done = 0;
wire control_write_data_finish;
wire AESL_slave_start;
reg AESL_slave_start_lock = 0;
wire AESL_slave_write_start_in;
wire AESL_slave_write_start_finish;
reg AESL_slave_ready;
wire AESL_slave_output_done;
wire AESL_slave_done;
reg ready_rise = 0;
reg start_rise = 0;
reg slave_start_status = 0;
reg slave_done_status = 0;
reg ap_done_lock = 0;


wire all_finish;
wire ap_clk;
wire ap_rst_n;
wire ap_rst_n_n;

`AUTOTB_DUT `AUTOTB_DUT_INST(
    .s_axi_control_AWADDR(control_AWADDR),
    .s_axi_control_AWVALID(control_AWVALID),
    .s_axi_control_AWREADY(control_AWREADY),
    .s_axi_control_WVALID(control_WVALID),
    .s_axi_control_WREADY(control_WREADY),
    .s_axi_control_WDATA(control_WDATA),
    .s_axi_control_WSTRB(control_WSTRB),
    .s_axi_control_ARADDR(control_ARADDR),
    .s_axi_control_ARVALID(control_ARVALID),
    .s_axi_control_ARREADY(control_ARREADY),
    .s_axi_control_RVALID(control_RVALID),
    .s_axi_control_RREADY(control_RREADY),
    .s_axi_control_RDATA(control_RDATA),
    .s_axi_control_RRESP(control_RRESP),
    .s_axi_control_BVALID(control_BVALID),
    .s_axi_control_BREADY(control_BREADY),
    .s_axi_control_BRESP(control_BRESP),
    .interrupt(control_INTERRUPT),
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .m_axi_gmem_a_AWVALID(gmem_a_AWVALID),
    .m_axi_gmem_a_AWREADY(gmem_a_AWREADY),
    .m_axi_gmem_a_AWADDR(gmem_a_AWADDR),
    .m_axi_gmem_a_AWID(gmem_a_AWID),
    .m_axi_gmem_a_AWLEN(gmem_a_AWLEN),
    .m_axi_gmem_a_AWSIZE(gmem_a_AWSIZE),
    .m_axi_gmem_a_AWBURST(gmem_a_AWBURST),
    .m_axi_gmem_a_AWLOCK(gmem_a_AWLOCK),
    .m_axi_gmem_a_AWCACHE(gmem_a_AWCACHE),
    .m_axi_gmem_a_AWPROT(gmem_a_AWPROT),
    .m_axi_gmem_a_AWQOS(gmem_a_AWQOS),
    .m_axi_gmem_a_AWREGION(gmem_a_AWREGION),
    .m_axi_gmem_a_AWUSER(gmem_a_AWUSER),
    .m_axi_gmem_a_WVALID(gmem_a_WVALID),
    .m_axi_gmem_a_WREADY(gmem_a_WREADY),
    .m_axi_gmem_a_WDATA(gmem_a_WDATA),
    .m_axi_gmem_a_WSTRB(gmem_a_WSTRB),
    .m_axi_gmem_a_WLAST(gmem_a_WLAST),
    .m_axi_gmem_a_WID(gmem_a_WID),
    .m_axi_gmem_a_WUSER(gmem_a_WUSER),
    .m_axi_gmem_a_ARVALID(gmem_a_ARVALID),
    .m_axi_gmem_a_ARREADY(gmem_a_ARREADY),
    .m_axi_gmem_a_ARADDR(gmem_a_ARADDR),
    .m_axi_gmem_a_ARID(gmem_a_ARID),
    .m_axi_gmem_a_ARLEN(gmem_a_ARLEN),
    .m_axi_gmem_a_ARSIZE(gmem_a_ARSIZE),
    .m_axi_gmem_a_ARBURST(gmem_a_ARBURST),
    .m_axi_gmem_a_ARLOCK(gmem_a_ARLOCK),
    .m_axi_gmem_a_ARCACHE(gmem_a_ARCACHE),
    .m_axi_gmem_a_ARPROT(gmem_a_ARPROT),
    .m_axi_gmem_a_ARQOS(gmem_a_ARQOS),
    .m_axi_gmem_a_ARREGION(gmem_a_ARREGION),
    .m_axi_gmem_a_ARUSER(gmem_a_ARUSER),
    .m_axi_gmem_a_RVALID(gmem_a_RVALID),
    .m_axi_gmem_a_RREADY(gmem_a_RREADY),
    .m_axi_gmem_a_RDATA(gmem_a_RDATA),
    .m_axi_gmem_a_RLAST(gmem_a_RLAST),
    .m_axi_gmem_a_RID(gmem_a_RID),
    .m_axi_gmem_a_RUSER(gmem_a_RUSER),
    .m_axi_gmem_a_RRESP(gmem_a_RRESP),
    .m_axi_gmem_a_BVALID(gmem_a_BVALID),
    .m_axi_gmem_a_BREADY(gmem_a_BREADY),
    .m_axi_gmem_a_BRESP(gmem_a_BRESP),
    .m_axi_gmem_a_BID(gmem_a_BID),
    .m_axi_gmem_a_BUSER(gmem_a_BUSER),
    .m_axi_gmem_b_AWVALID(gmem_b_AWVALID),
    .m_axi_gmem_b_AWREADY(gmem_b_AWREADY),
    .m_axi_gmem_b_AWADDR(gmem_b_AWADDR),
    .m_axi_gmem_b_AWID(gmem_b_AWID),
    .m_axi_gmem_b_AWLEN(gmem_b_AWLEN),
    .m_axi_gmem_b_AWSIZE(gmem_b_AWSIZE),
    .m_axi_gmem_b_AWBURST(gmem_b_AWBURST),
    .m_axi_gmem_b_AWLOCK(gmem_b_AWLOCK),
    .m_axi_gmem_b_AWCACHE(gmem_b_AWCACHE),
    .m_axi_gmem_b_AWPROT(gmem_b_AWPROT),
    .m_axi_gmem_b_AWQOS(gmem_b_AWQOS),
    .m_axi_gmem_b_AWREGION(gmem_b_AWREGION),
    .m_axi_gmem_b_AWUSER(gmem_b_AWUSER),
    .m_axi_gmem_b_WVALID(gmem_b_WVALID),
    .m_axi_gmem_b_WREADY(gmem_b_WREADY),
    .m_axi_gmem_b_WDATA(gmem_b_WDATA),
    .m_axi_gmem_b_WSTRB(gmem_b_WSTRB),
    .m_axi_gmem_b_WLAST(gmem_b_WLAST),
    .m_axi_gmem_b_WID(gmem_b_WID),
    .m_axi_gmem_b_WUSER(gmem_b_WUSER),
    .m_axi_gmem_b_ARVALID(gmem_b_ARVALID),
    .m_axi_gmem_b_ARREADY(gmem_b_ARREADY),
    .m_axi_gmem_b_ARADDR(gmem_b_ARADDR),
    .m_axi_gmem_b_ARID(gmem_b_ARID),
    .m_axi_gmem_b_ARLEN(gmem_b_ARLEN),
    .m_axi_gmem_b_ARSIZE(gmem_b_ARSIZE),
    .m_axi_gmem_b_ARBURST(gmem_b_ARBURST),
    .m_axi_gmem_b_ARLOCK(gmem_b_ARLOCK),
    .m_axi_gmem_b_ARCACHE(gmem_b_ARCACHE),
    .m_axi_gmem_b_ARPROT(gmem_b_ARPROT),
    .m_axi_gmem_b_ARQOS(gmem_b_ARQOS),
    .m_axi_gmem_b_ARREGION(gmem_b_ARREGION),
    .m_axi_gmem_b_ARUSER(gmem_b_ARUSER),
    .m_axi_gmem_b_RVALID(gmem_b_RVALID),
    .m_axi_gmem_b_RREADY(gmem_b_RREADY),
    .m_axi_gmem_b_RDATA(gmem_b_RDATA),
    .m_axi_gmem_b_RLAST(gmem_b_RLAST),
    .m_axi_gmem_b_RID(gmem_b_RID),
    .m_axi_gmem_b_RUSER(gmem_b_RUSER),
    .m_axi_gmem_b_RRESP(gmem_b_RRESP),
    .m_axi_gmem_b_BVALID(gmem_b_BVALID),
    .m_axi_gmem_b_BREADY(gmem_b_BREADY),
    .m_axi_gmem_b_BRESP(gmem_b_BRESP),
    .m_axi_gmem_b_BID(gmem_b_BID),
    .m_axi_gmem_b_BUSER(gmem_b_BUSER),
    .m_axi_gmem_c_AWVALID(gmem_c_AWVALID),
    .m_axi_gmem_c_AWREADY(gmem_c_AWREADY),
    .m_axi_gmem_c_AWADDR(gmem_c_AWADDR),
    .m_axi_gmem_c_AWID(gmem_c_AWID),
    .m_axi_gmem_c_AWLEN(gmem_c_AWLEN),
    .m_axi_gmem_c_AWSIZE(gmem_c_AWSIZE),
    .m_axi_gmem_c_AWBURST(gmem_c_AWBURST),
    .m_axi_gmem_c_AWLOCK(gmem_c_AWLOCK),
    .m_axi_gmem_c_AWCACHE(gmem_c_AWCACHE),
    .m_axi_gmem_c_AWPROT(gmem_c_AWPROT),
    .m_axi_gmem_c_AWQOS(gmem_c_AWQOS),
    .m_axi_gmem_c_AWREGION(gmem_c_AWREGION),
    .m_axi_gmem_c_AWUSER(gmem_c_AWUSER),
    .m_axi_gmem_c_WVALID(gmem_c_WVALID),
    .m_axi_gmem_c_WREADY(gmem_c_WREADY),
    .m_axi_gmem_c_WDATA(gmem_c_WDATA),
    .m_axi_gmem_c_WSTRB(gmem_c_WSTRB),
    .m_axi_gmem_c_WLAST(gmem_c_WLAST),
    .m_axi_gmem_c_WID(gmem_c_WID),
    .m_axi_gmem_c_WUSER(gmem_c_WUSER),
    .m_axi_gmem_c_ARVALID(gmem_c_ARVALID),
    .m_axi_gmem_c_ARREADY(gmem_c_ARREADY),
    .m_axi_gmem_c_ARADDR(gmem_c_ARADDR),
    .m_axi_gmem_c_ARID(gmem_c_ARID),
    .m_axi_gmem_c_ARLEN(gmem_c_ARLEN),
    .m_axi_gmem_c_ARSIZE(gmem_c_ARSIZE),
    .m_axi_gmem_c_ARBURST(gmem_c_ARBURST),
    .m_axi_gmem_c_ARLOCK(gmem_c_ARLOCK),
    .m_axi_gmem_c_ARCACHE(gmem_c_ARCACHE),
    .m_axi_gmem_c_ARPROT(gmem_c_ARPROT),
    .m_axi_gmem_c_ARQOS(gmem_c_ARQOS),
    .m_axi_gmem_c_ARREGION(gmem_c_ARREGION),
    .m_axi_gmem_c_ARUSER(gmem_c_ARUSER),
    .m_axi_gmem_c_RVALID(gmem_c_RVALID),
    .m_axi_gmem_c_RREADY(gmem_c_RREADY),
    .m_axi_gmem_c_RDATA(gmem_c_RDATA),
    .m_axi_gmem_c_RLAST(gmem_c_RLAST),
    .m_axi_gmem_c_RID(gmem_c_RID),
    .m_axi_gmem_c_RUSER(gmem_c_RUSER),
    .m_axi_gmem_c_RRESP(gmem_c_RRESP),
    .m_axi_gmem_c_BVALID(gmem_c_BVALID),
    .m_axi_gmem_c_BREADY(gmem_c_BREADY),
    .m_axi_gmem_c_BRESP(gmem_c_BRESP),
    .m_axi_gmem_c_BID(gmem_c_BID),
    .m_axi_gmem_c_BUSER(gmem_c_BUSER));
assign ap_clk = AESL_clock;
assign ap_rst_n = AESL_reset;
assign ap_rst_n_n = ~AESL_reset;
assign AESL_reset = dut_rst;
assign AESL_start = svtb_top.misc_if.tb2dut_ap_start;
assign AESL_ready = svtb_top.misc_if.dut2tb_ap_ready;
assign AESL_done  = svtb_top.misc_if.dut2tb_ap_done;
assign all_finish = svtb_top.misc_if.finished;
initial begin : initial_process
    integer proc_rand;
    rst = 0;
    # 100;
    repeat(0+3) @ (posedge AESL_clock);
    # 0.1;
    rst = 1;
end
initial begin : initial_process_for_dut_rst
    integer proc_rand;
    dut_rst = 0;
    # 100;
    repeat(3) @ (posedge AESL_clock);
    # 0.1;
    dut_rst = 1;
end
initial begin
    AESL_clock = 0;
    forever #`AUTOTB_CLOCK_PERIOD_DIV2 AESL_clock = ~AESL_clock;
end

    sv_module_top svtb_top();

////////////////////////////////////////////
// progress and performance
////////////////////////////////////////////

task wait_start();
    while (~AESL_start) begin
        @ (posedge AESL_clock);
    end
endtask

reg [31:0] clk_cnt = 0;
reg AESL_ready_p1;
reg AESL_start_p1;

always @ (posedge AESL_clock) begin
    if (AESL_reset == 0) begin
        clk_cnt <= 32'h0;
        AESL_ready_p1 <= 1'b0;
        AESL_start_p1 <= 1'b0;
    end
    else begin
        clk_cnt <= clk_cnt + 1;
        AESL_ready_p1 <= AESL_ready;
        AESL_start_p1 <= AESL_start;
    end
end

reg [31:0] start_timestamp [0:AUTOTB_TRANSACTION_NUM - 1];
reg [31:0] start_cnt;
reg [31:0] ready_timestamp [0:AUTOTB_TRANSACTION_NUM - 1];
reg [31:0] ap_ready_cnt;
reg [31:0] finish_timestamp [0:AUTOTB_TRANSACTION_NUM - 1];
reg [31:0] finish_cnt;
reg [31:0] lat_total;
event report_progress;

always @(posedge AESL_clock)
begin
    if (finish_cnt == AUTOTB_TRANSACTION_NUM - 1 && AESL_done == 1'b1)
        lat_total = clk_cnt - start_timestamp[0];
end

initial begin
    start_cnt = 0;
    finish_cnt = 0;
    ap_ready_cnt = 0;
    wait (AESL_reset == 1);
    wait_start();
    start_timestamp[start_cnt] = clk_cnt;
    start_cnt = start_cnt + 1;
    if (AESL_done) begin
        finish_timestamp[finish_cnt] = clk_cnt;
        finish_cnt = finish_cnt + 1;
    end
    -> report_progress;
    forever begin
        @ (posedge AESL_clock);
        if (start_cnt < AUTOTB_TRANSACTION_NUM) begin
            if ((AESL_start && AESL_ready_p1)||(AESL_start && ~AESL_start_p1)) begin
                start_timestamp[start_cnt] = clk_cnt;
                start_cnt = start_cnt + 1;
            end
        end
        if (ap_ready_cnt < AUTOTB_TRANSACTION_NUM) begin
            if (AESL_start_p1 && AESL_ready_p1) begin
                ready_timestamp[ap_ready_cnt] = clk_cnt;
                ap_ready_cnt = ap_ready_cnt + 1;
            end
        end
        if (finish_cnt < AUTOTB_TRANSACTION_NUM) begin
            if (AESL_done) begin
                finish_timestamp[finish_cnt] = clk_cnt;
                finish_cnt = finish_cnt + 1;
            end
        end
        -> report_progress;
    end
end

reg [31:0] progress_timeout;

initial begin : simulation_progress
    real intra_progress;
    wait (AESL_reset == 1);
    progress_timeout = PROGRESS_TIMEOUT;
    $display("////////////////////////////////////////////////////////////////////////////////////");
    $display("// Inter-Transaction Progress: Completed Transaction / Total Transaction");
    $display("// Intra-Transaction Progress: Measured Latency / Latency Estimation * 100%%");
    $display("//");
    $display("// RTL Simulation : \"Inter-Transaction Progress\" [\"Intra-Transaction Progress\"] @ \"Simulation Time\"");
    $display("////////////////////////////////////////////////////////////////////////////////////");
    print_progress();
    while (finish_cnt < AUTOTB_TRANSACTION_NUM) begin
        @ (report_progress);
        if (finish_cnt < AUTOTB_TRANSACTION_NUM) begin
            if (AESL_done) begin
                print_progress();
                progress_timeout = PROGRESS_TIMEOUT;
            end else begin
                if (progress_timeout == 0) begin
                    print_progress();
                    progress_timeout = PROGRESS_TIMEOUT;
                end else begin
                    progress_timeout = progress_timeout - 1;
                end
            end
        end
    end
    print_progress();
    $display("////////////////////////////////////////////////////////////////////////////////////");
    calculate_performance();
end

task get_intra_progress(output real intra_progress);
    begin
        if (start_cnt > finish_cnt) begin
            intra_progress = clk_cnt - start_timestamp[finish_cnt];
        end else if(finish_cnt > 0) begin
            intra_progress = LATENCY_ESTIMATION;
        end else begin
            intra_progress = 0;
        end
        intra_progress = intra_progress / LATENCY_ESTIMATION;
    end
endtask

task print_progress();
    real intra_progress;
    begin
        if (LATENCY_ESTIMATION > 0) begin
            get_intra_progress(intra_progress);
            $display("// RTL Simulation : %0d / %0d [%2.2f%%] @ \"%0t\"", finish_cnt, AUTOTB_TRANSACTION_NUM, intra_progress * 100, $time);
        end else begin
            $display("// RTL Simulation : %0d / %0d [n/a] @ \"%0t\"", finish_cnt, AUTOTB_TRANSACTION_NUM, $time);
        end
    end
endtask

task calculate_performance();
    integer i;
    integer fp;
    reg [31:0] latency [0:AUTOTB_TRANSACTION_NUM - 1];
    reg [31:0] latency_min;
    reg [31:0] latency_max;
    reg [31:0] latency_total;
    reg [31:0] latency_average;
    reg [31:0] interval [0:AUTOTB_TRANSACTION_NUM - 2];
    reg [31:0] interval_min;
    reg [31:0] interval_max;
    reg [31:0] interval_total;
    reg [31:0] interval_average;
    reg [31:0] total_execute_time;
    begin
        latency_min = -1;
        latency_max = 0;
        latency_total = 0;
        interval_min = -1;
        interval_max = 0;
        interval_total = 0;
        total_execute_time = lat_total;

        for (i = 0; i < AUTOTB_TRANSACTION_NUM; i = i + 1) begin
            // calculate latency
            latency[i] = finish_timestamp[i] - start_timestamp[i];
            if (latency[i] > latency_max) latency_max = latency[i];
            if (latency[i] < latency_min) latency_min = latency[i];
            latency_total = latency_total + latency[i];
            // calculate interval
            if (AUTOTB_TRANSACTION_NUM == 1) begin
                interval[i] = 0;
                interval_max = 0;
                interval_min = 0;
                interval_total = 0;
            end else if (i < AUTOTB_TRANSACTION_NUM - 1) begin
                interval[i] = start_timestamp[i + 1] - start_timestamp[i];
                if (interval[i] > interval_max) interval_max = interval[i];
                if (interval[i] < interval_min) interval_min = interval[i];
                interval_total = interval_total + interval[i];
            end
        end

        latency_average = latency_total / AUTOTB_TRANSACTION_NUM;
        if (AUTOTB_TRANSACTION_NUM == 1) begin
            interval_average = 0;
        end else begin
            interval_average = interval_total / (AUTOTB_TRANSACTION_NUM - 1);
        end

        fp = $fopen(`AUTOTB_LAT_RESULT_FILE, "w");

        $fdisplay(fp, "$MAX_LATENCY = \"%0d\"", latency_max);
        $fdisplay(fp, "$MIN_LATENCY = \"%0d\"", latency_min);
        $fdisplay(fp, "$AVER_LATENCY = \"%0d\"", latency_average);
        $fdisplay(fp, "$MAX_THROUGHPUT = \"%0d\"", interval_max);
        $fdisplay(fp, "$MIN_THROUGHPUT = \"%0d\"", interval_min);
        $fdisplay(fp, "$AVER_THROUGHPUT = \"%0d\"", interval_average);
        $fdisplay(fp, "$TOTAL_EXECUTE_TIME = \"%0d\"", total_execute_time);

        $fclose(fp);

        fp = $fopen(`AUTOTB_PER_RESULT_TRANS_FILE, "w");

        $fdisplay(fp, "%20s%16s%16s", "", "latency", "interval");
        if (AUTOTB_TRANSACTION_NUM == 1) begin
            i = 0;
            $fdisplay(fp, "transaction%8d:%16d%16d", i, latency[i], interval[i]);
        end else begin
            for (i = 0; i < AUTOTB_TRANSACTION_NUM; i = i + 1) begin
                if (i < AUTOTB_TRANSACTION_NUM - 1) begin
                    $fdisplay(fp, "transaction%8d:%16d%16d", i, latency[i], interval[i]);
                end else begin
                    $fdisplay(fp, "transaction%8d:%16d               x", i, latency[i]);
                end
            end
        end

        $fclose(fp);
    end
endtask


////////////////////////////////////////////
// Dependence Check
////////////////////////////////////////////

`ifndef POST_SYN

`endif
///////////////////////////////////////////////////////
// dataflow status monitor
///////////////////////////////////////////////////////
dataflow_monitor U_dataflow_monitor(
    .clock(AESL_clock),
    .reset(~rst),
    .finish(all_finish));

`include "fifo_para.vh"
endmodule
