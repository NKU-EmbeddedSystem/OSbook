f1 = open("time_result_3000_01.txt")
lines1 = f1.readlines()

f2 = open("time_result_3000_02.txt")
lines2 = f2.readlines()

f3 = open("time_result_3000_03.txt")
lines3 = f3.readlines()

data = []

for i in range(len(lines1)):
     line1=lines1[i]
     line2=lines2[i]
     line3=lines3[i]
     if "real" in line1:
         time_str1 = line1[5:(len(line1)-2)]
         time_str2 = line2[5:(len(line2)-2)]
         time_str3 = line3[5:(len(line3)-2)]
         min_sec1 = time_str1.split('m')
         min_sec2 = time_str2.split('m')
         min_sec3 = time_str3.split('m')
         time1 = float(min_sec1[0])*60+float(min_sec1[1])
         time2 = float(min_sec2[0])*60+float(min_sec2[1])
         time3 = float(min_sec3[0])*60+float(min_sec3[1])
         aver_time = (time1+time2+time3)/3.
         data.append(aver_time)
print(data)