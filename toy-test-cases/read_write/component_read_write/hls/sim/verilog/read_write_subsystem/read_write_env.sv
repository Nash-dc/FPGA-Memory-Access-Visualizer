//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
//Tool Version Limit: 2025.05
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================
`ifndef READ_WRITE_ENV__SV                                                                                   
    `define READ_WRITE_ENV__SV                                                                               
                                                                                                                    
    class axi_latency_mem_0 extends axi_latency;
        rand int    wr_latency;
        rand int    rd_latency;
        `uvm_object_utils_begin(axi_latency_mem_0)
        `uvm_object_utils_end
        function new ( string name = "axi_latency_mem_0" );
            super.new(name);
        endfunction
        virtual function int get_wr_lat();
            int delay;
            void'(std::randomize(delay) with { delay == 64;});
            wr_latency = delay;
            return wr_latency;
        endfunction
        virtual function int get_rd_lat();
            int delay;
            void'(std::randomize(delay) with { delay == 64;});
            rd_latency = delay;
            return rd_latency;
        endfunction
    endclass

    class axi_latency_mem_1 extends axi_latency;
        rand int    wr_latency;
        rand int    rd_latency;
        `uvm_object_utils_begin(axi_latency_mem_1)
        `uvm_object_utils_end
        function new ( string name = "axi_latency_mem_1" );
            super.new(name);
        endfunction
        virtual function int get_wr_lat();
            int delay;
            void'(std::randomize(delay) with { delay == 64;});
            wr_latency = delay;
            return wr_latency;
        endfunction
        virtual function int get_rd_lat();
            int delay;
            void'(std::randomize(delay) with { delay == 64;});
            rd_latency = delay;
            return rd_latency;
        endfunction
    endclass

                                                                                                                    
    class read_write_env extends uvm_env;                                                                          
                                                                                                                    
        axi_latency_mem_0    lat_mem_0;
        axi_latency_mem_1    lat_mem_1;
        read_write_virtual_sequencer read_write_virtual_sqr;                                                      
        read_write_config read_write_cfg;                                                                         
                                                                                                                    
        axi_pkg::axi_env#(64,64,8,3,1) axi_master_mem_0;
        axi_pkg::axi_env#(64,64,8,3,1) axi_master_mem_1;
        axi_pkg::axi_env#(6,4,4,3,1) axi_lite_control;
                                                                                                                    
        read_write_reference_model   refm;                                                                         
                                                                                                                    
        read_write_subsystem_monitor subsys_mon;                                                                   
                                                                                                                    
        `uvm_component_utils_begin(read_write_env)                                                                 
        `uvm_field_object (refm, UVM_DEFAULT | UVM_REFERENCE)                                                       
        `uvm_field_object (read_write_virtual_sqr, UVM_DEFAULT | UVM_REFERENCE)                                    
        `uvm_field_object (read_write_cfg        , UVM_DEFAULT)                                                    
        `uvm_component_utils_end                                                                                    
                                                                                                                    
        function new (string name = "read_write_env", uvm_component parent = null);                              
            super.new(name, parent);                                                                                
        endfunction                                                                                                 
                                                                                                                    
        extern virtual function void build_phase(uvm_phase phase);                                                  
        extern virtual function void connect_phase(uvm_phase phase);                                                
        extern virtual task          run_phase(uvm_phase phase);                                                    
                                                                                                                    
    endclass                                                                                                        
                                                                                                                    
    function void read_write_env::build_phase(uvm_phase phase);                                                    
        super.build_phase(phase);                                                                                   
        read_write_cfg = read_write_config::type_id::create("read_write_cfg", this);                           
                                                                                                                    

        read_write_cfg.mem_0_cfg.set_default();
        read_write_cfg.mem_0_cfg.drv_type = axi_pkg::SLAVE;
        read_write_cfg.mem_0_cfg.reset_level = axi_pkg::RESET_LEVEL_LOW;
        lat_mem_0 = axi_latency_mem_0::type_id::create("lat_mem_0", this);
        read_write_cfg.mem_0_cfg.clatency = lat_mem_0;
        read_write_cfg.mem_0_cfg.write_latency_mode = TRANSACTION_FIRST;
        read_write_cfg.mem_0_cfg.read_latency_mode = TRANSACTION_FIRST;
        uvm_config_db#(axi_pkg::axi_cfg)::set(this, "axi_master_mem_0*", "cfg", read_write_cfg.mem_0_cfg);
        axi_master_mem_0 = axi_pkg::axi_env#(64,64,8,3,1)::type_id::create("axi_master_mem_0", this);

        read_write_cfg.mem_1_cfg.set_default();
        read_write_cfg.mem_1_cfg.drv_type = axi_pkg::SLAVE;
        read_write_cfg.mem_1_cfg.reset_level = axi_pkg::RESET_LEVEL_LOW;
        lat_mem_1 = axi_latency_mem_1::type_id::create("lat_mem_1", this);
        read_write_cfg.mem_1_cfg.clatency = lat_mem_1;
        read_write_cfg.mem_1_cfg.write_latency_mode = TRANSACTION_FIRST;
        read_write_cfg.mem_1_cfg.read_latency_mode = TRANSACTION_FIRST;
        uvm_config_db#(axi_pkg::axi_cfg)::set(this, "axi_master_mem_1*", "cfg", read_write_cfg.mem_1_cfg);
        axi_master_mem_1 = axi_pkg::axi_env#(64,64,8,3,1)::type_id::create("axi_master_mem_1", this);

        read_write_cfg.control_cfg.set_default();
        read_write_cfg.control_cfg.drv_type = axi_pkg::MASTER;
        read_write_cfg.control_cfg.reset_level = axi_pkg::RESET_LEVEL_LOW;
        uvm_config_db#(axi_pkg::axi_cfg)::set(this, "axi_lite_control*", "cfg", read_write_cfg.control_cfg);
        axi_lite_control = axi_pkg::axi_env#(6,4,4,3,1)::type_id::create("axi_lite_control", this);



        refm = read_write_reference_model::type_id::create("refm", this);


        uvm_config_db#(read_write_reference_model)::set(this, "*", "refm", refm);


        `uvm_info(this.get_full_name(), "set reference model by uvm_config_db", UVM_LOW)


        subsys_mon = read_write_subsystem_monitor::type_id::create("subsys_mon", this);


        read_write_virtual_sqr = read_write_virtual_sequencer::type_id::create("read_write_virtual_sqr", this);
        `uvm_info(this.get_full_name(), "build_phase done", UVM_LOW)
    endfunction


    function void read_write_env::connect_phase(uvm_phase phase);
        super.connect_phase(phase);


        if(read_write_cfg.mem_0_cfg.drv_type==axi_pkg::MASTER ||read_write_cfg.mem_0_cfg.drv_type==axi_pkg::SLAVE)
            read_write_virtual_sqr.mem_0_sqr = axi_master_mem_0.vsqr;
        axi_master_mem_0.item_wtr_port.connect(subsys_mon.mem_0_wtr_imp);
        axi_master_mem_0.item_rtr_port.connect(subsys_mon.mem_0_rtr_imp);
        uvm_callbacks#(axi_pkg::axi_state, axi_pkg::axi_state_cbs)::add(axi_master_mem_0.state, refm.axi_memaccess_cb_mem_0);
        if(read_write_cfg.mem_1_cfg.drv_type==axi_pkg::MASTER ||read_write_cfg.mem_1_cfg.drv_type==axi_pkg::SLAVE)
            read_write_virtual_sqr.mem_1_sqr = axi_master_mem_1.vsqr;
        axi_master_mem_1.item_wtr_port.connect(subsys_mon.mem_1_wtr_imp);
        axi_master_mem_1.item_rtr_port.connect(subsys_mon.mem_1_rtr_imp);
        uvm_callbacks#(axi_pkg::axi_state, axi_pkg::axi_state_cbs)::add(axi_master_mem_1.state, refm.axi_memaccess_cb_mem_1);
        if(read_write_cfg.control_cfg.drv_type==axi_pkg::MASTER ||read_write_cfg.control_cfg.drv_type==axi_pkg::SLAVE)
            read_write_virtual_sqr.control_sqr = axi_lite_control.vsqr;
        axi_lite_control.item_wtr_port.connect(subsys_mon.control_wtr_imp);
        axi_lite_control.item_rtr_port.connect(subsys_mon.control_rtr_imp);
        refm.read_write_cfg = read_write_cfg;
        `uvm_info(this.get_full_name(), "connect phase done", UVM_LOW)
    endfunction


    task read_write_env::run_phase(uvm_phase phase);
        `uvm_info(this.get_full_name(), "read_write_env is running", UVM_LOW)
    endtask


`endif
