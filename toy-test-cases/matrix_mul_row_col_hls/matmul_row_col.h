#ifndef MATMUL_ROW_COL_H
#define MATMUL_ROW_COL_H

constexpr int MATRIX_DIM = 16;
constexpr int MATRIX_SIZE = MATRIX_DIM * MATRIX_DIM;
constexpr int OUTPUT_SIZE = MATRIX_SIZE;

void matmul_row_col(const int a[MATRIX_SIZE], const int b[MATRIX_SIZE],
                    int c[OUTPUT_SIZE]);

#endif
