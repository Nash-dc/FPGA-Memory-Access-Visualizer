
log_wave -r /
set designtopgroup [add_wave_group "Design Top Signals"]
set cinoutgroup [add_wave_group "C InOuts" -into $designtopgroup]
set mem_1_r_group [add_wave_group mem_1_r(axi_master) -into $cinoutgroup]
set rdata_group [add_wave_group "Read Channel" -into $mem_1_r_group]
set wdata_group [add_wave_group "Write Channel" -into $mem_1_r_group]
set ctrl_group [add_wave_group "Handshakes" -into $mem_1_r_group]
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_BUSER -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_BID -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_BRESP -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_BREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_BVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_RRESP -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_RUSER -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_RID -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_RLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_RDATA -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_RREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_RVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARUSER -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARREGION -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARQOS -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARPROT -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARCACHE -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARLOCK -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARBURST -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARSIZE -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARLEN -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARID -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARADDR -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_ARVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_WUSER -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_WID -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_WLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_WSTRB -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_WDATA -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_WREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_WVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWUSER -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWREGION -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWQOS -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWPROT -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWCACHE -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWLOCK -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWBURST -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWSIZE -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWLEN -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWID -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWADDR -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_1_AWVALID -into $ctrl_group -color #ffff00 -radix hex
set mem_0_r_group [add_wave_group mem_0_r(axi_master) -into $cinoutgroup]
set rdata_group [add_wave_group "Read Channel" -into $mem_0_r_group]
set wdata_group [add_wave_group "Write Channel" -into $mem_0_r_group]
set ctrl_group [add_wave_group "Handshakes" -into $mem_0_r_group]
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_BUSER -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_BID -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_BRESP -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_BREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_BVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_RRESP -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_RUSER -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_RID -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_RLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_RDATA -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_RREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_RVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARUSER -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARREGION -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARQOS -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARPROT -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARCACHE -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARLOCK -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARBURST -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARSIZE -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARLEN -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARID -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARADDR -into $rdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_ARVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_WUSER -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_WID -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_WLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_WSTRB -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_WDATA -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_WREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_WVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWUSER -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWREGION -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWQOS -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWPROT -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWCACHE -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWLOCK -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWBURST -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWSIZE -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWLEN -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWID -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWADDR -into $wdata_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/m_axi_mem_0_AWVALID -into $ctrl_group -color #ffff00 -radix hex
set mem_0_r__mem_1_r__return_group [add_wave_group mem_0_r__mem_1_r__return(axi_slave) -into $cinoutgroup]
add_wave /apatb_read_write_top/AESL_inst_read_write/interrupt -into $mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_BRESP -into $mem_0_r__mem_1_r__return_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_BREADY -into $mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_BVALID -into $mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_RRESP -into $mem_0_r__mem_1_r__return_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_RDATA -into $mem_0_r__mem_1_r__return_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_RREADY -into $mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_RVALID -into $mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_ARREADY -into $mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_ARVALID -into $mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_ARADDR -into $mem_0_r__mem_1_r__return_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_WSTRB -into $mem_0_r__mem_1_r__return_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_WDATA -into $mem_0_r__mem_1_r__return_group -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_WREADY -into $mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_WVALID -into $mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_AWREADY -into $mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_AWVALID -into $mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/AESL_inst_read_write/s_axi_control_AWADDR -into $mem_0_r__mem_1_r__return_group -radix hex
set resetgroup [add_wave_group "Reset" -into $designtopgroup]
add_wave /apatb_read_write_top/AESL_inst_read_write/ap_rst_n -into $resetgroup
set clockgroup [add_wave_group "Clock" -into $designtopgroup]
add_wave /apatb_read_write_top/AESL_inst_read_write/ap_clk -into $clockgroup
set testbenchgroup [add_wave_group "Test Bench Signals"]
set tbinternalsiggroup [add_wave_group "Internal Signals" -into $testbenchgroup]
set tb_simstatus_group [add_wave_group "Simulation Status" -into $tbinternalsiggroup]
set tb_portdepth_group [add_wave_group "Port Depth" -into $tbinternalsiggroup]
add_wave /apatb_read_write_top/AUTOTB_TRANSACTION_NUM -into $tb_simstatus_group -radix hex
add_wave /apatb_read_write_top/ready_cnt -into $tb_simstatus_group -radix hex
add_wave /apatb_read_write_top/done_cnt -into $tb_simstatus_group -radix hex
add_wave /apatb_read_write_top/LENGTH_mem_0 -into $tb_portdepth_group -radix hex
add_wave /apatb_read_write_top/LENGTH_mem_0_r -into $tb_portdepth_group -radix hex
add_wave /apatb_read_write_top/LENGTH_mem_1 -into $tb_portdepth_group -radix hex
add_wave /apatb_read_write_top/LENGTH_mem_1_r -into $tb_portdepth_group -radix hex
set tbcinoutgroup [add_wave_group "C InOuts" -into $testbenchgroup]
set tb_mem_1_r_group [add_wave_group mem_1_r(axi_master) -into $tbcinoutgroup]
set rdata_group [add_wave_group "Read Channel" -into $tb_mem_1_r_group]
set wdata_group [add_wave_group "Write Channel" -into $tb_mem_1_r_group]
set ctrl_group [add_wave_group "Handshakes" -into $tb_mem_1_r_group]
add_wave /apatb_read_write_top/mem_1_BUSER -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_BID -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_BRESP -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_BREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_1_BVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_1_RRESP -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_RUSER -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_RID -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_RLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_1_RDATA -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_RREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_1_RVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_1_ARUSER -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_ARREGION -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_ARQOS -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_ARPROT -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_ARCACHE -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_ARLOCK -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_ARBURST -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_ARSIZE -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_ARLEN -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_ARID -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_ARADDR -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_ARREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_1_ARVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_1_WUSER -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_WID -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_WLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_1_WSTRB -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_WDATA -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_WREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_1_WVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_1_AWUSER -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_AWREGION -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_AWQOS -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_AWPROT -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_AWCACHE -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_AWLOCK -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_AWBURST -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_AWSIZE -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_AWLEN -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_AWID -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_AWADDR -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_1_AWREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_1_AWVALID -into $ctrl_group -color #ffff00 -radix hex
set tb_mem_0_r_group [add_wave_group mem_0_r(axi_master) -into $tbcinoutgroup]
set rdata_group [add_wave_group "Read Channel" -into $tb_mem_0_r_group]
set wdata_group [add_wave_group "Write Channel" -into $tb_mem_0_r_group]
set ctrl_group [add_wave_group "Handshakes" -into $tb_mem_0_r_group]
add_wave /apatb_read_write_top/mem_0_BUSER -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_BID -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_BRESP -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_BREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_0_BVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_0_RRESP -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_RUSER -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_RID -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_RLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_0_RDATA -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_RREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_0_RVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_0_ARUSER -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_ARREGION -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_ARQOS -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_ARPROT -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_ARCACHE -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_ARLOCK -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_ARBURST -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_ARSIZE -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_ARLEN -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_ARID -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_ARADDR -into $rdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_ARREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_0_ARVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_0_WUSER -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_WID -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_WLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_0_WSTRB -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_WDATA -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_WREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_0_WVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_0_AWUSER -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_AWREGION -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_AWQOS -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_AWPROT -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_AWCACHE -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_AWLOCK -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_AWBURST -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_AWSIZE -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_AWLEN -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_AWID -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_AWADDR -into $wdata_group -radix hex
add_wave /apatb_read_write_top/mem_0_AWREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/mem_0_AWVALID -into $ctrl_group -color #ffff00 -radix hex
set tb_mem_0_r__mem_1_r__return_group [add_wave_group mem_0_r__mem_1_r__return(axi_slave) -into $tbcinoutgroup]
add_wave /apatb_read_write_top/control_INTERRUPT -into $tb_mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/control_BRESP -into $tb_mem_0_r__mem_1_r__return_group -radix hex
add_wave /apatb_read_write_top/control_BREADY -into $tb_mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/control_BVALID -into $tb_mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/control_RRESP -into $tb_mem_0_r__mem_1_r__return_group -radix hex
add_wave /apatb_read_write_top/control_RDATA -into $tb_mem_0_r__mem_1_r__return_group -radix hex
add_wave /apatb_read_write_top/control_RREADY -into $tb_mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/control_RVALID -into $tb_mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/control_ARREADY -into $tb_mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/control_ARVALID -into $tb_mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/control_ARADDR -into $tb_mem_0_r__mem_1_r__return_group -radix hex
add_wave /apatb_read_write_top/control_WSTRB -into $tb_mem_0_r__mem_1_r__return_group -radix hex
add_wave /apatb_read_write_top/control_WDATA -into $tb_mem_0_r__mem_1_r__return_group -radix hex
add_wave /apatb_read_write_top/control_WREADY -into $tb_mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/control_WVALID -into $tb_mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/control_AWREADY -into $tb_mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/control_AWVALID -into $tb_mem_0_r__mem_1_r__return_group -color #ffff00 -radix hex
add_wave /apatb_read_write_top/control_AWADDR -into $tb_mem_0_r__mem_1_r__return_group -radix hex
save_wave_config read_write.wcfg
run all
quit

