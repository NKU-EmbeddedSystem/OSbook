import matplotlib.pyplot as plt
import numpy as np
import os, math, sys


assert len(sys.argv) == 2

res_root = sys.argv[1]

paths = ['./{}/{}'.format(res_root, name) for name in os.listdir(res_root) if name.split('.')[1] == 'txt']
dic = dict()
for path in paths:
    func, scale = (os.path.basename(path)).split('.')[0].split('_')
    costs = []
    with open(path, 'r') as f:
        for line in f.readlines():
            costs.append(eval(line))
    if func not in dic.keys():
        dic[func] = dict()
    dic[func][eval(scale)] = np.mean(costs)

for func in dic.keys():
    tmp = sorted(dic[func].items(), key=lambda x: x[0])
    x = [math.log2(tup[0]) for tup in tmp]
    y = [tup[1] for tup in tmp]
    print(func, x, y)
    plt.plot(x, y, 'o-',label=func)
plt.xlabel('scale(n)')
plt.ylabel('time(s)')
plt.legend()
plt.savefig('./{}/costtime.png'.format(res_root))
plt.close()

tmp = sorted(dic['cmn'].items(), key=lambda x: x[0])
cmn = [tup[1] for tup in tmp]
x   = [math.log2(tup[0]) for tup in tmp]
tmp = sorted(dic['sse'].items(), key=lambda x: x[0])
sse = [tup[1] for tup in tmp]
tmp = sorted(dic['avx'].items(), key=lambda x: x[0])
avx = [tup[1] for tup in tmp]

sse_speedup = [cmn[i]/sse[i] for i in range(len(y))]
avx_speedup = [cmn[i]/avx[i] for i in range(len(y))]
sse_avx_speedup = [sse[i]/avx[i] for i in range(len(y))]

print('cmn/sse', sse_speedup)
print('cmn/avx', avx_speedup)
print('sse/avx', sse_avx_speedup)

plt.plot(x, sse_speedup, 'o-', label='sse')
plt.plot(x, avx_speedup, 'o-', label='avx')
plt.xlabel('scale(n)')
plt.ylabel('speedup')
plt.legend()
plt.savefig('./{}/speedup.png'.format(res_root))
plt.close()