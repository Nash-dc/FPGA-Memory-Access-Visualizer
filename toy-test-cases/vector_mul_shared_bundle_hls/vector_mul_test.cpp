#include "vector_mul.h"

#include <cstdio>

int main() {
  int in1[VECTOR_SIZE];
  int in2[VECTOR_SIZE];
  int out[VECTOR_SIZE] = {};

  for (int x = 0; x < VECTOR_SIZE; ++x) {
    in1[x] = x + 1;
    in2[x] = 2 * x - 3;
  }

  vector_mul(in1, in2, out);

  for (int x = 0; x < VECTOR_SIZE; ++x) {
    const int expected = in1[x] * in2[x];
    if (out[x] != expected) {
      std::printf("Mismatch at %d: expected %d, got %d\n", x, expected,
                  out[x]);
      return 1;
    }
  }

  std::puts("TEST PASSED");
  return 0;
}
