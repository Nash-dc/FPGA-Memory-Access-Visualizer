#ifndef MATMUL_FULL_CONTIGUOUS_H
#define MATMUL_FULL_CONTIGUOUS_H

constexpr int MATRIX_DIM = 16;
constexpr int MATRIX_SIZE = MATRIX_DIM * MATRIX_DIM;

void matmul_full_contiguous(const int a[MATRIX_SIZE],
                            const int b[MATRIX_SIZE],
                            int c[MATRIX_SIZE]);

#endif
