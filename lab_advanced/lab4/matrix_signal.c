#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <assert.h>
#include <semaphore.h>
#include <bits/types/struct_timeval.h>
#include <sys/time.h>

sem_t sem;

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

typedef struct{
  float* matrix_A;
  float* matrix_B;
  float* matrix_C;
  int m_from;
  int m_to;
  int k_from;
  int k_to;
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
    // TODO 基于信号量执行部分矩阵乘
    for([TODO]){
        for([TODO]){
            for([TODO]){
                sem_wait(&sem);  // 等待信号量，当信号量>0时向下运行，并将信号量减1
                [TODO]
                sem_post(&sem);  // 归还信号，信号量加1
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

    // 改变矩阵划分方式，使用四个线程(th1,th2,th3,th4)运行矩阵乘法运算
    // 过程中发生了数据冲突，使用信号量解决该问题
    pthread_t th1;
    pthread_t th2;
    pthread_t th3;
    pthread_t th4;

    int mid_m = m/2;
    int mid_k = k/2;
    mul_thread_args th1_args={ matrix_A, matrix_B, matrix_C, 0, mid_m, 0, mid_k, k,n };
    mul_thread_args th2_args={ matrix_A, matrix_B, matrix_C, 0, mid_m, mid_k, k, k,n };
    mul_thread_args th3_args={ matrix_A, matrix_B, matrix_C, mid_m, m, 0, mid_k, k,n };
    mul_thread_args th4_args={ matrix_A, matrix_B, matrix_C, mid_m, m, mid_k, k, k,n };

    // TODO 初始化信号量
    [TODO];
    pthread_create(&th1,NULL,matrix_mul_th,&th1_args);
    pthread_create(&th2,NULL,matrix_mul_th,&th2_args);
    pthread_create(&th3,NULL,matrix_mul_th,&th3_args);
    pthread_create(&th4,NULL,matrix_mul_th,&th4_args);

    pthread_join(th1,NULL);
    pthread_join(th2,NULL);
    pthread_join(th3,NULL);
    pthread_join(th4,NULL);

    // TODO 清除信号量
    [TODO];
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
    FILE* result_fp=fopen("./output/result/matrix_signal.txt","w");
    for(int i = 0; i < m; i++){
        for(int j = 0; j < n; j++){
            fprintf(result_fp,"%.1f ",result_C[i][j]);
        }
        fprintf(result_fp,"\n");
    }
    fclose(result_fp);

    // 输出运算时间
    FILE* time_fp = fopen("./output/time/matrix_multi_signal.txt","w");
    fprintf(time_fp,"%f s",total_time/CLOCKS_PER_SEC);
    fclose(time_fp); 
  
    free(A);
    free(B);
    free(C);

    return 0;

}
