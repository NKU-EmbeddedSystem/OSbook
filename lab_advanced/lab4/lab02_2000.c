
#include <bits/types/struct_timeval.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <assert.h>
#include <sys/time.h>
// #include <time.h>

#define bool int
#define true 1
#define false 0


void read_csv(int file_no, float* array) {
    FILE * fp = NULL;
    char *line, *word;
    char buffer[10000];
    int i = 0;
    if(file_no == 0){
        fp = fopen("./dataset/shape_1000/A_1000.csv", "r");
    } else if(file_no == 1) {
        fp = fopen("./dataset/shape_1000/B_1000.csv", "r");
    } else if(file_no == 2) {
        fp = fopen("./dataset/shape_1000/C_1000.csv", "r");
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

void matrix_mul(float* matrix_A, float* matrix_B, float* matrix_C, int m, int k, int n, int thread_num){
    float(*A)[k] = (float(*)[k]) matrix_A;
    float(*B)[n] = (float(*)[n]) matrix_B;
    float(*C)[n] = (float(*)[n]) matrix_C;

    memset(C, 0, m*n*sizeof(float));

    // int mi, ki, ni;
    // for(mi = 0; mi < m; mi++){
    //     for(ni = 0; ni < n; ni++){
    //         for(ki = 0; ki < k; ki++){
    //             C[mi][ni] += A[mi][ki] * B[ki][ni];
    //         }
    //     }
    // }

    // new code for multitreading
    pthread_t th[thread_num];
    mul_thread_args th_args[thread_num];
    for(int i = 1; i <= thread_num; i++){
        // pthread_t th;
        int step = m/thread_num;
        int begin = (i-1) * step;
        int end = begin + step;

        end = i == thread_num ? m : end; 
        mul_thread_args args = { matrix_A, matrix_B, matrix_C, begin,end, k, n };
        th_args[i-1] = args;
        pthread_create(&(th[i-1]),NULL,matrix_mul_th,&(th_args[i-1]));
    }

    for(int i = 1;i<= thread_num;i++ ){
        pthread_join(th[i-1],NULL);
    }
}

int main(int argc,char *argv[]){
    // int m = 3, k = 3, n = 5, i, j;
    // float* A = malloc(3*3*sizeof(float));
    // float* B = malloc(3*5*sizeof(float));
    // float* C = malloc(3*5*sizeof(float));

    // A[0] = 1; A[1] = 2; A[2] = 3;
    // A[3] = 4; A[4] = 5; A[5] = 6;
    // A[6] = 7; A[7] = 8; A[8] = 9;

    // B[0] = 1; B[1] = 1; B[2] = 1; B[3] = 1; B[4] = 1;
    // B[5] = 2; B[6] = 2; B[7] = 2; B[8] = 2; B[9] = 2;
    // B[10] = 3; B[11] = 3; B[12] = 3; B[13] = 3; B[14] = 3;

    // matrix_mul(A, B, C, m, k, n);

    // for(i = 0; i < m; i++){
    //     for(j = 0; j < n; j++){
    //         printf("%f\t", C[i*n + j]);
    //     }
    //     printf("\n");
    // }

    // free(A);
    // free(B);
    // free(C);
    int m = 1000, k = 1000, n = 1000, i, j;
    float* A = malloc(m*k*sizeof(float));
    float* B = malloc(k*n*sizeof(float));
    float* C = malloc(m*n*sizeof(float));
    float* C_answer = malloc(m*n*sizeof(float));

    read_csv(0, A);
    read_csv(1, B);
    read_csv(2, C_answer);
    
    // for(int i = 1 ; i<=50; i++){
//        start = clock();
    struct timeval start;
    struct timeval end;
    float  total_time;
       
    for(int i = 1;i<=150;i++){
      float sum = 0;
      for(int j=0;j<3;j++){
        gettimeofday(&start,NULL);
        matrix_mul(A, B, C, m, k, n, i);
        gettimeofday(&end,NULL);
        total_time = (end.tv_sec - start.tv_sec)*1000000 + (end.tv_usec - start.tv_usec);
        sum += total_time;
      }
      printf("thread number: %d\n", i);
      printf("time = %f\n",sum/3);
      if(test_result(C, C_answer, m*n)){
          printf("check pass!\n");
      }else{
          printf("answer wrong!\n");
      }
    }

    //     printf("thread number: %d  time: %ld\n",i,end - start);
    //     printf("time = %0.10f \n", (double)(end - start)/CLOCKS_PER_SEC);
    // // }
    

    free(A);
    free(B);
    free(C);
    free(C_answer);
    return 0;
}
