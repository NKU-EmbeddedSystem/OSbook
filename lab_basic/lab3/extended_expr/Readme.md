mmap_pagefault_snoop.bt: bpftrace程序，使用eBPF观察调用mmap时发生的page fault事件

pipe.c: 使用无名管道进行进程通信

faults.py: 运行mmap_pagefault_snoop.bt，观测mmap的结果

straceout.txt: 使用strace统计pipe.c调用write的结果
