### Improve Matrix Multiplication through SIMD
#### How to run
1. prepare Linux running environment, these codes are tested on VMware Ubuntu 18.04
2. use `sudo cat /proc/cpuinfo | grep -i sse`, `sudo cat /proc/cpuinfo | grep -i avx`, ... check whether support SIMD and their version
3. install gcc, perf, vim, git...that the tools are used later
4. use `gcc -o test.out -msse -mavx test.c -w` get excutable file
  - `-msse` and `-mavx` are used to compile SIMD instructions, more details see https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html
  - `-w` means not show warnings
5. use `./test.out` to run. suppose `m0(m, r) = m1(m, n) x m2(n, r)`, use arg `-m` `-n` `-r` set the value of them (n must statisfy`n % 8 == 0`)
  can also complete above works by `source run.sh`
6. others:
  - use `gcc -msse -mavx test.c -S` check assembly code
  - if you use common matrix multiplication, can try `gcc test.c -O1 -ftree-vectorize -S` auto generate SIMD improved codes.

#### About Codes
目前实现了三种矩阵乘算法，一种是普通的矩阵乘，另外两种分别基于SSE和AVX优化。在main函数末尾解注释其中一个即可使用。
矩阵的大小可使用命令行参数或直接修改代码进行设定。
矩阵使用固定种子的随机数初始化。

#### References
[1] https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html  
[2] https://blog.csdn.net/yaojingqingcheng/article/details/121616954

#### TODO
- GEMM
- Timing method mentioned in lab_1/2 and lab_multithreading(current code just use perf simply)
