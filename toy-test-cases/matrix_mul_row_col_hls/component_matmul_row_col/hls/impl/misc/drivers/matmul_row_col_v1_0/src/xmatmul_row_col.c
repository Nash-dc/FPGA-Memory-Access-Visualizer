// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xmatmul_row_col.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XMatmul_row_col_CfgInitialize(XMatmul_row_col *InstancePtr, XMatmul_row_col_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XMatmul_row_col_Start(XMatmul_row_col *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_AP_CTRL) & 0x80;
    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XMatmul_row_col_IsDone(XMatmul_row_col *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XMatmul_row_col_IsIdle(XMatmul_row_col *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XMatmul_row_col_IsReady(XMatmul_row_col *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XMatmul_row_col_EnableAutoRestart(XMatmul_row_col *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XMatmul_row_col_DisableAutoRestart(XMatmul_row_col *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_AP_CTRL, 0);
}

void XMatmul_row_col_Set_a(XMatmul_row_col *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_A_DATA, (u32)(Data));
    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_A_DATA + 4, (u32)(Data >> 32));
}

u64 XMatmul_row_col_Get_a(XMatmul_row_col *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_A_DATA);
    Data += (u64)XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_A_DATA + 4) << 32;
    return Data;
}

void XMatmul_row_col_Set_b(XMatmul_row_col *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_B_DATA, (u32)(Data));
    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_B_DATA + 4, (u32)(Data >> 32));
}

u64 XMatmul_row_col_Get_b(XMatmul_row_col *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_B_DATA);
    Data += (u64)XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_B_DATA + 4) << 32;
    return Data;
}

void XMatmul_row_col_Set_c(XMatmul_row_col *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_C_DATA, (u32)(Data));
    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_C_DATA + 4, (u32)(Data >> 32));
}

u64 XMatmul_row_col_Get_c(XMatmul_row_col *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_C_DATA);
    Data += (u64)XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_C_DATA + 4) << 32;
    return Data;
}

void XMatmul_row_col_InterruptGlobalEnable(XMatmul_row_col *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_GIE, 1);
}

void XMatmul_row_col_InterruptGlobalDisable(XMatmul_row_col *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_GIE, 0);
}

void XMatmul_row_col_InterruptEnable(XMatmul_row_col *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_IER);
    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_IER, Register | Mask);
}

void XMatmul_row_col_InterruptDisable(XMatmul_row_col *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_IER);
    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_IER, Register & (~Mask));
}

void XMatmul_row_col_InterruptClear(XMatmul_row_col *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMatmul_row_col_WriteReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_ISR, Mask);
}

u32 XMatmul_row_col_InterruptGetEnabled(XMatmul_row_col *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_IER);
}

u32 XMatmul_row_col_InterruptGetStatus(XMatmul_row_col *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMatmul_row_col_ReadReg(InstancePtr->Control_BaseAddress, XMATMUL_ROW_COL_CONTROL_ADDR_ISR);
}

