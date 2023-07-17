<<<<<<< HEAD
#!/bin/bash

dir=$(dirname "$0")/input

unzip -q "$dir/ham.zip" -d "$dir"  # 解压 ham.zip

for i in "$dir/ham"/*
do
   filename=$i
   # 查找主题为回复的邮件并打印第一行内容，即发送者和日期
   if [ $(grep -c "^Subject: *R[eE]" "$filename") -ne '0' ];then # 即存在一行以包含 Re 或 RE 的 Subject
     awk 'NR==1' "$filename" >> new.txt
   fi
done
=======
#!/bin/bash

dir=$(dirname "$0")/input

#unzip -q "$dir/ham.zip" -d "$dir"  # 解压 ham.zip

for i in "$dir/ham"/*
do
   filename=$i
   # 查找主题为回复的邮件并打印第一行内容，即发送者和日期
   if [ $(grep -c "^Subject: *R[eE]" "$filename") -ne '0' ];then # 即存在一行以包含 Re 或 RE 的 Subject
     awk 'NR==1' "$filename" >> ./output/new.txt
   fi
done
>>>>>>> 2c55923f7a5c1d88fbdce3b7e38d25a4dc5bd172
