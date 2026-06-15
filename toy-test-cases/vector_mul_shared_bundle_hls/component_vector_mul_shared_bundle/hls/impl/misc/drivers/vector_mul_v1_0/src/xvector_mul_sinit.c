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
#include "xvector_mul.h"

extern XVector_mul_Config XVector_mul_ConfigTable[];

#ifdef SDT
XVector_mul_Config *XVector_mul_LookupConfig(UINTPTR BaseAddress) {
	XVector_mul_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XVector_mul_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XVector_mul_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XVector_mul_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XVector_mul_Initialize(XVector_mul *InstancePtr, UINTPTR BaseAddress) {
	XVector_mul_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XVector_mul_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XVector_mul_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XVector_mul_Config *XVector_mul_LookupConfig(u16 DeviceId) {
	XVector_mul_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XVECTOR_MUL_NUM_INSTANCES; Index++) {
		if (XVector_mul_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XVector_mul_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XVector_mul_Initialize(XVector_mul *InstancePtr, u16 DeviceId) {
	XVector_mul_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XVector_mul_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XVector_mul_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

