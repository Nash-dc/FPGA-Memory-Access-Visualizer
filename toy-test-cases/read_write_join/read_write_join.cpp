#include "read_write_join.h"

void read_blocks(
    int *mem,
    const int offset_start,
    hls::stream<int> &out_stream
    )
{
  for (int i = 0; i < NUM_BLOCK; i++) {
    const int off = offset_start + i * STRIDE;
    for (int j = 0; j < BLOCK_LENGTH; j++) {
      #pragma HLS pipeline II=1
      out_stream.write(mem[off + j]);
    }
  }
}

void join_and_write(
    int *mem,
    const int offset_start,
    hls::stream<int> &left_stream,
    hls::stream<int> &right_stream
    )
{
  for (int i = 0; i < NUM_BLOCK; i++) {
    const int off = offset_start + i * STRIDE;
    for (int j = 0; j < BLOCK_LENGTH; j++) {
      #pragma HLS pipeline II=1
      const int left = left_stream.read();
      const int right = right_stream.read();
      mem[off + j] = left + right;
    }
  }
}

void read_write_join(
    int *mem_0,
    int *mem_1
    )
{
#pragma HLS interface m_axi port=mem_0 bundle=mem_0 depth=4096
#pragma HLS interface m_axi port=mem_1 bundle=mem_1 depth=4096

#pragma HLS dataflow
  hls::stream<int, DEPTH> stream_0;
  hls::stream<int, DEPTH> stream_1;

  read_blocks(mem_0, 0, stream_0);
  read_blocks(mem_1, BLOCK_LENGTH, stream_1);
  join_and_write(mem_0, N * 2, stream_0, stream_1);
}
