# Merge Sort HLS Test Case

This kernel is a fixed-size, bottom-up merge sort intended to stress the memory
access pass with local-buffer dependencies.

The top-level function is:

```cpp
void merge_sort_hls(const int in[SORT_SIZE], int out[SORT_SIZE]);
```

The kernel reads `in` from `gmem_in`, sorts through ping-pong local BRAM buffers,
and writes `out` to `gmem_out`.
