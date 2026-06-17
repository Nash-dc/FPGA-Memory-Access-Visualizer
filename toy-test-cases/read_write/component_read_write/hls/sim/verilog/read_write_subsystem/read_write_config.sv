//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
//Tool Version Limit: 2025.05
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================
`ifndef READ_WRITE_CONFIG__SV                        
    `define READ_WRITE_CONFIG__SV                    
                                                            
    class read_write_config extends uvm_object;            
                                                            
        int check_ena;                                      
        int cover_ena;                                      
        axi_pkg::axi_cfg mem_0_cfg;
        axi_pkg::axi_cfg mem_1_cfg;
        axi_pkg::axi_cfg control_cfg;

        `uvm_object_utils_begin(read_write_config)         
        `uvm_field_object(mem_0_cfg, UVM_DEFAULT);
        `uvm_field_object(mem_1_cfg, UVM_DEFAULT);
        `uvm_field_object(control_cfg, UVM_DEFAULT);
        `uvm_field_int   (check_ena , UVM_DEFAULT)          
        `uvm_field_int   (cover_ena , UVM_DEFAULT)          
        `uvm_object_utils_end                               

        function new (string name = "read_write_config");
            super.new(name);                                
        mem_0_cfg = axi_pkg::axi_cfg::type_id::create("mem_0_cfg");
        mem_1_cfg = axi_pkg::axi_cfg::type_id::create("mem_1_cfg");
        control_cfg = axi_pkg::axi_cfg::type_id::create("control_cfg");
        endfunction                                         
                                                            
    endclass                                                
                                                            
`endif                                                      
