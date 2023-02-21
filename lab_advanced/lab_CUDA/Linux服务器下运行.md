### 前言

​	如果没有一台英伟达显卡的个人电脑，可以租用带有独显的服务器进行实验，下面是在购买服务器与搭建环境后的编译、运行流程。

### 环境

本次实验在购买的带有英伟达显卡的服务器进行实验（有条件也可以在本地进行实验），操作系统是Ubuntu 20.04 LTS ， GPU驱动版本450.102.04，CUDA版本11.0.3，cuDNN版本8.1.0（版本不同不影响实验），编程语言C，Ｃ＋＋，CUDA

### 购买服务器与搭建环境

##### 购买服务器

本实验可以直接在腾讯云中购买自动安装GPU驱动与CUDA的服务器

![image-20221211210142257](./Linux服务器下运行.assets/image-20221211210142257.png)

可参考配置如下：

![img](./Linux服务器下运行.assets/1670749863657-a91a3dfc-aedd-4c11-aae6-41b46eb83f5a.png)

![img](./Linux服务器下运行.assets/1670749879436-df155ecb-c1ec-4805-9c3e-8cf0dcdf8f32.png)

![img](./Linux服务器下运行.assets/1670749899115-7dc036d7-4bdd-4963-b1d4-f3e4975a4cb9.png)

![img](./Linux服务器下运行.assets/1670750173021-647f64d1-65b3-466b-abfe-1e6e32f9cf65.png)

配置成功后远程连接。

##### 验证 cuda是否安装

```
nvidia-smi
```

![img](./Linux服务器下运行.assets/1670755218948-7d544a84-5d46-4a63-97d2-d82807e73c90.png)

说明已经安装成功。

##### 安装cmake 与验证是否安装

安装：

```
sudo apt-get install cmake
```

验证：

```
cmake --version
```

![img](./Linux服务器下运行.assets/1670755172875-1e4403c0-dae3-4f87-9dac-57969452ebd6.png)

##### 设置CMAKE_CUDA_COMPILER 环境变量

通过自己服务器中`/usr/local/`文件夹下的`cuda` 版本来设置环境变量

```
 export PATH=/usr/local/cuda-10.1/bin/:$PATH
```

并通过一下指令查看是否设置成功

```
export
```

#### 编译与运行

以此编译并进行执行

```
cmake ./
```

```
make
```

```
./test
```

### 