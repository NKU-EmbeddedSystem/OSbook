# 进阶篇实验5：面向硬件加速器的优化_SIMD部分
## 实验介绍
分别实现了龙芯、Intel两种SIMD扩展优化矩阵乘的代码：  
- 龙芯：test_loongson_*.c  
- Intel：test_intel_*.c

以及一般矩阵乘：test_cmn.c  

其中，test_loongson_*.c包含一般矩阵乘方法与LSX、LASX优化的矩阵乘方法，test_intel_*.c包含一般矩阵乘方法与SSE、AVX优化的矩阵乘方法。  
input文件夹下提供了四种规模(128/256/512/1024)的矩阵输入，以及它们进行矩阵乘后的标准答案(`output/standard_result`)。

## 运行方式 
### 方法一：直接使用脚本
`bash run_intel.sh` 或 `bash run_loongson.sh`  

### 方法二：分步执行
1. 生成输入数据（可选，input文件夹下已提供示例）：`python3 generate.py`（需要numpy库）
2. 将代码编译为可执行文件：指令示例`gcc -o test_sse -msse test_intel_sse.c`（推荐按照示例格式`test_*`命名可执行文件）
3. 运行可执行文件：指令示例`./test_sse 128`，128为矩阵规模
4. 自查矩阵乘正确性（可选）：`python3 check.py cmn 128`，cmn为矩阵乘所用方法，128为矩阵规模
5. 查看加速比：请完成某一架构的所有测试后，使用`python3 speedup_ratio.py <arch> <size>`查看加速比。示例：完成intel的cmn,sse和avx的测试后，使用指令`python3 speedup_ratio.py intel 128`查看sse和avx相对于cmn的加速比

## 目录结构

```
lab_SIMD/
├── check.py            -- 对比result与standard_result，用于自查矩阵乘实现的正确性
├── generate.py         -- 生成程序输入，需要numpy库
├── input               -- 程序输入(两个矩阵四种规模)示例，可使用generate.py重新生成
│   ├── A_1024.txt
│   ├── A_128.txt
│   ├── A_256.txt
│   ├── A_512.txt
│   ├── B_1024.txt
│   ├── B_128.txt
│   ├── B_256.txt
│   └── B_512.txt
├── output              
│   ├── result          -- 存放程序输出的结果矩阵
│   ├── standard_result -- 标准答案，由generate.py生成程序输入时一起生成
│   │   ├── C_1024.txt
│   │   ├── C_128.txt
│   │   ├── C_256.txt
│   │   └── C_512.txt
│   └── time            -- 存放程序输出的一次矩阵乘平均执行时间，可用于计算加速比
├── README.md
├── run_intel.sh        -- 执行该脚本即可完成所有在Intel平台的测试
├── run_loongson.sh     -- 执行该脚本即可完成所有在龙芯平台的测试
├── speedup_ratio.py    -- 完成龙芯SIMD优化矩阵乘所有测试(cmn,lsx,lasx)或intel的所有测试(cmn,sse,avx)后，使用该脚本查看加速比
├── test_cmn.c          -- 一般矩阵乘实现
├── test_intel_avx.c    -- Intel SSE 优化矩阵乘
├── test_intel_sse.c    -- Intel AVX 优化矩阵乘
├── test_loongson_lasx.c-- 龙芯LSX优化矩阵乘
└── test_loongson_lsx.c -- 龙芯LASX优化矩阵乘
```
