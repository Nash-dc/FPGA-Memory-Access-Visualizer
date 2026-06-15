set SynModuleInfo {
  {SRCNAME matrix_mul_Pipeline_init_c_loop_init_c_col_loop MODELNAME matrix_mul_Pipeline_init_c_loop_init_c_col_loop RTLNAME matrix_mul_matrix_mul_Pipeline_init_c_loop_init_c_col_loop
    SUBMODULES {
      {MODELNAME matrix_mul_flow_control_loop_pipe_sequential_init RTLNAME matrix_mul_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME matrix_mul_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME matrix_mul_Pipeline_load_a_tile_row_loop_load_a_tile_lane_loop MODELNAME matrix_mul_Pipeline_load_a_tile_row_loop_load_a_tile_lane_loop RTLNAME matrix_mul_matrix_mul_Pipeline_load_a_tile_row_loop_load_a_tile_lane_loop}
  {SRCNAME matrix_mul_Pipeline_load_b_tile_lane_loop_load_b_tile_col_loop MODELNAME matrix_mul_Pipeline_load_b_tile_lane_loop_load_b_tile_col_loop RTLNAME matrix_mul_matrix_mul_Pipeline_load_b_tile_lane_loop_load_b_tile_col_loop}
  {SRCNAME matrix_mul_Pipeline_compute_row_loop_compute_col_loop MODELNAME matrix_mul_Pipeline_compute_row_loop_compute_col_loop RTLNAME matrix_mul_matrix_mul_Pipeline_compute_row_loop_compute_col_loop
    SUBMODULES {
      {MODELNAME matrix_mul_mul_32s_32s_32_1_1 RTLNAME matrix_mul_mul_32s_32s_32_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME matrix_mul_sparsemux_9_2_32_1_1 RTLNAME matrix_mul_sparsemux_9_2_32_1_1 BINDTYPE op TYPE sparsemux IMPL compactencoding_dontcare}
    }
  }
  {SRCNAME matrix_mul_Pipeline_store_c_loop MODELNAME matrix_mul_Pipeline_store_c_loop RTLNAME matrix_mul_matrix_mul_Pipeline_store_c_loop}
  {SRCNAME matrix_mul MODELNAME matrix_mul RTLNAME matrix_mul IS_TOP 1
    SUBMODULES {
      {MODELNAME matrix_mul_A_tile_RAM_AUTO_1R1W RTLNAME matrix_mul_A_tile_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME matrix_mul_C_local_RAM_AUTO_1R1W RTLNAME matrix_mul_C_local_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME matrix_mul_gmem_a_m_axi RTLNAME matrix_mul_gmem_a_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME matrix_mul_gmem_b_m_axi RTLNAME matrix_mul_gmem_b_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME matrix_mul_gmem_c_m_axi RTLNAME matrix_mul_gmem_c_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME matrix_mul_control_s_axi RTLNAME matrix_mul_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
