extern "C" void mem_test_kernel(int* A, int* B, int N) {
  #pragma HLS INTERFACE m_axi port=A offset=slave bundle=gmem0
  #pragma HLS INTERFACE m_axi port=B offset=slave bundle=gmem1
  for (int i = 0; i < N; i++) {
    B[i] = A[i] + 1;
  }
}
