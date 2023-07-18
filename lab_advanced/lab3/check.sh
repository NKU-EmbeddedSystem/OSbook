#!/bin/bash

if [ ! -e "output/result/result_naive.txt" ]; then
    echo "��������˷�����ļ������ڣ�lab3-1���շ���Ϊ: 0��"
    exit 1
fi
if [ ! -e "output/result/result_blocked.txt" ]; then
    echo "�ֿ����˷�����ļ������ڣ�lab3-2���շ���Ϊ: 0��"
    exit 1
fi
if [ ! -e "output/result/result_opt.txt" ]; then
    echo "�Ż�����˷�����ļ������ڣ�lab3-3���շ���Ϊ: 0��"
    exit 1
fi

# ��������ļ���MD5ֵ
md5_output_naive=$(md5sum "output/result/result_naive.txt" | awk '{print $1}')
md5_output_blocked=$(md5sum "output/result/result_blocked.txt" | awk '{print $1}')
md5_output_opt=$(md5sum "output/result/result_opt.txt" | awk '{print $1}')
md5_target=$(md5sum "output/result/result_reference.txt" | awk '{print $1}')

# �Ƚ�����MD5ֵ�б��Ƿ����
if [[ "$md5_output_naive" == "$md5_target" ]]; then
    echo "����ļ�naive MD5ֵƥ�䣬lab3-1����Ϊ: 100��"
else
    echo "����ļ�naive MD5ֵ��ƥ�䣬lab3-1���շ���Ϊ: 0��"
    echo $md5_output_naive
fi
if [[ "$md5_output_blocked" == "$md5_target" ]]; then
    echo "����ļ�blocked MD5ֵƥ�䣬lab3-2���շ���Ϊ: 100��"
else
    echo "����ļ�blocked MD5ֵ��ƥ�䣬lab3-2���շ���Ϊ: 0��"
    echo $md5_output_blocked
fi
if [[ "$md5_output_opt" == "$md5_target" ]]; then
    echo "����ļ�MD5ֵƥ�䣬lab3-3���շ���Ϊ: 100��"
else
    echo "����ļ�MD5ֵ��ƥ�䣬lab3-3���շ���Ϊ: 0��"
    echo $md5_output_opt
fi

if [ "$md5_output_naive" == "$md5_target" ] && [ "$md5_output_blocked" == "$md5_target" ] && [ "$md5_output_opt" == "$md5_target" ]; then
    echo "lab3-3���շ���Ϊ: 100��"
fi