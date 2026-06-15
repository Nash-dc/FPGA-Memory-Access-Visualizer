set SynModuleInfo {
  {SRCNAME merge_sort_offchip_hls_Pipeline_copy_input_to_scratch_a MODELNAME merge_sort_offchip_hls_Pipeline_copy_input_to_scratch_a RTLNAME merge_sort_offchip_hls_merge_sort_offchip_hls_Pipeline_copy_input_to_scratch_a
    SUBMODULES {
      {MODELNAME merge_sort_offchip_hls_flow_control_loop_pipe_sequential_init RTLNAME merge_sort_offchip_hls_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME merge_sort_offchip_hls_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME merge_sort_offchip_hls_Pipeline_merge_element_loop MODELNAME merge_sort_offchip_hls_Pipeline_merge_element_loop RTLNAME merge_sort_offchip_hls_merge_sort_offchip_hls_Pipeline_merge_element_loop}
  {SRCNAME merge_sort_offchip_hls_Pipeline_copy_result_to_out MODELNAME merge_sort_offchip_hls_Pipeline_copy_result_to_out RTLNAME merge_sort_offchip_hls_merge_sort_offchip_hls_Pipeline_copy_result_to_out}
  {SRCNAME merge_sort_offchip_hls MODELNAME merge_sort_offchip_hls RTLNAME merge_sort_offchip_hls IS_TOP 1
    SUBMODULES {
      {MODELNAME merge_sort_offchip_hls_gmem_in_m_axi RTLNAME merge_sort_offchip_hls_gmem_in_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME merge_sort_offchip_hls_gmem_scratch_a_m_axi RTLNAME merge_sort_offchip_hls_gmem_scratch_a_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME merge_sort_offchip_hls_gmem_scratch_b_m_axi RTLNAME merge_sort_offchip_hls_gmem_scratch_b_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME merge_sort_offchip_hls_gmem_out_m_axi RTLNAME merge_sort_offchip_hls_gmem_out_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME merge_sort_offchip_hls_control_s_axi RTLNAME merge_sort_offchip_hls_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
