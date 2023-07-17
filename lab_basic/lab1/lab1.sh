#!/bin/bash

input_dir=$(dirname "$0")/input
output_dir=$(dirname "$0")/output

for i in "$input_dir"/*
do
    # 提取文件名
    filename=$(basename "$i")
    # TODO 获取文件的修改时间
    mtime=[TODO]
    # TODO 格式化时间
    formatted_data=[TODO]
    # TODO 提取文件的后缀名
    extension=[TODO]
    # 构建新的文件名
    new_filename="${formatted_date}.${extension}"
    # TODO 拼接输出路径
    output_path=[TODO]
    # 输出到output
    cp "$i" "$output_path"
done
