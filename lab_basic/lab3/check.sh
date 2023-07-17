#!/bin/bash

if [ ! -e "output/result.txt" ]; then
    echo "输出文件不存在，lab3 最终分数为: 0。"
    exit 1
fi

# 计算输出文件的MD5值
md5_output=$(md5sum "output/result.txt" | awk '{print $1}')
md5_target="29a9bb6f547f27e719353c48d5d5769e"

# 比较两个MD5值列表是否相等
if [[ "$md5_output" == "$md5_target" ]]; then
    echo "输出文件MD5值匹配，lab3 最终分数为: 100。"
else
    echo "输出文件MD5值不匹配，lab3 最终分数为: 0。"
    echo $md5_output
fi

