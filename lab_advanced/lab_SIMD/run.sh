#!/bin/bash
rm *.out
gcc -o test.out -msse -mavx test.c -w
sudo perf record ./test.out -m 100 -n 1000 -r 100
sudo perf report > perf.txt

# perf probe -x ./test.out <func name>
# perf record -e probe_test:<func_name> ./test.out -m 100 -n 1000 -r 100
# perf script