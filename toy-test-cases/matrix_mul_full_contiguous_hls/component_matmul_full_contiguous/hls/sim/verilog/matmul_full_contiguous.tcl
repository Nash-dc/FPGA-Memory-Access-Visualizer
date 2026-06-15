
log_wave -r /
set designtopgroup [add_wave_group "Design Top Signals"]
set cinoutgroup [add_wave_group "C InOuts" -into $designtopgroup]
set a__b__c__return_group [add_wave_group a__b__c__return(axi_slave) -into $cinoutgroup]
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/interrupt -into $a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_BRESP -into $a__b__c__return_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_BREADY -into $a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_BVALID -into $a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_RRESP -into $a__b__c__return_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_RDATA -into $a__b__c__return_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_RREADY -into $a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_RVALID -into $a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_ARREADY -into $a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_ARVALID -into $a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_ARADDR -into $a__b__c__return_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_WSTRB -into $a__b__c__return_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_WDATA -into $a__b__c__return_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_WREADY -into $a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_WVALID -into $a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_AWREADY -into $a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_AWVALID -into $a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/s_axi_control_AWADDR -into $a__b__c__return_group -radix hex
set coutputgroup [add_wave_group "C Outputs" -into $designtopgroup]
set c_group [add_wave_group c(axi_master) -into $coutputgroup]
set rdata_group [add_wave_group "Read Channel" -into $c_group]
set wdata_group [add_wave_group "Write Channel" -into $c_group]
set ctrl_group [add_wave_group "Handshakes" -into $c_group]
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_BUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_BID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_BRESP -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_BREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_BVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_RRESP -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_RUSER -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_RID -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_RLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_RDATA -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_RREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_RVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARUSER -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARREGION -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARQOS -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARPROT -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARCACHE -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARLOCK -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARBURST -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARSIZE -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARLEN -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARID -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARADDR -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_ARVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_WUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_WID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_WLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_WSTRB -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_WDATA -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_WREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_WVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWREGION -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWQOS -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWPROT -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWCACHE -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWLOCK -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWBURST -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWSIZE -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWLEN -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWADDR -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_c_AWVALID -into $ctrl_group -color #ffff00 -radix hex
set cinputgroup [add_wave_group "C Inputs" -into $designtopgroup]
set b_group [add_wave_group b(axi_master) -into $cinputgroup]
set rdata_group [add_wave_group "Read Channel" -into $b_group]
set wdata_group [add_wave_group "Write Channel" -into $b_group]
set ctrl_group [add_wave_group "Handshakes" -into $b_group]
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_BUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_BID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_BRESP -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_BREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_BVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_RRESP -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_RUSER -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_RID -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_RLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_RDATA -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_RREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_RVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARUSER -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARREGION -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARQOS -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARPROT -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARCACHE -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARLOCK -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARBURST -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARSIZE -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARLEN -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARID -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARADDR -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_ARVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_WUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_WID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_WLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_WSTRB -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_WDATA -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_WREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_WVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWREGION -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWQOS -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWPROT -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWCACHE -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWLOCK -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWBURST -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWSIZE -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWLEN -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWADDR -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_b_AWVALID -into $ctrl_group -color #ffff00 -radix hex
set a_group [add_wave_group a(axi_master) -into $cinputgroup]
set rdata_group [add_wave_group "Read Channel" -into $a_group]
set wdata_group [add_wave_group "Write Channel" -into $a_group]
set ctrl_group [add_wave_group "Handshakes" -into $a_group]
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_BUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_BID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_BRESP -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_BREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_BVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_RRESP -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_RUSER -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_RID -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_RLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_RDATA -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_RREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_RVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARUSER -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARREGION -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARQOS -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARPROT -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARCACHE -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARLOCK -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARBURST -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARSIZE -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARLEN -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARID -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARADDR -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_ARVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_WUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_WID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_WLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_WSTRB -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_WDATA -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_WREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_WVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWREGION -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWQOS -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWPROT -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWCACHE -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWLOCK -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWBURST -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWSIZE -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWLEN -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWADDR -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/m_axi_gmem_a_AWVALID -into $ctrl_group -color #ffff00 -radix hex
set blocksiggroup [add_wave_group "Block-level IO Handshake(internal)" -into $designtopgroup]
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/ap_done -into $blocksiggroup
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/ap_idle -into $blocksiggroup
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/ap_ready -into $blocksiggroup
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/ap_start -into $blocksiggroup
set resetgroup [add_wave_group "Reset" -into $designtopgroup]
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/ap_rst_n -into $resetgroup
set clockgroup [add_wave_group "Clock" -into $designtopgroup]
add_wave /apatb_matmul_full_contiguous_top/AESL_inst_matmul_full_contiguous/ap_clk -into $clockgroup
set testbenchgroup [add_wave_group "Test Bench Signals"]
set tbinternalsiggroup [add_wave_group "Internal Signals" -into $testbenchgroup]
set tb_simstatus_group [add_wave_group "Simulation Status" -into $tbinternalsiggroup]
set tb_portdepth_group [add_wave_group "Port Depth" -into $tbinternalsiggroup]
add_wave /apatb_matmul_full_contiguous_top/AUTOTB_TRANSACTION_NUM -into $tb_simstatus_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/ready_cnt -into $tb_simstatus_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/done_cnt -into $tb_simstatus_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/LENGTH_a -into $tb_portdepth_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/LENGTH_b -into $tb_portdepth_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/LENGTH_c -into $tb_portdepth_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/LENGTH_gmem_a -into $tb_portdepth_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/LENGTH_gmem_b -into $tb_portdepth_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/LENGTH_gmem_c -into $tb_portdepth_group -radix hex
set tbcinoutgroup [add_wave_group "C InOuts" -into $testbenchgroup]
set tb_a__b__c__return_group [add_wave_group a__b__c__return(axi_slave) -into $tbcinoutgroup]
add_wave /apatb_matmul_full_contiguous_top/control_INTERRUPT -into $tb_a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_BRESP -into $tb_a__b__c__return_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_BREADY -into $tb_a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_BVALID -into $tb_a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_RRESP -into $tb_a__b__c__return_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_RDATA -into $tb_a__b__c__return_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_RREADY -into $tb_a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_RVALID -into $tb_a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_ARREADY -into $tb_a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_ARVALID -into $tb_a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_ARADDR -into $tb_a__b__c__return_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_WSTRB -into $tb_a__b__c__return_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_WDATA -into $tb_a__b__c__return_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_WREADY -into $tb_a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_WVALID -into $tb_a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_AWREADY -into $tb_a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_AWVALID -into $tb_a__b__c__return_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/control_AWADDR -into $tb_a__b__c__return_group -radix hex
set tbcoutputgroup [add_wave_group "C Outputs" -into $testbenchgroup]
set tb_c_group [add_wave_group c(axi_master) -into $tbcoutputgroup]
set rdata_group [add_wave_group "Read Channel" -into $tb_c_group]
set wdata_group [add_wave_group "Write Channel" -into $tb_c_group]
set ctrl_group [add_wave_group "Handshakes" -into $tb_c_group]
add_wave /apatb_matmul_full_contiguous_top/gmem_c_BUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_BID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_BRESP -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_BREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_BVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_RRESP -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_RUSER -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_RID -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_RLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_RDATA -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_RREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_RVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARUSER -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARREGION -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARQOS -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARPROT -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARCACHE -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARLOCK -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARBURST -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARSIZE -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARLEN -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARID -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARADDR -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_ARVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_WUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_WID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_WLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_WSTRB -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_WDATA -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_WREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_WVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWREGION -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWQOS -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWPROT -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWCACHE -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWLOCK -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWBURST -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWSIZE -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWLEN -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWADDR -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_c_AWVALID -into $ctrl_group -color #ffff00 -radix hex
set tbcinputgroup [add_wave_group "C Inputs" -into $testbenchgroup]
set tb_b_group [add_wave_group b(axi_master) -into $tbcinputgroup]
set rdata_group [add_wave_group "Read Channel" -into $tb_b_group]
set wdata_group [add_wave_group "Write Channel" -into $tb_b_group]
set ctrl_group [add_wave_group "Handshakes" -into $tb_b_group]
add_wave /apatb_matmul_full_contiguous_top/gmem_b_BUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_BID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_BRESP -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_BREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_BVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_RRESP -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_RUSER -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_RID -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_RLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_RDATA -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_RREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_RVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARUSER -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARREGION -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARQOS -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARPROT -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARCACHE -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARLOCK -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARBURST -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARSIZE -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARLEN -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARID -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARADDR -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_ARVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_WUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_WID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_WLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_WSTRB -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_WDATA -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_WREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_WVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWREGION -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWQOS -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWPROT -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWCACHE -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWLOCK -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWBURST -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWSIZE -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWLEN -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWADDR -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_b_AWVALID -into $ctrl_group -color #ffff00 -radix hex
set tb_a_group [add_wave_group a(axi_master) -into $tbcinputgroup]
set rdata_group [add_wave_group "Read Channel" -into $tb_a_group]
set wdata_group [add_wave_group "Write Channel" -into $tb_a_group]
set ctrl_group [add_wave_group "Handshakes" -into $tb_a_group]
add_wave /apatb_matmul_full_contiguous_top/gmem_a_BUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_BID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_BRESP -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_BREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_BVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_RRESP -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_RUSER -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_RID -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_RLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_RDATA -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_RREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_RVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARUSER -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARREGION -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARQOS -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARPROT -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARCACHE -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARLOCK -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARBURST -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARSIZE -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARLEN -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARID -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARADDR -into $rdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_ARVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_WUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_WID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_WLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_WSTRB -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_WDATA -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_WREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_WVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWUSER -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWREGION -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWQOS -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWPROT -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWCACHE -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWLOCK -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWBURST -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWSIZE -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWLEN -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWID -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWADDR -into $wdata_group -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_matmul_full_contiguous_top/gmem_a_AWVALID -into $ctrl_group -color #ffff00 -radix hex
save_wave_config matmul_full_contiguous.wcfg
run all
quit

