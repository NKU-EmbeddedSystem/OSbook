#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "test.h"


void print_matrix(float**m, int rows, int cols) {
    for (int i=0; i<rows; i++) {
        for (int j=0; j<cols; j++) {
            printf("%f ", m[i][j]);
        }
        printf("\n");
    }
}

struct _MUL_FUNC {
    char* name;
    float (*excute)(float**,float**,float**,int,int,int);
} mul_func;


int main(int argc, char* argv[]) {              

    int m = 8, n = 8, r = 8;

    mul_func.name = "cmn";
    mul_func.excute = cmn_matrix_multiplication;

    int opt, tmp;
    extern char* optarg;
    while ((opt = getopt(argc, argv, "m:n:r:u:")) != -1) {
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
            case 'u':
                if (strcmp(optarg, "cmn") == 0) {
                    mul_func.name = "cmn";
                    mul_func.excute = cmn_matrix_multiplication;
                } else if (strcmp(optarg, "sse") == 0) {
                    mul_func.name = "sse";
                    mul_func.excute = sse_matrix_multiplication;
                } else if (strcmp(optarg, "avx") == 0) {
                    mul_func.name = "avx";
                    mul_func.excute = avx_matrix_multiplication;
                } 
                break;
        }
    }

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

    // if you want real random, please uncomment here
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

    // matrix multiplication
    float cost_time = mul_func.excute(matrix, matrix_1, matrix_2, m, n, r);
    printf("%f\n", cost_time);  // unit is second
}