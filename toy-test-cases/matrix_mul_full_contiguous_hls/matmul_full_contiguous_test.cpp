#include "matmul_full_contiguous.h"

#include <cstdio>

int main() {
  int a[MATRIX_SIZE];
  int b[MATRIX_SIZE];
  int c[MATRIX_SIZE] = {};

  for (int row = 0; row < MATRIX_DIM; ++row) {
    for (int col = 0; col < MATRIX_DIM; ++col) {
      const int index = row * MATRIX_DIM + col;
      a[index] = row + col + 1;
      b[index] = 3 * row - col + 2;
    }
  }

  matmul_full_contiguous(a, b, c);

  for (int row = 0; row < MATRIX_DIM; ++row) {
    for (int col = 0; col < MATRIX_DIM; ++col) {
      int expected = 0;
      for (int k = 0; k < MATRIX_DIM; ++k) {
        expected += a[row * MATRIX_DIM + k] * b[k * MATRIX_DIM + col];
      }

      const int index = row * MATRIX_DIM + col;
      if (c[index] != expected) {
        std::printf("Mismatch at (%d, %d): expected %d, got %d\n", row, col,
                    expected, c[index]);
        return 1;
      }
    }
  }

  std::puts("TEST PASSED");
  return 0;
}
