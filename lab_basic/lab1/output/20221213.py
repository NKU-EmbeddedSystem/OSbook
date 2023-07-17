import os
import random
from posixpath import split
from tkinter import N
dir="./resize_market"

random.randint(1,6)
fileList = os.listdir(dir)
n=1600
i=1
for file in fileList:
    c=random.randint(1,6)
    s=random.randint(1,6)
    new=str(n)+'_c'+str(c)+'s'+str(s)+'_0'+str(n*10+c+s+i)+"_0"+str(i)+".jpg"
    i+=1
    if i == 10:
        i=0
        n+=1
    
    file=os.path.join(dir,file)
    new=os.path.join("gen_image",new)

    os.rename(file,new)