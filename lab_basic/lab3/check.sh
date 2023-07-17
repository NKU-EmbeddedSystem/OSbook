#!/bin/bash

# 计算目录下文件的MD5值
calculate_md5() {
    local directory=$1

    # 遍历目录中的所有文件
    for file in "$directory"/*; do
        # 忽略子目录
        if [[ -d $file ]]; then
            continue
        fi

        # 计算文件的MD5值
        local md5=$(md5sum "$file" | awk '{print $1}')
    done

    echo "$md5"
}

# 目录1和目录2的路径
dir1="output/"
dir2="output/"

# 计算目录1和目录2下文件的MD5值
md5_1=$(calculate_md5 "$dir1")
md5_2=$(calculate_md5 "$dir2")

# 比较两个MD5值列表是否相等
if [[ "$md5_1" == "$md5_2" ]]; then
    echo "目录1和目录2下的文件MD5值相等"
    
else
    echo "目录1和目录2下的文件MD5值不相等"
fi
