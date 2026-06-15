//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
//Tool Version Limit: 2025.05
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================
`ifndef MATMUL_FULL_CONTIGUOUS_ENV__SV                                                                                   
    `define MATMUL_FULL_CONTIGUOUS_ENV__SV                                                                               
                                                                                                                    
                                                                                                                    
    class matmul_full_contiguous_env extends uvm_env;                                                                          
                                                                                                                    
        matmul_full_contiguous_virtual_sequencer matmul_full_contiguous_virtual_sqr;                                                      
        matmul_full_contiguous_config matmul_full_contiguous_cfg;                                                                         
                                                                                                                    
        axi_pkg::axi_env#(64,64,8,3,1) axi_master_gmem_a;
        axi_pkg::axi_env#(64,64,8,3,1) axi_master_gmem_b;
        axi_pkg::axi_env#(64,64,8,3,1) axi_master_gmem_c;
        axi_pkg::axi_env#(6,4,4,3,1) axi_lite_control;
                                                                                                                    
        matmul_full_contiguous_reference_model   refm;                                                                         
                                                                                                                    
        matmul_full_contiguous_subsystem_monitor subsys_mon;                                                                   
                                                                                                                    
        `uvm_component_utils_begin(matmul_full_contiguous_env)                                                                 
        `uvm_field_object (refm, UVM_DEFAULT | UVM_REFERENCE)                                                       
        `uvm_field_object (matmul_full_contiguous_virtual_sqr, UVM_DEFAULT | UVM_REFERENCE)                                    
        `uvm_field_object (matmul_full_contiguous_cfg        , UVM_DEFAULT)                                                    
        `uvm_component_utils_end                                                                                    
                                                                                                                    
        function new (string name = "matmul_full_contiguous_env", uvm_component parent = null);                              
            super.new(name, parent);                                                                                
        endfunction                                                                                                 
                                                                                                                    
        extern virtual function void build_phase(uvm_phase phase);                                                  
        extern virtual function void connect_phase(uvm_phase phase);                                                
        extern virtual task          run_phase(uvm_phase phase);                                                    
                                                                                                                    
    endclass                                                                                                        
                                                                                                                    
    function void matmul_full_contiguous_env::build_phase(uvm_phase phase);                                                    
        super.build_phase(phase);                                                                                   
        matmul_full_contiguous_cfg = matmul_full_contiguous_config::type_id::create("matmul_full_contiguous_cfg", this);                           
                                                                                                                    

        matmul_full_contiguous_cfg.gmem_a_cfg.set_default();
        matmul_full_contiguous_cfg.gmem_a_cfg.drv_type = axi_pkg::SLAVE;
        matmul_full_contiguous_cfg.gmem_a_cfg.reset_level = axi_pkg::RESET_LEVEL_LOW;
        matmul_full_contiguous_cfg.gmem_a_cfg.write_latency_mode = TRANSACTION_FIRST;
        matmul_full_contiguous_cfg.gmem_a_cfg.read_latency_mode = TRANSACTION_FIRST;
        uvm_config_db#(axi_pkg::axi_cfg)::set(this, "axi_master_gmem_a*", "cfg", matmul_full_contiguous_cfg.gmem_a_cfg);
        axi_master_gmem_a = axi_pkg::axi_env#(64,64,8,3,1)::type_id::create("axi_master_gmem_a", this);

        matmul_full_contiguous_cfg.gmem_b_cfg.set_default();
        matmul_full_contiguous_cfg.gmem_b_cfg.drv_type = axi_pkg::SLAVE;
        matmul_full_contiguous_cfg.gmem_b_cfg.reset_level = axi_pkg::RESET_LEVEL_LOW;
        matmul_full_contiguous_cfg.gmem_b_cfg.write_latency_mode = TRANSACTION_FIRST;
        matmul_full_contiguous_cfg.gmem_b_cfg.read_latency_mode = TRANSACTION_FIRST;
        uvm_config_db#(axi_pkg::axi_cfg)::set(this, "axi_master_gmem_b*", "cfg", matmul_full_contiguous_cfg.gmem_b_cfg);
        axi_master_gmem_b = axi_pkg::axi_env#(64,64,8,3,1)::type_id::create("axi_master_gmem_b", this);

        matmul_full_contiguous_cfg.gmem_c_cfg.set_default();
        matmul_full_contiguous_cfg.gmem_c_cfg.drv_type = axi_pkg::SLAVE;
        matmul_full_contiguous_cfg.gmem_c_cfg.reset_level = axi_pkg::RESET_LEVEL_LOW;
        matmul_full_contiguous_cfg.gmem_c_cfg.write_latency_mode = TRANSACTION_FIRST;
        matmul_full_contiguous_cfg.gmem_c_cfg.read_latency_mode = TRANSACTION_FIRST;
        uvm_config_db#(axi_pkg::axi_cfg)::set(this, "axi_master_gmem_c*", "cfg", matmul_full_contiguous_cfg.gmem_c_cfg);
        axi_master_gmem_c = axi_pkg::axi_env#(64,64,8,3,1)::type_id::create("axi_master_gmem_c", this);

        matmul_full_contiguous_cfg.control_cfg.set_default();
        matmul_full_contiguous_cfg.control_cfg.drv_type = axi_pkg::MASTER;
        matmul_full_contiguous_cfg.control_cfg.reset_level = axi_pkg::RESET_LEVEL_LOW;
        uvm_config_db#(axi_pkg::axi_cfg)::set(this, "axi_lite_control*", "cfg", matmul_full_contiguous_cfg.control_cfg);
        axi_lite_control = axi_pkg::axi_env#(6,4,4,3,1)::type_id::create("axi_lite_control", this);



        refm = matmul_full_contiguous_reference_model::type_id::create("refm", this);


        uvm_config_db#(matmul_full_contiguous_reference_model)::set(this, "*", "refm", refm);


        `uvm_info(this.get_full_name(), "set reference model by uvm_config_db", UVM_LOW)


        subsys_mon = matmul_full_contiguous_subsystem_monitor::type_id::create("subsys_mon", this);


        matmul_full_contiguous_virtual_sqr = matmul_full_contiguous_virtual_sequencer::type_id::create("matmul_full_contiguous_virtual_sqr", this);
        `uvm_info(this.get_full_name(), "build_phase done", UVM_LOW)
    endfunction


    function void matmul_full_contiguous_env::connect_phase(uvm_phase phase);
        super.connect_phase(phase);


        if(matmul_full_contiguous_cfg.gmem_a_cfg.drv_type==axi_pkg::MASTER ||matmul_full_contiguous_cfg.gmem_a_cfg.drv_type==axi_pkg::SLAVE)
            matmul_full_contiguous_virtual_sqr.gmem_a_sqr = axi_master_gmem_a.vsqr;
        axi_master_gmem_a.item_wtr_port.connect(subsys_mon.gmem_a_wtr_imp);
        axi_master_gmem_a.item_rtr_port.connect(subsys_mon.gmem_a_rtr_imp);
        uvm_callbacks#(axi_pkg::axi_state, axi_pkg::axi_state_cbs)::add(axi_master_gmem_a.state, refm.axi_memaccess_cb_gmem_a);
        if(matmul_full_contiguous_cfg.gmem_b_cfg.drv_type==axi_pkg::MASTER ||matmul_full_contiguous_cfg.gmem_b_cfg.drv_type==axi_pkg::SLAVE)
            matmul_full_contiguous_virtual_sqr.gmem_b_sqr = axi_master_gmem_b.vsqr;
        axi_master_gmem_b.item_wtr_port.connect(subsys_mon.gmem_b_wtr_imp);
        axi_master_gmem_b.item_rtr_port.connect(subsys_mon.gmem_b_rtr_imp);
        uvm_callbacks#(axi_pkg::axi_state, axi_pkg::axi_state_cbs)::add(axi_master_gmem_b.state, refm.axi_memaccess_cb_gmem_b);
        if(matmul_full_contiguous_cfg.gmem_c_cfg.drv_type==axi_pkg::MASTER ||matmul_full_contiguous_cfg.gmem_c_cfg.drv_type==axi_pkg::SLAVE)
            matmul_full_contiguous_virtual_sqr.gmem_c_sqr = axi_master_gmem_c.vsqr;
        axi_master_gmem_c.item_wtr_port.connect(subsys_mon.gmem_c_wtr_imp);
        axi_master_gmem_c.item_rtr_port.connect(subsys_mon.gmem_c_rtr_imp);
        uvm_callbacks#(axi_pkg::axi_state, axi_pkg::axi_state_cbs)::add(axi_master_gmem_c.state, refm.axi_memaccess_cb_gmem_c);
        if(matmul_full_contiguous_cfg.control_cfg.drv_type==axi_pkg::MASTER ||matmul_full_contiguous_cfg.control_cfg.drv_type==axi_pkg::SLAVE)
            matmul_full_contiguous_virtual_sqr.control_sqr = axi_lite_control.vsqr;
        axi_lite_control.item_wtr_port.connect(subsys_mon.control_wtr_imp);
        axi_lite_control.item_rtr_port.connect(subsys_mon.control_rtr_imp);
        refm.matmul_full_contiguous_cfg = matmul_full_contiguous_cfg;
        `uvm_info(this.get_full_name(), "connect phase done", UVM_LOW)
    endfunction


    task matmul_full_contiguous_env::run_phase(uvm_phase phase);
        `uvm_info(this.get_full_name(), "matmul_full_contiguous_env is running", UVM_LOW)
    endtask


`endif
