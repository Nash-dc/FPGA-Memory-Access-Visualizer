// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XVECTOR_MUL_H
#define XVECTOR_MUL_H

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
#include "xvector_mul_hw.h"

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
} XVector_mul_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XVector_mul;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XVector_mul_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XVector_mul_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XVector_mul_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XVector_mul_ReadReg(BaseAddress, RegOffset) \
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
int XVector_mul_Initialize(XVector_mul *InstancePtr, UINTPTR BaseAddress);
XVector_mul_Config* XVector_mul_LookupConfig(UINTPTR BaseAddress);
#else
int XVector_mul_Initialize(XVector_mul *InstancePtr, u16 DeviceId);
XVector_mul_Config* XVector_mul_LookupConfig(u16 DeviceId);
#endif
int XVector_mul_CfgInitialize(XVector_mul *InstancePtr, XVector_mul_Config *ConfigPtr);
#else
int XVector_mul_Initialize(XVector_mul *InstancePtr, const char* InstanceName);
int XVector_mul_Release(XVector_mul *InstancePtr);
#endif

void XVector_mul_Start(XVector_mul *InstancePtr);
u32 XVector_mul_IsDone(XVector_mul *InstancePtr);
u32 XVector_mul_IsIdle(XVector_mul *InstancePtr);
u32 XVector_mul_IsReady(XVector_mul *InstancePtr);
void XVector_mul_EnableAutoRestart(XVector_mul *InstancePtr);
void XVector_mul_DisableAutoRestart(XVector_mul *InstancePtr);

void XVector_mul_Set_in1(XVector_mul *InstancePtr, u64 Data);
u64 XVector_mul_Get_in1(XVector_mul *InstancePtr);
void XVector_mul_Set_in2(XVector_mul *InstancePtr, u64 Data);
u64 XVector_mul_Get_in2(XVector_mul *InstancePtr);
void XVector_mul_Set_out_r(XVector_mul *InstancePtr, u64 Data);
u64 XVector_mul_Get_out_r(XVector_mul *InstancePtr);

void XVector_mul_InterruptGlobalEnable(XVector_mul *InstancePtr);
void XVector_mul_InterruptGlobalDisable(XVector_mul *InstancePtr);
void XVector_mul_InterruptEnable(XVector_mul *InstancePtr, u32 Mask);
void XVector_mul_InterruptDisable(XVector_mul *InstancePtr, u32 Mask);
void XVector_mul_InterruptClear(XVector_mul *InstancePtr, u32 Mask);
u32 XVector_mul_InterruptGetEnabled(XVector_mul *InstancePtr);
u32 XVector_mul_InterruptGetStatus(XVector_mul *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
