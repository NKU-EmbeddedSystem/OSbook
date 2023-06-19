#include <iostream>
#include <vector>
#include <chrono> // ������ܲ��������ͷ�ļ�
#include <cstdlib> // ���C��׼��ͷ�ļ�

using namespace std;
using namespace std::chrono; // �߾���ʱ��������ռ�


// ֱ��ʵ�ֵľ���˷�
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

// ��Ի����Ż��ľ���˷�
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

// �ֿ����˷�
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

// ���cache�Ż��ķֿ����˷�
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

//�����֤����
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

// ���ܲ��Ժ���
void performanceTest(const vector<vector<int>>& A, const vector<vector<int>>& B, const string& testName,
                     vector<vector<int>> (*multiplyFunction)(const vector<vector<int>>&, const vector<vector<int>>&) ) {
    auto start = high_resolution_clock::now(); // ��¼��ʼʱ��

    // ִ�о���˷�
    vector<vector<int>> result = multiplyFunction(A, B);

    auto end = high_resolution_clock::now(); // ��¼����ʱ��
    auto duration = duration_cast<nanoseconds>(end - start); // ����ִ��ʱ��

    double time = duration.count() / 1e9; // ת��Ϊ��
    double size = A.size(); 
    double gflops = (2.0 * size * size * size) / time / 1e9; // ����GFLOPS

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
    // �������������
    int size = 1000; // �����С�����Ը�����Ҫ����
    vector<vector<int>> A(size, vector<int>(size, 1));
    vector<vector<int>> B(size, vector<int>(size, 2));


    double totalFlops = 2.0 * size * size * size;
    performanceTest(A, B, "Before optimization:", matrixMultiplicationDirect);
    //performanceTest(A, B, "After Changing Order optimization:", matrixMultiplicationCacheOptimized);
    performanceTest(A, B, "Blocked & Cache Optimized Multiplication: ", matrixMultiplicationBlockedCacheOptimized);
    performanceTest(A, B, "Blocked Multiplication: ", matrixMultiplicationBlocked);

    
}
