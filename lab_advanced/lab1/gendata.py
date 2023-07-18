import joblib
import numpy as np
import os

if os.path.exists("./input"):
    pass
else:
    os.mkdir('./input')

shapes = [2**10]
rd = np.random.RandomState(888)
for n in shapes:
    matrix_A = rd.randint(-2, 5, (n ,n))
    matrix_B = rd.randint(-2, 5, (n, n))
    matrix_C = np.dot(matrix_A,matrix_B)

    joblib.dump(matrix_A.tolist(), filename='./input/'+'/A_'+str(n)+'.pkl')
    joblib.dump(matrix_B.tolist(), filename='./input/'+'/B_'+str(n)+'.pkl')
    joblib.dump(matrix_C.tolist(), filename='./input/'+'/C_'+str(n)+'.pkl')
    standard_answer = matrix_C.tolist()
    result = open("./output/result/standard_result.txt", "w")
    result.close()
    result = open("./output/result/standard_result.txt", "a")
    for i in range(n):
        for j in range(n):
            result.write(str(standard_answer[i][j]) + " ")
        result.write("\n")

    