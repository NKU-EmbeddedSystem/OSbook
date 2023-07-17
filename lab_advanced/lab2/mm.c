#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <time.h>

#define bool int
#define true 1
#define false 0


void read_csv(int file_no, float* array) {
    FILE * fp = NULL;
    char *line, *word;
    char buffer[10000];
    int i = 0;
    if(file_no == 0){
        fp = fopen("./input/A_1024.csv", "r");
    } else if(file_no == 1) {
        fp = fopen("./input/B_1024.csv", "r");
    } else if(file_no == 2) {
        fp = fopen("./input/C_1024.csv", "r");
    } else{
        assert(0);
    }
    if(fp == NULL){
        assert(0);
    }
    while((line = fgets(buffer, sizeof(buffer), fp))!=NULL){
        word = strtok(line, ",");
        while (word != NULL){
            array[i++] = strtol(word, NULL, 10);
            word = strtok(NULL, ",");
        }
    }
    fclose(fp);
}

bool test_result(float* result, float* answer, int len){
    int i;
    for(i = 0; i < len; i++){
        if(result[i] != answer[i]){
            return false;
        }
    }
    return true;
}
void matrix_mul(float* matrix_A, float* matrix_B, float* matrix_C, int m, int k, int n){
    float(*A)[k] = (float(*)[k]) matrix_A;
    float(*B)[n] = (float(*)[n]) matrix_B;
    float(*C)[n] = (float(*)[n]) matrix_C;

    memset(C, 0, m*n*sizeof(float));
    
    // 利用矩阵A与矩阵B对应行乘积并累加计算C矩阵
    int mi, ki, ni;
    for(mi = 0; mi < m; mi++){
        for(ni = 0; ni < n; ni++){
            for(ki = 0; ki < k; ki++){
                C[mi][ni] += A[mi][ki] * B[ki][ni];
            }
        }
    }
}

int main(){
    int m = 1024, k = 1024, n = 1024, i, j;
    float* A = malloc(m*k*sizeof(float));
    float* B = malloc(k*n*sizeof(float));
    float* C = malloc(m*n*sizeof(float));
    float* C_answer = malloc(m*n*sizeof(float));

    read_csv(0, A);
    read_csv(1, B);
    read_csv(2, C_answer);
    clock_t start, end;
    start = clock();
    matrix_mul(A, B, C, m, k, n);
    end = clock();
    int result_clock = end - start;
    float result_time = (float)result_clock / CLOCKS_PER_SEC;

    if(test_result(C, C_answer, m*n)){
        printf("check pass! %fs\n", result_time);
    }else{
        printf("answer wrong!\n");
    }

    FILE * fp = NULL;
    fp = fopen("./output/result/result.txt", "w");
    fclose(fp);
    fp = fopen("./output/result/result.txt", "a");
    for(i = 0; i < m; i++){
        for(j = 0; j < n; j++){
            fprintf(fp, "%d ", (int)C[i*n+j]);
        }
        fprintf(fp, "\n");
    }
    fclose(fp);

    fp = fopen("./output/time/time.txt", "a");
    fprintf(fp, "%fs\n", result_time);
    fclose(fp);
    

    free(A);
    free(B);
    free(C);
    free(C_answer);
    return 0;
}