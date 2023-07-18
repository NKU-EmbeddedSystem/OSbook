#!/bin/bash

# 多线程 5x14  openmp 3x10
mark=0

if [ ! -e "output/result/matrix_single_thread.txt" ]; then
    echo "matrix_single_thread输出文件不存在"
fi
if [ ! -e "output/result/matrix_dual_thread.txt" ]; then
    echo "matrix_dual_thread输出文件不存在"
fi
if [ ! -e "output/result/matrix_multi_thread.txt" ]; then
    echo "matrix_multi_thread输出文件不存在"
fi
if [ ! -e "output/result/matrix_lock.txt" ]; then
    echo "matrix_lock输出文件不存在"
fi
if [ ! -e "output/result/matrix_signal.txt" ]; then
    echo "matrix_signal输出文件不存在"
fi
if [ ! -e "output/result/matrix_openmp.txt" ]; then
    echo "matrix_openmp输出文件不存在"
fi
if [ ! -e "output/result/openmp_critical.txt" ]; then
    echo "matrix_critical输出文件不存在"
fi
if [ ! -e "output/result/openmp_reduction.txt" ]; then
    echo "matrix_reduction输出文件不存在"
fi

# 计算输出文件的MD5值
md5_output_0=$(md5sum "output/result/matrix_single_thread.txt" | awk '{print $1}')
md5_output_1=$(md5sum "output/result/matrix_dual_thread.txt" | awk '{print $1}')
md5_output_2=$(md5sum "output/result/matrix_multi_thread.txt" | awk '{print $1}')
md5_output_3=$(md5sum "output/result/matrix_lock.txt" | awk '{print $1}')
md5_output_4=$(md5sum "output/result/matrix_signal.txt" | awk '{print $1}')
md5_output_5=$(md5sum "output/result/matrix_openmp.txt" | awk '{print $1}')
md5_output_6=$(md5sum "output/result/openmp_critical.txt" | awk '{print $1}')
md5_output_7=$(md5sum "output/result/openmp_reduction.txt" | awk '{print $1}')
md5_target_matrix=$(md5sum "output/result/matrix_answer.txt" | awk '{print $1}')
md5_target_openmp=$(md5sum "output/result/openmp_answer.txt" | awk '{print $1}')

# 比较两个MD5值列表是否相等
if [[ "$md5_output_0" == "$md5_target_matrix" ]]; then
    let  mark=mark+14
    echo "matrix_single_thread输出文件MD5值匹配，得分14"
else
    echo "matrix_single_thread输出文件MD5值不匹配，得分0"
fi

if [[ "$md5_output_1" == "$md5_target_matrix" ]]; then
    let  mark=mark+14
    echo "matrix_dual_thread输出文件MD5值匹配，得分14"
else
    echo "matrix_dual_thread输出文件MD5值不匹配，得分0"
fi

if [[ "$md5_output_2" == "$md5_target_matrix" ]]; then
    let  mark=mark+14
    echo "matrix_multi_thread输出文件MD5值匹配，得分14"
else
    echo "matrix_multi_thread输出文件MD5值不匹配，得分0"
fi

if [[ "$md5_output_3" == "$md5_target_matrix" ]]; then
    let  mark=mark+14
    echo "matrix_lock输出文件MD5值匹配，得分14"
else
    echo "matrix_lock输出文件MD5值不匹配，得分0"
fi

if [[ "$md5_output_4" == "$md5_target_matrix" ]]; then
    let  mark=mark+14
    echo "matrix_signal输出文件MD5值匹配，得分14"
else
    echo "matrix_signal输出文件MD5值不匹配，得分0"
fi

if [[ "$md5_output_5" == "$md5_target_matrix" ]]; then
    let  mark=mark+10
    echo "matrix_openmp输出文件MD5值匹配，得分10"
else
    echo "matrix_openmp输出文件MD5值不匹配，得分0"
fi

if [[ "$md5_output_6" == "$md5_target_openmp" ]]; then
    let  mark=mark+10
    echo "openmp_critical输出文件MD5值匹配，得分10"
else
    echo "openmp_critical输出文件MD5值不匹配，得分0"
fi

if [[ "$md5_output_7" == "$md5_target_openmp" ]]; then
    let  mark=mark+10
    echo "openmp_reduction输出文件MD5值匹配，得分10"
else
    echo "openmp_reduction输出文件MD5值不匹配，得分0"
fi

echo "输出文件MD5值匹配，lab4 最终分数为: $mark。"
