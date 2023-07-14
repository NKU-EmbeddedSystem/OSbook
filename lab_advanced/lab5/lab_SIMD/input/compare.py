import os


filenames = os.listdir("output")
paths = ["{}/{}".format("output", filename) for filename in filenames]

dic = {}
for path in paths:
    items = os.path.basename(path).split('.')[0].split('_')
    func = items[0]
    inputx = items[1]
    with open(path) as f:
        value = eval(f.readline())
    if inputx in dic:
        dic[inputx][func] = value
    else:
        dic[inputx] = {'cmn': 100.0, 'sse': 100.0, 'avx': 100.0}
        dic[inputx][func] = value

print("SPEEDUP: matrix size | cmn/sse | cmn/avx")
for inputx in dic.keys():
    cmn = dic[inputx]['cmn']
    sse = dic[inputx]['sse']
    avx = dic[inputx]['avx']
    spdu_1 = cmn / sse
    spdu_2 = cmn / avx
    with open("input/{}.txt".format(inputx)) as f:
        mat_size = f.readline()
    print("\t({})\t{}\t{}".format(mat_size, spdu_1, spdu_2))