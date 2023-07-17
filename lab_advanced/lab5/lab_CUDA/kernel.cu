#include <stdlib.h>
#include <cuda_runtime.h>  
#include <string.h>
#include <assert.h>
#include <stdio.h>
#include<time.h>

#ifdef __unix
#define fopen_s(pFile,filename,mode) ((*(pFile))=fopen((filename),(mode)))==NULL
#endif

// 读取csv文件，获取数据测试数据
/* //for window run 
void read_csv(int file_no, float* M) {
    FILE* fp = NULL;
    errno_t err;
    char* word;
    char buffer[1000000];
    char* ptr = NULL;
    int i = 0;
    if (file_no == 0) {
        err = fopen_s(&fp, "../input/shape_1000/A_1000.csv", "r");
    }
    else if (file_no == 1) {
        err = fopen_s(&fp, "../input/shape_1000/B_1000.csv", "r");
    }
    else if (file_no == 2) {
        err = fopen_s(&fp, "../input/shape_1000/C_1000.csv", "r");
    }
    else {
        assert(0);
    }
    if (err) {
        assert(0);
    }
    while (fgets(buffer, sizeof(buffer), fp) != NULL) {
        word = strtok_s(buffer, ",", &ptr);
        while (word != NULL) {
            M[i++] = strtod(word, NULL);
            word = strtok_r(NULL, ",", &ptr);
        }
    }
}
*/
// for linux run
void read_csv(int file_no, float* array) {
    FILE * fp = NULL;
    char *line, *word;
    char buffer[100000];
    int i = 0;
    if(file_no == 0){
        printf("hello");
        fp = fopen("./input/shape_1000/A_1000.csv", "r");
    } else if(file_no == 1) {
        fp = fopen("./input/shape_1000/B_1000.csv", "r");
    } else if(file_no == 2) {
        fp = fopen("./input/shape_1000/C_1000.csv", "r");
    } else{
        assert(0);
    }
    if(fp == NULL){
        //assert(0);
    }
    while((line = fgets(buffer, sizeof(buffer), fp))!=NULL){
        word = strtok(line, ",");
        while (word != NULL){
            array[i++] = strtol(word, NULL, 10);
            word = strtok(NULL, ",");
        }
    }
}

// 核函数
__global__ void matrixMul(float* A, float* B, float* C, int m, int n, int p)
{
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    float sum = 0;
    if (row < m && col < p)
    {
        for (int k = 0; k < n; k++)
        {
            sum += A[row * n + k] * B[k * p + col];
        }
        C[row * p + col] = sum;
    }
}

// 预热函数，come form the book <Professional CUDA C编程>
__global__ void warm_up_gpu() {
    unsigned int tid = blockIdx.x * blockDim.x + threadIdx.x;
    float ia, ib;
    ia = ib = 0.0f;
    ib += ia + tid;
}
int main()
{
    int m, n, p;
    float* A, * B, * C,*Ct;
    int sizeA, sizeB, sizeC;
    // creat cuda timer
    cudaEvent_t start, stop;
    float esp_time_gpu;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    // creat cpu timer
    float esp_time_cpu_Data_Pre;
    float esp_time_cpu_Data_HostToDevice;
    float esp_time_cpu_Data_DeviceToHost;
    clock_t start_cpu, stop_cpu;


    start_cpu = clock();// start timing
    // Initialize matrix sizes
    m = n = p = 1000;
    sizeA = m * n;
    sizeB = n * p;
    sizeC = m * p;
    // Allocate host memory
    A = (float*)malloc(sizeA * sizeof(float));
    B = (float*)malloc(sizeB * sizeof(float));
    C = (float*)malloc(sizeC * sizeof(float));
    Ct = (float*)malloc(sizeC * sizeof(float));
    read_csv(0, A);
    read_csv(1, B);
    stop_cpu = clock();// end timing
    esp_time_cpu_Data_Pre = (float)(stop_cpu - start_cpu) / CLOCKS_PER_SEC * 1000 * 1000;


    read_csv(2, Ct);
    for(int i = 0; i < sizeC; i++)C[i] = 0.0f;
    // Allocate device memory
    float* d_A, * d_B, * d_C;
    cudaMalloc((void**)&d_A, sizeA * sizeof(float));
    cudaMalloc((void**)&d_B, sizeB * sizeof(float));
    cudaMalloc((void**)&d_C, sizeC * sizeof(float));


    start_cpu = clock();// start timing
    // Copy host memory to device
    cudaMemcpy(d_A, A, sizeA * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, sizeB * sizeof(float), cudaMemcpyHostToDevice);
    stop_cpu = clock();// end timing
    esp_time_cpu_Data_HostToDevice = (float)(stop_cpu - start_cpu)/ CLOCKS_PER_SEC*1000 * 1000;

    // Calculate grid size
    dim3 blockSize(32, 32);
    dim3 gridSize((m + blockSize.x - 1) / blockSize.x,
        (p + blockSize.y - 1) / blockSize.y);
    printf("Block(%d,%d)   Grid(%d,%d).\n", blockSize.x, blockSize.y, gridSize.x, gridSize.y);

    warm_up_gpu << <gridSize, blockSize>> > ();
    cudaEventRecord(start, 0);// start
    // Launch kernel
    for (int i = 0; i < 10; i++) {
        matrixMul <<<gridSize, blockSize >>> (d_A, d_B, d_C, m, n, p);
    }
    cudaEventRecord(stop, 0);// stop
    // device synchronize
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&esp_time_gpu, start, stop);


    start_cpu = clock();// start timing
    // Copy device memory to host
    cudaMemcpy(C, d_C, sizeC * sizeof(float), cudaMemcpyDeviceToHost);
    stop_cpu = clock();// end timing
    esp_time_cpu_Data_DeviceToHost = (float)(stop_cpu - start_cpu) / CLOCKS_PER_SEC * 1000*1000;
    


     //检查执行结果
    float maxError = 0.0;
    for (int i = 0; i < sizeC; ++i) {
        maxError = fmax(maxError, fabs(C[i] - Ct[i]));
    }
    printf("矩阵大小:%d×%d\n", m, p);
    printf("最大误差:%f\n", maxError);

    printf("Time for the kernel: %f ms\n", esp_time_gpu/10);
    printf("Time for preparing data: %f us\n", esp_time_cpu_Data_Pre);
    printf("Time for Host to Device: %f us\n", esp_time_cpu_Data_HostToDevice);
    printf("Time for Device to Host: %f us\n", esp_time_cpu_Data_DeviceToHost);

 
    char filename[50];
    sprintf(filename, "output/time/time_cuda_%d.txt", m);
    FILE *file = fopen(filename, "w");
    if (file == NULL) {
        printf("无法打开文件.\n");
        return -1;
    }
    fprintf(file, "%f",  esp_time_gpu/10);
    fclose(file);
    
    sprintf(filename, "output/result/baseline_%d.txt", m);
    FILE *file1 = fopen(filename, "w");
    if (file1 == NULL) {
        printf("无法打开文件.\n");
        return -1;
    }
    for(int i=0 ;i<sizeC;i++){
        fprintf(file1,"%f\n",C[i]);
    }
    fclose(file1);
    
    sprintf(filename, "output/result/result_%d.txt", m);
    FILE *file2 = fopen(filename, "w");
    if (file2 == NULL) {
        printf("无法打开文件.\n");
        return -1;
    }
    for(int i=0 ;i<sizeC;i++){
        fprintf(file2,"%f\n", Ct[i]);
    }
    fclose(file2);
    
    // Free device memory
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    // Free host memory
    free(A);
    free(B);
    free(C);
    free(Ct);
    return 0;
}
