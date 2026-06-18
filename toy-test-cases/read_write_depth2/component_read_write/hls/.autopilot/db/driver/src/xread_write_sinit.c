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
#include "xread_write.h"

extern XRead_write_Config XRead_write_ConfigTable[];

#ifdef SDT
XRead_write_Config *XRead_write_LookupConfig(UINTPTR BaseAddress) {
	XRead_write_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XRead_write_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XRead_write_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XRead_write_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XRead_write_Initialize(XRead_write *InstancePtr, UINTPTR BaseAddress) {
	XRead_write_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XRead_write_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XRead_write_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XRead_write_Config *XRead_write_LookupConfig(u16 DeviceId) {
	XRead_write_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XREAD_WRITE_NUM_INSTANCES; Index++) {
		if (XRead_write_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XRead_write_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XRead_write_Initialize(XRead_write *InstancePtr, u16 DeviceId) {
	XRead_write_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XRead_write_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XRead_write_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

