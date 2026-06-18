#include "read_write_join.h"
#include <cstdio>

int main()
{
  int mem_0[N * 4];
  int mem_1[N * 4];
  int ref_0[N * 4];

  for (int i = 0; i < N * 4; i++) {
    mem_0[i] = i;
    mem_1[i] = 10000 + i;
    ref_0[i] = mem_0[i];
  }

  for (int i = 0; i < NUM_BLOCK; i++) {
    const int src_0 = i * STRIDE;
    const int src_1 = BLOCK_LENGTH + i * STRIDE;
    const int dst = N * 2 + i * STRIDE;
    for (int j = 0; j < BLOCK_LENGTH; j++) {
      ref_0[dst + j] = mem_0[src_0 + j] + mem_1[src_1 + j];
    }
  }

  read_write_join(mem_0, mem_1);

  for (int i = 0; i < N * 4; i++) {
    if (mem_0[i] != ref_0[i]) {
      printf("Read Write Join: mem_0 test failed at index %d, expected %d, got %d\n",
             i, ref_0[i], mem_0[i]);
      return 1;
    }
  }

  printf("Read Write Join test passed\n");
  return 0;
}
