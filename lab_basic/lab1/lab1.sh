#!/bin/bash

input_dir=$(dirname "$0")/input
output_dir=$(dirname "$0")/output

for i in "$input_dir"/*
do
    # 提取文件名
    filename=$(basename "$i")
    # 获取文件的修改时间
    mtime=$(stat -c %Y "$i")
    # 格式化时间
    formatted_date=$(date '+%Y%m%d' -d @"$mtime")
    # 提取文件的后缀名
    extension=${filename#*.}
    # 构建新的文件名
    new_filename="${formatted_date}.${extension}"
    # 拼接输出路径
    output_path="$output_dir/$new_filename"
    # 输出到output
    cp "$i" "$output_path"
done
