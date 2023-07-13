f = open("1000_result.txt")
lines = f.readlines()

#f2 = open("time_result_500_02.txt")
#lines2 = f2.readlines()

#f3 = open("time_result_500_03.txt")
#lines3 = f3.readlines()

data = []

for i in range(len(lines)):
     line=lines[i]
     #line2=lines2[i]
     #line3=lines3[i]
     if "time =" in line:
         time_str = line[7:]
         #time_str2 = line2[5:(len(line2)-2)]
         #time_str3 = line3[5:(len(line3)-2)]
         #min_sec1 = time_str1.split('m')
         #min_sec2 = time_str2.split('m')
         #min_sec3 = time_str3.split('m')
         time = float(time_str)/1000000
        # time2 = float(min_sec2[0])*60+float(min_sec2[1])
        # time3 = float(min_sec3[0])*60+float(min_sec3[1])
        # aver_time = (time1+time2+time3)/3.
         data.append(time)
print(data)
