#include "merge_sort.h"

static int min_int(int left, int right) {
#pragma HLS INLINE
  return left < right ? left : right;
}

void merge_sort_hls(const int in[SORT_SIZE], int out[SORT_SIZE]) {
#pragma HLS INTERFACE m_axi port=in offset=slave bundle=gmem_in depth=SORT_SIZE max_read_burst_length=16 max_widen_bitwidth=512
#pragma HLS INTERFACE m_axi port=out offset=slave bundle=gmem_out depth=SORT_SIZE max_write_burst_length=16 max_widen_bitwidth=512
#pragma HLS INTERFACE s_axilite port=in bundle=control
#pragma HLS INTERFACE s_axilite port=out bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control

  int buffer_a[SORT_SIZE];
  int buffer_b[SORT_SIZE];

load_input_loop:
  for (int i = 0; i < SORT_SIZE; ++i) {
#pragma HLS PIPELINE II=1
    buffer_a[i] = in[i];
  }

  bool source_is_a = true;

merge_width_loop:
  for (int width = 1; width < SORT_SIZE; width <<= 1) {
  merge_block_loop:
    for (int left = 0; left < SORT_SIZE; left += (width << 1)) {
      const int mid = min_int(left + width, SORT_SIZE);
      const int right = min_int(left + (width << 1), SORT_SIZE);
      if (source_is_a) {
        int i = left;
        int j = mid;
      merge_a_to_b_loop:
        for (int k = left; k < right; ++k) {
#pragma HLS PIPELINE II=1
          const bool take_left =
              (i < mid) && ((j >= right) || (buffer_a[i] <= buffer_a[j]));
          if (take_left) {
            buffer_b[k] = buffer_a[i];
            ++i;
          } else {
            buffer_b[k] = buffer_a[j];
            ++j;
          }
        }
      } else {
        int i = left;
        int j = mid;
      merge_b_to_a_loop:
        for (int k = left; k < right; ++k) {
#pragma HLS PIPELINE II=1
          const bool take_left =
              (i < mid) && ((j >= right) || (buffer_b[i] <= buffer_b[j]));
          if (take_left) {
            buffer_a[k] = buffer_b[i];
            ++i;
          } else {
            buffer_a[k] = buffer_b[j];
            ++j;
          }
        }
      }
    }
    source_is_a = !source_is_a;
  }

store_output_loop:
  for (int i = 0; i < SORT_SIZE; ++i) {
#pragma HLS PIPELINE II=1
    out[i] = source_is_a ? buffer_a[i] : buffer_b[i];
  }
}
