#!/bin/bash

echo generate inputs ...
# python3 generate.py   # generate.py need numpy

echo compiling ...
gcc -o test_cmn test_cmn.c
gcc -o test_lsx -mlsx test_loongson_lsx.c
gcc -o test_lasx -mlasx test_loongson_lasx.c

echo start testing ...
sizes=(128 256 512 1024)
funcs=(cmn lsx lasx)
for size in ${sizes[*]}
do
    for func in ${funcs[*]}
    do
        echo  ============= $func $size ============= 
        ./test_$func $size
        python3 check.py $func $size
    done
    python3 speedup_ratio.py loongson $size
done