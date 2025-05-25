cmake_minimum_required(VERSION 3.10)

project(MatrixMultiplyOpenCL)

find_package(OpenCL REQUIRED)

add_executable(matrix_multiply matrix_multiply.cpp)

target_include_directories(matrix_multiply PRIVATE ${OpenCL_INCLUDE_DIRS})
target_link_libraries(matrix_multiply PRIVATE ${OpenCL_LIBRARIES})
