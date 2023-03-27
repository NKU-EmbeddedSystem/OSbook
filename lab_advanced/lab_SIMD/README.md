### SIMD优化矩阵乘
#### 1. 环境配置
示例代码测试环境：  
- XXX配置的机器
- 编译器：gcc 11.3.0

#### 2. 运行
- 检查机器是否支持以及支持什么版本的SIMD扩展指令集
  - `cat /proc/cpuinfo | grep -i sse`
  - `cat /proc/cpuinfo | grep -i avx`
- 运行脚本run.sh，自动完成程序编译及性能测试
  - `bash run.sh`

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