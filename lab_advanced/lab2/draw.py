import matplotlib.pyplot as plt
# 横轴数据

x_data = ["O0", "O1", "O2", "O3+funroll-loops"]
# 纵轴数据
y_data = []
first = 0
with open('output/time/time.txt', 'r') as f:
    for line in f:
        if first == 0:
             first = 1
             continue
        line = line.strip()
        parts = line.split(': ')
        time = float(parts[1][:-1])
        y_data.append(time)
# 循环设置每个横纵轴数据
for i in range(len(x_data)):
# width设置柱形图的宽度，这里因为前面的数据过于密集不方便展示出来，所以手动调宽
	plt.bar(x_data[i], y_data[i])
# 设置标题
plt.title("Analysis")
# 设置横轴标签
plt.xlabel("Optimization level")
# 设置纵轴标签
plt.ylabel("time/s")
plt.savefig("./output/img/result.png")
