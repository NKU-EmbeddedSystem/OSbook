import joblib
import numpy as np
import os

os.mkdir('./dataset')

shapes = [2**i for i in range(0, 8)]
rd = np.random.RandomState(888)
for n in shapes:
    matrix_A = rd.randint(-2, 5, (n ,n))
    matrix_B = rd.randint(-2, 5, (n, n))
    matrix_C = np.dot(matrix_A,matrix_B)

    os.mkdir('./dataset/shape_'+str(n))
    joblib.dump(matrix_A.tolist(), filename='./dataset/'+'shape_'+str(n)+'/A_'+str(n)+'.pkl')
    joblib.dump(matrix_B.tolist(), filename='./dataset/'+'shape_'+str(n)+'/B_'+str(n)+'.pkl')
    joblib.dump(matrix_C.tolist(), filename='./dataset/'+'shape_'+str(n)+'/C_'+str(n)+'.pkl')
    