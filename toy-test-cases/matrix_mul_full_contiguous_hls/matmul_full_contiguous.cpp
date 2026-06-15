#include "matmul_full_contiguous.h"

void matmul_full_contiguous(const int a[MATRIX_SIZE],
                            const int b[MATRIX_SIZE],
                            int c[MATRIX_SIZE]) {
#pragma HLS INTERFACE m_axi port=a offset=slave bundle=gmem_a depth=MATRIX_SIZE max_read_burst_length=1 max_widen_bitwidth=512
#pragma HLS INTERFACE m_axi port=b offset=slave bundle=gmem_b depth=MATRIX_SIZE max_read_burst_length=1 max_widen_bitwidth=512
#pragma HLS INTERFACE m_axi port=c offset=slave bundle=gmem_c depth=MATRIX_SIZE max_write_burst_length=1 max_widen_bitwidth=512

#pragma HLS INTERFACE s_axilite port=a bundle=control
#pragma HLS INTERFACE s_axilite port=b bundle=control
#pragma HLS INTERFACE s_axilite port=c bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control

  int A_local[MATRIX_SIZE];
  int B_local[MATRIX_SIZE];
  int C_local[MATRIX_SIZE];

load_ab_full_loop:
  for (int index = 0; index < MATRIX_SIZE; ++index) {
#pragma HLS PIPELINE II=1
    A_local[index] = a[index];
    B_local[index] = b[index];
  }

compute_row_loop:
  for (int row = 0; row < MATRIX_DIM; ++row) {
  compute_col_loop:
    for (int col = 0; col < MATRIX_DIM; ++col) {
#pragma HLS PIPELINE II=1
      int sum = 0;

    compute_k_loop:
      for (int k = 0; k < MATRIX_DIM; ++k) {
        sum += A_local[row * MATRIX_DIM + k] * B_local[k * MATRIX_DIM + col];
      }

      C_local[row * MATRIX_DIM + col] = sum;
    }
  }

store_c_full_loop:
  for (int index = 0; index < MATRIX_SIZE; ++index) {
#pragma HLS PIPELINE II=1
    c[index] = C_local[index];
  }
}
