#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <immintrin.h>
#include <xmmintrin.h>


void print_matrix(float**m, int rows, int cols) {
    for (int i=0; i<rows; i++) {
        for (int j=0; j<cols; j++) {
            printf("%f ", m[i][j]);
        }
        printf("\n");
    }
}

void common_matrix_multiplication(float**matrix, float**matrix_1, float**matrix_2, int m, int n, int r) {
    for (int i=0; i<m; i++) {
        for (int j=0; j<r; j++) {
            for (int k=0; k<n; k++) {
                matrix[i][j] += matrix_1[i][k] * matrix_2[k][j];
            }
        }
    }
}

// void gemm_matrix_multiplication(float**matrix, float**matrix_1, float**matrix_2, int m, int n, int r) {

// }

void sse_matrix_multiplication(float**matrix, float**matrix_1, float**matrix_2, int m, int n, int r) {
    float*tmp = (float*)malloc(4*sizeof(float));
    for (int i=0; i<4; i++) tmp[i] = 0.f;
    for (int i=0; i<m; i++) {
        for (int j=0; j<r; j++) {
            for (int k=0; k<n; k+=4) {
                // _mm_storeu_ps(tmp, _mm_mul_ps(
                //     _mm_set_ps(matrix_1[i][k], matrix_1[i][k+1], matrix_1[i][k+2], matrix_1[i][k+3]), 
                //     _mm_set_ps(matrix_2[k][j], matrix_2[k+1][j], matrix_2[k+2][j], matrix_2[k+3][j])
                // ));
                _mm_storeu_ps(tmp, _mm_mul_ps(
                    _mm_loadu_ps((float*)(matrix_1[i]+k)), 
                    _mm_setr_ps(matrix_2[k][j], matrix_2[k+1][j], matrix_2[k+2][j], matrix_2[k+3][j])
                ));
                matrix[i][j] += tmp[0] + tmp[1] + tmp[2] + tmp[3];
                // printf("%f %f %f %f\n", tmp[0], tmp[1], tmp[2], tmp[3]);
            }
        }
    }  
}

void avx_matrix_multiplication(float**matrix, float**matrix_1, float**matrix_2, int m, int n, int r) {
    float*tmp = (float*)malloc(8*sizeof(float));
    for (int i=0; i<8; i++) tmp[i] = 0.f;
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
}

int main(int argc, char* argv[]) {
    // for (int i=0; i<argc; i++) {
    //     printf("argv[%d] = %s\n", i, argv[i]);
    // }                 

    int m = 8, n = 8, r = 8;

    int opt, tmp;
    extern char* optarg;
    while ((opt = getopt(argc, argv, "m:n:r:")) != -1) {
        switch(opt) {
            case 'm': 
                tmp = atoi(optarg);
                if (tmp > 0) m = tmp;
                else printf("m must greater than 0, use default value 8\n");
                break;
            case 'n':
                tmp = atoi(optarg);
                if (tmp > 0 && tmp % 8 == 0) n = tmp;
                else printf("n must be divisible by 8 and greater than 0, use default value 8\n");
                break;
            case 'r':
                tmp = atoi(optarg);
                if (tmp > 0) r = tmp;
                else printf("r must greater than 0, use default value 8\n");
                break;
        }
    }

    // // config, (m, r) = (m, n) x (n, r)
    // int m = 8, n = 8, r = 8;
    // if (n % 8 != 0 || n <= 0) {
    //     printf("n must be divisible by 8 and greater than 0");
    //     return -1;
    // }

    printf("------------------------------------------------\n");
    printf("(%d,%d) = (%d,%d) x (%d,%d)\n", m, r, m, n, n, r);
    printf("------------------------------------------------\n");

    // allocate memory for 3 matrices
    float**matrix_1 = (float**)malloc(m*sizeof(float*));
    for (int i=0; i<m; i++) {
        matrix_1[i] = (float*)malloc(n*sizeof(float));
    }
    float**matrix_2 = (float**)malloc(n*sizeof(float*));
    for (int i=0; i<n; i++) {
        matrix_2[i] = (float*)malloc(r*sizeof(float));
    }
    float**matrix = (float**)malloc(m*sizeof(float*));
    for (int i=0; i<r; i++) {
        matrix[i] = (float*)malloc(r*sizeof(float));
    }

    // initialize matrices
    // srand((unsigned)time(NULL));
    for (int i=0; i<m; i++) {
        for (int j=0; j<n; j++) {
            matrix_1[i][j] = (float)(rand() / (float)RAND_MAX);
        }
    }
    for (int i=0; i<n; i++) {
        for (int j=0; j<r; j++) {
            matrix_2[i][j] = (float)(rand() / (float)RAND_MAX);
        }
    }
    for (int i=0; i<m; i++) {
        for (int j=0; j<r; j++) {
            matrix[i][j] = 0.f;
        }
    }
    // printf("%s\n", "matrix_1:");
    // print_matrix(matrix_1, m, n);
    // printf("%s\n", "matrix_2:");
    // print_matrix(matrix_2, n, r);
    // printf("------------------------------------------------\n");

    // matrix multiplication
    // common_matrix_multiplication(matrix, matrix_1, matrix_2, m, n, r);
    // sse_matrix_multiplication(matrix, matrix_1, matrix_2, m, n, r);
    avx_matrix_multiplication(matrix, matrix_1, matrix_2, m, n, r);
    
    // printf("%s\n", "result:");
    // print_matrix(matrix, m, r);
}