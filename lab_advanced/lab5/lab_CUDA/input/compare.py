import os

shapes = [10,20,30,40,50,60,70,80,90,100]

c = len(shapes)
print("TIME: matrix size | py | cuda    SPEEDUP: py/cuda")
for i in range(c):
    time_py = 0
    time_cuda = 0
    with open("../output/time_py_"+str(shapes[i])+".txt",'r') as f:
        time_py = f.readline()
    with open("../output/time_cuda_"+str(shapes[i])+".txt",'r') as f:
        time_cuda = f.readline()
    speed = float(time_py)/float(time_cuda)
    print("\t({})\t{}\t{}\t\t{}".format(shapes[i],round(float(time_py),4),round(float(time_cuda),4),round(speed,4)))
    
    

