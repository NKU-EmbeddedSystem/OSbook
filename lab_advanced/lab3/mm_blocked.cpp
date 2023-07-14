#include <iostream>
#include <vector>
#include <chrono> // ������ܲ��������ͷ�ļ�
#include <cstdlib> // ���C��׼��ͷ�ļ�
#include <sstream>
#include <fstream>

using namespace std;
using namespace std::chrono; // �߾���ʱ��������ռ�
#define blockSize 128

// ֱ��ʵ�ֵľ���˷�
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

// �ֿ����˷�
vector<vector<float>> matrixMultiplicationBlocked(const vector<vector<float>>& A, const vector<vector<float>>& B) {
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


//�����֤����
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

// ���ܲ��Ժ���
void performanceTest(const vector<vector<float>>& A, const vector<vector<float>>& B, const string& testName,
                     vector<vector<float>> (*multiplyFunction)(const vector<vector<float>>&, const vector<vector<float>>&) ) {
    auto start = high_resolution_clock::now(); // ��¼��ʼʱ��

    // ִ�о���˷�
    vector<vector<float>> result = multiplyFunction(A, B);

    auto end = high_resolution_clock::now(); // ��¼����ʱ��
    auto duration = duration_cast<nanoseconds>(end - start); // ����ִ��ʱ��

    double time = duration.count() / 1e9; // ת��Ϊ��
    double size = A.size(); 
    double gflops = (2.0 * size * size * size) / time / 1e9; // ����GFLOPS

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
    // �������������
    //int size = 1024; // �����С�����Ը�����Ҫ����
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

    vector<vector<float>> A(matrixsize, vector<float>(matrixsize, 1.0));
    vector<vector<float>> B(matrixsize, vector<float>(matrixsize, 2.0));

    performanceTest(A, B, "Blocked Multiplication: ", matrixMultiplicationBlocked);
    
}
