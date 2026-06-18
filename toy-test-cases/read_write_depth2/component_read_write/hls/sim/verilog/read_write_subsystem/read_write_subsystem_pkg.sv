//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
//Tool Version Limit: 2025.05
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================
`timescale 1ns/1ps 

`ifndef READ_WRITE_SUBSYSTEM_PKG__SV          
    `define READ_WRITE_SUBSYSTEM_PKG__SV      
                                                     
    package read_write_subsystem_pkg;               
                                                     
        import uvm_pkg::*;                           
        import file_agent_pkg::*;                    
        import axi_pkg::*;
                                                     
        `include "uvm_macros.svh"                  
                                                     
        `include "read_write_config.sv"           
        `include "read_write_reference_model.sv"  
        `include "read_write_scoreboard.sv"       
        `include "read_write_subsystem_monitor.sv"
        `include "read_write_virtual_sequencer.sv"
        `include "read_write_pkg_sequence_lib.sv" 
        `include "read_write_env.sv"              
                                                     
    endpackage                                       
                                                     
`endif                                               
