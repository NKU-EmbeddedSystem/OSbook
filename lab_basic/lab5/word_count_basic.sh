#!/bin/bash

word="$3"
#�޶��ļ���Χ
files=$(ls *.txt | head -"$2" | tail -$(($2 - $1 + 1)))
#��ʼ��������
total=0
#�����ļ�$1���ļ�$2����ͳ�Ƶ���$3���ֵĴ���
for file in $files;do
	count=$(grep -o -i -w "$word" "$file" | wc -l)
	total=$((total + count))
done
#���ͳ�ƽ��
echo "word '$word' appears $total times from file No.$1 to file No.$2" > output/output_basic.txt
