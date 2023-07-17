#!/bin/bash

g++ -o server_basic server_basic.cpp
g++ -o client_basic client_basic.cpp

./server_basic fork & ./client_basic
