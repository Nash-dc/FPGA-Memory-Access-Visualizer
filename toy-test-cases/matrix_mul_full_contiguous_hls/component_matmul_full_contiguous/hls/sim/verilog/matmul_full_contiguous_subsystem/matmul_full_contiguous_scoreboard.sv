//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
//Tool Version Limit: 2025.05
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================
`ifndef MATMUL_FULL_CONTIGUOUS_SCOREBOARD__SV                                                       
    `define MATMUL_FULL_CONTIGUOUS_SCOREBOARD__SV                                                   
                                                                                               
                                                                                               
    class matmul_full_contiguous_scoreboard extends uvm_component;                                        
                                                                                               
        matmul_full_contiguous_reference_model refm;                                                      
                                                                                               
                                                                                               
        `uvm_component_utils_begin(matmul_full_contiguous_scoreboard)                                     
        `uvm_field_object(refm  , UVM_DEFAULT)                                                 
        `uvm_component_utils_end                                                               
                                                                                               
        virtual function void build_phase(uvm_phase phase);                                    
            if (!uvm_config_db #(matmul_full_contiguous_reference_model)::get(this, "", "refm", refm))
                `uvm_fatal(this.get_full_name(), "No refm from high level")                  
            `uvm_info(this.get_full_name(), "get reference model by uvm_config_db", UVM_MEDIUM) 
                                                                                               
        endfunction                                                                            
                                                                                               
        function new (string name = "", uvm_component parent = null);                        
            super.new(name, parent);                                                           
        endfunction                                                                            
                                                                                               
        virtual task run_phase(uvm_phase phase);                                               

            fork                                                                               
                forever begin
                    @refm.allaxilite_write_data_finish;
                    `uvm_info(this.get_full_name(), "receive allaxilite_write_finish axilite write_mem_page_process", UVM_LOW)
                end
                                                                                               
                forever begin                                                                  
                    @refm.dut2tb_ap_done;                                                             
                    `uvm_info(this.get_full_name(), "receive ap_done_for_nexttrans and do axim dump", UVM_LOW)           
                    for(int j=0; j<refm.ap_done_cnt; j++) begin
                        if(j<refm.trans_num_total) begin
                            refm.mem_blk_pages_gmem_a.tvout_dump_frontpage(0);
                        end
                    end
                    for(int j=0; j<refm.ap_done_cnt; j++) begin
                        if(j<refm.trans_num_total) begin
                            refm.mem_blk_pages_gmem_b.tvout_dump_frontpage(0);
                        end
                    end
                    for(int j=0; j<refm.ap_done_cnt; j++) begin
                        if(j<refm.trans_num_total) begin
                            refm.mem_blk_pages_gmem_c.tvout_dump_frontpage(1);
                        end
                    end
                end                                                                            
                begin                                                                          
                    @refm.finish;                                                              
                    `uvm_info(this.get_full_name(), "receive FINISH", UVM_LOW)               
                end                                                                            
            join                                                                               
        endtask                                                                                
                                                                                               
        virtual function void write_axi_wtr_gmem_a(axi_pkg::axi_transfer tr);
        endfunction

        virtual function void write_axi_rtr_gmem_a(axi_pkg::axi_transfer tr);
        endfunction

        virtual function void write_axi_wtr_gmem_b(axi_pkg::axi_transfer tr);
        endfunction

        virtual function void write_axi_rtr_gmem_b(axi_pkg::axi_transfer tr);
        endfunction

        virtual function void write_axi_wtr_gmem_c(axi_pkg::axi_transfer tr);
        endfunction

        virtual function void write_axi_rtr_gmem_c(axi_pkg::axi_transfer tr);
        endfunction

        virtual function void write_axi_wtr_control(axi_pkg::axi_transfer tr);
        endfunction

        virtual function void write_axi_rtr_control(axi_pkg::axi_transfer tr);
        endfunction

    endclass                                                                                   
                                                                                               
`endif                                                                                         
