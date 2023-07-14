#include <iostream>
#include <vector>
#include <chrono> // 添加性能测试所需的头文件
#include <cstdlib> // 添加C标准库头文件
#include <sstream>
#include <fstream>

using namespace std;
using namespace std::chrono; // 高精度时间库命名空间
#define blockSize 128

// 直接实现的矩阵乘
vector<vector<float>> matrixMultiplicationDirect(const vector<vector<float>>& A, const vector<vector<float>>& B) {
    int m = A.size();
    int n = A[0].size();
    int p = B[0].size();

    vector<vector<float>> C(m, vector<float>(p, 0.0));

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < p; j++) {
            for (int k = 0; k < n; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    return C;
}

// 分块矩阵乘法
vector<vector<float>> matrixMultiplicationBlocked1(const vector<vector<float>>& A, const vector<vector<float>>& B) {
    int m = A.size();
    int n = A[0].size();
    int p = B[0].size();
    vector<vector<float>> C(m, vector<float>(p, 0.0));

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

// 针�?cache优化的分块矩阵乘�??
vector<vector<float>> matrixMultiplicationBlocked2(const vector<vector<float>>& A, const vector<vector<float>>& B) {
    int m = A.size();
    int n = A[0].size();
    int p = B[0].size();
    vector<vector<float>> C(m, vector<float>(p, 0.0));

    for (int kk = 0; kk < n; kk += blockSize) {
        for (int jj = 0; jj < p; jj += blockSize) {
            for (int i = 0; i < m; i++) {
                for (int k = kk; k < min(kk + blockSize, n); k++) {
                    for (int j = jj; j < min(jj + blockSize, p); j++) {
                        C[i][j] += A[i][k] * B[k][j];
                    }
                }
            }
        }
    }

    return C;
}



//结果验证函数
bool verifyMatrixEquality(const vector<vector<float>>& A, const vector<vector<float>>& B) {
    if (A.size() != B.size() || A[0].size() != B[0].size()) {
        return false;
    }

    int m = A.size();
    int n = A[0].size();

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (A[i][j] != B[i][j]) {
                return false;
            }
        }
    }

    return true;
}

// 性能测试函数
void performanceTest(const vector<vector<float>>& A, const vector<vector<float>>& B, const string& testName,
                     vector<vector<float>> (*multiplyFunction)(const vector<vector<float>>&, const vector<vector<float>>&) ) {
    auto start = high_resolution_clock::now(); // 记录开始时

    //矩阵乘法
    vector<vector<float>> result = multiplyFunction(A, B);

    auto end = high_resolution_clock::now(); // 记录结束时间
    auto duration = duration_cast<nanoseconds>(end - start); // 计算时间

    double time = duration.count() / 1e9; 
    double size = A.size(); 
    double gflops = (2.0 * size * size * size) / time / 1e9; // 计算GFLOPS

    cout << testName << "Time: " << duration.count() << " nanoseconds" << endl;
    cout << testName << " GFLOPS: " << gflops << endl;

    // vector<vector<float>> referenceResult = matrixMultiplicationDirect(A, B);
    // if (verifyMatrixEquality(referenceResult, result)) {
    //     cout << "Result correct!" << endl;
    // } else {
    //     cout << "Result wrong!" << endl;
    // }
}


int main() {

    //int size = 1024; 
    ifstream inputFile("input/size.txt");

    if (!inputFile.is_open()) {
        cout << "Failed to open input or output file...\n";
        return 0;
    }

    string line;
    getline(inputFile, line);
    int blocksize, matrixsize;
    stringstream ss(line);
    ss >> blocksize >> matrixsize;

    vector<vector<float>> A(size, vector<float>(size, 1.0));
    vector<vector<float>> B(size, vector<float>(size, 2.0));


    performanceTest(A, B, "Blocked Multiplication: ", matrixMultiplicationDirect);
    
}
