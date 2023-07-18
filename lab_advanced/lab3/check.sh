#!/bin/bash

if [ ! -e "output/result/result_naive.txt" ]; then
    echo "基础矩阵乘法输出文件不存在"
    exit 1
fi
if [ ! -e "output/result/result_blocked.txt" ]; then
    echo "分块矩阵乘法输出文件不存在"
    exit 1
fi
if [ ! -e "output/result/result_opt.txt" ]; then
    echo "优化矩阵乘法输出文件不存在"
    exit 1
fi

# 计算输出文件的MD5值
md5_output_naive=$(md5sum "output/result/result_naive.txt" | awk '{print $1}')
md5_output_blocked=$(md5sum "output/result/result_blocked.txt" | awk '{print $1}')
md5_output_opt=$(md5sum "output/result/result_opt.txt" | awk '{print $1}')

if [ "$md5_output_blocked" == "$md5_output_naive" ]; then
    echo "输出文件blocked MD5值匹配，lab3-1最终分数为: 50"
else
    echo "输出文件blocked MD5值不匹配，lab3-1最终分数为: 0"
    echo $md5_output_blocked
    echo $md5_output_naive
fi
if [[ "$md5_output_opt" == "$md5_output_naive" ]]; then
    echo "输出文件MD5值匹配，lab3-2最终分数为: 50"
else
    echo "输出文件MD5值不匹配，lab3-2最终分数为: 0"
    echo $md5_output_opt
    echo $md5_output_naive
fi

if  [ "$md5_output_blocked" == "$md5_output_naive" ] && [ "$md5_output_opt" == "$md5_output_naive" ]; then
    echo "lab3最终分数为: 100"
fi
