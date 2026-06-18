set SynModuleInfo {
  {SRCNAME read MODELNAME read_r RTLNAME read_write_read_r
    SUBMODULES {
      {MODELNAME read_write_flow_control_loop_delay_pipe RTLNAME read_write_flow_control_loop_delay_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME read_write_flow_control_loop_delay_pipe_U}
    }
  }
  {SRCNAME read.1 MODELNAME read_1 RTLNAME read_write_read_1}
  {SRCNAME write MODELNAME write_r RTLNAME read_write_write_r
    SUBMODULES {
      {MODELNAME read_write_flow_control_loop_pipe RTLNAME read_write_flow_control_loop_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME read_write_flow_control_loop_pipe_U}
    }
  }
  {SRCNAME write.2 MODELNAME write_2 RTLNAME read_write_write_2}
  {SRCNAME read_write MODELNAME read_write RTLNAME read_write IS_TOP 1
    SUBMODULES {
      {MODELNAME read_write_fifo_w32_d2_S RTLNAME read_write_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME stream_U}
      {MODELNAME read_write_fifo_w64_d2_S RTLNAME read_write_fifo_w64_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME mem_0_r_c_U}
      {MODELNAME read_write_fifo_w32_d2_S RTLNAME read_write_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME stream_1_U}
      {MODELNAME read_write_fifo_w64_d2_S RTLNAME read_write_fifo_w64_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME mem_1_r_c_U}
      {MODELNAME read_write_start_for_write_U0 RTLNAME read_write_start_for_write_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_write_U0_U}
      {MODELNAME read_write_start_for_write_2_U0 RTLNAME read_write_start_for_write_2_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_write_2_U0_U}
      {MODELNAME read_write_mem_0_m_axi RTLNAME read_write_mem_0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME read_write_mem_1_m_axi RTLNAME read_write_mem_1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME read_write_control_s_axi RTLNAME read_write_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
