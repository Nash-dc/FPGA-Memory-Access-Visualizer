set SynModuleInfo {
  {SRCNAME matmul_full_contiguous_Pipeline_load_ab_full_loop MODELNAME matmul_full_contiguous_Pipeline_load_ab_full_loop RTLNAME matmul_full_contiguous_matmul_full_contiguous_Pipeline_load_ab_full_loop
    SUBMODULES {
      {MODELNAME matmul_full_contiguous_mul_8ns_10ns_17_1_1 RTLNAME matmul_full_contiguous_mul_8ns_10ns_17_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME matmul_full_contiguous_flow_control_loop_pipe_sequential_init RTLNAME matmul_full_contiguous_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME matmul_full_contiguous_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME matmul_full_contiguous_Pipeline_compute_row_loop_compute_col_loop MODELNAME matmul_full_contiguous_Pipeline_compute_row_loop_compute_col_loop RTLNAME matmul_full_contiguous_matmul_full_contiguous_Pipeline_compute_row_loop_compute_col_loop
    SUBMODULES {
      {MODELNAME matmul_full_contiguous_mul_32s_32s_32_1_1 RTLNAME matmul_full_contiguous_mul_32s_32s_32_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME matmul_full_contiguous_sparsemux_33_4_32_1_1 RTLNAME matmul_full_contiguous_sparsemux_33_4_32_1_1 BINDTYPE op TYPE sparsemux IMPL compactencoding_dontcare}
      {MODELNAME matmul_full_contiguous_mul_6ns_8ns_13_1_1 RTLNAME matmul_full_contiguous_mul_6ns_8ns_13_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME matmul_full_contiguous_mul_7ns_9ns_15_1_1 RTLNAME matmul_full_contiguous_mul_7ns_9ns_15_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME matmul_full_contiguous_Pipeline_store_c_full_loop MODELNAME matmul_full_contiguous_Pipeline_store_c_full_loop RTLNAME matmul_full_contiguous_matmul_full_contiguous_Pipeline_store_c_full_loop}
  {SRCNAME matmul_full_contiguous MODELNAME matmul_full_contiguous RTLNAME matmul_full_contiguous IS_TOP 1
    SUBMODULES {
      {MODELNAME matmul_full_contiguous_A_local_RAM_AUTO_1R1W RTLNAME matmul_full_contiguous_A_local_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME matmul_full_contiguous_B_local_RAM_AUTO_1R1W RTLNAME matmul_full_contiguous_B_local_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME matmul_full_contiguous_C_local_RAM_AUTO_1R1W RTLNAME matmul_full_contiguous_C_local_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME matmul_full_contiguous_gmem_a_m_axi RTLNAME matmul_full_contiguous_gmem_a_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME matmul_full_contiguous_gmem_b_m_axi RTLNAME matmul_full_contiguous_gmem_b_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME matmul_full_contiguous_gmem_c_m_axi RTLNAME matmul_full_contiguous_gmem_c_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME matmul_full_contiguous_control_s_axi RTLNAME matmul_full_contiguous_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
