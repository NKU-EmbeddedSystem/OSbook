# 高级任务实现

运行方法

首先保证client端和要处理的文件处于同一文件夹下，这里略微修改了word_count.sh以便程序读取client端产生的中间结果。

1. 分别编译server和client

```
g++ -o server server.cpp
g++ -o client client.cpp
```

2. 运行server端并输入client端数量

```
./server
```

3. 运行对应数量的client端

```
./client
```

4. 输入要处理的文件数，以及要统计的单词

5. 得到单词的统计结果

![image-20230705151849976](C:\Users\骁\AppData\Roaming\Typora\typora-user-images\image-20230705151849976.png)