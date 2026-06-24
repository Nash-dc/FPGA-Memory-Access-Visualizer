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
#include "xread_only.h"

extern XRead_only_Config XRead_only_ConfigTable[];

#ifdef SDT
XRead_only_Config *XRead_only_LookupConfig(UINTPTR BaseAddress) {
	XRead_only_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XRead_only_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XRead_only_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XRead_only_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XRead_only_Initialize(XRead_only *InstancePtr, UINTPTR BaseAddress) {
	XRead_only_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XRead_only_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XRead_only_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XRead_only_Config *XRead_only_LookupConfig(u16 DeviceId) {
	XRead_only_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XREAD_ONLY_NUM_INSTANCES; Index++) {
		if (XRead_only_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XRead_only_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XRead_only_Initialize(XRead_only *InstancePtr, u16 DeviceId) {
	XRead_only_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XRead_only_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XRead_only_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

