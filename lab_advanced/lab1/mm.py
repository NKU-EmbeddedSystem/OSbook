import joblib
import operator
import time
import os
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

def test():
    time_file = open("./output/time/time.txt", "w")
    time_file.write("time\n")
    time_file.close()
    for i in range(1):
        n = 2**10
        matrix_A = joblib.load(filename='./input/'+'/A_'+str(n)+'.pkl')
        matrix_B = joblib.load(filename='./input/'+'/B_'+str(n)+'.pkl')
        matrix_C_answer = joblib.load(filename='./input/'+'/C_'+str(n)+'.pkl')
        begin = time.perf_counter()
        matrix_C_result = matrix_mul(matrix_A, matrix_B)
        end = time.perf_counter()
        answer = open("./output/result/result.txt", "w")
        answer.close()
        answer = open("./output/result/result.txt", "a")
        for j in range(n):
            for k in range(n):
                answer.write(str(matrix_C_answer[j][k]) + " ")
            answer.write("\n")
        answer.close()
        # joblib.dump(matrix_C_result, filename='./output/'+'shape_'+str(n)+'/C_'+str(n)+'.pkl')
        if operator.eq(matrix_C_answer,matrix_C_result) == True:
            print("Check matrix_mul with " + str(n) + "*" + str(n) + " pass! " + f"{end - begin:0.10f}s")
        else:
            print("Check matrix_mul with " + str(n) + "*" + str(n) + " error!")
        time_file = open("./output/time/time.txt", "a")
        time_file.write(str(end-begin)+"s\n")
        time_file.close()
        # joblib.dump(end - begin, filename='./output/time/time.txt')

test()