# This script segment is generated automatically by AutoPilot

set name matmul_full_contiguous_mul_8ns_10ns_17_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 5 \
    name B_local \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local \
    op interface \
    ports { B_local_address0 { O 4 vector } B_local_ce0 { O 1 bit } B_local_we0 { O 1 bit } B_local_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 6 \
    name B_local_1 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_1 \
    op interface \
    ports { B_local_1_address0 { O 4 vector } B_local_1_ce0 { O 1 bit } B_local_1_we0 { O 1 bit } B_local_1_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_1'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 7 \
    name B_local_2 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_2 \
    op interface \
    ports { B_local_2_address0 { O 4 vector } B_local_2_ce0 { O 1 bit } B_local_2_we0 { O 1 bit } B_local_2_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_2'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 8 \
    name B_local_3 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_3 \
    op interface \
    ports { B_local_3_address0 { O 4 vector } B_local_3_ce0 { O 1 bit } B_local_3_we0 { O 1 bit } B_local_3_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_3'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 9 \
    name B_local_4 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_4 \
    op interface \
    ports { B_local_4_address0 { O 4 vector } B_local_4_ce0 { O 1 bit } B_local_4_we0 { O 1 bit } B_local_4_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_4'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 10 \
    name B_local_5 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_5 \
    op interface \
    ports { B_local_5_address0 { O 4 vector } B_local_5_ce0 { O 1 bit } B_local_5_we0 { O 1 bit } B_local_5_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_5'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 11 \
    name B_local_6 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_6 \
    op interface \
    ports { B_local_6_address0 { O 4 vector } B_local_6_ce0 { O 1 bit } B_local_6_we0 { O 1 bit } B_local_6_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_6'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 12 \
    name B_local_7 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_7 \
    op interface \
    ports { B_local_7_address0 { O 4 vector } B_local_7_ce0 { O 1 bit } B_local_7_we0 { O 1 bit } B_local_7_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_7'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 13 \
    name B_local_8 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_8 \
    op interface \
    ports { B_local_8_address0 { O 4 vector } B_local_8_ce0 { O 1 bit } B_local_8_we0 { O 1 bit } B_local_8_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_8'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 14 \
    name B_local_9 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_9 \
    op interface \
    ports { B_local_9_address0 { O 4 vector } B_local_9_ce0 { O 1 bit } B_local_9_we0 { O 1 bit } B_local_9_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_9'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 15 \
    name B_local_10 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_10 \
    op interface \
    ports { B_local_10_address0 { O 4 vector } B_local_10_ce0 { O 1 bit } B_local_10_we0 { O 1 bit } B_local_10_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_10'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 16 \
    name B_local_11 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_11 \
    op interface \
    ports { B_local_11_address0 { O 4 vector } B_local_11_ce0 { O 1 bit } B_local_11_we0 { O 1 bit } B_local_11_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_11'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 17 \
    name B_local_12 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_12 \
    op interface \
    ports { B_local_12_address0 { O 4 vector } B_local_12_ce0 { O 1 bit } B_local_12_we0 { O 1 bit } B_local_12_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_12'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 18 \
    name B_local_13 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_13 \
    op interface \
    ports { B_local_13_address0 { O 4 vector } B_local_13_ce0 { O 1 bit } B_local_13_we0 { O 1 bit } B_local_13_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_13'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 19 \
    name B_local_14 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_14 \
    op interface \
    ports { B_local_14_address0 { O 4 vector } B_local_14_ce0 { O 1 bit } B_local_14_we0 { O 1 bit } B_local_14_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_14'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 20 \
    name B_local_15 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_15 \
    op interface \
    ports { B_local_15_address0 { O 4 vector } B_local_15_ce0 { O 1 bit } B_local_15_we0 { O 1 bit } B_local_15_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_15'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 21 \
    name B_local_16 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename B_local_16 \
    op interface \
    ports { B_local_16_address0 { O 4 vector } B_local_16_ce0 { O 1 bit } B_local_16_we0 { O 1 bit } B_local_16_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_16'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 22 \
    name A_local \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename A_local \
    op interface \
    ports { A_local_address0 { O 5 vector } A_local_ce0 { O 1 bit } A_local_we0 { O 1 bit } A_local_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 23 \
    name A_local_1 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename A_local_1 \
    op interface \
    ports { A_local_1_address0 { O 5 vector } A_local_1_ce0 { O 1 bit } A_local_1_we0 { O 1 bit } A_local_1_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_1'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 24 \
    name A_local_2 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename A_local_2 \
    op interface \
    ports { A_local_2_address0 { O 5 vector } A_local_2_ce0 { O 1 bit } A_local_2_we0 { O 1 bit } A_local_2_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_2'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 25 \
    name A_local_3 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename A_local_3 \
    op interface \
    ports { A_local_3_address0 { O 5 vector } A_local_3_ce0 { O 1 bit } A_local_3_we0 { O 1 bit } A_local_3_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_3'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 26 \
    name A_local_4 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename A_local_4 \
    op interface \
    ports { A_local_4_address0 { O 5 vector } A_local_4_ce0 { O 1 bit } A_local_4_we0 { O 1 bit } A_local_4_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_4'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 27 \
    name A_local_5 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename A_local_5 \
    op interface \
    ports { A_local_5_address0 { O 5 vector } A_local_5_ce0 { O 1 bit } A_local_5_we0 { O 1 bit } A_local_5_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_5'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 28 \
    name A_local_6 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename A_local_6 \
    op interface \
    ports { A_local_6_address0 { O 5 vector } A_local_6_ce0 { O 1 bit } A_local_6_we0 { O 1 bit } A_local_6_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_6'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 29 \
    name A_local_7 \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename A_local_7 \
    op interface \
    ports { A_local_7_address0 { O 5 vector } A_local_7_ce0 { O 1 bit } A_local_7_we0 { O 1 bit } A_local_7_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_7'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 3 \
    name gmem_b \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_gmem_b \
    op interface \
    ports { m_axi_gmem_b_0_AWVALID { O 1 bit } m_axi_gmem_b_0_AWREADY { I 1 bit } m_axi_gmem_b_0_AWADDR { O 64 vector } m_axi_gmem_b_0_AWID { O 1 vector } m_axi_gmem_b_0_AWLEN { O 32 vector } m_axi_gmem_b_0_AWSIZE { O 3 vector } m_axi_gmem_b_0_AWBURST { O 2 vector } m_axi_gmem_b_0_AWLOCK { O 2 vector } m_axi_gmem_b_0_AWCACHE { O 4 vector } m_axi_gmem_b_0_AWPROT { O 3 vector } m_axi_gmem_b_0_AWQOS { O 4 vector } m_axi_gmem_b_0_AWREGION { O 4 vector } m_axi_gmem_b_0_AWUSER { O 1 vector } m_axi_gmem_b_0_WVALID { O 1 bit } m_axi_gmem_b_0_WREADY { I 1 bit } m_axi_gmem_b_0_WDATA { O 512 vector } m_axi_gmem_b_0_WSTRB { O 64 vector } m_axi_gmem_b_0_WLAST { O 1 bit } m_axi_gmem_b_0_WID { O 1 vector } m_axi_gmem_b_0_WUSER { O 1 vector } m_axi_gmem_b_0_ARVALID { O 1 bit } m_axi_gmem_b_0_ARREADY { I 1 bit } m_axi_gmem_b_0_ARADDR { O 64 vector } m_axi_gmem_b_0_ARID { O 1 vector } m_axi_gmem_b_0_ARLEN { O 32 vector } m_axi_gmem_b_0_ARSIZE { O 3 vector } m_axi_gmem_b_0_ARBURST { O 2 vector } m_axi_gmem_b_0_ARLOCK { O 2 vector } m_axi_gmem_b_0_ARCACHE { O 4 vector } m_axi_gmem_b_0_ARPROT { O 3 vector } m_axi_gmem_b_0_ARQOS { O 4 vector } m_axi_gmem_b_0_ARREGION { O 4 vector } m_axi_gmem_b_0_ARUSER { O 1 vector } m_axi_gmem_b_0_RVALID { I 1 bit } m_axi_gmem_b_0_RREADY { O 1 bit } m_axi_gmem_b_0_RDATA { I 512 vector } m_axi_gmem_b_0_RLAST { I 1 bit } m_axi_gmem_b_0_RID { I 1 vector } m_axi_gmem_b_0_RFIFONUM { I 5 vector } m_axi_gmem_b_0_RUSER { I 1 vector } m_axi_gmem_b_0_RRESP { I 2 vector } m_axi_gmem_b_0_BVALID { I 1 bit } m_axi_gmem_b_0_BREADY { O 1 bit } m_axi_gmem_b_0_BRESP { I 2 vector } m_axi_gmem_b_0_BID { I 1 vector } m_axi_gmem_b_0_BUSER { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 4 \
    name gmem_a \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_gmem_a \
    op interface \
    ports { m_axi_gmem_a_0_AWVALID { O 1 bit } m_axi_gmem_a_0_AWREADY { I 1 bit } m_axi_gmem_a_0_AWADDR { O 64 vector } m_axi_gmem_a_0_AWID { O 1 vector } m_axi_gmem_a_0_AWLEN { O 32 vector } m_axi_gmem_a_0_AWSIZE { O 3 vector } m_axi_gmem_a_0_AWBURST { O 2 vector } m_axi_gmem_a_0_AWLOCK { O 2 vector } m_axi_gmem_a_0_AWCACHE { O 4 vector } m_axi_gmem_a_0_AWPROT { O 3 vector } m_axi_gmem_a_0_AWQOS { O 4 vector } m_axi_gmem_a_0_AWREGION { O 4 vector } m_axi_gmem_a_0_AWUSER { O 1 vector } m_axi_gmem_a_0_WVALID { O 1 bit } m_axi_gmem_a_0_WREADY { I 1 bit } m_axi_gmem_a_0_WDATA { O 512 vector } m_axi_gmem_a_0_WSTRB { O 64 vector } m_axi_gmem_a_0_WLAST { O 1 bit } m_axi_gmem_a_0_WID { O 1 vector } m_axi_gmem_a_0_WUSER { O 1 vector } m_axi_gmem_a_0_ARVALID { O 1 bit } m_axi_gmem_a_0_ARREADY { I 1 bit } m_axi_gmem_a_0_ARADDR { O 64 vector } m_axi_gmem_a_0_ARID { O 1 vector } m_axi_gmem_a_0_ARLEN { O 32 vector } m_axi_gmem_a_0_ARSIZE { O 3 vector } m_axi_gmem_a_0_ARBURST { O 2 vector } m_axi_gmem_a_0_ARLOCK { O 2 vector } m_axi_gmem_a_0_ARCACHE { O 4 vector } m_axi_gmem_a_0_ARPROT { O 3 vector } m_axi_gmem_a_0_ARQOS { O 4 vector } m_axi_gmem_a_0_ARREGION { O 4 vector } m_axi_gmem_a_0_ARUSER { O 1 vector } m_axi_gmem_a_0_RVALID { I 1 bit } m_axi_gmem_a_0_RREADY { O 1 bit } m_axi_gmem_a_0_RDATA { I 512 vector } m_axi_gmem_a_0_RLAST { I 1 bit } m_axi_gmem_a_0_RID { I 1 vector } m_axi_gmem_a_0_RFIFONUM { I 5 vector } m_axi_gmem_a_0_RUSER { I 1 vector } m_axi_gmem_a_0_RRESP { I 2 vector } m_axi_gmem_a_0_BVALID { I 1 bit } m_axi_gmem_a_0_BREADY { O 1 bit } m_axi_gmem_a_0_BRESP { I 2 vector } m_axi_gmem_a_0_BID { I 1 vector } m_axi_gmem_a_0_BUSER { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 30 \
    name sext_ln20 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_sext_ln20 \
    op interface \
    ports { sext_ln20 { I 58 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 31 \
    name sext_ln20_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_sext_ln20_1 \
    op interface \
    ports { sext_ln20_1 { I 58 vector } } \
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
set InstName matmul_full_contiguous_flow_control_loop_pipe_sequential_init_U
set CompName matmul_full_contiguous_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix matmul_full_contiguous_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


