#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define CACHE_LINE_SIZE (64)
#define MICRO_PANEL_SIZE (CACHE_LINE_SIZE / sizeof(float))

// compiler error
#define min(a, b) ((a) > (b) ? (b) : (a))

#define MC 10
#define KC 10
#define NR 10
float all = 0;

void matrix_mul(float* matrix_A, float* matrix_B, float* matrix_C, int m, int k, int n){
    float(*A)[k] = (float(*)[k]) matrix_A;
    float(*B)[n] = (float(*)[n]) matrix_B;
    float(*C)[n] = (float(*)[n]) matrix_C;

    memset(C, 0, m*n*sizeof(float));
    
    int mc = MC;
    int kc = KC;
    int nr = NR;
    // devide matrix_b into multiple blocks
    for(int row_b1 = 0; row_b1 < k; row_b1 += kc) {
        int min_kc = min(k - row_b1, kc);
        float* block_B = malloc(min_kc * n * sizeof(float));
        // pack the block of matrix_b into row-order for sequential access
        // a block of matrix_b will be placed into llc cache
        int counter = 0;
        for(int i2 = 0; i2 < n; i2++) {
            for(int i3 = row_b1; i3 < row_b1 + min_kc; i3++) {
                block_B[counter] = B[i3][i2];
                counter++;
            }
        }

        // devide matrix_a into multiple blocks
        //for(int column_a1 = 0; column_a1 < k; column_a1 += kc) {

            // devide block of matrix_a into multiple micro-blocks
            // a micro-block of matrix_a will be placed into l2 cache
            for(int row_a1 = 0; row_a1 < m; row_a1 += mc) {
                int min_mc = min(m - row_a1, mc);
                // pack the block of matrix_a into column-order for sequential access
                float* mblock_A = malloc(min_mc * min_kc * sizeof(float));
                int counter = 0;
                for(int i3 = row_a1; i3 < row_a1 + min_mc; i3++) {
                    for(int i4 = row_b1; i4 < row_b1 +min_kc; i4++) {
                        mblock_A[counter] = A[i3][i4];
                        //printf("%f\n", A[i3][i4]);
                        counter++;
                    }
                }

                // devide block of matrix_b into multiple micro-blocks
                // a micro-block of matrix_b should be able to be placed into l1 cache
                for(int column_b1 = 0; column_b1 < n; column_b1 += nr) {
                    // since we have already blocked matrix_b, we only need to locate the pointer here
                    int min_nr = min(n - column_b1, nr);
                    float* mblock_B = block_B + column_b1 * min_kc;

                    // now we simply do multiplication of micro-block of matrix_a and matrix_b
                    // i4 = row; i5 = column;
                    // we use the row-order to calculate the matrix_c so the access is sequential
                    for(int i4 = 0; i4 < min_mc; i4++) {
                        for(int i5 = 0; i5 < min_nr; i5++) {
                            float result = 0.0f;
                            // TODO: optimizing redundant mulitiplication and addition.
                            for(int i6 = 0; i6 < min_kc; i6++) {
                                //printf("%f   %f\n", mblock_A[i4 * min_kc + i6], mblock_B[i5 * min_kc + i6]);
                                result += mblock_A[i4 * min_kc + i6] * mblock_B[i5 * min_kc + i6];
                                //all += result;
                            }
                            C[row_a1 + i4][row_b1 + column_b1 + i5] += result;
                        }
                    }
                }
                free(mblock_A);
            }
        //}
        free(block_B);
    }
    printf("%f\n", all);
}

int main(){
    int m = 3, k = 3, n = 5, i, j;
    float* A = malloc(3*3*sizeof(float));
    float* B = malloc(3*5*sizeof(float));
    float* C = malloc(3*5*sizeof(float));

    A[0] = 1; A[1] = 2; A[2] = 3;
    A[3] = 4; A[4] = 5; A[5] = 6;
    A[6] = 7; A[7] = 8; A[8] = 9;

    B[0] = 1; B[1] = 1; B[2] = 1; B[3] = 1; B[4] = 1;
    B[5] = 2; B[6] = 2; B[7] = 2; B[8] = 2; B[9] = 2;
    B[10] = 3; B[11] = 3; B[12] = 3; B[13] = 3; B[14] = 3;

    matrix_mul(A, B, C, m, k, n);

    for(i = 0; i < m; i++){
        for(j = 0; j < n; j++){
            printf("%f\t", C[i*n + j]);
        }
        printf("\n");
    }

    free(A);
    free(B);
    free(C);
    return 0;
}