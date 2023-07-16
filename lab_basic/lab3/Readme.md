# 基础实验3：单个大规模文件的处理

## 实验介绍

本章实验实现从单个大文件中检索特定字符串，分别使用read系统调用和mmap系统调用两种方式实现。

## 运行方式

在当前目录下使用./lab3.sh即可运行程序。

## 目录结构

```
lab3/
├── README.md
├── extended_expr/  -- 辅助实验相关代码
│   ├── Readme.md
│   ├── faults.py
│   ├── mmap_pagefault_snoop.bt
│   ├── pipe.c
│   └── straceout.txt
├── input/
│   └── new.txt     -- 输入文件
├── lab3.c          -- mmap和read方法实现单个大规模文件的字符串处理
├── lab3.sh         -- 运行lab3.c的脚本文件
└── output/
    └── result.txt  -- lab3.c的运行结果
```
