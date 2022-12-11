# Cache optimization for GEMM 

### How it works

We follow the gemm implementation of GotoBLAS.
Here is a brief introduction of how it works:
```
1. Cutting the multiplied matrix into multiple blocks and multiple each block seperately. With this method, we can reduce much of the memory access. Moreover, this method can be done recursively, which means cutting the matrix block into smaller blocks.
2. We use pre-defined parameters to put the block of matrix into different cache-level. For instance, we can put block of left matrix into llc and put the mini-block of right matrix into l2 cache so that we can reduce the cache miss into minimal ratio and improve the overall throughput.
```
### Reference
https://arxiv.org/pdf/1609.00076.pdf

https://link.springer.com/content/pdf/10.1007/3-540-45545-0_15.pdf

https://github.com/flame/how-to-optimize-gemm

https://github.com/xianyi/OpenBLAS

https://www.tacc.utexas.edu/research-development/tacc-software/gotoblas2