# 生成测试数据,矩阵A矩阵B及其乘积结果矩阵C
# 及计算其乘积矩阵C 并存入xls

# 生成随机矩阵
import numpy as np
import os
import time
folder_path = './input'

if not os.path.exists(folder_path):
    os.makedirs(folder_path)
#　每次生成的随机数一样
rd = np.random.RandomState(888) 

shapes=[1000]

for n in shapes:
    # 随机整数
    matrix_A = rd.randint(-2, 5, (n ,n)) # 随机生成[-2,5)的整数，10000x12000的矩阵
    matrix_B = rd.randint(-2, 5, (n, n)) # 随机生成[-2,5)的整数，12000x10000的矩阵
    T1 = time.time()
    matrix_C = np.dot(matrix_A,matrix_B)
    T2 = time.time()
    T3= (T2-T1)*1000
    with open("./output/time/time_py_"+str(n)+".txt",'w') as f:
        f.write(str(T3))

    os.mkdir('./input/shape_'+str(n))
    file=open('./input/'+'shape_'+str(n)+'/A_'+str(n)+'.csv','w')
    A_list=matrix_A.tolist()
    for row in A_list:
        file.write(str(row[0]))
        for i in range(1,len(row)):
            file.write(','+str(row[i]))
        file.write('\n')
    file.close()

    file=open('./input/'+'shape_'+str(n)+'/B_'+str(n)+'.csv','w')
    B_list=matrix_B.tolist()
    for row in B_list:
        file.write(str(row[0]))
        for i in range(1,len(row)):
            file.write(','+str(row[i]))
        file.write('\n')
    file.close()

    file=open('./input/'+'shape_'+str(n)+'/C_'+str(n)+'.csv','w')
    C_list=matrix_C.tolist()
    for row in C_list:
        file.write(str(row[0]))
        for i in range(1,len(row)):
            file.write(','+str(row[i]))
        file.write('\n')
    file.close()
