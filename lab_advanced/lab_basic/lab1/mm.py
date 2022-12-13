import joblib
import operator
import time
import matplotlib.pyplot as plt
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

def main_test():
    shapes = [2**i for i in range(0, 13)]
    times = []
    size = []
    for n in shapes:
        matrix_A = joblib.load(filename='./dataset/'+'shape_'+str(n)+'/A_'+str(n)+'.pkl')
        matrix_B = joblib.load(filename='./dataset/'+'shape_'+str(n)+'/B_'+str(n)+'.pkl')
        matrix_C_answer = joblib.load(filename='./dataset/'+'shape_'+str(n)+'/C_'+str(n)+'.pkl')
        size.append(n)
        begin = time.perf_counter()
        matrix_C = matrix_mul(matrix_A, matrix_B)
        end = time.perf_counter()
        times.append(end-begin)
        if operator.eq(matrix_C, matrix_C_answer) == True:
            print("pass size "+str(n)+f" and run {end - begin:0.10f} seconds")
        else:
            print("answer of size "+str(n)+" is wrong")

    plt.plot(size, times, c="red")
    plt.scatter(size, times, c="red")
    plt.grid(True, linestyle='--', alpha=0.5)
    plt.xlabel("matirx size(n, n)")
    plt.ylabel("run time")
    plt.show()

    try:
        plt.savefig("./result_img/result.png")
    except:
        os.mkdir("./result_img")
        plt.savefig("./result_img/result.png")