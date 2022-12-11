cmake_minimum_required(VERSION 3.8)
set(CMAKE_CUDA_FLAGS "-arch=compute_35 -g -G -O3")
project(lab_CUDA LANGUAGES CXX C CUDA)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH}")
add_executable(test test.cu)
