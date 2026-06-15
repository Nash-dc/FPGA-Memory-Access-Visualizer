# This script segment is generated automatically by AutoPilot

set name matmul_full_contiguous_mul_32s_32s_32_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


set name matmul_full_contiguous_mul_6ns_8ns_13_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set name matmul_full_contiguous_mul_7ns_9ns_15_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE {op} TYPE {sparsemux} IMPL {compactencoding_dontcare}
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
    id 97 \
    name A_local \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename A_local \
    op interface \
    ports { A_local_address0 { O 5 vector } A_local_ce0 { O 1 bit } A_local_q0 { I 32 vector } A_local_address1 { O 5 vector } A_local_ce1 { O 1 bit } A_local_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 98 \
    name A_local_1 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename A_local_1 \
    op interface \
    ports { A_local_1_address0 { O 5 vector } A_local_1_ce0 { O 1 bit } A_local_1_q0 { I 32 vector } A_local_1_address1 { O 5 vector } A_local_1_ce1 { O 1 bit } A_local_1_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_1'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 99 \
    name A_local_2 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename A_local_2 \
    op interface \
    ports { A_local_2_address0 { O 5 vector } A_local_2_ce0 { O 1 bit } A_local_2_q0 { I 32 vector } A_local_2_address1 { O 5 vector } A_local_2_ce1 { O 1 bit } A_local_2_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_2'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 100 \
    name A_local_3 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename A_local_3 \
    op interface \
    ports { A_local_3_address0 { O 5 vector } A_local_3_ce0 { O 1 bit } A_local_3_q0 { I 32 vector } A_local_3_address1 { O 5 vector } A_local_3_ce1 { O 1 bit } A_local_3_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_3'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 101 \
    name A_local_4 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename A_local_4 \
    op interface \
    ports { A_local_4_address0 { O 5 vector } A_local_4_ce0 { O 1 bit } A_local_4_q0 { I 32 vector } A_local_4_address1 { O 5 vector } A_local_4_ce1 { O 1 bit } A_local_4_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_4'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 102 \
    name A_local_5 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename A_local_5 \
    op interface \
    ports { A_local_5_address0 { O 5 vector } A_local_5_ce0 { O 1 bit } A_local_5_q0 { I 32 vector } A_local_5_address1 { O 5 vector } A_local_5_ce1 { O 1 bit } A_local_5_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_5'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 103 \
    name A_local_6 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename A_local_6 \
    op interface \
    ports { A_local_6_address0 { O 5 vector } A_local_6_ce0 { O 1 bit } A_local_6_q0 { I 32 vector } A_local_6_address1 { O 5 vector } A_local_6_ce1 { O 1 bit } A_local_6_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_6'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 104 \
    name A_local_7 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename A_local_7 \
    op interface \
    ports { A_local_7_address0 { O 5 vector } A_local_7_ce0 { O 1 bit } A_local_7_q0 { I 32 vector } A_local_7_address1 { O 5 vector } A_local_7_ce1 { O 1 bit } A_local_7_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'A_local_7'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 121 \
    name B_local \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local \
    op interface \
    ports { B_local_address0 { O 4 vector } B_local_ce0 { O 1 bit } B_local_q0 { I 32 vector } B_local_address1 { O 4 vector } B_local_ce1 { O 1 bit } B_local_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 122 \
    name B_local_1 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_1 \
    op interface \
    ports { B_local_1_address0 { O 4 vector } B_local_1_ce0 { O 1 bit } B_local_1_q0 { I 32 vector } B_local_1_address1 { O 4 vector } B_local_1_ce1 { O 1 bit } B_local_1_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_1'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 123 \
    name B_local_2 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_2 \
    op interface \
    ports { B_local_2_address0 { O 4 vector } B_local_2_ce0 { O 1 bit } B_local_2_q0 { I 32 vector } B_local_2_address1 { O 4 vector } B_local_2_ce1 { O 1 bit } B_local_2_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_2'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 124 \
    name B_local_3 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_3 \
    op interface \
    ports { B_local_3_address0 { O 4 vector } B_local_3_ce0 { O 1 bit } B_local_3_q0 { I 32 vector } B_local_3_address1 { O 4 vector } B_local_3_ce1 { O 1 bit } B_local_3_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_3'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 125 \
    name B_local_4 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_4 \
    op interface \
    ports { B_local_4_address0 { O 4 vector } B_local_4_ce0 { O 1 bit } B_local_4_q0 { I 32 vector } B_local_4_address1 { O 4 vector } B_local_4_ce1 { O 1 bit } B_local_4_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_4'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 126 \
    name B_local_5 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_5 \
    op interface \
    ports { B_local_5_address0 { O 4 vector } B_local_5_ce0 { O 1 bit } B_local_5_q0 { I 32 vector } B_local_5_address1 { O 4 vector } B_local_5_ce1 { O 1 bit } B_local_5_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_5'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 127 \
    name B_local_6 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_6 \
    op interface \
    ports { B_local_6_address0 { O 4 vector } B_local_6_ce0 { O 1 bit } B_local_6_q0 { I 32 vector } B_local_6_address1 { O 4 vector } B_local_6_ce1 { O 1 bit } B_local_6_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_6'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 128 \
    name B_local_7 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_7 \
    op interface \
    ports { B_local_7_address0 { O 4 vector } B_local_7_ce0 { O 1 bit } B_local_7_q0 { I 32 vector } B_local_7_address1 { O 4 vector } B_local_7_ce1 { O 1 bit } B_local_7_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_7'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 129 \
    name B_local_8 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_8 \
    op interface \
    ports { B_local_8_address0 { O 4 vector } B_local_8_ce0 { O 1 bit } B_local_8_q0 { I 32 vector } B_local_8_address1 { O 4 vector } B_local_8_ce1 { O 1 bit } B_local_8_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_8'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 130 \
    name B_local_9 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_9 \
    op interface \
    ports { B_local_9_address0 { O 4 vector } B_local_9_ce0 { O 1 bit } B_local_9_q0 { I 32 vector } B_local_9_address1 { O 4 vector } B_local_9_ce1 { O 1 bit } B_local_9_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_9'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 131 \
    name B_local_10 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_10 \
    op interface \
    ports { B_local_10_address0 { O 4 vector } B_local_10_ce0 { O 1 bit } B_local_10_q0 { I 32 vector } B_local_10_address1 { O 4 vector } B_local_10_ce1 { O 1 bit } B_local_10_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_10'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 132 \
    name B_local_11 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_11 \
    op interface \
    ports { B_local_11_address0 { O 4 vector } B_local_11_ce0 { O 1 bit } B_local_11_q0 { I 32 vector } B_local_11_address1 { O 4 vector } B_local_11_ce1 { O 1 bit } B_local_11_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_11'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 133 \
    name B_local_12 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_12 \
    op interface \
    ports { B_local_12_address0 { O 4 vector } B_local_12_ce0 { O 1 bit } B_local_12_q0 { I 32 vector } B_local_12_address1 { O 4 vector } B_local_12_ce1 { O 1 bit } B_local_12_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_12'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 134 \
    name B_local_13 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_13 \
    op interface \
    ports { B_local_13_address0 { O 4 vector } B_local_13_ce0 { O 1 bit } B_local_13_q0 { I 32 vector } B_local_13_address1 { O 4 vector } B_local_13_ce1 { O 1 bit } B_local_13_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_13'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 135 \
    name B_local_14 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_14 \
    op interface \
    ports { B_local_14_address0 { O 4 vector } B_local_14_ce0 { O 1 bit } B_local_14_q0 { I 32 vector } B_local_14_address1 { O 4 vector } B_local_14_ce1 { O 1 bit } B_local_14_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_14'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 136 \
    name B_local_16 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_16 \
    op interface \
    ports { B_local_16_address0 { O 4 vector } B_local_16_ce0 { O 1 bit } B_local_16_q0 { I 32 vector } B_local_16_address1 { O 4 vector } B_local_16_ce1 { O 1 bit } B_local_16_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_16'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 137 \
    name B_local_15 \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename B_local_15 \
    op interface \
    ports { B_local_15_address0 { O 4 vector } B_local_15_ce0 { O 1 bit } B_local_15_q0 { I 32 vector } B_local_15_address1 { O 4 vector } B_local_15_ce1 { O 1 bit } B_local_15_q1 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'B_local_15'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 138 \
    name C_local \
    reset_level 1 \
    sync_rst true \
    dir O \
    corename C_local \
    op interface \
    ports { C_local_address0 { O 8 vector } C_local_ce0 { O 1 bit } C_local_we0 { O 1 bit } C_local_d0 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'C_local'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 105 \
    name B_local_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_load \
    op interface \
    ports { B_local_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 106 \
    name B_local_1_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_1_load \
    op interface \
    ports { B_local_1_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 107 \
    name B_local_2_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_2_load \
    op interface \
    ports { B_local_2_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 108 \
    name B_local_3_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_3_load \
    op interface \
    ports { B_local_3_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 109 \
    name B_local_4_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_4_load \
    op interface \
    ports { B_local_4_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 110 \
    name B_local_5_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_5_load \
    op interface \
    ports { B_local_5_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 111 \
    name B_local_6_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_6_load \
    op interface \
    ports { B_local_6_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 112 \
    name B_local_7_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_7_load \
    op interface \
    ports { B_local_7_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 113 \
    name B_local_8_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_8_load \
    op interface \
    ports { B_local_8_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 114 \
    name B_local_9_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_9_load \
    op interface \
    ports { B_local_9_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 115 \
    name B_local_10_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_10_load \
    op interface \
    ports { B_local_10_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 116 \
    name B_local_11_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_11_load \
    op interface \
    ports { B_local_11_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 117 \
    name B_local_12_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_12_load \
    op interface \
    ports { B_local_12_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 118 \
    name B_local_13_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_13_load \
    op interface \
    ports { B_local_13_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 119 \
    name B_local_14_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_14_load \
    op interface \
    ports { B_local_14_load { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 120 \
    name B_local_15_load \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_B_local_15_load \
    op interface \
    ports { B_local_15_load { I 32 vector } } \
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


