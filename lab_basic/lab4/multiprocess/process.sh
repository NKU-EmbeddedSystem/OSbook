#!/bin/bash

gcc -o mmap mmap.c
gcc -o process process.c
gcc lab3.c -o lab3
./lab3 > output/lab3_result.txt
./process > output/lab4_process_result.txt 
