#ifndef TEST_FILE_H
#define TEST_FILE_H

#include <time.h>
#include <immintrin.h>
#include <xmmintrin.h>

float cmn_matrix_multiplication(float**matrix, float**matrix_1, float**matrix_2, int m, int n, int r);
float sse_matrix_multiplication(float**matrix, float**matrix_1, float**matrix_2, int m, int n, int r);
float avx_matrix_multiplication(float**matrix, float**matrix_1, float**matrix_2, int m, int n, int r);

#endif