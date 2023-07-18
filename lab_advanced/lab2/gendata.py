# 生成测试数据,矩阵A矩阵B及其乘积结果矩阵C
# 及计算其乘积矩阵C 并存入xls

# 生成随机矩阵
import numpy as np
import os

if os.path.exists("./input"):
    pass
else:
    os.mkdir('./input')
#　每次生成的随机数一样
rd = np.random.RandomState(888) 

# shapes=[10,20,30,40,50,60,70,80,90,100,200,300,400,500,600,700,800,900,1000,2000,3000,4000,5000]
shapes = [2**10]

for n in shapes:
    # 随机整数

    matrix_A = rd.randint(-2, 5, (n ,n)) # 随机生成[-2,5)的整数，10000x12000的矩阵
    matrix_B = rd.randint(-2, 5, (n, n)) # 随机生成[-2,5)的整数，12000x10000的矩阵
    matrix_C = np.dot(matrix_A,matrix_B)

    file=open('./input/A_'+str(n)+'.csv','w')
    A_list=matrix_A.tolist()
    for row in A_list:
        file.write(str(row[0]))
        for i in range(1,len(row)):
            file.write(','+str(row[i]))
        file.write('\n')
    file.close()

    file=open('./input/B_'+str(n)+'.csv','w')
    B_list=matrix_B.tolist()
    for row in B_list:
        file.write(str(row[0]))
        for i in range(1,len(row)):
            file.write(','+str(row[i]))
        file.write('\n')
    file.close()

    file=open('./input/C_'+str(n)+'.csv','w')
    standard_result = open("./output/result/standard_result.txt", "w")
    standard_result.close()
    standard_result = open("./output/result/standard_result.txt", "a")
    C_list=matrix_C.tolist()
    for row in C_list:
        file.write(str(row[0]))
        standard_result.write(str(row[0]) + " ")
        for i in range(1,len(row)):
            file.write(','+str(row[i]))
            standard_result.write(str(row[i]) + " ")
        file.write('\n')
        standard_result.write("\n")
    file.close()