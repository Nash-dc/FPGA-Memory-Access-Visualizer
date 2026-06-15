// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XMERGE_SORT_HLS_H
#define XMERGE_SORT_HLS_H

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
#include "xmerge_sort_hls_hw.h"

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
} XMerge_sort_hls_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XMerge_sort_hls;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XMerge_sort_hls_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XMerge_sort_hls_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XMerge_sort_hls_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XMerge_sort_hls_ReadReg(BaseAddress, RegOffset) \
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
int XMerge_sort_hls_Initialize(XMerge_sort_hls *InstancePtr, UINTPTR BaseAddress);
XMerge_sort_hls_Config* XMerge_sort_hls_LookupConfig(UINTPTR BaseAddress);
#else
int XMerge_sort_hls_Initialize(XMerge_sort_hls *InstancePtr, u16 DeviceId);
XMerge_sort_hls_Config* XMerge_sort_hls_LookupConfig(u16 DeviceId);
#endif
int XMerge_sort_hls_CfgInitialize(XMerge_sort_hls *InstancePtr, XMerge_sort_hls_Config *ConfigPtr);
#else
int XMerge_sort_hls_Initialize(XMerge_sort_hls *InstancePtr, const char* InstanceName);
int XMerge_sort_hls_Release(XMerge_sort_hls *InstancePtr);
#endif

void XMerge_sort_hls_Start(XMerge_sort_hls *InstancePtr);
u32 XMerge_sort_hls_IsDone(XMerge_sort_hls *InstancePtr);
u32 XMerge_sort_hls_IsIdle(XMerge_sort_hls *InstancePtr);
u32 XMerge_sort_hls_IsReady(XMerge_sort_hls *InstancePtr);
void XMerge_sort_hls_EnableAutoRestart(XMerge_sort_hls *InstancePtr);
void XMerge_sort_hls_DisableAutoRestart(XMerge_sort_hls *InstancePtr);

void XMerge_sort_hls_Set_in_r(XMerge_sort_hls *InstancePtr, u64 Data);
u64 XMerge_sort_hls_Get_in_r(XMerge_sort_hls *InstancePtr);
void XMerge_sort_hls_Set_out_r(XMerge_sort_hls *InstancePtr, u64 Data);
u64 XMerge_sort_hls_Get_out_r(XMerge_sort_hls *InstancePtr);

void XMerge_sort_hls_InterruptGlobalEnable(XMerge_sort_hls *InstancePtr);
void XMerge_sort_hls_InterruptGlobalDisable(XMerge_sort_hls *InstancePtr);
void XMerge_sort_hls_InterruptEnable(XMerge_sort_hls *InstancePtr, u32 Mask);
void XMerge_sort_hls_InterruptDisable(XMerge_sort_hls *InstancePtr, u32 Mask);
void XMerge_sort_hls_InterruptClear(XMerge_sort_hls *InstancePtr, u32 Mask);
u32 XMerge_sort_hls_InterruptGetEnabled(XMerge_sort_hls *InstancePtr);
u32 XMerge_sort_hls_InterruptGetStatus(XMerge_sort_hls *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
