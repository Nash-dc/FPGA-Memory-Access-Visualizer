set SynModuleInfo {
  {SRCNAME merge_sort_hls_Pipeline_load_input_loop MODELNAME merge_sort_hls_Pipeline_load_input_loop RTLNAME merge_sort_hls_merge_sort_hls_Pipeline_load_input_loop
    SUBMODULES {
      {MODELNAME merge_sort_hls_flow_control_loop_pipe_sequential_init RTLNAME merge_sort_hls_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME merge_sort_hls_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME merge_sort_hls_Pipeline_merge_b_to_a_loop MODELNAME merge_sort_hls_Pipeline_merge_b_to_a_loop RTLNAME merge_sort_hls_merge_sort_hls_Pipeline_merge_b_to_a_loop}
  {SRCNAME merge_sort_hls_Pipeline_merge_a_to_b_loop MODELNAME merge_sort_hls_Pipeline_merge_a_to_b_loop RTLNAME merge_sort_hls_merge_sort_hls_Pipeline_merge_a_to_b_loop}
  {SRCNAME merge_sort_hls_Pipeline_store_output_loop MODELNAME merge_sort_hls_Pipeline_store_output_loop RTLNAME merge_sort_hls_merge_sort_hls_Pipeline_store_output_loop}
  {SRCNAME merge_sort_hls MODELNAME merge_sort_hls RTLNAME merge_sort_hls IS_TOP 1
    SUBMODULES {
      {MODELNAME merge_sort_hls_buffer_a_RAM_1WNR_AUTO_1R1W RTLNAME merge_sort_hls_buffer_a_RAM_1WNR_AUTO_1R1W BINDTYPE storage TYPE ram_1wnr IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME merge_sort_hls_gmem_in_m_axi RTLNAME merge_sort_hls_gmem_in_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME merge_sort_hls_gmem_out_m_axi RTLNAME merge_sort_hls_gmem_out_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME merge_sort_hls_control_s_axi RTLNAME merge_sort_hls_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
