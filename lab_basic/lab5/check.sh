#!/bin/bash

# 计算目录下所有文件的MD5值
calculate_md5() {
    local directory=$1
    local md5_list=()

    # 遍历目录中的所有文件
    for file in "$directory"/*; do
        # 忽略子目录
        if [[ -d $file ]]; then
            continue
        fi

        # 计算文件的MD5值
        md5=$(md5sum "$file" | awk '{print $1}')
        md5_list+=("$md5")
    done

    # 输出MD5值列表
    echo "${md5_list[@]}"
}

# 目录1和目录2的路径
dir1="output/"
dir2="output/"
input_dir="input/"

# 计算目录1和目录2下所有文件的MD5值
md5_list1=$(calculate_md5 "$dir1")
md5_list2=$(calculate_md5 "$dir2")

# 比较两个MD5值列表是否相等
if [[ "$md5_list1" == "$md5_list2" ]]; then
    echo "目录1和目录2下的文件MD5值相等"
    
    # 计算相等的MD5值的个数
    count=$(echo "$md5_list1" | tr ' ' '\n' | sort | uniq -c | wc -l)
    echo "相等的MD5值的个数为: $count"

    # 计算目录下的文件总数
    file_count=$(find "$dir1" -type f | wc -l)
    #echo "目录 $dir1 下的文件总数为: $file_count"
    
    ratio=$(echo "scale=2;$count*2 / $file_count*100" | bc)
    echo "最终分数为: $ratio"
    
else
    echo "目录1和目录2下的文件MD5值不相等"
fi
