#!/bin/bash

g++ -o mm_naive mm_naive.cpp
g++ -o mm_blocked mm_blocked.cpp
g++ -o mm_opt mm_opt.cpp

./mm_naive
./mm_blocked
./mm_opt
