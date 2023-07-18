import sys


func = sys.argv[1]
size = sys.argv[2]

result_path = 'output/result/{}_{}.txt'.format(func, size)
stand_path = 'output/standard_result/C_{}.txt'.format(size)

f1 = open(result_path)
f2 = open(stand_path)

f1_lines = f1.readlines()
f2_lines = f2.readlines()

assert len(f1_lines) == len(f2_lines)

for i in range(len(f1_lines)):
    f1_line = f1_lines[i]
    f2_line = f2_lines[i]
    values_1 = [eval(item) for item in f1_line.split(',')]
    values_2 = [eval(item) for item in f2_line.split(',')]
    assert values_1 == values_2

f1.close()
f2.close()