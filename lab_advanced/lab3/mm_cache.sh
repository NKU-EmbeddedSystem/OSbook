#!/bin/bash

g++ -o mm_naive mm_naive.cpp
g++ -o mm_blocked mm_blocked.cpp
g++ -o mm_opt mm_opt.cpp

perf stat -e cache-references,cache-misses ./mm_naive > output/naive_result.txt
perf stat -e cache-references,cache-misses ./mm_blocked > output/blocked_result.txt
perf stat -e cache-references,cache-misses ./mm_opt > output/opt_result.txt
