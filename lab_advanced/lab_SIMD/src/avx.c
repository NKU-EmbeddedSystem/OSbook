#include "test.h"


float avx_matrix_multiplication(float**matrix, float**matrix_1, float**matrix_2, int m, int n, int r) {
    float*tmp = (float*)malloc(8*sizeof(float));
    for (int i=0; i<8; i++) tmp[i] = 0.f;
    // ------------------------------------------------------------
    clock_t start, end;
    start = clock();
    // ------------------------------------------------------------
    for (int i=0; i<m; i++) {
        for (int j=0; j<r; j++) {
            for (int k=0; k<n; k+=8) {
                _mm256_storeu_ps(tmp, _mm256_mul_ps(
                    _mm256_loadu_ps((matrix_1[i]+k)), 
                    _mm256_setr_ps(matrix_2[k][j], matrix_2[k+1][j], matrix_2[k+2][j], matrix_2[k+3][j],
                                matrix_2[k+4][j], matrix_2[k+5][j], matrix_2[k+6][j], matrix_2[k+7][j])
                ));
                matrix[i][j] += tmp[0] + tmp[1] + tmp[2] + tmp[3] + tmp[4] + tmp[5] + tmp[6] + tmp[7];
            }
        }
    }
    // ------------------------------------------------------------
    end = clock();
    float result_time = (float)(end-start) / CLOCKS_PER_SEC;
    return result_time;
}