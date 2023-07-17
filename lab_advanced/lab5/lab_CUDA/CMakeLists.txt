cmake_minimum_required(VERSION 3.8)
set(CMAKE_CUDA_FLAGS "-arch=compute_35 -g -G -O3")
project(lab_CUDA LANGUAGES CXX C CUDA)

# Set the output folder where your program will be created
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)


set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH}")
add_executable(test test.cu)
#add_executable(test kernel.cu)
