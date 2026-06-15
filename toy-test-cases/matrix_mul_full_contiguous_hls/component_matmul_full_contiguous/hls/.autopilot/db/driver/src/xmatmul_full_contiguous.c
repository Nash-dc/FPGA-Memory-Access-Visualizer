// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xmatmul_full_contiguous.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XMatmul_full_contiguous_CfgInitialize(XMatmul_full_contiguous *InstancePtr, XMatmul_full_contiguous_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XMatmul_full_contiguous_Start(XMatmul_full_contiguous *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_AP_CTRL) & 0x80;
    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XMatmul_full_contiguous_IsDone(XMatmul_full_contiguous *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XMatmul_full_contiguous_IsIdle(XMatmul_full_contiguous *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XMatmul_full_contiguous_IsReady(XMatmul_full_contiguous *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XMatmul_full_contiguous_EnableAutoRestart(XMatmul_full_contiguous *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XMatmul_full_contiguous_DisableAutoRestart(XMatmul_full_contiguous *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_AP_CTRL, 0);
}

void XMatmul_full_contiguous_Set_a(XMatmul_full_contiguous *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_A_DATA, (u32)(Data));
    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_A_DATA + 4, (u32)(Data >> 32));
}

u64 XMatmul_full_contiguous_Get_a(XMatmul_full_contiguous *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_A_DATA);
    Data += (u64)XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_A_DATA + 4) << 32;
    return Data;
}

void XMatmul_full_contiguous_Set_b(XMatmul_full_contiguous *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_B_DATA, (u32)(Data));
    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_B_DATA + 4, (u32)(Data >> 32));
}

u64 XMatmul_full_contiguous_Get_b(XMatmul_full_contiguous *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_B_DATA);
    Data += (u64)XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_B_DATA + 4) << 32;
    return Data;
}

void XMatmul_full_contiguous_Set_c(XMatmul_full_contiguous *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_C_DATA, (u32)(Data));
    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_C_DATA + 4, (u32)(Data >> 32));
}

u64 XMatmul_full_contiguous_Get_c(XMatmul_full_contiguous *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_C_DATA);
    Data += (u64)XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_C_DATA + 4) << 32;
    return Data;
}

void XMatmul_full_contiguous_InterruptGlobalEnable(XMatmul_full_contiguous *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_GIE, 1);
}

void XMatmul_full_contiguous_InterruptGlobalDisable(XMatmul_full_contiguous *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_GIE, 0);
}

void XMatmul_full_contiguous_InterruptEnable(XMatmul_full_contiguous *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_IER);
    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_IER, Register | Mask);
}

void XMatmul_full_contiguous_InterruptDisable(XMatmul_full_contiguous *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_IER);
    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_IER, Register & (~Mask));
}

void XMatmul_full_contiguous_InterruptClear(XMatmul_full_contiguous *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_full_contiguous_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_ISR, Mask);
}

u32 XMatmul_full_contiguous_InterruptGetEnabled(XMatmul_full_contiguous *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_IER);
}

u32 XMatmul_full_contiguous_InterruptGetStatus(XMatmul_full_contiguous *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMatmul_full_contiguous_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_FULL_CONTIGUOUS_CONTROL_ADDR_ISR);
}

