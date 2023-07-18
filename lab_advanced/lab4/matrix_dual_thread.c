#include <bits/types/struct_timeval.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <assert.h>
#include <sys/time.h>

#define bool int
#define true 1
#define false 0


void read_csv(int file_no, float* array, char* dir, int size) {
    FILE * fp = NULL;
    char *line, *word;
    char buffer[10000];
    char* path = (char*) malloc(strlen(dir)+15);
    int i = 0;
    if(file_no == 0){
        sprintf(path,"%s/A_%d.csv",dir,size);
    } else if(file_no == 1) {
        sprintf(path,"%s/B_%d.csv",dir,size);
    } else{
        assert(0);
    }
    fp = fopen(path, "r");
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
}

typedef struct
{
  float* matrix_A;
  float* matrix_B;
  float* matrix_C;
  int m_from;
  int m_to;
  int k;
  int n;
} mul_thread_args;

void* matrix_mul_th(void* args){
    mul_thread_args* mul_args = (mul_thread_args*) args;

    int k = mul_args->k;
    int n = mul_args->n;
    float(*A)[k] = (float(*)[k]) mul_args->matrix_A;
    float(*B)[n] = (float(*)[n]) mul_args->matrix_B;
    float(*C)[n] = (float(*)[n]) mul_args->matrix_C;

    int mi, ki, ni;
    for(mi = mul_args->m_from; mi < mul_args->m_to; mi++){
        for(ni = 0; ni < n; ni++){
            for(ki = 0; ki < k; ki++){
                C[mi][ni] += A[mi][ki] * B[ki][ni];
            }
        }
    }

    return NULL;
}

void matrix_mul(float* matrix_A, float* matrix_B, float* matrix_C, int m, int k, int n){
    float(*A)[k] = (float(*)[k]) matrix_A;
    float(*B)[n] = (float(*)[n]) matrix_B;
    float(*C)[n] = (float(*)[n]) matrix_C;

    memset(C, 0, m*n*sizeof(float));

    // 使用双线程(th1,th2)优化矩阵乘法
    pthread_t th1;
    pthread_t th2;

    int mid = m/2;
    mul_thread_args th1_args={ matrix_A, matrix_B, matrix_C, 0, mid, k, n };
    mul_thread_args th2_args={ matrix_A, matrix_B, matrix_C, mid, m, k, n };

    pthread_create(&th1,NULL,matrix_mul_th,&th1_args);
    pthread_create(&th2,NULL,matrix_mul_th,&th2_args);

    pthread_join(th1,NULL);
    pthread_join(th2,NULL);
}

int main(int argc,char* argv[]){
    // 获取数据集位置以及矩阵大小
    if(argc != 3){
        printf("Wrong argument count!\n");
        return 1;
    }
    char* dir = argv[1];
    int size = atoi(argv[2]);

    int m = size, k = size, n = size, i, j;
    float* A = malloc(m*k*sizeof(float));
    float* B = malloc(k*n*sizeof(float));
    float* C = malloc(m*n*sizeof(float));

    // 读入测试用矩阵
    read_csv(0, A, dir,size);
    read_csv(1, B, dir,size);

    struct timeval start;
    struct timeval end;

    gettimeofday(&start,NULL);
    
    matrix_mul(A, B, C, m, k, n);

    gettimeofday(&end,NULL);

    // 计算乘法运行时间
    float total_time;
    total_time = (end.tv_sec - start.tv_sec)*1000000 + (end.tv_usec - start.tv_usec);
    float(*result_C)[n] = (float(*)[n]) C;

    // 输出运算结果
    FILE* result_fp=fopen("./output/result/matrix_dual_thread.txt","w");
    for(int i = 0; i < m; i++){
        for(int j = 0; j < n; j++){
            fprintf(result_fp,"%.1f ",result_C[i][j]);
        }
        fprintf(result_fp,"\n");
    }
    fclose(result_fp);

    // 输出运算时间
    FILE* time_fp = fopen("./output/time/matrix_dual_thread.txt","w");
    fprintf(time_fp,"%f s",total_time/CLOCKS_PER_SEC);
    fclose(time_fp);
    
    free(A);
    free(B);
    free(C);
    return 0;
}
