# 基础实验四：多进程与多线程

## 实验介绍
本章一共提供两个实验，multiprocess实现了多进程批量查找文件中的特殊字符串，multithreading实现了多线程查找大文件中的特殊字符串。

## 运行方式

### 多进程

```
chmod +x process.sh
./process.sh
```

### 多线程

```
chmod +x thread.sh
./thread.sh
```

## 目录结构
```
.
├── multiprocess            -- 多进程实验目录
│   ├── input               -- 输入文件
│   │   ├── f1
│   │   │   ├── test1.txt
│   │   │   └── test2.txt
│   │   └── f2
│   │       ├── test3.txt
│   │       └── test4.txt
│   ├── mmap.c              -- 用于实现一个文件夹中所有文件的特殊字符串查找
│   ├── output              -- 输出文件
│   │   └── out.txt
│   ├── process.c           -- 实现进程管理
│   ├── process.sh          -- 多进程程序运行脚本
│   └── README.md
├── multithreading          -- 多线程实验目录
│   ├── input               -- 输入文件
│   │   └── new.txt
│   ├── output              -- 输出文件
│   │   └── out.txt
│   ├── README.md
│   ├── thread.c            -- 多线程实现一个文件中的特殊字符串查找
│   └── thread.sh           -- 多线程程序运行脚本
└── README.md
```
