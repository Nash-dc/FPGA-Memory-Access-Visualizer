// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xvector_mul.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XVector_mul_CfgInitialize(XVector_mul *InstancePtr, XVector_mul_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XVector_mul_Start(XVector_mul *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_AP_CTRL) & 0x80;
    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XVector_mul_IsDone(XVector_mul *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XVector_mul_IsIdle(XVector_mul *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XVector_mul_IsReady(XVector_mul *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XVector_mul_EnableAutoRestart(XVector_mul *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XVector_mul_DisableAutoRestart(XVector_mul *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_AP_CTRL, 0);
}

void XVector_mul_Set_in1(XVector_mul *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IN1_DATA, (u32)(Data));
    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IN1_DATA + 4, (u32)(Data >> 32));
}

u64 XVector_mul_Get_in1(XVector_mul *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IN1_DATA);
    Data += (u64)XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IN1_DATA + 4) << 32;
    return Data;
}

void XVector_mul_Set_in2(XVector_mul *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IN2_DATA, (u32)(Data));
    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IN2_DATA + 4, (u32)(Data >> 32));
}

u64 XVector_mul_Get_in2(XVector_mul *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IN2_DATA);
    Data += (u64)XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IN2_DATA + 4) << 32;
    return Data;
}

void XVector_mul_Set_out_r(XVector_mul *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_OUT_R_DATA, (u32)(Data));
    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_OUT_R_DATA + 4, (u32)(Data >> 32));
}

u64 XVector_mul_Get_out_r(XVector_mul *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_OUT_R_DATA);
    Data += (u64)XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_OUT_R_DATA + 4) << 32;
    return Data;
}

void XVector_mul_InterruptGlobalEnable(XVector_mul *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_GIE, 1);
}

void XVector_mul_InterruptGlobalDisable(XVector_mul *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_GIE, 0);
}

void XVector_mul_InterruptEnable(XVector_mul *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IER);
    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IER, Register | Mask);
}

void XVector_mul_InterruptDisable(XVector_mul *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IER);
    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IER, Register & (~Mask));
}

void XVector_mul_InterruptClear(XVector_mul *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XVector_mul_WriteReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_ISR, Mask);
}

u32 XVector_mul_InterruptGetEnabled(XVector_mul *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_IER);
}

u32 XVector_mul_InterruptGetStatus(XVector_mul *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XVector_mul_ReadReg(InstancePtr->Control_BaseAddress, XVECTOR_MUL_CONTROL_ADDR_ISR);
}

