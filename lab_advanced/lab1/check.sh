#!/bin/bash

if [ ! -e "output/result/result.txt" ]; then
    echo "输出文件不存在，lab1 最终分数为: 0。"
    exit 1
fi

# 计算输出文件的MD5值
md5_output=$(md5sum "output/result/result.txt" | awk '{print $1}')
md5_target=$(md5sum "output/result/standard_result.txt" | awk '{print $1}')

# 比较两个MD5值列表是否相等
if [[ "$md5_output" == "$md5_target" ]]; then
    echo "输出文件MD5值匹配，lab1 最终分数为: 100。"
else
    echo "输出文件MD5值不匹配，lab1 最终分数为: 0。"
    echo $md5_output
fi