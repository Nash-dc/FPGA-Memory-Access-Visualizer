set SynModuleInfo {
  {SRCNAME Loop_VITIS_LOOP_72_1_proc MODELNAME Loop_VITIS_LOOP_72_1_proc RTLNAME read_only_Loop_VITIS_LOOP_72_1_proc
    SUBMODULES {
      {MODELNAME read_only_flow_control_loop_delay_pipe RTLNAME read_only_flow_control_loop_delay_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME read_only_flow_control_loop_delay_pipe_U}
    }
  }
  {SRCNAME Block_entry_proc MODELNAME Block_entry_proc RTLNAME read_only_Block_entry_proc}
  {SRCNAME Loop_VITIS_LOOP_76_2_proc MODELNAME Loop_VITIS_LOOP_76_2_proc RTLNAME read_only_Loop_VITIS_LOOP_76_2_proc}
  {SRCNAME sum MODELNAME sum RTLNAME read_only_sum
    SUBMODULES {
      {MODELNAME read_only_mul_32s_32s_32_5_1 RTLNAME read_only_mul_32s_32s_32_5_1 BINDTYPE op TYPE mul IMPL auto LATENCY 4 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME read_only MODELNAME read_only RTLNAME read_only IS_TOP 1
    SUBMODULES {
      {MODELNAME read_only_fifo_w32_d2_S RTLNAME read_only_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME stream_U}
      {MODELNAME read_only_fifo_w64_d2_S RTLNAME read_only_fifo_w64_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME p_loc_channel_U}
      {MODELNAME read_only_fifo_w32_d2_S RTLNAME read_only_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME stream_1_U}
      {MODELNAME read_only_mem_0_m_axi RTLNAME read_only_mem_0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME read_only_mem_1_m_axi RTLNAME read_only_mem_1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME read_only_control_s_axi RTLNAME read_only_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
