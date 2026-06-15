# Off-chip Merge Sort HLS Test Case

This variant is designed to stress transaction dependencies between off-chip
buffers. It copies `in` to `scratch_a`, then every merge pass reads one scratch
buffer from global memory and writes the other scratch buffer back to global
memory. The final pass copies the selected scratch buffer to `out`.

Top-level function:

```cpp
void merge_sort_offchip_hls(const int in[SORT_SIZE], int scratch_a[SORT_SIZE],
                            int scratch_b[SORT_SIZE], int out[SORT_SIZE]);
```
