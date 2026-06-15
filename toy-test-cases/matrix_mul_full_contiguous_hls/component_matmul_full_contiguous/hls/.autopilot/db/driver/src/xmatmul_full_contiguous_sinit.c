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
#include "xmatmul_full_contiguous.h"

extern XMatmul_full_contiguous_Config XMatmul_full_contiguous_ConfigTable[];

#ifdef SDT
XMatmul_full_contiguous_Config *XMatmul_full_contiguous_LookupConfig(UINTPTR BaseAddress) {
	XMatmul_full_contiguous_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XMatmul_full_contiguous_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XMatmul_full_contiguous_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XMatmul_full_contiguous_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMatmul_full_contiguous_Initialize(XMatmul_full_contiguous *InstancePtr, UINTPTR BaseAddress) {
	XMatmul_full_contiguous_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMatmul_full_contiguous_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMatmul_full_contiguous_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XMatmul_full_contiguous_Config *XMatmul_full_contiguous_LookupConfig(u16 DeviceId) {
	XMatmul_full_contiguous_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XMATMUL_FULL_CONTIGUOUS_NUM_INSTANCES; Index++) {
		if (XMatmul_full_contiguous_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XMatmul_full_contiguous_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMatmul_full_contiguous_Initialize(XMatmul_full_contiguous *InstancePtr, u16 DeviceId) {
	XMatmul_full_contiguous_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMatmul_full_contiguous_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMatmul_full_contiguous_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

