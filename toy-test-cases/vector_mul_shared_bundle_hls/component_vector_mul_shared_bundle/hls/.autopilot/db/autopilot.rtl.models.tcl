set SynModuleInfo {
  {SRCNAME vector_mul MODELNAME vector_mul RTLNAME vector_mul IS_TOP 1
    SUBMODULES {
      {MODELNAME vector_mul_mul_32s_32s_32_1_1 RTLNAME vector_mul_mul_32s_32s_32_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME vector_mul_gmem_m_axi RTLNAME vector_mul_gmem_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME vector_mul_control_s_axi RTLNAME vector_mul_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
      {MODELNAME vector_mul_flow_control_loop_pipe RTLNAME vector_mul_flow_control_loop_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME vector_mul_flow_control_loop_pipe_U}
    }
  }
}
