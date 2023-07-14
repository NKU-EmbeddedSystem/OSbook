### 进阶实验篇第5章：面向硬件加速器的优化_SIMD部分
#### 1. 实验介绍
分别实现了龙芯、Intel两种SIMD扩展优化矩阵乘的代码：  
- 龙芯：test_loongson.c  
- Intel：test_intel.c  

其中，test_loongson.c包含一般矩阵乘方法与LSX、LASX优化的矩阵乘方法，test_intel.c包含一般矩阵乘方法与SSE、AVX优化的矩阵乘方法。  
在input文件夹下设置矩阵规模后，程序将运行选定矩阵乘方法10次，计算每次运行的平均时间开销并记录到output文件夹下。  
input文件夹下提供了查看加速比的脚本compare.py。  

#### 2. 运行方式
(1) 编译：  
i. 准备工作：  
&nbsp;在input文件夹下按照示例"input1.txt"的格式，新建一个输入文件并写入矩阵规模   
&nbsp;将代码中读写文件部分的文件名改为你想要的  
&nbsp;**注释不需要的函数**  
ii. 控制台编译指令示例：  
&nbsp;`一般(cmn)`: gcc -o test_cmn test_x.c  
&nbsp;`SSE`: gcc -o test_sse -msse test_intel.c  
&nbsp;`AVX`: gcc -o test_avx -mavx test_intel.c  
&nbsp;`LSX`: gcc -o test_lsx -mlsx test_loongson.c  
&nbsp;`LASX`: gcc -o test_lasx -mlasx test_loongson.c  
iii. 运行可执行文件: 指令示例"./test_xxx"  
测试结果（时间开销）在output文件夹下  
完成一种SIMD扩展的所有测试后，可运行compare.py查看加速比  

#### 3. 目录结构
- input
  - compare.py: 完成龙芯SIMD优化矩阵乘所有测试(cmn,lsx,lasx)或intel的所有测试(cmn,sse,avx)后，使用该脚本查看加速比
  - input1.txt：程序输入示例，用于设定矩阵规模
- output
  - avx_input1.txt：输出示例
  - cmn_input1.txt：输出示例
  - sse_input1.txt：输出示例
- test_intel.c：Intel SIMD优化矩阵乘
- test_loongson.c：龙芯SIMD优化矩阵乘
