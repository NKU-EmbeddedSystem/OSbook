#!/bin/bash

dir=$(dirname "$0")/input

unzip -q "$dir/ham.zip" -d "$dir"  # 解压 ham.zip

for i in "$dir/ham"/*
do
   filename=$i
   # 查找主题为回复的邮件并打印第一行内容，即发送者和日期
   # 如果第一行的Subject 包含 Re 或 RE
   if [ $(grep -c "^Subject: *R[eE]" "$filename") -ne '0' ];then
   # 打印第一行内容
     awk 'NR==1' "$filename" >> ./output/new.txt
   fi
done

