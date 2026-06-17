// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XREAD_WRITE_H
#define XREAD_WRITE_H

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
#include "xread_write_hw.h"

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
} XRead_write_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XRead_write;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XRead_write_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XRead_write_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XRead_write_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XRead_write_ReadReg(BaseAddress, RegOffset) \
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
int XRead_write_Initialize(XRead_write *InstancePtr, UINTPTR BaseAddress);
XRead_write_Config* XRead_write_LookupConfig(UINTPTR BaseAddress);
#else
int XRead_write_Initialize(XRead_write *InstancePtr, u16 DeviceId);
XRead_write_Config* XRead_write_LookupConfig(u16 DeviceId);
#endif
int XRead_write_CfgInitialize(XRead_write *InstancePtr, XRead_write_Config *ConfigPtr);
#else
int XRead_write_Initialize(XRead_write *InstancePtr, const char* InstanceName);
int XRead_write_Release(XRead_write *InstancePtr);
#endif

void XRead_write_Start(XRead_write *InstancePtr);
u32 XRead_write_IsDone(XRead_write *InstancePtr);
u32 XRead_write_IsIdle(XRead_write *InstancePtr);
u32 XRead_write_IsReady(XRead_write *InstancePtr);
void XRead_write_Continue(XRead_write *InstancePtr);
void XRead_write_EnableAutoRestart(XRead_write *InstancePtr);
void XRead_write_DisableAutoRestart(XRead_write *InstancePtr);

void XRead_write_Set_mem_0_r(XRead_write *InstancePtr, u64 Data);
u64 XRead_write_Get_mem_0_r(XRead_write *InstancePtr);
void XRead_write_Set_mem_1_r(XRead_write *InstancePtr, u64 Data);
u64 XRead_write_Get_mem_1_r(XRead_write *InstancePtr);

void XRead_write_InterruptGlobalEnable(XRead_write *InstancePtr);
void XRead_write_InterruptGlobalDisable(XRead_write *InstancePtr);
void XRead_write_InterruptEnable(XRead_write *InstancePtr, u32 Mask);
void XRead_write_InterruptDisable(XRead_write *InstancePtr, u32 Mask);
void XRead_write_InterruptClear(XRead_write *InstancePtr, u32 Mask);
u32 XRead_write_InterruptGetEnabled(XRead_write *InstancePtr);
u32 XRead_write_InterruptGetStatus(XRead_write *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
