import sys


arch = sys.argv[1]
size = sys.argv[2]

if arch == 'intel':
    cmn_path = 'output/time/cmn_{}.txt'.format(size)
    sse_path = 'output/time/sse_{}.txt'.format(size)
    avx_path = 'output/time/avx_{}.txt'.format(size)
    with open(cmn_path, 'r') as f:
        cmn = eval(f.readline())
    with open(sse_path, 'r') as f:
        sse = eval(f.readline())
    with open(avx_path, 'r') as f:
        avx = eval(f.readline())
    cmn_sse = cmn / sse
    cmn_avx = cmn / avx
    print('SPEEDUP:\tcmn/sse={}\tcmn/avx={}'.format(cmn_sse, cmn_avx))
elif arch == 'loongson':
    cmn_path = 'output/time/cmn_{}.txt'.format(size)
    lsx_path = 'output/time/lsx_{}.txt'.format(size)
    lasx_path = 'output/time/lasx_{}.txt'.format(size)
    with open(cmn_path, 'r') as f:
        cmn = eval(f.readline())
    with open(lsx_path, 'r') as f:
        lsx = eval(f.readline())
    with open(lasx_path, 'r') as f:
        lasx = eval(f.readline())
    cmn_lsx = cmn / lsx
    cmn_lasx = cmn / lasx
    print('SPEEDUP:\tcmn/lsx={}\tcmn/lasx={}'.format(cmn_lsx, cmn_lasx))