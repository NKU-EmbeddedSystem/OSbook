#!/bin/bash

# 设置要读取的目录
directory="output"

# 遍历目录中的每个文件
for file in "$directory"/*; do
    # 检查文件是否是常规文件
    if [[ -f "$file" ]]; then
        # 计算文件内容的哈希值
        hash=$(md5sum "$file" | awk '{print $1}')

        # 输出文件名和内容的哈希值
        echo "文件: $file"
        echo "内容哈希值: $hash"
        echo
    fi
done

