// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xread_write.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XRead_write_CfgInitialize(XRead_write *InstancePtr, XRead_write_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XRead_write_Start(XRead_write *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_AP_CTRL) & 0x80;
    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XRead_write_IsDone(XRead_write *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XRead_write_IsIdle(XRead_write *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XRead_write_IsReady(XRead_write *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XRead_write_Continue(XRead_write *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_AP_CTRL) & 0x80;
    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_AP_CTRL, Data | 0x10);
}

void XRead_write_EnableAutoRestart(XRead_write *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XRead_write_DisableAutoRestart(XRead_write *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_AP_CTRL, 0);
}

void XRead_write_Set_mem_0_r(XRead_write *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_MEM_0_R_DATA, (u32)(Data));
    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_MEM_0_R_DATA + 4, (u32)(Data >> 32));
}

u64 XRead_write_Get_mem_0_r(XRead_write *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_MEM_0_R_DATA);
    Data += (u64)XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_MEM_0_R_DATA + 4) << 32;
    return Data;
}

void XRead_write_Set_mem_1_r(XRead_write *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_MEM_1_R_DATA, (u32)(Data));
    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_MEM_1_R_DATA + 4, (u32)(Data >> 32));
}

u64 XRead_write_Get_mem_1_r(XRead_write *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_MEM_1_R_DATA);
    Data += (u64)XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_MEM_1_R_DATA + 4) << 32;
    return Data;
}

void XRead_write_InterruptGlobalEnable(XRead_write *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_GIE, 1);
}

void XRead_write_InterruptGlobalDisable(XRead_write *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_GIE, 0);
}

void XRead_write_InterruptEnable(XRead_write *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_IER);
    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_IER, Register | Mask);
}

void XRead_write_InterruptDisable(XRead_write *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_IER);
    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_IER, Register & (~Mask));
}

void XRead_write_InterruptClear(XRead_write *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRead_write_WriteReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_ISR, Mask);
}

u32 XRead_write_InterruptGetEnabled(XRead_write *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_IER);
}

u32 XRead_write_InterruptGetStatus(XRead_write *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRead_write_ReadReg(InstancePtr->Control_BaseAddress, XREAD_WRITE_CONTROL_ADDR_ISR);
}

