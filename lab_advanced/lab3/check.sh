#!/bin/bash

if [ ! -e "output/result/result_naive.txt" ]; then
    echo "基础矩阵乘法输出文件不存在，lab3-1最终分数为: 0。"
    exit 1
fi
if [ ! -e "output/result/result_blocked.txt" ]; then
    echo "分块矩阵乘法输出文件不存在，lab3-2最终分数为: 0。"
    exit 1
fi
if [ ! -e "output/result/result_opt.txt" ]; then
    echo "优化矩阵乘法输出文件不存在，lab3-3最终分数为: 0。"
    exit 1
fi

# 计算输出文件的MD5值
md5_output_naive=$(md5sum "output/result/result_naive.txt" | awk '{print $1}')
md5_output_blocked=$(md5sum "output/result/result_blocked.txt" | awk '{print $1}')
md5_output_opt=$(md5sum "output/result/result_opt.txt" | awk '{print $1}')
md5_target=$(md5sum "output/result/result_reference.txt" | awk '{print $1}')

# 比较两个MD5值列表是否相等
if [[ "$md5_output_naive" == "$md5_target" ]]; then
    echo "输出文件naive MD5值匹配，lab3-1分数为: 100。"
else
    echo "输出文件naive MD5值不匹配，lab3-1最终分数为: 0。"
    echo $md5_output_naive
fi
if [[ "$md5_output_blocked" == "$md5_target" ]]; then
    echo "输出文件blocked MD5值匹配，lab3-2最终分数为: 100。"
else
    echo "输出文件blocked MD5值不匹配，lab3-2最终分数为: 0。"
    echo $md5_output_blocked
fi
if [[ "$md5_output_opt" == "$md5_target" ]]; then
    echo "输出文件MD5值匹配，lab3-3最终分数为: 100。"
else
    echo "输出文件MD5值不匹配，lab3-3最终分数为: 0。"
    echo $md5_output_opt
fi

if [ "$md5_output_naive" == "$md5_target" ] && [ "$md5_output_blocked" == "$md5_target" ] && [ "$md5_output_opt" == "$md5_target" ]; then
    echo "lab3-3最终分数为: 100。"
fi