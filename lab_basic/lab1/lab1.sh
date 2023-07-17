<<<<<<< HEAD
#!/bin/bash

dir=$(dirname "$0")/input

for i in "$dir"/*
do
    #提取文件名
    filename=$(basename "$i")
    #获取文件的修改时间
    mtime=$(stat -c %Y "$i")
    #格式化时间
    formate_date=$(date '+%Y%m%d' -d @"$mtime")
    #提取文件的后缀名
    name=${filename#*.}
    #进行拼接
    mv "$i" "$dir/${formate_date}.${name}"
done


=======
#!/bin/bash

dir=$(dirname "$0")/input

for i in "$dir"/*
do
    #提取文件名
    filename=$(basename "$i")
    #获取文件的修改时间
    mtime=$(stat -c %Y "$i")
    #格式化时间
    formate_date=$(date '+%Y%m%d' -d @"$mtime")
    #提取文件的后缀名
    name=${filename#*.}
    #进行拼接
    echo "${formate_date}.${name}">>./output/new.txt
    #修改源文件可使用mv
done


>>>>>>> 2c55923f7a5c1d88fbdce3b7e38d25a4dc5bd172
