#!/bin/bash

g++ -o server_advanced server_advanced.cpp
g++ -o client_advanced client_advanced.cpp
./server_advanced fork & ./client_advanced fork & ./client_advanced fork & ./client_advanced fork & ./client_advanced fork & ./client_advanced
