#include <iostream>
#include <vector>
#include <chrono> // 添加性能测试所需的头文件
#include <cstdlib> // 添加C标准库头文件

using namespace std;
using namespace std::chrono; // 高精度时间库命名空间


// 直接实现的矩阵乘法
vector<vector<int>> matrixMultiplicationDirect(const vector<vector<int>>& A, const vector<vector<int>>& B) {
    int m = A.size();
    int n = A[0].size();
    int p = B[0].size();

    vector<vector<int>> C(m, vector<int>(p, 0));

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < p; j++) {
            for (int k = 0; k < n; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    return C;
}

// 针对缓存优化的矩阵乘法
vector<vector<int>> matrixMultiplicationCacheOptimized(const vector<vector<int>>& A, const vector<vector<int>>& B) {
    int m = A.size();
    int n = A[0].size();
    int p = B[0].size();

    vector<vector<int>> C(m, vector<int>(p, 0));

    for (int i = 0; i < m; i++) {
        for (int k = 0; k < n; k++) {
            for (int j = 0; j < p; j++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    return C;
}

// 分块矩阵乘法
vector<vector<int>> matrixMultiplicationBlockedCacheOptimized(const vector<vector<int>>& A, const vector<vector<int>>& B) {
    int m = A.size();
    int n = A[0].size();
    int p = B[0].size();
    int blockSize = 50;
    vector<vector<int>> C(m, vector<int>(p, 0));

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

// 针对cache优化的分块矩阵乘法
vector<vector<int>> matrixMultiplicationBlocked(const vector<vector<int>>& A, const vector<vector<int>>& B) {
    int m = A.size();
    int n = A[0].size();
    int p = B[0].size();
    int blockSize = 50;
    vector<vector<int>> C(m, vector<int>(p, 0));

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

//结果验证函数
bool verifyMatrixEquality(const vector<vector<int>>& A, const vector<vector<int>>& B) {
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
void performanceTest(const vector<vector<int>>& A, const vector<vector<int>>& B, const string& testName,
                     vector<vector<int>> (*multiplyFunction)(const vector<vector<int>>&, const vector<vector<int>>&) ) {
    auto start = high_resolution_clock::now(); // 记录开始时间

    // 执行矩阵乘法
    vector<vector<int>> result = multiplyFunction(A, B);

    auto end = high_resolution_clock::now(); // 记录结束时间
    auto duration = duration_cast<nanoseconds>(end - start); // 计算执行时间

    double time = duration.count() / 1e9; // 转换为秒
    double size = A.size(); 
    double gflops = (2.0 * size * size * size) / time / 1e9; // 计算GFLOPS

    cout << testName << "Time: " << duration.count() << " nanoseconds" << endl;
    cout << testName << " GFLOPS: " << gflops << endl;

    vector<vector<int>> referenceResult = matrixMultiplicationDirect(A, B);
    if (verifyMatrixEquality(referenceResult, result)) {
        cout << "Result correct!" << endl;
    } else {
        cout << "Result wrong!" << endl;
    }
}


int main() {
    // 创建两个大矩阵
    int size = 1000; // 矩阵大小，可以根据需要调整
    vector<vector<int>> A(size, vector<int>(size, 1));
    vector<vector<int>> B(size, vector<int>(size, 2));


    double totalFlops = 2.0 * size * size * size;
    performanceTest(A, B, "Before optimization:", matrixMultiplicationDirect);
    //performanceTest(A, B, "After Changing Order optimization:", matrixMultiplicationCacheOptimized);
    performanceTest(A, B, "Blocked & Cache Optimized Multiplication: ", matrixMultiplicationBlockedCacheOptimized);
    performanceTest(A, B, "Blocked Multiplication: ", matrixMultiplicationBlocked);

    
}
