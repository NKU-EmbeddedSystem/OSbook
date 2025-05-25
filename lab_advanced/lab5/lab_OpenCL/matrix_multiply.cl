__kernel void matrixMul(const int m, const int n, const int p, __global float* A, __global float* B, __global float* C)
{
    int row = get_global_id(1);
    int col = get_global_id(0);
    if ((row < n) && (col < m))
    {
        float tmp = 0.0f;
        for (int k = 0; k < p; ++k)
        {
            tmp += A[row * p + k] * B[k * m + col]; // 修正B的索引
        }
        C[row * m + col] = tmp;
    }
}