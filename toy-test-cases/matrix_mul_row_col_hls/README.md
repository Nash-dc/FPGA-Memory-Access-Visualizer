# Matrix Row/Column Test Case

This test case computes a complete 16 by 16 matrix multiplication.

For each output element, the off-chip access pattern is intentionally simple:

```text
read A row:    a[row*16 + 0], ..., a[row*16 + 15]
read B column: b[0*16 + col], b[1*16 + col], ..., b[15*16 + col]
write C:       c[row*16 + col]
```

It demonstrates:

- contiguous A row access
- strided B column access
- element-level dependency for every output element
