#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <chrono>
#include <sstream>
#include <fstream>
#include <cstdlib>
#include <iostream>
#include "param.h"

using namespace std;
using namespace std::chrono;

void matrixMultiply(float **A, float **B, float **C, int N) {
    for (int i = 0; i < N; i++) {
        for (int k = 0; k < N; k++) {
            //C[i][j] = 0;
            for (int j = 0; j < N; j++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

void writeResultToFile(const float** result, int N, const string& filename) {
    ofstream outputFile(filename);

    if (outputFile.is_open()) {
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                outputFile << result[i][j] << " ";
            }
            outputFile << endl;
        }

        outputFile.close();
        cout << "Result written to " << filename << endl;
    } else {
        cerr << "Unable to open file: " << filename << endl;
    }
}

//写入所耗时间
void writeDurationToFile(long long duration, const string& filename) {
    ofstream outputFile(filename);

    if (outputFile.is_open()) {
        outputFile << duration << endl;
        outputFile.close();
        cout << "Duration written to " << filename << endl;
    } else {
        cerr << "Unable to open file: " << filename << endl;
    }
}

void testMatrixMultiplicationPerformance(int N, int blockSize) {
    float **A, **B, **C;
    A = (float **)malloc(N * sizeof(float *));
    B = (float **)malloc(N * sizeof(float *));
    C = (float **)malloc(N * sizeof(float *));
    
    for (int i = 0; i < N; i++) {
        A[i] = (float *)malloc(N * sizeof(float));
        B[i] = (float *)malloc(N * sizeof(float));
        C[i] = (float *)malloc(N * sizeof(float));
    }

    float valueA = 1.0;
    float valueB = N * N + 1.0;
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            A[i][j] = valueA;
            valueA += 1.0;
            B[i][j] = valueB;
            valueB *= -1.0;
        }
    }


    auto start = std::chrono::high_resolution_clock::now();
    matrixMultiply(A, B, C, N);
    auto end = std::chrono::high_resolution_clock::now();
    const float** result = const_cast<const float**>(C);
    writeResultToFile(result, N, "output/result/result_order.txt");

    std::chrono::duration<double> elapsed_time = end - start;
    cout << "Matrix multiplication with changing order: " << elapsed_time.count() << "seconds" << endl;

    writeDurationToFile(elapsed_time.count(), "output/time/time_order.txt");
    
    double time = elapsed_time.count();
    double gflops = 2.0 * N * N * N / time / 1e9;
    cout << "GFLOPS = " << gflops << endl;

    for (int i = 0; i < N; i++) {
        free(A[i]);
        free(B[i]);
        free(C[i]);
    }
    free(A);
    free(B);
    free(C);
}

int main() {
    //int N = 1024; // Size of the matrices
    //int blockSize = 64; // Block size for block matrix multiplication
    cout << "N = " << N << ", blockSize = " << blockSize << endl;
    srand(time(NULL)); // Seed the random number generator

    testMatrixMultiplicationPerformance(N, blockSize);

    return 0;
}
