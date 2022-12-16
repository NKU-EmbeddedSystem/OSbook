#!/bin/bash

for i in `ls`
do
    #提取文件名
    filename=$i
    #获取文件的修改时间
    mtime=`stat -c %Y $filename`
    #格式化时间
    formate_date=`date '+%Y%m%d' -d @$mtime`
    #提取文件的后缀名
    name=${filename#*.}
    #进行拼接
    mv $i ${formate_date}.${name}
done


