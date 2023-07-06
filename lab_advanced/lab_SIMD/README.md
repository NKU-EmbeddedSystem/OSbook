### SIMD优化矩阵乘
#### 1. 环境配置
示例代码测试环境：(95服务器)  
- cpu: intel
- OS: Ubuntu
- 编译器：gcc 11.3.0

#### 2. 运行
- 检查机器是否支持以及支持什么版本的SIMD扩展指令集
  - `cat /proc/cpuinfo | grep -i sse`
  - `cat /proc/cpuinfo | grep -i avx`
- 运行脚本run.sh，自动完成程序编译及性能测试
  - `bash run.sh`
  - 或运行`bash make.sh`生成可执行文件后，直接运行该文件并用`-m` `-n` `-r`指定矩阵大小(需为8的倍数)，它们的默认值均为8

#### 3. 文件结构
- include/
  - test.h
- script/
  - clean.sh：删除编译生成的obj和bin文件夹及文件
  - make.sh：编译生成可执行文件bin/test
  - draw.py：从结果文件夹cost_time_*中读取数据，计算平均时间开销和加速比并绘制折线图；需要python3及matplotlib、numpy库
  - test.sh：设定矩阵乘使用的方法(cmn/sse/avx)、矩阵规模、测试次数后，运行可执行文件完成测试，最后执行draw.py统计数据、绘图
- src/
  - cmn.c：未优化矩阵乘
  - sse.c：SSE矩阵乘
  - avx.c：AVX矩阵乘
  - main.c：接收命令行参数，并按其初始化矩阵，完成一次测试
- run.sh：依次执行clean-make-test三个shell脚本
- test_loongson.c: 使用龙芯SIMD扩展（LSX与LASX）优化矩阵乘，包含一般矩阵乘实现。需在支持龙芯指令集的机器上测试，编译指令参考`gcc -o test.out -mlsx test.c`。（曾由龙芯对接同学测试）
