// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xmatrix_mul.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XMatrix_mul_CfgInitialize(XMatrix_mul *InstancePtr, XMatrix_mul_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XMatrix_mul_Start(XMatrix_mul *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_AP_CTRL) & 0x80;
    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XMatrix_mul_IsDone(XMatrix_mul *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XMatrix_mul_IsIdle(XMatrix_mul *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XMatrix_mul_IsReady(XMatrix_mul *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XMatrix_mul_EnableAutoRestart(XMatrix_mul *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XMatrix_mul_DisableAutoRestart(XMatrix_mul *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_AP_CTRL, 0);
}

void XMatrix_mul_Set_a(XMatrix_mul *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_A_DATA, (u32)(Data));
    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_A_DATA + 4, (u32)(Data >> 32));
}

u64 XMatrix_mul_Get_a(XMatrix_mul *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_A_DATA);
    Data += (u64)XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_A_DATA + 4) << 32;
    return Data;
}

void XMatrix_mul_Set_b(XMatrix_mul *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_B_DATA, (u32)(Data));
    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_B_DATA + 4, (u32)(Data >> 32));
}

u64 XMatrix_mul_Get_b(XMatrix_mul *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_B_DATA);
    Data += (u64)XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_B_DATA + 4) << 32;
    return Data;
}

void XMatrix_mul_Set_c(XMatrix_mul *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_C_DATA, (u32)(Data));
    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_C_DATA + 4, (u32)(Data >> 32));
}

u64 XMatrix_mul_Get_c(XMatrix_mul *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_C_DATA);
    Data += (u64)XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_C_DATA + 4) << 32;
    return Data;
}

void XMatrix_mul_InterruptGlobalEnable(XMatrix_mul *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_GIE, 1);
}

void XMatrix_mul_InterruptGlobalDisable(XMatrix_mul *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_GIE, 0);
}

void XMatrix_mul_InterruptEnable(XMatrix_mul *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_IER);
    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_IER, Register | Mask);
}

void XMatrix_mul_InterruptDisable(XMatrix_mul *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_IER);
    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_IER, Register & (~Mask));
}

void XMatrix_mul_InterruptClear(XMatrix_mul *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatrix_mul_WriteReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_ISR, Mask);
}

u32 XMatrix_mul_InterruptGetEnabled(XMatrix_mul *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_IER);
}

u32 XMatrix_mul_InterruptGetStatus(XMatrix_mul *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMatrix_mul_ReadReg(InstancePtr->Control_BaseAddress, XMATRIX_MUL_CONTROL_ADDR_ISR);
}

