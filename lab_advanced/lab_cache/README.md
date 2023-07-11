# 面向cache优化的矩阵乘法

​	本章提供了三个矩阵乘法函数，分别是普通的矩阵乘法，分块矩阵乘法和优化和的矩阵乘法（交换运算顺序）。

​	编译该文件使用：

```
g++ -o blockmm -O0 blockmm.cpp
```

​	请注意在测试性能时，不要在一个程序中同时测试多种矩阵乘法，这会让部分数据留在缓存中，从而影响真实的性能表现。

​	运行程序

```
./blockmm
```

​	此外可以使用perf工具，来获取其cache表现情况

```
sudo perf stat -e cache-references,cache-misses ./blockmm
```

