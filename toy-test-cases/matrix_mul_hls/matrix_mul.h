#ifndef MATRIX_MUL_H
#define MATRIX_MUL_H

constexpr int MATRIX_DIM = 16;
constexpr int MATRIX_SIZE = MATRIX_DIM * MATRIX_DIM;
constexpr int UNROLL_FACTOR = 4;

void matrix_mul(const int a[MATRIX_SIZE], const int b[MATRIX_SIZE],
                int c[MATRIX_SIZE]);

#endif
