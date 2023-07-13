#include "test.h"


float cmn_matrix_multiplication(float**matrix, float**matrix_1, float**matrix_2, int m, int n, int r) {
    clock_t start, end;
    start = clock();
    // ------------------------------------------------------------
    for (int i=0; i<m; i++) {
        for (int j=0; j<r; j++) {
            for (int k=0; k<n; k++) {
                matrix[i][j] += matrix_1[i][k] * matrix_2[k][j];
            }
        }
    }
    // ------------------------------------------------------------
    end = clock();
    float result_time = (float)(end-start) / CLOCKS_PER_SEC;
    return result_time;
}