// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
# 1 "/data/hls-dev/toy-test-cases/matrix_mul_full_contiguous_hls/matmul_full_contiguous.cpp"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 401 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "/data/hls-dev/toy-test-cases/matrix_mul_full_contiguous_hls/matmul_full_contiguous.cpp" 2
# 1 "/data/hls-dev/toy-test-cases/matrix_mul_full_contiguous_hls/matmul_full_contiguous.h" 1



constexpr int MATRIX_DIM = 16;
constexpr int MATRIX_SIZE = MATRIX_DIM * MATRIX_DIM;

void matmul_full_contiguous(const int a[MATRIX_SIZE],
                            const int b[MATRIX_SIZE],
                            int c[MATRIX_SIZE]);
# 2 "/data/hls-dev/toy-test-cases/matrix_mul_full_contiguous_hls/matmul_full_contiguous.cpp" 2

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
#ifndef HLS_FASTSIM
#ifdef __cplusplus
extern "C"
#endif
void apatb_matmul_full_contiguous_ir(const int *, const int *, int *);
#ifdef __cplusplus
extern "C"
#endif
void matmul_full_contiguous_hw_stub(const int *a, const int *b, int *c){
matmul_full_contiguous(a, b, c);
return ;
}
#ifdef __cplusplus
extern "C"
#endif
void refine_signal_handler();
#ifdef __cplusplus
extern "C"
#endif
void apatb_matmul_full_contiguous_sw(const int *a, const int *b, int *c){
refine_signal_handler();
apatb_matmul_full_contiguous_ir(a, b, c);
return ;
}
#endif
# 47 "/data/hls-dev/toy-test-cases/matrix_mul_full_contiguous_hls/matmul_full_contiguous.cpp"

