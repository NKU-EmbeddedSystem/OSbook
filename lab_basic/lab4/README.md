# 基础实验四：多进程与多线程
## 实验介绍
本章一共提供两个实验，multiprocess实现了多进程批量查找文件中的特殊字符串，multithreading实现了多线程查找大文件中的特殊字符串。
## 运行方式
### 多进程
```
gcc -o mmap mmap.c
gcc -o process process.c
./process
```
### 多线程
```
gcc thread.c -o thread -lpthread
./thread
```
## 目录结构
multiprocess/README.md：多进程实验的运行方式

multiprocess/mmap.c：查找一个文件夹中所有文件的特殊字符串数量

multiprocess/process.c：多进程调度的程序

multithreading/README.md：多线程饰演的运行方式

multithreading/thread.c：多线程实现查找一个大文件中的特殊字符串数量
