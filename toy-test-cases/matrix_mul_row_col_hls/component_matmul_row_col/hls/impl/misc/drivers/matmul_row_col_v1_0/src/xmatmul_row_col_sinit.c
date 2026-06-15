// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xmatmul_row_col.h"

extern XMatmul_row_col_Config XMatmul_row_col_ConfigTable[];

#ifdef SDT
XMatmul_row_col_Config *XMatmul_row_col_LookupConfig(UINTPTR BaseAddress) {
	XMatmul_row_col_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XMatmul_row_col_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XMatmul_row_col_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XMatmul_row_col_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMatmul_row_col_Initialize(XMatmul_row_col *InstancePtr, UINTPTR BaseAddress) {
	XMatmul_row_col_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMatmul_row_col_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMatmul_row_col_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XMatmul_row_col_Config *XMatmul_row_col_LookupConfig(u16 DeviceId) {
	XMatmul_row_col_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XMATMUL_ROW_COL_NUM_INSTANCES; Index++) {
		if (XMatmul_row_col_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XMatmul_row_col_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMatmul_row_col_Initialize(XMatmul_row_col *InstancePtr, u16 DeviceId) {
	XMatmul_row_col_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMatmul_row_col_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMatmul_row_col_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

