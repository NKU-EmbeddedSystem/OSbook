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

        filename=$1$(basename "$file")

        # 计算文件的MD5值
        md5=$(md5sum "$filename" | awk '{print $1}')
        md5_list+=("$md5")
    done

    # 输出MD5值列表
    echo "${md5_list[@]}"
}

# 目录1和目录2的路径
output_dir="output/"
input_dir="input/"

# 计算目录1和目录2下所有文件的MD5值
md5_list1=$(calculate_md5 "$output_dir")
echo $md5_list1
md5_list2=$(calculate_md5 "$input_dir")
echo $md5_list2

mkdir -p .tmp
echo "$md5_list1" | tr ' ' '\n' | sort > .tmp/sorted_list1.txt
echo "$md5_list2" | tr ' ' '\n' | sort > .tmp/sorted_list2.txt
count=$(awk 'BEGIN {count=0} NR==FNR {a[$0]=1; next} a[$0]==1 {count++} END {print count}' .tmp/sorted_list1.txt .tmp/sorted_list2.txt)
rm -rf .tmp

echo $count
# 计算目录下的文件总数
file_count=$(find "$input_dir" -type f | wc -l)
echo "目录 $input_dir 下的文件总数为: $file_count"
ratio=$(echo "scale=2;$count / $file_count*100" | bc)
echo "最终分数为: $ratio"
