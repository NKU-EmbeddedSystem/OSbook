def matrix_mul(matrix_A, matrix_B):
    m = len(matrix_A)
    k1 = len(matrix_A[0])
    k2 = len(matrix_B)
    assert(k1 == k2)
    n = len(matrix_B[0])
    k = k1

    matrix_C = []
    for mi in range(m):
        matrix_C_mi = []
        for ni in range(n):
            matrix_C_mi_ni = 0
            for ki in range(k):
                matrix_C_mi_ni += matrix_A[mi][ki] * matrix_B[ki][ni]
            matrix_C_mi.append(matrix_C_mi_ni)
        matrix_C.append(matrix_C_mi)
    return matrix_C

A = [[1,2,3], [4,5,6], [7,8,9]]
print(A)
B = [[1,1,1,1,1], [2,2,2,2,2], [3,3,3,3,3]]
print(B)
C = matrix_mul(A,B)
print(C)