#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>  
#include <sys/time.h>
// 矩阵类型，行优先，M(row, col) = *(M.elements + row * M.width + col)
struct Matrix
{
    int width;
    int height;
    float *elements;
};

// 获取矩阵A的(row, col)元素
__device__ float getElement(Matrix *A, int row, int col)
{
    return A->elements[row * A->width + col];
}

// 为矩阵A的(row, col)元素赋值
__device__ void setElement(Matrix *A, int row, int col, float value)
{
    A->elements[row * A->width + col] = value;
}

// TODO 矩阵相乘kernel，2-D，每个线程计算一个元素
__global__ void matMulKernel(Matrix *A, Matrix *B, Matrix *C)
{
    [TODO];
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
    int width = 1 << 10;
    int height = 1 << 10;
    Matrix *A, *B, *C;
    // 申请托管内存
    cudaMallocManaged((void**)&A, sizeof(Matrix));
    cudaMallocManaged((void**)&B, sizeof(Matrix));
    cudaMallocManaged((void**)&C, sizeof(Matrix));
    int nBytes = width * height * sizeof(float);
    cudaMallocManaged((void**)&A->elements, nBytes);
    cudaMallocManaged((void**)&B->elements, nBytes);
    cudaMallocManaged((void**)&C->elements, nBytes);

    // 初始化数据
    A->height = height;
    A->width = width;
    B->height = height;
    B->width = width;
    C->height = height;
    C->width = width;
    for (int i = 0; i < width * height; ++i)
    {
        A->elements[i] = 1.0;
        B->elements[i] = 2.0;
    }

    // 定义kernel的执行配置
    dim3 blockSize(32, 32);
    dim3 gridSize((width + blockSize.x - 1) / blockSize.x, 
        (height + blockSize.y - 1) / blockSize.y);
    
    // 执行kernel
    matMulKernel << < gridSize, blockSize >> >(A, B, C);


    
    // 同步device 保证结果能正确访问
    cudaDeviceSynchronize();
    // 检查执行结果
    float maxError = 0.0;
    for (int i = 0; i < width * height; ++i)
        maxError = fmax(maxError, fabs(C->elements[i] - 2 * width));
    printf("最大误差:%f\n",maxError);

    // 将结果保存  
    char filename[50];
    sprintf(filename, "output/result/baseline_%d.txt", width);
    FILE *file1 = fopen(filename, "w");
    if (file1 == NULL) {
        printf("无法打开文件.\n");
        return -1;
    }
    for(int i=0 ;i<width * height;i++){
        fprintf(file1,"%d\n",int(2048));
    }
    fclose(file1);
    
    sprintf(filename, "output/result/result_%d.txt", width);
    FILE *file2 = fopen(filename, "w");
    if (file2 == NULL) {
        printf("无法打开文件.\n");
        return -1;
    }
    for(int i=0 ;i<width * height;i++){
        fprintf(file2,"%d\n", int(C->elements[i]));
    }
    fclose(file2);
    return 0;
}

