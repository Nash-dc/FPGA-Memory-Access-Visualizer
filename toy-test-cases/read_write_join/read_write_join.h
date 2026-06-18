#pragma once
#include "hls_stream.h"

#define BLOCK_LENGTH 128
#define NUM_BLOCK 8
#define N (BLOCK_LENGTH * NUM_BLOCK)
#define STRIDE (BLOCK_LENGTH * 2)

#define DEPTH 2

extern "C" {
void read_write_join(
    int *mem_0,
    int *mem_1
    );
}
