#!/bin/bash

result_files=$(find output/result -maxdepth 1 -type f -name "result_*.txt")

if [ -z "$result_files" ]; then
    echo "输出文件不存在，lab5_OpenCL 最终分数为: 0。"
    exit 1
fi

for file in $result_files; do
    # 提取文件名中的数字部分
    file_number=$(basename "$file" | grep -oE '[0-9]+')
    
    # 构建标准结果文件名
    baseline="output/result/baseline_${file_number}.txt"

    if [ ! -e "$baseline" ]; then
        echo "标准结果文件 $baseline 不存在，请生成标准结果文件"
        continue
    fi

    # 计算输出文件的MD5值
    md5_output=$(md5sum "$file" | awk '{print $1}')
    md5_target=$(md5sum "$baseline" | awk '{print $1}')

    # 比较两个MD5值列表是否相等
    if [[ "$md5_output" == "$md5_target" ]]; then
        echo "维度为${file_number}输出文件MD5值匹配，lab5_OpenCL 最终分数为: 100。"
    else
        echo "维度为${file_number}输出文件MD5值不匹配，lab5_OpenCL 最终分数为: 0。"
        echo "维度为${file_number}输出文件MD5值: $md5_output,标准输出文件MD5值：$md5_target"
    fi
done
