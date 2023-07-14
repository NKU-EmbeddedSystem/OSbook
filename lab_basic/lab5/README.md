# 基础实验5：多机协作处理

## 实验介绍
​	本章一共提供两个实验，basic提供了基础任务实现。基础任务实现是为了帮助同学们熟悉socket编程，只涉及到简单的server和client两者之间的通信。而advanced提供了高级任务实现，可以完成1个server和多个client的消息传递以及完成word_count的基础任务。

​	1.txt-10.txt为10段介绍操作系统的英文材料，input文件夹提供了示例输入，output_sample文件夹提供了对应的示例输出，可以通过此文件来验证程序是否正确。

## 运行方式

  本实验提供了两个shell脚本来直接运行basic和advanced代码，即
  ```
basic.sh
advanced.sh
```
如果遇到无法运行的问题，可以先使用```chmod 777 *.sh```修改文件权限。


## 目录介绍

input/*.txt：输入的文本数据

input/input_basic.txt：basic任务输入

input/input_advanced.txt：advanced任务输入

basic.sh：基础任务运行脚本

server_basic.cpp：基础任务服务器

client_basic.cpp：基础任务客户端

word_count_basic.sh：基础任务shell脚本

advanced.sh：高级任务运行脚本

server_advanced.cpp：高级任务服务端

client_advanced.cpp：高级任务客户端

word_count_advanced.sh：高级任务shell脚本
