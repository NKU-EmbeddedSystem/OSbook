# 生成测试数据,矩阵A矩阵B及其乘积结果矩阵C
# 及计算其乘积矩阵C 并存入xls

# 生成随机矩阵
import numpy as np
import os
import sys
import shutil

# os.mkdir('./dataset')
#　每次生成的随机数一样
rd = np.random.RandomState(676) 
shapes=[]

for i in range(1,len(sys.argv)):
    shapes.append(int(sys.argv[i]))

for n in shapes:
    if os.path.exists('./input/shape_'+str(n)):
        shutil.rmtree('./input/shape_'+str(n))
        ## 或不生成
        # continue
    # 随机整数
    matrix_A = rd.randint(-2, 5, (n ,n)) # 随机生成[-2,5)的整数，10000x12000的矩阵
    matrix_B = rd.randint(-2, 5, (n, n)) # 随机生成[-2,5)的整数，12000x10000的矩阵
    matrix_C = np.dot(matrix_A,matrix_B)

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

    file=open('./output/result/answer.txt','w')
    C_list=matrix_C.tolist()
    for row in C_list:
        file.write(str(float(row[0])))
        for i in range(1,len(row)):
            file.write(' '+str(float(row[i])))
        file.write('\n')
    file.close()
