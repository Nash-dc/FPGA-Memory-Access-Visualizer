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
#include "xmatrix_mul.h"

extern XMatrix_mul_Config XMatrix_mul_ConfigTable[];

#ifdef SDT
XMatrix_mul_Config *XMatrix_mul_LookupConfig(UINTPTR BaseAddress) {
	XMatrix_mul_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XMatrix_mul_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XMatrix_mul_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XMatrix_mul_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMatrix_mul_Initialize(XMatrix_mul *InstancePtr, UINTPTR BaseAddress) {
	XMatrix_mul_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMatrix_mul_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMatrix_mul_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XMatrix_mul_Config *XMatrix_mul_LookupConfig(u16 DeviceId) {
	XMatrix_mul_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XMATRIX_MUL_NUM_INSTANCES; Index++) {
		if (XMatrix_mul_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XMatrix_mul_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMatrix_mul_Initialize(XMatrix_mul *InstancePtr, u16 DeviceId) {
	XMatrix_mul_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMatrix_mul_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMatrix_mul_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

