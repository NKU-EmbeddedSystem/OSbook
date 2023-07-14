# 进阶篇实验4：多线程优化矩阵乘法

## 实验介绍

本次实验使用的操作系统为Ubuntu22.04 LTS，编译器为gcc 11.3.0，编程所用语言语言为C语言。实验旨在使用多线程技术对矩阵乘法进行优化，并通过解决race condition来介绍有关锁的相关知识。

本实验设置多个子实验，子实验的相同内容均为计算矩阵乘法 $C = A \times B$ 。另外为探究多线程的工作方法，子实验内容分别设置如下（后续可能有改动）：

（0）matrix_single_thread：单线程实现矩阵乘法 $C = A \times B$

（1）matrix_dual_thread：将 矩阵  $A_{(m\times n)}$  按行平分为两个矩阵   $A_{1_{(\frac{m}{2}\times n)}}$  和  $A_{2_{(\frac{m}{2}\times n)}}$ ，使用两个线程分别计算其与矩阵 $B$ 的乘积，将计算结果整合为最终结果 矩阵 $C$ 。

（2）matrix_multi_thread：改写了创建线程的部分，使得能够自由改变线程数量，自定义线程数量进行矩阵乘法运算。
                       
（3）matrix_lock：将 矩阵  $A_{(m\times n)}$  按列和行平分为四个矩阵   $A_{1_{(\frac{m}{2}\times n)}}$ 、 $A_{2_{(\frac{m}{2}\times n)}}$ 、 $A_{3_{(\frac{m}{2}\times n)}}$ 和  $A_{4_{(\frac{m}{2}\times n)}}$ ，使用四个线程分别计算其与矩阵 $B$ 的乘积，将计算结果整合为最终结果 矩阵 $C$ 。此时会发生race condition，使用锁解决该问题，可用以对比加锁前后的计算结果和运行时间。

（4）matrix_signal：同matrix_lock，不过使用了信号量来解决race condition。

（5）matrix_openmp：用openmp实现矩阵乘法的多线程优化。

（6）openmp_reduction：用openmp解决数据冲突（reduction）。

（7）openmp_critical：用openmp实现多线程优化(critical)。

## 运行方式

使用gcc编译源文件并执行，同时提供给运行所需的参数，例如矩阵规模、数据集路径以及线程数量等。

matrix_single_thread.c

```
gcc matrix_single_thread.c -o matrix_single_thread
./matrix_single_thread ./input/shape_100 100
```

matrix_dual_thread.c

```
gcc matrix_dual_thread.c -o matrix_dual_thread
./matrix_dual_thread ./input/shape_100 100
```

matrix_multi_thread.c

```
gcc matrix_multi_thread.c -o matrix_multi_thread
./matrix_multi_thread ./input/shape_100 100 4
```

matrix_lock.c 

```
gcc matrix_lock.c -o matrix_lock
./matrix_lock ./input/shape_100 100
```

matrix_signal.c 

```
gcc matrix_signal.c -o matrix_signal
./matrix_signal ./input/shape_100 100
```

matrix_openmp.c 

```
gcc matrix_openmp.c -lgomp -o matrix_openmp
./matrix_openmp ./input/shape_100 100
```

openmp_critical.c 

```
gcc openmp_critical.c -lgomp -o openmp_critical
./openmp_critical
```

openmp_reduction.c 

```
gcc openmp_reduction.c -lgomp -o openmp_reduction
./openmp_reduction
```

以上为各个测试文件的编译及测试方法。此外，还可以使用test.sh脚本来一次性执行所有的测试样例。
## 目录结构
input/data_gen.py：可生成自定义规模的测试用矩阵

input/shape_N：测试用数据集目录，内包含三个大小为N*N的矩阵，分别为 $C = A \times B$ 式中的三个矩阵

output/result.txt：测试脚本输出结果

matrix_single_thread.c:单线程实现矩阵乘法

matrix_dual_thread.c:双线程实现矩阵乘法

matrix_multi_thread.c:多线程实现矩阵乘法

matrix_lock.c:使用锁解决多线程矩阵乘法中遇到的数据冲突问题

matrix_signal.c:使用信号量解决多线程矩阵乘法中遇到的数据冲突问题

matrix_openmp.c:使用openmp多线程优化矩阵乘法运算

openmp_critical.c:使用critical方法解决openmp中的数据冲突问题

openmp_reduction.c:使用reduction方法解决openmp中的数据冲突问题
