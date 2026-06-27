#include "matmul_row_col.h"

void matmul_row_col(const int a[MATRIX_SIZE], const int b[MATRIX_SIZE],
                    int c[OUTPUT_SIZE]) {
#pragma HLS INTERFACE m_axi port=a offset=slave bundle=gmem_a depth=MATRIX_SIZE max_read_burst_length=16 max_widen_bitwidth=512
#pragma HLS INTERFACE m_axi port=b offset=slave bundle=gmem_b depth=MATRIX_SIZE max_read_burst_length=16 max_widen_bitwidth=512
#pragma HLS INTERFACE m_axi port=c offset=slave bundle=gmem_c depth=OUTPUT_SIZE max_write_burst_length=1 max_widen_bitwidth=32

#pragma HLS INTERFACE s_axilite port=a bundle=control
#pragma HLS INTERFACE s_axilite port=b bundle=control
#pragma HLS INTERFACE s_axilite port=c bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control

  int A_row[MATRIX_DIM];
  int B_col[MATRIX_DIM];

row_loop:
  for (int row = 0; row < MATRIX_DIM; ++row) {
  col_loop: 
    for (int col = 0; col < MATRIX_DIM; ++col) {

load_ab_loop:
      for (int k = 0; k < MATRIX_DIM; ++k) {
#pragma HLS PIPELINE II=1
        A_row[k] = a[row * MATRIX_DIM + k];
        B_col[k] = b[k * MATRIX_DIM + col];
      }

      int sum = 0;

compute_element_loop:
      for (int k = 0; k < MATRIX_DIM; ++k) {
#pragma HLS PIPELINE II=1
        sum += A_row[k] * B_col[k];
      }

store_c_element:
      c[row * MATRIX_DIM + col] = sum;
    }
  }
}
