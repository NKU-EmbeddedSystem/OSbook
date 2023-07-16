#!/bin/bash

# 设置要读取的目录
directory="output"

# 保存文件名的字符串
file_names=""

# 遍历目录中的每个文件
for file in "$directory"/*; do
    # 检查文件是否是常规文件
    if [[ -f "$file" ]]; then
        # 将文件名追加到字符串
        file_names+=$(basename "$file")
    fi
done

# 计算字符串的哈希值
hash=$(echo -n "$file_names" | md5sum | awk '{print $1}')

# 输出字符串和哈希值
echo "文件名字符串: $file_names"
echo "字符串哈希值: $hash"

