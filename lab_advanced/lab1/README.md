# 进阶实验1：Python矩阵乘法

## 实验介绍

使用Python语言实现矩阵乘法，了解矩阵乘法运算方式。

## 运行方式

本次实验提供了一个执行脚本lab1.sh。./lab1.sh gen_data用于生成数据集，./lab1.sh test用于测试。如果提示wrong usage of lab1.sh表示脚本的参数不是gen_data或test。

## 目录结构

```
lab1/
├── README.md
├── gendata.py  -- 生成测试数据，生成的数据存放于input文件夹中
├── input/      -- 含有两个用于乘法的矩阵A、B和A与B的矩阵乘结果
├── lab1.sh     -- 执行脚本，用于控制生成数据集和执行程序验证
├── mm.py       -- 用Python语言实现矩阵相乘，包含测试函数调用
└── output/     -- 内部包含result和time两个文件夹，result内包含标准结果并存放程序生成的结果，time内包含程序运行时间
```
