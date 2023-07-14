#!/bin/bash

 export PATH=/usr/local/cuda-10.1/bin/:$PATH
 cmake ./
 make
 ./test
