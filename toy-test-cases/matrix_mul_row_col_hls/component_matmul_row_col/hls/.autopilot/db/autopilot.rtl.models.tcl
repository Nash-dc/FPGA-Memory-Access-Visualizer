set SynModuleInfo {
  {SRCNAME matmul_row_col_Pipeline_load_ab_loop MODELNAME matmul_row_col_Pipeline_load_ab_loop RTLNAME matmul_row_col_matmul_row_col_Pipeline_load_ab_loop
    SUBMODULES {
      {MODELNAME matmul_row_col_partselect_32ns_512ns_9ns_32_1_1 RTLNAME matmul_row_col_partselect_32ns_512ns_9ns_32_1_1 BINDTYPE op TYPE partselect IMPL auto}
      {MODELNAME matmul_row_col_flow_control_loop_pipe_sequential_init RTLNAME matmul_row_col_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME matmul_row_col_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME matmul_row_col_Pipeline_compute_element_loop MODELNAME matmul_row_col_Pipeline_compute_element_loop RTLNAME matmul_row_col_matmul_row_col_Pipeline_compute_element_loop
    SUBMODULES {
      {MODELNAME matmul_row_col_mul_32s_32s_32_1_1 RTLNAME matmul_row_col_mul_32s_32s_32_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME matmul_row_col MODELNAME matmul_row_col RTLNAME matmul_row_col IS_TOP 1
    SUBMODULES {
      {MODELNAME matmul_row_col_A_row_RAM_AUTO_1R1W RTLNAME matmul_row_col_A_row_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME matmul_row_col_gmem_a_m_axi RTLNAME matmul_row_col_gmem_a_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME matmul_row_col_gmem_b_m_axi RTLNAME matmul_row_col_gmem_b_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME matmul_row_col_gmem_c_m_axi RTLNAME matmul_row_col_gmem_c_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME matmul_row_col_control_s_axi RTLNAME matmul_row_col_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
