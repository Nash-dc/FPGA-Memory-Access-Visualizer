//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
//Tool Version Limit: 2025.05
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================

`ifndef READ_WRITE_SUBSYSTEM_MONITOR_SV
`define READ_WRITE_SUBSYSTEM_MONITOR_SV

`uvm_analysis_imp_decl(_axi_wtr_mem_0)
`uvm_analysis_imp_decl(_axi_rtr_mem_0)
`uvm_analysis_imp_decl(_axi_wtr_mem_1)
`uvm_analysis_imp_decl(_axi_rtr_mem_1)
`uvm_analysis_imp_decl(_axi_wtr_control)
`uvm_analysis_imp_decl(_axi_rtr_control)

class read_write_subsystem_monitor extends uvm_component;

    read_write_reference_model refm;
    read_write_scoreboard scbd;

    `uvm_component_utils_begin(read_write_subsystem_monitor)
    `uvm_component_utils_end

    uvm_analysis_imp_axi_wtr_mem_0#(axi_pkg::axi_transfer, read_write_subsystem_monitor) mem_0_wtr_imp;
    uvm_analysis_imp_axi_rtr_mem_0#(axi_pkg::axi_transfer, read_write_subsystem_monitor) mem_0_rtr_imp;
    uvm_analysis_imp_axi_wtr_mem_1#(axi_pkg::axi_transfer, read_write_subsystem_monitor) mem_1_wtr_imp;
    uvm_analysis_imp_axi_rtr_mem_1#(axi_pkg::axi_transfer, read_write_subsystem_monitor) mem_1_rtr_imp;
    uvm_analysis_imp_axi_wtr_control#(axi_pkg::axi_transfer, read_write_subsystem_monitor) control_wtr_imp;
    uvm_analysis_imp_axi_rtr_control#(axi_pkg::axi_transfer, read_write_subsystem_monitor) control_rtr_imp;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(read_write_reference_model)::get(this, "", "refm", refm))
            `uvm_fatal(this.get_full_name(), "No refm from high level")
        `uvm_info(this.get_full_name(), "get reference model by uvm_config_db", UVM_MEDIUM)
        scbd = read_write_scoreboard::type_id::create("scbd", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    function new (string name = "", uvm_component parent = null);
        super.new(name, parent);
        mem_0_wtr_imp = new("mem_0_wtr_imp", this);
        mem_0_rtr_imp = new("mem_0_rtr_imp", this);
        mem_1_wtr_imp = new("mem_1_wtr_imp", this);
        mem_1_rtr_imp = new("mem_1_rtr_imp", this);
        control_wtr_imp = new("control_wtr_imp", this);
        control_rtr_imp = new("control_rtr_imp", this);
    endfunction

    virtual function void write_axi_wtr_mem_0(axi_transfer tr);
        refm.write_axi_wtr_mem_0(tr);
        scbd.write_axi_wtr_mem_0(tr);
    endfunction

    virtual function void write_axi_rtr_mem_0(axi_transfer tr);
        refm.write_axi_rtr_mem_0(tr);
        scbd.write_axi_rtr_mem_0(tr);
    endfunction

    virtual function void write_axi_wtr_mem_1(axi_transfer tr);
        refm.write_axi_wtr_mem_1(tr);
        scbd.write_axi_wtr_mem_1(tr);
    endfunction

    virtual function void write_axi_rtr_mem_1(axi_transfer tr);
        refm.write_axi_rtr_mem_1(tr);
        scbd.write_axi_rtr_mem_1(tr);
    endfunction

    virtual function void write_axi_wtr_control(axi_transfer tr);
        refm.write_axi_wtr_control(tr);
        scbd.write_axi_wtr_control(tr);
    endfunction

    virtual function void write_axi_rtr_control(axi_transfer tr);
        refm.write_axi_rtr_control(tr);
        scbd.write_axi_rtr_control(tr);
    endfunction
endclass
`endif
