#include <CL/cl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <math.h>
#include <time.h>

// 读取文件内容到字符串
char* readKernelSource(const char* filename) {
    FILE* file = fopen(filename, "r");
    if (!file) {
        fprintf(stderr, "无法打开内核文件: %s\n", filename);
        exit(1);
    }

    fseek(file, 0, SEEK_END);
    long length = ftell(file);
    fseek(file, 0, SEEK_SET);

    char* source = (char*)malloc(length + 1);
    fread(source, 1, length, file);
    source[length] = '\0';

    fclose(file);
    return source;
}
// 读取csv文件，获取数据测试数据
void read_csv(int file_no, float* array) {
    FILE * fp = NULL;
    char *line, *word;
    char buffer[100000];
    int i = 0;
    if(file_no == 0){
        fp = fopen("./input/shape_1000/A_1000.csv", "r");
    } else if(file_no == 1) {
        fp = fopen("./input/shape_1000/B_1000.csv", "r");
    } else if(file_no == 2) {
        fp = fopen("./input/shape_1000/C_1000.csv", "r");
    } else{
        assert(0);
    }
    if(fp == NULL){
        printf("无法打开文件.\n");
        exit(-1);
    }
    while((line = fgets(buffer, sizeof(buffer), fp))!=NULL){
        word = strtok(line, ",");
        while (word != NULL){
            array[i++] = strtof(word, NULL);
            word = strtok(NULL, ",");
        }
    }
    fclose(fp);
}

int main()
{
    int m, n, p;
    float *A, *B, *C, *Ct;
    int sizeA, sizeB, sizeC;

    // 计时变量
    float esp_time_cpu_Data_Pre;
    float esp_time_cpu_Data_HostToDevice;
    float esp_time_cpu_Data_DeviceToHost;
    clock_t start_cpu, stop_cpu;

    // 初始化矩阵大小
    m = n = p = 1000;
    sizeA = n * p;
    sizeB = p * m;
    sizeC = n * m;

    // 分配主机内存
    A = (float*)malloc(sizeof(float) * sizeA);
    B = (float*)malloc(sizeof(float) * sizeB);
    C = (float*)malloc(sizeof(float) * sizeC);
    Ct = (float*)malloc(sizeof(float) * sizeC);

    // 计时：数据准备
    start_cpu = clock();
    read_csv(0, A);
    read_csv(1, B);
    stop_cpu = clock();
    esp_time_cpu_Data_Pre = (float)(stop_cpu - start_cpu) / CLOCKS_PER_SEC * 1000 * 1000;

    read_csv(2, Ct);
    for(int i = 0; i < sizeC; i++) C[i] = 0.0f;

    // OpenCL 初始化
    cl_int err_num;
    cl_uint num_platform;
    cl_platform_id *platform_list;
    err_num = clGetPlatformIDs(0, NULL, &num_platform);
    platform_list = (cl_platform_id *)malloc(sizeof(cl_platform_id) * num_platform);
    err_num = clGetPlatformIDs(num_platform, platform_list, NULL);

    cl_uint num_device;
    cl_device_id device;
    err_num = clGetDeviceIDs(platform_list[0], CL_DEVICE_TYPE_GPU, 1, &device, NULL);

    cl_context_properties context_properties[3] = {
        CL_CONTEXT_PLATFORM,
        (cl_context_properties)platform_list[0],
        0
    };
    cl_context context = clCreateContext(context_properties, 1, &device, NULL, NULL, &err_num);

    cl_queue_properties queue_properties[3] = {
        CL_QUEUE_PROPERTIES,
        CL_QUEUE_PROFILING_ENABLE,
        0
    };
    cl_command_queue command_queue = clCreateCommandQueueWithProperties(context, device, queue_properties, &err_num);

    // 创建缓冲区
    cl_mem buffer_A = clCreateBuffer(context, CL_MEM_READ_ONLY, sizeof(float) * sizeA, NULL, &err_num);
    cl_mem buffer_B = clCreateBuffer(context, CL_MEM_READ_ONLY, sizeof(float) * sizeB, NULL, &err_num);
    cl_mem buffer_C = clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(float) * sizeC, NULL, &err_num);

    // 计时：Host->Device
    start_cpu = clock();
    clEnqueueWriteBuffer(command_queue, buffer_A, CL_TRUE, 0, sizeof(float) * sizeA, A, 0, NULL, NULL);
    clEnqueueWriteBuffer(command_queue, buffer_B, CL_TRUE, 0, sizeof(float) * sizeB, B, 0, NULL, NULL);
    stop_cpu = clock();
    esp_time_cpu_Data_HostToDevice = (float)(stop_cpu - start_cpu) / CLOCKS_PER_SEC * 1000 * 1000;

    char* kernelSource = readKernelSource("matrix_multiply.cl");

    // 创建和编译程序
    cl_program program = clCreateProgramWithSource(context, 1, (const char**)&kernelSource, NULL, &err_num);
    err_num = clBuildProgram(program, 0, NULL, NULL, NULL, NULL);
    if (err_num != CL_SUCCESS) {
        size_t log_size;
        clGetProgramBuildInfo(program, device, CL_PROGRAM_BUILD_LOG, 0, NULL, &log_size);
        char *log = (char *)malloc(log_size);
        clGetProgramBuildInfo(program, device, CL_PROGRAM_BUILD_LOG, log_size, log, NULL);
        printf("Build log:\n%s\n", log);
        free(log);
        return 1;
    }

    cl_kernel kernel = clCreateKernel(program, "matrixMul", &err_num);

    // 设置参数
    err_num = 0;
    err_num |= clSetKernelArg(kernel, 0, sizeof(int), &m);
    err_num |= clSetKernelArg(kernel, 1, sizeof(int), &n);
    err_num |= clSetKernelArg(kernel, 2, sizeof(int), &p);
    err_num |= clSetKernelArg(kernel, 3, sizeof(cl_mem), &buffer_A);
    err_num |= clSetKernelArg(kernel, 4, sizeof(cl_mem), &buffer_B);
    err_num |= clSetKernelArg(kernel, 5, sizeof(cl_mem), &buffer_C);

    
    size_t local_work_size[2] = {16, 16};
    size_t global_work_size[2] = {
        ((m + local_work_size[0] - 1) / local_work_size[0]) * local_work_size[0],
        ((n + local_work_size[1] - 1) / local_work_size[1]) * local_work_size[1]
    };

    // 检查设备限制
    size_t max_work_group_size;
    clGetDeviceInfo(device, CL_DEVICE_MAX_WORK_GROUP_SIZE, sizeof(max_work_group_size), &max_work_group_size, NULL);
    if (local_work_size[0] * local_work_size[1] > max_work_group_size) {
        printf("Local work size too large for device\n");
        return 1;
    }
    // 计时：核函数执行
    cl_event event;
    cl_ulong time_start, time_end;
    double esp_time_gpu = 0.0;
    for (int i = 0; i < 10; i++) {
        err_num = clEnqueueNDRangeKernel(command_queue, kernel, 2, NULL, global_work_size, local_work_size, 0, NULL, &event);
        clWaitForEvents(1, &event);
        clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_START, sizeof(time_start), &time_start, NULL);
        clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_END, sizeof(time_end), &time_end, NULL);
        esp_time_gpu += (time_end - time_start) / 1000000.0; // ns->ms
        clReleaseEvent(event);
    }
    esp_time_gpu /= 10.0;
    if (err_num != CL_SUCCESS) {
        printf("Kernel execution failed: %d\n", err_num);
        return 1;
    }
    clFinish(command_queue);  // 确保所有命令执行完毕

    // 计时：Device->Host
    start_cpu = clock();
    clEnqueueReadBuffer(command_queue, buffer_C, CL_TRUE, 0, sizeof(float) * sizeC, C, 0, NULL, NULL);
    stop_cpu = clock();
    esp_time_cpu_Data_DeviceToHost = (float)(stop_cpu - start_cpu) / CLOCKS_PER_SEC * 1000 * 1000;

    // 检查执行结果
    float maxError = 0.0;
    for (int i = 0; i < sizeC; ++i) {
        maxError = fmaxf(maxError, fabsf(C[i] - Ct[i]));
    }
    printf("矩阵大小:%d×%d\n", m, p);
    printf("最大误差:%f\n", maxError);
    printf("Time for the kernel: %f ms\n", esp_time_gpu);
    printf("Time for preparing data: %f us\n", esp_time_cpu_Data_Pre);
    printf("Time for Host to Device: %f us\n", esp_time_cpu_Data_HostToDevice);
    printf("Time for Device to Host: %f us\n", esp_time_cpu_Data_DeviceToHost);

    // 输出到文件
    char filename[100];
    sprintf(filename, "output/time/time_opencl_%d.txt", m);
    FILE *file = fopen(filename, "w");
    if (file) {
        fprintf(file, "%f", esp_time_gpu);
        fclose(file);
    }

    sprintf(filename, "output/result/baseline_%d.txt", m);
    FILE *file1 = fopen(filename, "w");
    if (file1) {
        for(int i=0 ;i<sizeC;i++){
            fprintf(file1,"%d\n", (int)C[i]);
        }
        fclose(file1);
    }

    sprintf(filename, "output/result/result_%d.txt", m);
    FILE *file2 = fopen(filename, "w");
    if (file2) {
        for(int i=0 ;i<sizeC;i++){
            fprintf(file2,"%d\n", (int)Ct[i]);
        }
        fclose(file2);
    }

    // 释放资源
    clReleaseKernel(kernel);
    clReleaseProgram(program);
    clReleaseMemObject(buffer_A);
    clReleaseMemObject(buffer_B);
    clReleaseMemObject(buffer_C);
    clReleaseCommandQueue(command_queue);
    clReleaseContext(context);
    free(platform_list);

    free(A);
    free(B);
    free(C);
    free(Ct);

    return 0;
}
