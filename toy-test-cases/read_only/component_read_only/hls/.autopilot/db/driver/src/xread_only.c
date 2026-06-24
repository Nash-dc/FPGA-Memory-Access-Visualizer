// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xread_only.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XRead_only_CfgInitialize(XRead_only *InstancePtr, XRead_only_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XRead_only_Start(XRead_only *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_AP_CTRL) & 0x80;
    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XRead_only_IsDone(XRead_only *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XRead_only_IsIdle(XRead_only *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XRead_only_IsReady(XRead_only *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XRead_only_Continue(XRead_only *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_AP_CTRL) & 0x80;
    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_AP_CTRL, Data | 0x10);
}

void XRead_only_EnableAutoRestart(XRead_only *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XRead_only_DisableAutoRestart(XRead_only *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_AP_CTRL, 0);
}

void XRead_only_Set_mem_0_r(XRead_only *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_MEM_0_R_DATA, (u32)(Data));
    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_MEM_0_R_DATA + 4, (u32)(Data >> 32));
}

u64 XRead_only_Get_mem_0_r(XRead_only *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_MEM_0_R_DATA);
    Data += (u64)XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_MEM_0_R_DATA + 4) << 32;
    return Data;
}

void XRead_only_Set_mem_1_r(XRead_only *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_MEM_1_R_DATA, (u32)(Data));
    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_MEM_1_R_DATA + 4, (u32)(Data >> 32));
}

u64 XRead_only_Get_mem_1_r(XRead_only *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_MEM_1_R_DATA);
    Data += (u64)XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_MEM_1_R_DATA + 4) << 32;
    return Data;
}

void XRead_only_Set_res_i(XRead_only *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_RES_I_DATA, Data);
}

u32 XRead_only_Get_res_i(XRead_only *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_RES_I_DATA);
    return Data;
}

u32 XRead_only_Get_res_o(XRead_only *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_RES_O_DATA);
    return Data;
}

void XRead_only_InterruptGlobalEnable(XRead_only *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_GIE, 1);
}

void XRead_only_InterruptGlobalDisable(XRead_only *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_GIE, 0);
}

void XRead_only_InterruptEnable(XRead_only *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_IER);
    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_IER, Register | Mask);
}

void XRead_only_InterruptDisable(XRead_only *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_IER);
    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_IER, Register & (~Mask));
}

void XRead_only_InterruptClear(XRead_only *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_only_WriteReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_ISR, Mask);
}

u32 XRead_only_InterruptGetEnabled(XRead_only *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_IER);
}

u32 XRead_only_InterruptGetStatus(XRead_only *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRead_only_ReadReg(InstancePtr->Control_BaseAddress, XREAD_ONLY_CONTROL_ADDR_ISR);
}

