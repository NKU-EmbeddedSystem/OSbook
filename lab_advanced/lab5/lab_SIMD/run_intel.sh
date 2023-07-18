#!/bin/bash

echo generate inputs ...
# python3 generate.py   # generate.py need numpy

echo compiling ...
gcc -o test_cmn test_cmn.c
gcc -o test_sse -msse test_intel_sse.c
gcc -o test_avx -mavx test_intel_avx.c

echo start testing ...
sizes=(128 256 512 1024)
funcs=(cmn sse avx)
for size in ${sizes[*]}
do
    for func in ${funcs[*]}
    do
        echo  ============= $func $size ============= 
        ./test_$func $size
        python3 check.py $func $size
    done
    python3 speedup_ratio.py intel $size
done