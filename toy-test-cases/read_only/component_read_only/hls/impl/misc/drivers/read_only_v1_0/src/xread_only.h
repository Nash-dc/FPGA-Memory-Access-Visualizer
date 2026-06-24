// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XREAD_ONLY_H
#define XREAD_ONLY_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xread_only_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_BaseAddress;
} XRead_only_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XRead_only;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XRead_only_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XRead_only_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XRead_only_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XRead_only_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XRead_only_Initialize(XRead_only *InstancePtr, UINTPTR BaseAddress);
XRead_only_Config* XRead_only_LookupConfig(UINTPTR BaseAddress);
#else
int XRead_only_Initialize(XRead_only *InstancePtr, u16 DeviceId);
XRead_only_Config* XRead_only_LookupConfig(u16 DeviceId);
#endif
int XRead_only_CfgInitialize(XRead_only *InstancePtr, XRead_only_Config *ConfigPtr);
#else
int XRead_only_Initialize(XRead_only *InstancePtr, const char* InstanceName);
int XRead_only_Release(XRead_only *InstancePtr);
#endif

void XRead_only_Start(XRead_only *InstancePtr);
u32 XRead_only_IsDone(XRead_only *InstancePtr);
u32 XRead_only_IsIdle(XRead_only *InstancePtr);
u32 XRead_only_IsReady(XRead_only *InstancePtr);
void XRead_only_Continue(XRead_only *InstancePtr);
void XRead_only_EnableAutoRestart(XRead_only *InstancePtr);
void XRead_only_DisableAutoRestart(XRead_only *InstancePtr);

void XRead_only_Set_mem_0_r(XRead_only *InstancePtr, u64 Data);
u64 XRead_only_Get_mem_0_r(XRead_only *InstancePtr);
void XRead_only_Set_mem_1_r(XRead_only *InstancePtr, u64 Data);
u64 XRead_only_Get_mem_1_r(XRead_only *InstancePtr);
void XRead_only_Set_res_i(XRead_only *InstancePtr, u32 Data);
u32 XRead_only_Get_res_i(XRead_only *InstancePtr);
u32 XRead_only_Get_res_o(XRead_only *InstancePtr);

void XRead_only_InterruptGlobalEnable(XRead_only *InstancePtr);
void XRead_only_InterruptGlobalDisable(XRead_only *InstancePtr);
void XRead_only_InterruptEnable(XRead_only *InstancePtr, u32 Mask);
void XRead_only_InterruptDisable(XRead_only *InstancePtr, u32 Mask);
void XRead_only_InterruptClear(XRead_only *InstancePtr, u32 Mask);
u32 XRead_only_InterruptGetEnabled(XRead_only *InstancePtr);
u32 XRead_only_InterruptGetStatus(XRead_only *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
