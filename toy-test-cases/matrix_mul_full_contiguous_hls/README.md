# Matrix Full Contiguous Load Test Case

This test case computes a complete 16 by 16 matrix multiplication with full
contiguous off-chip phases:

```text
load full A/B in one pipelined loop:
  a[0], b[0], a[1], b[1], ..., a[255], b[255]
compute C entirely from local buffers
store C:     c[0], c[1], ..., c[255]
```

It demonstrates:

- full contiguous A and B load in one loop body
- local-buffer compute phase
- full contiguous C store
