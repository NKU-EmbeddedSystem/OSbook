#!/bin/bash

gcc -o mmap mmap.c
gcc -o process process.c

./process > output/new.txt
