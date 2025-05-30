# 面向cache优化的矩阵乘法

## 实验介绍

本章提供了三个矩阵乘法函数，分别是普通的矩阵乘法，分块矩阵乘法和优化和的矩阵乘法（交换运算顺序）。

## 运行方式

编译该文件使用：

```
g++ -o mm_naive -O0 mm_naive.cpp
```

请注意在测试性能时，不要在一个程序中同时测试多种矩阵乘法，这会让部分数据留在缓存中，从而影响真实的性能表现。

运行程序

```
./mm_naive
```

此外可以使用perf工具，来获取其cache表现情况

```

sudo perf stat -e cache-references,cache-misses ./mm_naive
```

也可以直接使用shell脚本运行程序：

```
./mm_cache.sh
```

同理如果暂无权限，我们可以使用

```
chmod +x *.sh
```

## 目录结构

```
lab3
├── README.md
├── param.h       -- 控制矩阵大小和分块大小
├── mm_block.cpp  -- 分块矩阵乘法（优化前）
├── mm_cache.sh   -- 运行上述三份代码并输出测试结果到output中
├── mm_naive.cpp  -- 朴素实现的矩阵乘法
├── mm_order.cpp  -- 交换循环顺序优化的矩阵乘法
└── output/
    ├── result/
    │   ├── blocked_result.txt
    │   ├── naive_result.txt
    │   └── opt_result.txt
    └── time/
        ├── blocked_time.txt
        ├── naive_time.txt
        └── opt_time.txt
    
```
