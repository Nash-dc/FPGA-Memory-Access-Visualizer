# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 5 \
    name indvars_iv14 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_indvars_iv14 \
    op interface \
    ports { indvars_iv14 { I 64 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 6 \
    name mid \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_mid \
    op interface \
    ports { mid { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 7 \
    name left_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_left_1 \
    op interface \
    ports { left_1 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 8 \
    name gmem_scratch_b \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_gmem_scratch_b \
    op interface \
    ports { m_axi_gmem_scratch_b_0_AWVALID { O 1 bit } m_axi_gmem_scratch_b_0_AWREADY { I 1 bit } m_axi_gmem_scratch_b_0_AWADDR { O 64 vector } m_axi_gmem_scratch_b_0_AWID { O 1 vector } m_axi_gmem_scratch_b_0_AWLEN { O 32 vector } m_axi_gmem_scratch_b_0_AWSIZE { O 3 vector } m_axi_gmem_scratch_b_0_AWBURST { O 2 vector } m_axi_gmem_scratch_b_0_AWLOCK { O 2 vector } m_axi_gmem_scratch_b_0_AWCACHE { O 4 vector } m_axi_gmem_scratch_b_0_AWPROT { O 3 vector } m_axi_gmem_scratch_b_0_AWQOS { O 4 vector } m_axi_gmem_scratch_b_0_AWREGION { O 4 vector } m_axi_gmem_scratch_b_0_AWUSER { O 1 vector } m_axi_gmem_scratch_b_0_WVALID { O 1 bit } m_axi_gmem_scratch_b_0_WREADY { I 1 bit } m_axi_gmem_scratch_b_0_WDATA { O 32 vector } m_axi_gmem_scratch_b_0_WSTRB { O 4 vector } m_axi_gmem_scratch_b_0_WLAST { O 1 bit } m_axi_gmem_scratch_b_0_WID { O 1 vector } m_axi_gmem_scratch_b_0_WUSER { O 1 vector } m_axi_gmem_scratch_b_0_ARVALID { O 1 bit } m_axi_gmem_scratch_b_0_ARREADY { I 1 bit } m_axi_gmem_scratch_b_0_ARADDR { O 64 vector } m_axi_gmem_scratch_b_0_ARID { O 1 vector } m_axi_gmem_scratch_b_0_ARLEN { O 32 vector } m_axi_gmem_scratch_b_0_ARSIZE { O 3 vector } m_axi_gmem_scratch_b_0_ARBURST { O 2 vector } m_axi_gmem_scratch_b_0_ARLOCK { O 2 vector } m_axi_gmem_scratch_b_0_ARCACHE { O 4 vector } m_axi_gmem_scratch_b_0_ARPROT { O 3 vector } m_axi_gmem_scratch_b_0_ARQOS { O 4 vector } m_axi_gmem_scratch_b_0_ARREGION { O 4 vector } m_axi_gmem_scratch_b_0_ARUSER { O 1 vector } m_axi_gmem_scratch_b_0_RVALID { I 1 bit } m_axi_gmem_scratch_b_0_RREADY { O 1 bit } m_axi_gmem_scratch_b_0_RDATA { I 32 vector } m_axi_gmem_scratch_b_0_RLAST { I 1 bit } m_axi_gmem_scratch_b_0_RID { I 1 vector } m_axi_gmem_scratch_b_0_RFIFONUM { I 9 vector } m_axi_gmem_scratch_b_0_RUSER { I 1 vector } m_axi_gmem_scratch_b_0_RRESP { I 2 vector } m_axi_gmem_scratch_b_0_BVALID { I 1 bit } m_axi_gmem_scratch_b_0_BREADY { O 1 bit } m_axi_gmem_scratch_b_0_BRESP { I 2 vector } m_axi_gmem_scratch_b_0_BID { I 1 vector } m_axi_gmem_scratch_b_0_BUSER { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 9 \
    name right_r \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_right_r \
    op interface \
    ports { right_r { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10 \
    name gmem_scratch_a \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_gmem_scratch_a \
    op interface \
    ports { m_axi_gmem_scratch_a_0_AWVALID { O 1 bit } m_axi_gmem_scratch_a_0_AWREADY { I 1 bit } m_axi_gmem_scratch_a_0_AWADDR { O 64 vector } m_axi_gmem_scratch_a_0_AWID { O 1 vector } m_axi_gmem_scratch_a_0_AWLEN { O 32 vector } m_axi_gmem_scratch_a_0_AWSIZE { O 3 vector } m_axi_gmem_scratch_a_0_AWBURST { O 2 vector } m_axi_gmem_scratch_a_0_AWLOCK { O 2 vector } m_axi_gmem_scratch_a_0_AWCACHE { O 4 vector } m_axi_gmem_scratch_a_0_AWPROT { O 3 vector } m_axi_gmem_scratch_a_0_AWQOS { O 4 vector } m_axi_gmem_scratch_a_0_AWREGION { O 4 vector } m_axi_gmem_scratch_a_0_AWUSER { O 1 vector } m_axi_gmem_scratch_a_0_WVALID { O 1 bit } m_axi_gmem_scratch_a_0_WREADY { I 1 bit } m_axi_gmem_scratch_a_0_WDATA { O 32 vector } m_axi_gmem_scratch_a_0_WSTRB { O 4 vector } m_axi_gmem_scratch_a_0_WLAST { O 1 bit } m_axi_gmem_scratch_a_0_WID { O 1 vector } m_axi_gmem_scratch_a_0_WUSER { O 1 vector } m_axi_gmem_scratch_a_0_ARVALID { O 1 bit } m_axi_gmem_scratch_a_0_ARREADY { I 1 bit } m_axi_gmem_scratch_a_0_ARADDR { O 64 vector } m_axi_gmem_scratch_a_0_ARID { O 1 vector } m_axi_gmem_scratch_a_0_ARLEN { O 32 vector } m_axi_gmem_scratch_a_0_ARSIZE { O 3 vector } m_axi_gmem_scratch_a_0_ARBURST { O 2 vector } m_axi_gmem_scratch_a_0_ARLOCK { O 2 vector } m_axi_gmem_scratch_a_0_ARCACHE { O 4 vector } m_axi_gmem_scratch_a_0_ARPROT { O 3 vector } m_axi_gmem_scratch_a_0_ARQOS { O 4 vector } m_axi_gmem_scratch_a_0_ARREGION { O 4 vector } m_axi_gmem_scratch_a_0_ARUSER { O 1 vector } m_axi_gmem_scratch_a_0_RVALID { I 1 bit } m_axi_gmem_scratch_a_0_RREADY { O 1 bit } m_axi_gmem_scratch_a_0_RDATA { I 32 vector } m_axi_gmem_scratch_a_0_RLAST { I 1 bit } m_axi_gmem_scratch_a_0_RID { I 1 vector } m_axi_gmem_scratch_a_0_RFIFONUM { I 9 vector } m_axi_gmem_scratch_a_0_RUSER { I 1 vector } m_axi_gmem_scratch_a_0_RRESP { I 2 vector } m_axi_gmem_scratch_a_0_BVALID { I 1 bit } m_axi_gmem_scratch_a_0_BREADY { O 1 bit } m_axi_gmem_scratch_a_0_BRESP { I 2 vector } m_axi_gmem_scratch_a_0_BID { I 1 vector } m_axi_gmem_scratch_a_0_BUSER { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 11 \
    name scratch_b \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_scratch_b \
    op interface \
    ports { scratch_b { I 64 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 12 \
    name source_is_a \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_source_is_a \
    op interface \
    ports { source_is_a { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 13 \
    name scratch_a \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_scratch_a \
    op interface \
    ports { scratch_a { I 64 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


# flow_control definition:
set InstName merge_sort_offchip_hls_flow_control_loop_pipe_sequential_init_U
set CompName merge_sort_offchip_hls_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix merge_sort_offchip_hls_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


