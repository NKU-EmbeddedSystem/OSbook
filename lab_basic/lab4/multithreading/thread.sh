#!/bin/bash

gcc thread.c -o thread -lpthread
gcc lab3.c -o lab3
./lab3 > output/lab3_result.txt
./thread > output/lab4_process_result.txt
