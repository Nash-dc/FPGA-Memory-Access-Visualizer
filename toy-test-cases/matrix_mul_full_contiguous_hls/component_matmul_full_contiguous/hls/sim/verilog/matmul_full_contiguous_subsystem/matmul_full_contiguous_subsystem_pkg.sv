//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
//Tool Version Limit: 2025.05
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================
`timescale 1ns/1ps 

`ifndef MATMUL_FULL_CONTIGUOUS_SUBSYSTEM_PKG__SV          
    `define MATMUL_FULL_CONTIGUOUS_SUBSYSTEM_PKG__SV      
                                                     
    package matmul_full_contiguous_subsystem_pkg;               
                                                     
        import uvm_pkg::*;                           
        import file_agent_pkg::*;                    
        import axi_pkg::*;
                                                     
        `include "uvm_macros.svh"                  
                                                     
        `include "matmul_full_contiguous_config.sv"           
        `include "matmul_full_contiguous_reference_model.sv"  
        `include "matmul_full_contiguous_scoreboard.sv"       
        `include "matmul_full_contiguous_subsystem_monitor.sv"
        `include "matmul_full_contiguous_virtual_sequencer.sv"
        `include "matmul_full_contiguous_pkg_sequence_lib.sv" 
        `include "matmul_full_contiguous_env.sv"              
                                                     
    endpackage                                       
                                                     
`endif                                               
