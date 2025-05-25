# 进阶实验5：面向硬件加速器的优化_OpenCL部分

## 实验介绍

本实验实现了基于OpenCL的矩阵乘法。在能够搭建编译OpenCL环境的情况下，基于OpenCL编写矩阵乘程序并进行编译执行，并能够进行性能评估。该实验可以在支持OpenCL的服务器或个人电脑上进行，操作系统可以是Ubuntu 20.04 LTS（不限制）。需要安装OpenCL SDK、相应的驱动程序，以及C/C++编译环境。具体使用流程请参考[这里](./Linux服务器下运行.md)。

## 运行方式

i. 准备工作：

修改data_gen.py代码中的shapes为自己计算矩阵维度，并生成python运行矩阵乘的时间，结果保存在output目录中。根据[这里](./Linux服务器下运行.md)配置相关环境。

如果需要更换不同的OpenCL代码，修改CMakeLists.txt文件中的代码，如将add_executable(test test.cpp)改为add_executable(test kernel.cpp)。

ii. 直接编译与执行
直接运行

```
bash opencl_linux_run.sh
```

## 目录结构

```
lab_OpenCL/
├── CMakeLists.txt		-- cmake构建系统所需的文件
├── check.sh			-- 打分脚本，会根据自己设定的维度进行矩阵乘得到的output/result内的结果进行打分
├── Linux服务器下运行.assets/
├── Linux服务器下运行.md
├── README.md
├── opencl_linux_run.sh	-- 在linux上运行的shell脚本，包括设置OpenCL环境变量，请确保cmake工具已经安装
├── data_gen.py			-- 随机生成相应维度的相乘的矩阵A，B，以及相乘的结果C    和在python上所需时间，可用于实验，默认已经生成了1000维度的且以此进行实验
├── input/
│   ├── shape_1000 		-- 由data_gen.py生成的进行计算的输入矩阵
│   └── compare.py		-- 比较python与OpenCL矩阵乘的时间与速度
├── matrix_multiply.cl			-- OpenCL内核代码，包含矩阵乘的实现
├── matrix_multiply.cpp			-- 主机端OpenCL程序，负责加载和执行OpenCL内核
├── output/
│   ├── result/
│   │	├── result_*.txt 	-- 实际的OpenCL进行计算的输出
│   │	└── baseline_*.txt	-- 标准输出
│   └── time/
│   │	├── time_opencl_*.txt	-- OpenCL进行计算时间
│   │	└── time_py_*.txt	-- python进行计算的时间 
```
