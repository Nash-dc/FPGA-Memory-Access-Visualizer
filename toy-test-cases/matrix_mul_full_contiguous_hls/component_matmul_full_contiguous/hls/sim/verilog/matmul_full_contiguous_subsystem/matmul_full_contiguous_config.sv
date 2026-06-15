//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
//Tool Version Limit: 2025.05
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================
`ifndef MATMUL_FULL_CONTIGUOUS_CONFIG__SV                        
    `define MATMUL_FULL_CONTIGUOUS_CONFIG__SV                    
                                                            
    class matmul_full_contiguous_config extends uvm_object;            
                                                            
        int check_ena;                                      
        int cover_ena;                                      
        axi_pkg::axi_cfg gmem_a_cfg;
        axi_pkg::axi_cfg gmem_b_cfg;
        axi_pkg::axi_cfg gmem_c_cfg;
        axi_pkg::axi_cfg control_cfg;

        `uvm_object_utils_begin(matmul_full_contiguous_config)         
        `uvm_field_object(gmem_a_cfg, UVM_DEFAULT);
        `uvm_field_object(gmem_b_cfg, UVM_DEFAULT);
        `uvm_field_object(gmem_c_cfg, UVM_DEFAULT);
        `uvm_field_object(control_cfg, UVM_DEFAULT);
        `uvm_field_int   (check_ena , UVM_DEFAULT)          
        `uvm_field_int   (cover_ena , UVM_DEFAULT)          
        `uvm_object_utils_end                               

        function new (string name = "matmul_full_contiguous_config");
            super.new(name);                                
        gmem_a_cfg = axi_pkg::axi_cfg::type_id::create("gmem_a_cfg");
        gmem_b_cfg = axi_pkg::axi_cfg::type_id::create("gmem_b_cfg");
        gmem_c_cfg = axi_pkg::axi_cfg::type_id::create("gmem_c_cfg");
        control_cfg = axi_pkg::axi_cfg::type_id::create("control_cfg");
        endfunction                                         
                                                            
    endclass                                                
                                                            
`endif                                                      
