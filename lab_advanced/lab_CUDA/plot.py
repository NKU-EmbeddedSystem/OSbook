import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as sts

if __name__ == '__main__':
    y = [0.017306,	0.024678,	0.034611,	0.048128,	0.056211,	0.066253,	0.076595,	0.088371,	0.098099,	 0.108954	]
    # y = [0.017306,	0.024678,	0.034611,	0.048128,	0.056211,	0.066253,	0.076595,	0.088371,	0.098099,	 0.108954	, 0.431718 ,   1.229414,2.256384,	4.108083,	7.161958	,10.717593,14.774477,	26.002945,	32.370277,	227.425262,	749.336304,	1757.466797]
    x = [10,	20,	30	,40,	50,	60,	70,	80,	90,	100]
    # x = [100,	400	,900,	1600,	2500	,3600,	4900	,6400	,8100,	10000]
    # x = [100,	400	,900,	1600,	2500	,3600,	4900	,6400	,8100,	10000,	40000,90000	,160000,	250000,	360000,490000,	640000,	810000	,1000000,	4000000	,9000000,	16000000]
    plt.rcParams['font.sans-serif']=['SimHei'] #用来正常显示中文标签
    fig = plt.figure()
    fig.suptitle('矩阵大小与Cuda乘法耗时时间关系图')

    plt.xlabel('矩阵大小(n)')
    plt.ylabel('Cuda乘法耗时/ms')
    # plt.xscale('log')
    plt.plot(x,y,'-o')
    plt.show()

    # # 双对数坐标下
    # fig, ax = plt.subplots()
    # ax.set_xscale("log")
    # ax.set_yscale("log")
    # ax.set_adjustable("datalim")
    # ax.plot(c[1][:-1], c[0], 'o')
    # ax.set_xlim(1e-1, 1e6)
    # ax.set_ylim(1e-2, 1e6)
    # ax.grid()
    # plt.draw()
    # plt.show()

    # # 半对数坐标
    # fig1, ax1 = plt.subplots()
    # ax1.hist(r, bins=500)
    # ax1.set_xscale("log")
    # ax1.set_xlim(1e-1, 1e6)
    # ax1.grid()
    # plt.draw()
    # plt.show()