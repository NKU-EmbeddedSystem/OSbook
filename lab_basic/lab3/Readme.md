## 第四章基础篇实验3：单个大规模文件的处理

input/new.txt：输入文件

lab3.c：mmap和read方法实现单个大规模文件的字符串处理

lab3.sh: 运行lab3.c的脚本文件

mmap_pagefault_snoop.bt: bpftrace程序，使用eBPF观察调用mmap时发生的page fault事件

pipe.c: 使用无名管道进行进程通信

output/result.txt: lab3.c的运行结果

output/faults.py: 运行mmap_pagefault_snoop.bt，观测mmap的结果

output/straceout.txt: 使用strace统计pipe.c调用write的结果
