#!/bin/bash

# 读取文件内容并排序
sort_file() {
    local file=$1

    # 除倒数两行外，读取文件内容并排序
    sorted_content=$(head -n -2 "$file" | sort)

    # 输出排序后的内容
    echo "$sorted_content"
}

# 文件1和文件2的路径
file1="output/lab4_process_result.txt"
file2="output/lab4_process_result.txt"

# 读取并排序文件1的内容
sorted_content1=$(sort_file "$file1")

# 读取并排序文件2的内容
sorted_content2=$(sort_file "$file2")

# 比较两个排序结果的MD5值
md5_1=$(echo "$sorted_content1" | md5sum | awk '{print $1}')
md5_2=$(echo "$sorted_content2" | md5sum | awk '{print $1}')

# 输出比较结果
echo "文件1的排序结果的MD5值: $md5_1"
echo "文件2的排序结果的MD5值: $md5_2"

# 比较MD5值是否相等
if [[ "$md5_1" == "$md5_2" ]]; then
    echo "文件1和文件2的排序结果的MD5值相等"
else
    echo "文件1和文件2的排序结果的MD5值不相等"
fi

