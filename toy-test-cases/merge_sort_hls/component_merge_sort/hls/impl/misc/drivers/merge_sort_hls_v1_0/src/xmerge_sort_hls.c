// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xmerge_sort_hls.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XMerge_sort_hls_CfgInitialize(XMerge_sort_hls *InstancePtr, XMerge_sort_hls_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XMerge_sort_hls_Start(XMerge_sort_hls *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMerge_sort_hls_ReadReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_AP_CTRL) & 0x80;
    XMerge_sort_hls_WriteReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XMerge_sort_hls_IsDone(XMerge_sort_hls *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMerge_sort_hls_ReadReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XMerge_sort_hls_IsIdle(XMerge_sort_hls *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMerge_sort_hls_ReadReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XMerge_sort_hls_IsReady(XMerge_sort_hls *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMerge_sort_hls_ReadReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XMerge_sort_hls_EnableAutoRestart(XMerge_sort_hls *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMerge_sort_hls_WriteReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XMerge_sort_hls_DisableAutoRestart(XMerge_sort_hls *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMerge_sort_hls_WriteReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_AP_CTRL, 0);
}

void XMerge_sort_hls_Set_in_r(XMerge_sort_hls *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMerge_sort_hls_WriteReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_IN_R_DATA, (u32)(Data));
    XMerge_sort_hls_WriteReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_IN_R_DATA + 4, (u32)(Data >> 32));
}

u64 XMerge_sort_hls_Get_in_r(XMerge_sort_hls *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMerge_sort_hls_ReadReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_IN_R_DATA);
    Data += (u64)XMerge_sort_hls_ReadReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_IN_R_DATA + 4) << 32;
    return Data;
}

void XMerge_sort_hls_Set_out_r(XMerge_sort_hls *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMerge_sort_hls_WriteReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_OUT_R_DATA, (u32)(Data));
    XMerge_sort_hls_WriteReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_OUT_R_DATA + 4, (u32)(Data >> 32));
}

u64 XMerge_sort_hls_Get_out_r(XMerge_sort_hls *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMerge_sort_hls_ReadReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_OUT_R_DATA);
    Data += (u64)XMerge_sort_hls_ReadReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_OUT_R_DATA + 4) << 32;
    return Data;
}

void XMerge_sort_hls_InterruptGlobalEnable(XMerge_sort_hls *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMerge_sort_hls_WriteReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_GIE, 1);
}

void XMerge_sort_hls_InterruptGlobalDisable(XMerge_sort_hls *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMerge_sort_hls_WriteReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_GIE, 0);
}

void XMerge_sort_hls_InterruptEnable(XMerge_sort_hls *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMerge_sort_hls_ReadReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_IER);
    XMerge_sort_hls_WriteReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_IER, Register | Mask);
}

void XMerge_sort_hls_InterruptDisable(XMerge_sort_hls *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMerge_sort_hls_ReadReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_IER);
    XMerge_sort_hls_WriteReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_IER, Register & (~Mask));
}

void XMerge_sort_hls_InterruptClear(XMerge_sort_hls *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMerge_sort_hls_WriteReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_ISR, Mask);
}

u32 XMerge_sort_hls_InterruptGetEnabled(XMerge_sort_hls *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMerge_sort_hls_ReadReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_IER);
}

u32 XMerge_sort_hls_InterruptGetStatus(XMerge_sort_hls *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMerge_sort_hls_ReadReg(InstancePtr->Control_BaseAddress, XMERGE_SORT_HLS_CONTROL_ADDR_ISR);
}

