#!/bin/bash

g++ -o mm_naive -O0 mm_naive.cpp &
g++ -o mm_block -O0 mm_block.cpp &
g++ -o mm_order -O0 mm_order.cpp

./mm_naive
./mm_blocke
./mm_order
