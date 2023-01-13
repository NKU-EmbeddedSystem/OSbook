#!/bin/bash

for i in `ls`
do
   filename=$i
#查找主题为回复的邮件并打印第一行内容，即发送者和日期
   if [ `grep -c "^Subject: *R[eE]" $filename` -ne '0' ];then #即存在一行以包含Re或RE的Subject
     awk 'NR==1' $filename >> new.txt
   fi
done
