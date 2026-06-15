#include "merge_sort.h"

#include <cstdio>

static void reference_sort(const int in[SORT_SIZE], int out[SORT_SIZE]) {
  for (int i = 0; i < SORT_SIZE; ++i)
    out[i] = in[i];

  for (int i = 1; i < SORT_SIZE; ++i) {
    int value = out[i];
    int j = i - 1;
    while (j >= 0 && out[j] > value) {
      out[j + 1] = out[j];
      --j;
    }
    out[j + 1] = value;
  }
}

int main() {
  int in[SORT_SIZE];
  int out[SORT_SIZE] = {};
  int expected[SORT_SIZE] = {};

  for (int i = 0; i < SORT_SIZE; ++i) {
    int value = (SORT_SIZE - i) * 7;
    value ^= (i * 19 + 11);
    value %= 97;
    in[i] = value - 48;
  }

  merge_sort_hls(in, out);
  reference_sort(in, expected);

  for (int i = 0; i < SORT_SIZE; ++i) {
    if (out[i] != expected[i]) {
      std::printf("Mismatch at %d: expected %d, got %d\n", i, expected[i],
                  out[i]);
      return 1;
    }
  }

  std::puts("TEST PASSED");
  return 0;
}
