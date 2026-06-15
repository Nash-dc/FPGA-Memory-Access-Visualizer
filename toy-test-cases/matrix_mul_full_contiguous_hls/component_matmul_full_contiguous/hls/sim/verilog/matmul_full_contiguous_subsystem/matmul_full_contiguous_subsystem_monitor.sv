//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
//Tool Version Limit: 2025.05
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================

`ifndef MATMUL_FULL_CONTIGUOUS_SUBSYSTEM_MONITOR_SV
`define MATMUL_FULL_CONTIGUOUS_SUBSYSTEM_MONITOR_SV

`uvm_analysis_imp_decl(_axi_wtr_gmem_a)
`uvm_analysis_imp_decl(_axi_rtr_gmem_a)
`uvm_analysis_imp_decl(_axi_wtr_gmem_b)
`uvm_analysis_imp_decl(_axi_rtr_gmem_b)
`uvm_analysis_imp_decl(_axi_wtr_gmem_c)
`uvm_analysis_imp_decl(_axi_rtr_gmem_c)
`uvm_analysis_imp_decl(_axi_wtr_control)
`uvm_analysis_imp_decl(_axi_rtr_control)

class matmul_full_contiguous_subsystem_monitor extends uvm_component;

    matmul_full_contiguous_reference_model refm;
    matmul_full_contiguous_scoreboard scbd;

    `uvm_component_utils_begin(matmul_full_contiguous_subsystem_monitor)
    `uvm_component_utils_end

    uvm_analysis_imp_axi_wtr_gmem_a#(axi_pkg::axi_transfer, matmul_full_contiguous_subsystem_monitor) gmem_a_wtr_imp;
    uvm_analysis_imp_axi_rtr_gmem_a#(axi_pkg::axi_transfer, matmul_full_contiguous_subsystem_monitor) gmem_a_rtr_imp;
    uvm_analysis_imp_axi_wtr_gmem_b#(axi_pkg::axi_transfer, matmul_full_contiguous_subsystem_monitor) gmem_b_wtr_imp;
    uvm_analysis_imp_axi_rtr_gmem_b#(axi_pkg::axi_transfer, matmul_full_contiguous_subsystem_monitor) gmem_b_rtr_imp;
    uvm_analysis_imp_axi_wtr_gmem_c#(axi_pkg::axi_transfer, matmul_full_contiguous_subsystem_monitor) gmem_c_wtr_imp;
    uvm_analysis_imp_axi_rtr_gmem_c#(axi_pkg::axi_transfer, matmul_full_contiguous_subsystem_monitor) gmem_c_rtr_imp;
    uvm_analysis_imp_axi_wtr_control#(axi_pkg::axi_transfer, matmul_full_contiguous_subsystem_monitor) control_wtr_imp;
    uvm_analysis_imp_axi_rtr_control#(axi_pkg::axi_transfer, matmul_full_contiguous_subsystem_monitor) control_rtr_imp;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(matmul_full_contiguous_reference_model)::get(this, "", "refm", refm))
            `uvm_fatal(this.get_full_name(), "No refm from high level")
        `uvm_info(this.get_full_name(), "get reference model by uvm_config_db", UVM_MEDIUM)
        scbd = matmul_full_contiguous_scoreboard::type_id::create("scbd", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    function new (string name = "", uvm_component parent = null);
        super.new(name, parent);
        gmem_a_wtr_imp = new("gmem_a_wtr_imp", this);
        gmem_a_rtr_imp = new("gmem_a_rtr_imp", this);
        gmem_b_wtr_imp = new("gmem_b_wtr_imp", this);
        gmem_b_rtr_imp = new("gmem_b_rtr_imp", this);
        gmem_c_wtr_imp = new("gmem_c_wtr_imp", this);
        gmem_c_rtr_imp = new("gmem_c_rtr_imp", this);
        control_wtr_imp = new("control_wtr_imp", this);
        control_rtr_imp = new("control_rtr_imp", this);
    endfunction

    virtual function void write_axi_wtr_gmem_a(axi_transfer tr);
        refm.write_axi_wtr_gmem_a(tr);
        scbd.write_axi_wtr_gmem_a(tr);
    endfunction

    virtual function void write_axi_rtr_gmem_a(axi_transfer tr);
        refm.write_axi_rtr_gmem_a(tr);
        scbd.write_axi_rtr_gmem_a(tr);
    endfunction

    virtual function void write_axi_wtr_gmem_b(axi_transfer tr);
        refm.write_axi_wtr_gmem_b(tr);
        scbd.write_axi_wtr_gmem_b(tr);
    endfunction

    virtual function void write_axi_rtr_gmem_b(axi_transfer tr);
        refm.write_axi_rtr_gmem_b(tr);
        scbd.write_axi_rtr_gmem_b(tr);
    endfunction

    virtual function void write_axi_wtr_gmem_c(axi_transfer tr);
        refm.write_axi_wtr_gmem_c(tr);
        scbd.write_axi_wtr_gmem_c(tr);
    endfunction

    virtual function void write_axi_rtr_gmem_c(axi_transfer tr);
        refm.write_axi_rtr_gmem_c(tr);
        scbd.write_axi_rtr_gmem_c(tr);
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
