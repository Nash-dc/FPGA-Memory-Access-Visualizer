#include "matrix_mul.h"

void matrix_mul(const int a[MATRIX_SIZE],
                const int b[MATRIX_SIZE],
                int c[MATRIX_SIZE]) {
  static_assert(MATRIX_DIM % UNROLL_FACTOR == 0,
                "MATRIX_DIM must be a multiple of UNROLL_FACTOR");

#pragma HLS INTERFACE m_axi port=a offset=slave bundle=gmem_a depth=MATRIX_SIZE max_read_burst_length=1 max_widen_bitwidth=512
#pragma HLS INTERFACE m_axi port=b offset=slave bundle=gmem_b depth=MATRIX_SIZE max_read_burst_length=1 max_widen_bitwidth=512
#pragma HLS INTERFACE m_axi port=c offset=slave bundle=gmem_c depth=MATRIX_SIZE max_write_burst_length=1 max_widen_bitwidth=512

#pragma HLS INTERFACE s_axilite port=a bundle=control
#pragma HLS INTERFACE s_axilite port=b bundle=control
#pragma HLS INTERFACE s_axilite port=c bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control

  int A_tile[MATRIX_DIM][UNROLL_FACTOR];
  int B_tile[UNROLL_FACTOR][MATRIX_DIM];
  int C_local[MATRIX_DIM][MATRIX_DIM];

#pragma HLS ARRAY_PARTITION variable=A_tile complete dim=2
#pragma HLS ARRAY_PARTITION variable=B_tile complete dim=1
#pragma HLS ARRAY_PARTITION variable=C_local cyclic factor=UNROLL_FACTOR dim=2

init_c_loop:
  for (int row = 0; row < MATRIX_DIM; ++row) {
  init_c_col_loop:
    for (int col = 0; col < MATRIX_DIM; ++col) {
#pragma HLS PIPELINE II=1
      C_local[row][col] = 0;
    }
  }

k_tile_loop:
  for (int k0 = 0; k0 < MATRIX_DIM; k0 += UNROLL_FACTOR) {

  load_a_tile_row_loop:
    for (int row = 0; row < MATRIX_DIM; ++row) {
    load_a_tile_lane_loop:
      for (int lane = 0; lane < UNROLL_FACTOR; ++lane) {
#pragma HLS PIPELINE II=1
        A_tile[row][lane] = a[row * MATRIX_DIM + k0 + lane];
      }
    }

  load_b_tile_lane_loop:
    for (int lane = 0; lane < UNROLL_FACTOR; ++lane) {
    load_b_tile_col_loop:
      for (int col = 0; col < MATRIX_DIM; ++col) {
#pragma HLS PIPELINE II=1
        B_tile[lane][col] = b[(k0 + lane) * MATRIX_DIM + col];
      }
    }

  compute_row_loop:
    for (int row = 0; row < MATRIX_DIM; ++row) {
    compute_col_loop:
      for (int col = 0; col < MATRIX_DIM; ++col) {
#pragma HLS PIPELINE II=1
#pragma HLS DEPENDENCE variable=C_local inter false

        int sum = C_local[row][col];

      compute_lane_loop:
        for (int lane = 0; lane < UNROLL_FACTOR; ++lane) {
#pragma HLS UNROLL
          sum += A_tile[row][lane] * B_tile[lane][col];
        }

        C_local[row][col] = sum;
      }
    }
  }

store_c_loop:
  for (int index = 0; index < MATRIX_SIZE; ++index) {
#pragma HLS PIPELINE II=1
    c[index] = C_local[index / MATRIX_DIM][index % MATRIX_DIM];
  }
}