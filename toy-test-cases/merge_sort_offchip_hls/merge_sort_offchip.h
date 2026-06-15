#ifndef MERGE_SORT_OFFCHIP_H
#define MERGE_SORT_OFFCHIP_H

static const int SORT_SIZE = 64;

void merge_sort_offchip_hls(const int in[SORT_SIZE], int scratch_a[SORT_SIZE],
                            int scratch_b[SORT_SIZE], int out[SORT_SIZE]);

#endif
