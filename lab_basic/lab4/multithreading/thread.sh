#!/bin/bash

gcc thread.c -o thread -lpthread

./thread > output/new.txt
