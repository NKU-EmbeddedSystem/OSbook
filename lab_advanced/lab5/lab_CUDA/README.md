### 进阶实验篇第5章：面向硬件加速器的优化_CUDA部分
#### 1. 实验介绍
本实验实现了基于CUDA的矩阵乘法，再能够搭建编译CUDA环境的情况下，基于CUDA写矩阵乘程序并进行编译执行，而且能够进行性能评估。。该实验可以在购买的带有英伟达显卡的服务器进行实验，操作系统是Ubuntu 20.04 LTS （
不限制）， GPU驱动版本450.102.04，CUDA版本11.0.3，cuDNN版本8.1.0（版本不同不影响>实验），编程语言C，Ｃ＋＋，CUDA，具体使用流程请参考[这里](./Linux服务器下运行.md)。也可以在带有英伟达显卡的个人电脑进行实验，操作系统是Windows11（不限制），
需安装CUDA toolkit、Visual Studio等软件，使用编程语言C ，C++，CUDA ，具体使用流程
请参考[这里](./Windows下运行.md)。
#### 2. 运行方式
i. 准备工作：
修改data_gen.py代码中的shapes为自己计算矩阵维度，并且生成python运行矩阵乘的时间再output目录中。根据[这里](./Linux服务器下运行.md)配置相关环境。
如果需要更换不同的cuda代码，修改CMakelist.txt文件中的代码，如将add_executable(test test.cu)改为add_executable(test kernel.cu)。
ii. 直接编译与执行
'''
cmake ./
make
./test
'''
或者直接运行
'''
sh cuda_linux_run.sh
'''
#### 3. 目录结构
- input
	- compare.py: 比较python与cuda矩阵乘的时间与速度
- output 
	- time_py_X.txt: python运行的时间
	- time_cuda_X.txt: cuda运行的时间
 - CmakeLists.txt: Cmake构建系统所需的文件
 - cuda_linux_run.sh: 在linux上运行的shell脚本
 - data_gen.py: 随机生成相应维度的相乘的矩阵A，B以及相乘的结果C和在python上所需时间
 - kernel.cu: 具有基础且完整的CUDA编写程序流程，教材中的代码讲解主要来源，包括性能分析部分。
 - test.cu: 使用统一内存托管的方法编写的矩阵乘代码。
