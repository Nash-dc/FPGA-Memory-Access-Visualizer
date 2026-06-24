#include "read_write.h"

void read(
    int * mem,
    const int offset_start,
    hls::stream<int>& out_stream
    )
{
  for(int i = 0; i < NUM_BLOCK; i++){
    const int off = offset_start + i*STRIDE;
    for(int j = 0; j < BLOCK_LENGTH; j++){
      #pragma HLS pipeline II=1
      out_stream.write(mem[off+j]);
    }
  }
}

void write(
    int * mem,
    const int offset_start,
    hls::stream<int>& in_stream
    )
{
  for(int i = 0; i < NUM_BLOCK; i++){
    const int off = offset_start + i*STRIDE;
    for(int j = 0; j < BLOCK_LENGTH; j++){
      #pragma HLS pipeline II=4
      mem[off+j] = in_stream.read();
    }
  }
}

void sum(
    hls::stream<int> stream[2],
    int & res
    )
{
  for(int i = 0; i < N; i++){
    #pragma HLS pipeline II=1
    res += stream[0].read() * stream[1].read();
  }
}

void read_write(
    int * mem_0,
    int * mem_1
    )
{
#pragma HLS interface m_axi port=mem_0  bundle=mem_0 depth=4096 num_read_outstanding=1
#pragma HLS interface m_axi port=mem_1  bundle=mem_1 depth=4096 num_read_outstanding=1

#pragma HLS dataflow
  hls::stream<int,DEPTH> stream[2];
  read(mem_0,0,     stream[0]);
  read(mem_1,BLOCK_LENGTH,stream[1]);
  write(mem_0,N*2+0,stream[0]);
  write(mem_1,N*2+BLOCK_LENGTH,stream[1]);
}

void read_only (
    int * mem_0,
    int * mem_1,
    int & res
    )
{
#pragma HLS interface m_axi port=mem_0  bundle=mem_0 depth=4096
#pragma HLS interface m_axi port=mem_1  bundle=mem_1 depth=4096
#pragma HLS interface s_axilite port=res

#pragma HLS dataflow
  hls::stream<int,DEPTH> stream[2];
  for(int i = 0; i < N; i++){
    #pragma HLS pipeline II=1
    stream[0].write(mem_0[i]);
  }
  for(int i = 0; i < N; i++){
    #pragma HLS pipeline II=1
    stream[1].write(mem_1[N+ i]);
  }

  sum(stream,res);
}
