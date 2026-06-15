#include "merge_sort_offchip.h"

static int min_int(int left, int right) {
#pragma HLS INLINE
  return left < right ? left : right;
}

void merge_sort_offchip_hls(const int in[SORT_SIZE], int scratch_a[SORT_SIZE],
                            int scratch_b[SORT_SIZE], int out[SORT_SIZE]) {
#pragma HLS INTERFACE m_axi port=in offset=slave bundle=gmem_in depth=SORT_SIZE max_read_burst_length=16 max_widen_bitwidth=64
#pragma HLS INTERFACE m_axi port=scratch_a offset=slave bundle=gmem_scratch_a depth=SORT_SIZE max_read_burst_length=16 max_write_burst_length=16 max_widen_bitwidth=32
#pragma HLS INTERFACE m_axi port=scratch_b offset=slave bundle=gmem_scratch_b depth=SORT_SIZE max_read_burst_length=16 max_write_burst_length=16 max_widen_bitwidth=32
#pragma HLS INTERFACE m_axi port=out offset=slave bundle=gmem_out depth=SORT_SIZE max_write_burst_length=16 max_widen_bitwidth=512
#pragma HLS INTERFACE s_axilite port=in bundle=control
#pragma HLS INTERFACE s_axilite port=scratch_a bundle=control
#pragma HLS INTERFACE s_axilite port=scratch_b bundle=control
#pragma HLS INTERFACE s_axilite port=out bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control

copy_input_to_scratch_a:
  for (int i = 0; i < SORT_SIZE; ++i) {
#pragma HLS PIPELINE II=1
    scratch_a[i] = in[i];
  }

  bool source_is_a = true;

merge_width_loop:
  for (int width = 1; width < SORT_SIZE; width <<= 1) {
  merge_block_loop:
    for (int left = 0; left < SORT_SIZE; left += (width << 1)) {
      const int mid = min_int(left + width, SORT_SIZE);
      const int right = min_int(left + (width << 1), SORT_SIZE);

      int i = left;
      int j = mid;

    merge_element_loop:
      for (int k = left; k < right; ++k) {
#pragma HLS PIPELINE II=1
        if (source_is_a) {
          const int left_value = (i < mid) ? scratch_a[i] : 0;
          const int right_value = (j < right) ? scratch_a[j] : 0;
          const bool take_left =
              (i < mid) && ((j >= right) || (left_value <= right_value));
          if (take_left) {
            scratch_b[k] = left_value;
            ++i;
          } else {
            scratch_b[k] = right_value;
            ++j;
          }
        } else {
          const int left_value = (i < mid) ? scratch_b[i] : 0;
          const int right_value = (j < right) ? scratch_b[j] : 0;
          const bool take_left =
              (i < mid) && ((j >= right) || (left_value <= right_value));
          if (take_left) {
            scratch_a[k] = left_value;
            ++i;
          } else {
            scratch_a[k] = right_value;
            ++j;
          }
        }
      }
    }
    source_is_a = !source_is_a;
  }

copy_result_to_out:
  for (int i = 0; i < SORT_SIZE; ++i) {
#pragma HLS PIPELINE II=1
    out[i] = source_is_a ? scratch_a[i] : scratch_b[i];
  }
}
