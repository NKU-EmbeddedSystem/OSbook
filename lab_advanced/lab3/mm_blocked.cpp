#include <iostream>
#include <vector>
#include <chrono> // 添加性能测试所需的头文件
#include <cstdlib> // 添加C标准库头文件
#include <sstream>
#include <fstream>

using namespace std;
using namespace std::chrono; // 高精度时间库命名空间
#define blockSize 128 //设置分块大小

// 分块矩阵乘法
vector<vector<float>> matrixMultiplicationBlocked(const vector<vector<float>>& A, const vector<vector<float>>& B) {
    int m = A.size();
    int n = A[0].size();
    int p = B[0].size();
    vector<vector<float>> C(m, vector<float>(p, 0.0));

    //分块矩阵乘法部分，每次处理blockSize*blockSize
    for (int kk = 0; kk < n; kk += blockSize) {
        for (int jj = 0; jj < p; jj += blockSize) {
            for (int i = 0; i < m; i++) {
                for (int j = jj; j < min(jj + blockSize, p); j++) {
                    for (int k = kk; k < min(kk + blockSize, n); k++) {
                        C[i][j] += A[i][k] * B[k][j];
                    }
                }
            }
        }
    }

    return C;
}

//写入矩阵结果
void writeResultToFile(const vector<vector<float>>& result, const string& filename) {
    ofstream outputFile(filename);

    if (outputFile.is_open()) {
        for (const auto& row : result) {
            for (const auto& element : row) {
                outputFile << element << " ";
            }
            outputFile << endl;
        }

        outputFile.close();
        cout << "Result written to " << filename << endl;
    } else {
        cerr << "Unable to open file: " << filename << endl;
    }
}

//写入运行时间
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

// 性能测试函数
void performanceTest(const vector<vector<float>>& A, const vector<vector<float>>& B, const string& testName,
                     vector<vector<float>> (*multiplyFunction)(const vector<vector<float>>&, const vector<vector<float>>&) ) {
    auto start = high_resolution_clock::now(); // 记录开始时间

    // 执行矩阵乘法
    vector<vector<float>> result = multiplyFunction(A, B);

    auto end = high_resolution_clock::now(); // 记录结束时间
    auto duration = duration_cast<nanoseconds>(end - start); // 计算执行时间
    //输出结果
    writeResultToFile(result, "output/result/result_blocked.txt");
   
    double time = duration.count() / 1e9; // 转换为秒
    double size = A.size(); 
    double gflops = (2.0 * size * size * size) / time / 1e9; // 计算GFLOPS
    writeDurationToFile(duration.count(), "output/time/time_blocked.txt");
    cout << testName << "Time: " << duration.count() << " nanoseconds" << endl;
    cout << testName << " GFLOPS: " << gflops << endl;
}


int main() {
    int matrixsize = 2048; // 矩阵大小
     // 初始化矩阵A
    vector<vector<float>> A(matrixsize, vector<float>(matrixsize));
    float valueA = 1.0;
    for (int i = 0; i < matrixsize; i++) {
        for (int j = 0; j < matrixsize; j++) {
            A[i][j] = valueA;
            valueA += 1.0;
        }
    }

    // 初始化矩阵B
    vector<vector<float>> B(matrixsize, vector<float>(matrixsize));
    float valueB = matrixsize * matrixsize + 1.0;
    for (int i = 0; i < matrixsize; i++) {
        for (int j = 0; j < matrixsize; j++) {
            B[i][j] = valueB;
            valueB *= -1.0;
        }
    }

    performanceTest(A, B, "Blocked Multiplication: ", matrixMultiplicationBlocked);
    
}
