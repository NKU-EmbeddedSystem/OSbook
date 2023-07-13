### 实验环境

本次实验可以在购买的带有英伟达显卡的服务器进行实验，操作系统是Ubuntu 20.04 LTS （不限制）， GPU驱动版本450.102.04，CUDA版本11.0.3，cuDNN版本8.1.0（版本不同不影响实验），编程语言C，Ｃ＋＋，CUDA，具体使用流程请参考[这里](./Linux服务器下运行.md)。

本次实验也可以在带有英伟达显卡的个人电脑进行实验，操作系统是Windows11（不限制），需安装CUDA toolkit、Visual Studio等软件，使用编程语言C ，C++，CUDA ，具体使用流程请参考[这里](./Windows下运行.md)。

### 实验目的

基于CUDA进行矩阵乘实验，学会简单的CUDA编程，理解GPU等加速器原理

### 实验内容

本实验主要是能够搭建编译CUDA环境，基于CUDA编写矩阵乘程序并进行编译执行，而且能够进行性能评估

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





