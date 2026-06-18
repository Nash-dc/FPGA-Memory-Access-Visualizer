#include "read_write.h"
#include <cstdio>

int main(){
  int mem_0[N*4];
  int mem_1[N*4];
  int ref_0[N*4];
  int ref_1[N*4];

  for(int i = 0; i < N*4; i++){
    mem_0[i] = i;
    mem_1[i] = 10000 + i;
    ref_0[i] = mem_0[i];
    ref_1[i] = mem_1[i];
  }

  for(int i = 0; i < NUM_BLOCK; i++){
    const int src_0 = i * STRIDE;
    const int dst_0 = N * 2 + i * STRIDE;
    const int src_1 = BLOCK_LENGTH + i * STRIDE;
    const int dst_1 = N * 2 + BLOCK_LENGTH + i * STRIDE;

    for(int j = 0; j < BLOCK_LENGTH; j++){
      ref_0[dst_0 + j] = ref_0[src_0 + j];
      ref_1[dst_1 + j] = ref_1[src_1 + j];
    }
  }

  read_write(mem_0, mem_1);

  for(int i = 0; i < N*4; i++){
    if(mem_0[i] != ref_0[i]){
      printf("Read Write: mem_0 test failed at index %d, expected %d, got %d\n",
             i, ref_0[i], mem_0[i]);
      return 1;
    }
    if(mem_1[i] != ref_1[i]){
      printf("Read Write: mem_1 test failed at index %d, expected %d, got %d\n",
             i, ref_1[i], mem_1[i]);
      return 1;
    }
  }

  printf("Read Write test passed\n");
  return 0;
}
