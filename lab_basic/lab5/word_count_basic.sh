#!/bin/bash

word="$3"
#限定文件范围
files=$(ls input/*.txt | head -"$2" | tail -$(($2 - $1 + 1)))
#初始化单词数
total=0
#遍历文件$1到文件$2，并统计单词$3出现的次数
for file in $files;do
	count=$(grep -o -i -w "$word" "$file" | wc -l)
	total=$((total + count))
done
#输出统计结果
echo "word '$word' appears $total times from file No.$1 to file No.$2" > output/output_basic.txt
