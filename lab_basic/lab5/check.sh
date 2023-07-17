#!/bin/bash

if [ ! -e "output/output_basic.txt" ]; then
    echo "输出文件不存在，lab3 最终分数为: 0。"
    exit 1
elif [ ! -e "output/output_advanced.txt" ]; then
    echo "输出文件不存在，lab3 最终分数为: 0。"
    exit 1
fi

# 计算输出文件的MD5值
md5_basic_output=$(md5sum "output/output_basic.txt" | awk '{print $1}')
md5_advanced_output=$(md5sum "output/output_advanced.txt" | awk '{print $1}')
md5_basic_target="9c220a1481f40ffa6293a091f452a87a"
md5_advanced_target="7198d84258186f44fa15bb10a811a7b5"

# 比较两个MD5值列表是否相等
score=0
if [[ "$md5_basic_output" == "$md5_basic_target" ]]; then
    score=$(expr $score + 50)
fi
if [[ "$md5_advanced_output" == "$md5_advanced_target" ]]; then
    score=$(expr $score + 50)
fi
echo "lab3 最终分数为:"$score

