### 进阶实验篇第5章：面向硬件加速器的优化_SIMD部分
#### 1. 内容介绍
分别实现了龙芯、Intel两种SIMD扩展优化矩阵乘的代码：  
- 龙芯：test_loongson.c  
- Intel：test_intel.c  

其中，test_loongson.c包含一般矩阵乘方法与LSX、LASX优化的矩阵乘方法，test_intel.c包含一般矩阵乘方法与SSE、AVX优化的矩阵乘方法。设置矩阵规模和矩阵乘方法后，运行该方法10次，可得每次运行的平均时间开销，并提供查看加速比的脚本。  

#### 2. 运行
(1) 编译：  
i. 准备工作：  
在input文件夹下按示例新建一个输入文件并写入矩阵规模  
将代码中读写文件部分的文件名改为你想要的  
**注释不需要的函数**  
ii. 控制台编译指令示例：  
`一般(cmn)`: gcc -o test_cmn test_x.c  
`SSE`: gcc -o test_sse -msse test_intel.c  
`AVX`: gcc -o test_avx -mavx test_intel.c  
`LSX`: gcc -o test_lsx -mlsx test_loongson.c  
`LASX`: gcc -o test_lasx -mlasx test_loongson.c  
iii. 运行可执行文件: 指令示例`./test_xxx`  
测试结果（时间开销）在output文件夹下  
完成一种SIMD扩展的所有测试后，可运行compare.py查看加速比  