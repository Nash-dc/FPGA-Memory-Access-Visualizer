#include "vector_mul.h"

void vector_mul(const int in1[VECTOR_SIZE], const int in2[VECTOR_SIZE],
                int out[VECTOR_SIZE]) {
#pragma HLS INTERFACE m_axi port=in1 offset=slave bundle=gmem depth=VECTOR_SIZE max_read_burst_length=16
#pragma HLS INTERFACE m_axi port=in2 offset=slave bundle=gmem depth=VECTOR_SIZE max_read_burst_length=16
#pragma HLS INTERFACE m_axi port=out offset=slave bundle=gmem depth=VECTOR_SIZE max_write_burst_length=16
#pragma HLS INTERFACE s_axilite port=in1 bundle=control
#pragma HLS INTERFACE s_axilite port=in2 bundle=control
#pragma HLS INTERFACE s_axilite port=out bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control

vector_mul_loop:
  for (int x = 0; x < VECTOR_SIZE; ++x) {
#pragma HLS PIPELINE II=1
    out[x] = in1[x] * in2[x];
  }
}
