/**
 * @file mm0.c
 * @author By
 * @brief basic mm(row&col) + mutex
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <assert.h>

pthread_mutex_t lock;

#define bool int
#define true 1
#define false 0


void read_csv(int file_no, float* array) {
    FILE * fp = NULL;
    char *line, *word;
    char buffer[10000];
    int i = 0;
    if(file_no == 0){
        fp = fopen("../dataset/shape_1000/A_1000.csv", "r");
    } else if(file_no == 1) {
        fp = fopen("../dataset/shape_1000/B_1000.csv", "r");
    } else if(file_no == 2) {
        fp = fopen("../dataset/shape_1000/C_1000.csv", "r");
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

typedef struct{
  float* matrix_A;
  float* matrix_B;
  float* matrix_C;
  int m_from;
  int m_to;
  int k_from;
  int k_to;
  int k;  // 也许可以修改一下这里
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
            for(ki = mul_args->k_from; ki < mul_args->k_to; ki++){
               // pthread_mutex_lock(&lock);
                C[mi][ni] += A[mi][ki] * B[ki][ni];
               // pthread_mutex_unlock(&lock);
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

    // int mi, ki, ni;
    // for(mi = 0; mi < m; mi++){
    //     for(ni = 0; ni < n; ni++){
    //         for(ki = 0; ki < k; ki++){
    //             C[mi][ni] += A[mi][ki] * B[ki][ni];
    //         }
    //     }
    // }

    // new code for multitreading
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

    pthread_mutex_init(&lock,NULL);
    pthread_create(&th1,NULL,matrix_mul_th,&th1_args);
    pthread_create(&th2,NULL,matrix_mul_th,&th2_args);
    pthread_create(&th3,NULL,matrix_mul_th,&th3_args);
    pthread_create(&th4,NULL,matrix_mul_th,&th4_args);

    pthread_join(th1,NULL);
    pthread_join(th2,NULL);
    pthread_join(th3,NULL);
    pthread_join(th4,NULL);
}

int main(){
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
    // return 0;
    int m = 1000, k = 1000, n = 1000, i, j;
    float* A = malloc(m*k*sizeof(float));
    float* B = malloc(k*n*sizeof(float));
    float* C = malloc(m*n*sizeof(float));
    float* C_answer = malloc(m*n*sizeof(float));

    read_csv(0, A);
    read_csv(1, B);
    read_csv(2, C_answer);

    matrix_mul(A, B, C, m, k, n);

    if(test_result(C, C_answer, m*n)){
        printf("check pass!\n");
    }else{
        printf("answer wrong!\n");
    }
    

    free(A);
    free(B);
    free(C);
    free(C_answer);
    return 0;
}
