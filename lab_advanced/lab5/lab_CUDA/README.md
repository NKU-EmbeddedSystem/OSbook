### 进阶实验篇第5章：面向硬件加速器的优化_CUDA部分
#### 1. 实验介绍
本实验实现了基于CUDA的矩阵乘法，再能够搭建编译CUDA环境的情况下，基于CUDA写矩阵乘程序并进行编译执行，而且能够进行性能评估。。该实验可以在购买的带有英伟达显卡的服务器进行实验，操作系统是Ubuntu 20.04 LTS （
不限制）， GPU驱动版本450.102.04，CUDA版本11.0.3，cuDNN版本8.1.0（版本不同不影响>实验），编程语言C，Ｃ＋＋，CUDA，具体使用流程请参考[这里](./Linux服务器下运行.md)。也可以在带有英伟达显卡的个人电脑进行实验，操作系统是Windows11（不限制），
需安装CUDA toolkit、Visual Studio等软件，使用编程语言C ，C++，CUDA ，具体使用流程
请参考[这里](./Windows下运行.md)。
#### 2. 运行方式
i. 准备工作：
修改data_gen.py代码中的shapes为自己计算矩阵维度，并且生成python运行矩阵乘的时间再output目录中。根据[这里](./Linux服务器下运行.md)配置相关环境
ii. 直接编译与执行
‘'''
cmake ./
make
./test
'''
或者直接运行
#### 3. 目录结构
- input
	- compare.py: 比较python与cuda矩阵乘的时间与速度
	- shapeX: 通过data_gen.py随机生成的进行矩阵乘法与结果对比的矩阵A,B,C
- output 
	- time_py_X.txt: python运行的时间
	- time_cuda_X.txt: cuda运行的时间
	
### 关于代码

kernel.cu文件：具有完整的CUDA编写程序流程，教材中代码讲解来源，包含性能分析部分代码，没有写入CMakelists.txt文件中，如果需要在linux服务器上运行，请修改CMakelist.txt文件中

``` add_executable(test test.cu)
add_executable(test test.cu)
```

为

```
add_executable(test kernel.cu)
```



test.cu文件：使用教材中提到的统一内存托管方法，而且使用`__device__` 关键字创建与使用设备端函数。矩阵乘的实现方法可以自行理解。





