import numpy as np
import os, shutil


# 固定随机数种子，使每次生成的随机数一样
rd = np.random.RandomState(42)
# 矩阵大小
shapes = [128, 256, 512, 1024]

# 清空input目录，重新生成
if os.path.exists("./input"):
    shutil.rmtree("./input")
os.mkdir("./input")
if os.path.exists("./output/standard_result"):
    shutil.rmtree("./output/standard_result")
os.mkdir("./output/standard_result")

# 生成两个矩阵以及它们乘法结果的标准答案：两个矩阵在input文件夹下，标准答案在output/standard_result文件夹下
for n in shapes:
    matrix_A = rd.randint(-2, 5, (n ,n))    # matrix_1
    matrix_B = rd.randint(-2, 5, (n, n))    # matrix_2
    matrix_C = np.dot(matrix_A,matrix_B)    # matrix

    file=open('./input/A_'+str(n)+'.txt','w')
    A_list=matrix_A.tolist()
    for row in A_list:
        file.write(str(row[0]))
        for i in range(1,len(row)):
            file.write(','+str(row[i]))
        file.write('\n')
    file.close()

    file=open('./input/B_'+str(n)+'.txt','w')
    B_list=matrix_B.tolist()
    for row in B_list:
        file.write(str(row[0]))
        for i in range(1,len(row)):
            file.write(','+str(row[i]))
        file.write('\n')
    file.close()

    file=open('./output/standard_result/C_'+str(n)+'.txt','w')
    C_list=matrix_C.tolist()
    for row in C_list:
        file.write(str(row[0]))
        for i in range(1,len(row)):
            file.write(','+str(row[i]))
        file.write('\n')
    file.close()