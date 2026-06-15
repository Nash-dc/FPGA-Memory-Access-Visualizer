// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XMATMUL_FULL_CONTIGUOUS_H
#define XMATMUL_FULL_CONTIGUOUS_H

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
#include "xmatmul_full_contiguous_hw.h"

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
} XMatmul_full_contiguous_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XMatmul_full_contiguous;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XMatmul_full_contiguous_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XMatmul_full_contiguous_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XMatmul_full_contiguous_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XMatmul_full_contiguous_ReadReg(BaseAddress, RegOffset) \
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
int XMatmul_full_contiguous_Initialize(XMatmul_full_contiguous *InstancePtr, UINTPTR BaseAddress);
XMatmul_full_contiguous_Config* XMatmul_full_contiguous_LookupConfig(UINTPTR BaseAddress);
#else
int XMatmul_full_contiguous_Initialize(XMatmul_full_contiguous *InstancePtr, u16 DeviceId);
XMatmul_full_contiguous_Config* XMatmul_full_contiguous_LookupConfig(u16 DeviceId);
#endif
int XMatmul_full_contiguous_CfgInitialize(XMatmul_full_contiguous *InstancePtr, XMatmul_full_contiguous_Config *ConfigPtr);
#else
int XMatmul_full_contiguous_Initialize(XMatmul_full_contiguous *InstancePtr, const char* InstanceName);
int XMatmul_full_contiguous_Release(XMatmul_full_contiguous *InstancePtr);
#endif

void XMatmul_full_contiguous_Start(XMatmul_full_contiguous *InstancePtr);
u32 XMatmul_full_contiguous_IsDone(XMatmul_full_contiguous *InstancePtr);
u32 XMatmul_full_contiguous_IsIdle(XMatmul_full_contiguous *InstancePtr);
u32 XMatmul_full_contiguous_IsReady(XMatmul_full_contiguous *InstancePtr);
void XMatmul_full_contiguous_EnableAutoRestart(XMatmul_full_contiguous *InstancePtr);
void XMatmul_full_contiguous_DisableAutoRestart(XMatmul_full_contiguous *InstancePtr);

void XMatmul_full_contiguous_Set_a(XMatmul_full_contiguous *InstancePtr, u64 Data);
u64 XMatmul_full_contiguous_Get_a(XMatmul_full_contiguous *InstancePtr);
void XMatmul_full_contiguous_Set_b(XMatmul_full_contiguous *InstancePtr, u64 Data);
u64 XMatmul_full_contiguous_Get_b(XMatmul_full_contiguous *InstancePtr);
void XMatmul_full_contiguous_Set_c(XMatmul_full_contiguous *InstancePtr, u64 Data);
u64 XMatmul_full_contiguous_Get_c(XMatmul_full_contiguous *InstancePtr);

void XMatmul_full_contiguous_InterruptGlobalEnable(XMatmul_full_contiguous *InstancePtr);
void XMatmul_full_contiguous_InterruptGlobalDisable(XMatmul_full_contiguous *InstancePtr);
void XMatmul_full_contiguous_InterruptEnable(XMatmul_full_contiguous *InstancePtr, u32 Mask);
void XMatmul_full_contiguous_InterruptDisable(XMatmul_full_contiguous *InstancePtr, u32 Mask);
void XMatmul_full_contiguous_InterruptClear(XMatmul_full_contiguous *InstancePtr, u32 Mask);
u32 XMatmul_full_contiguous_InterruptGetEnabled(XMatmul_full_contiguous *InstancePtr);
u32 XMatmul_full_contiguous_InterruptGetStatus(XMatmul_full_contiguous *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
