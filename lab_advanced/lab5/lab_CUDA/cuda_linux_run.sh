#!/bin/bash
# 修改自己的cuda版本与路径
cuda_version=11
# 循环检查cuda路径是否存在
for x in `seq 1 9`
do
    cuda_path="/usr/local/cuda-${cuda_version}.${x}"
    if [ -d "$cuda_path" ]; then
        echo "hello"
        echo "CUDA路径 $cuda_path 存在"
        
        # 将路径加入环境变量
        export PATH="$cuda_path/bin:$PATH"
        
        echo "已将路径 $cuda_path 添加到环境变量"
        break
    else
        echo "不存在CUDA路径$cuda_path"
    fi
done

if [ -d "./build/" ]; then
    echo "build文件夹已经存在"
else
    mkdir build
fi
cd build
cmake -DCMAKE_INSTALL_PREFIX=./ ..
make

cd ..
./build/bin/test
