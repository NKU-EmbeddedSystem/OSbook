#!/bin/bash

# 检查常见的 OpenCL 库路径
opencl_lib="/usr/lib/x86_64-linux-gnu/libOpenCL.so"
if [ -f "$opencl_lib" ]; then
    echo "OpenCL 库 $opencl_lib 存在"
    export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"
    echo "已将 $opencl_lib 所在路径加入 LD_LIBRARY_PATH"
else
    echo "未找到 OpenCL 库 $opencl_lib，请确认已安装 OpenCL 驱动"
    exit 1
fi

if [ -d "./build/" ]; then
    echo "build 文件夹已经存在"
else
    mkdir build
fi
cd build
cmake -DCMAKE_INSTALL_PREFIX=./ ..
make

cd ..
./build/matrix_multiply
