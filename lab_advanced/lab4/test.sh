size=100

echo "===============\n单线程矩阵乘法\n" > output/result.txt
gcc matrix_single_thread.c -o matrix_single_thread
./matrix_single_thread ./input/shape_$size $size >> output/result.txt

echo "===============\n双线程矩阵乘法\n" >> output/result.txt
gcc matrix_dual_thread.c -o matrix_dual_thread
./matrix_dual_thread ./input/shape_$size $size >> output/result.txt

echo "===============\n多线程优化分块矩阵乘法(4,8,16)\n" >> output/result.txt
gcc matrix_multi_thread.c -o matrix_multi_thread
./matrix_multi_thread ./input/shape_$size $size 4 >> output/result.txt
./matrix_multi_thread ./input/shape_$size $size 8 >> output/result.txt
./matrix_multi_thread ./input/shape_$size $size 16 >> output/result.txt

echo "===============\n分块矩阵乘法（锁）\n" >> output/result.txt
gcc matrix_lock.c -o matrix_lock
./matrix_lock ./input/shape_$size $size >> output/result.txt

echo "===============\n分块矩阵乘法（信号量）\n" >> output/result.txt
gcc matrix_signal.c -o matrix_signal
./matrix_signal ./input/shape_$size $size >> output/result.txt

echo "===============\nopenmp实现多线程优化矩阵乘法\n" >> output/result.txt
gcc matrix_openmp.c -fopenmp -o matrix_openmp
./matrix_openmp ./input/shape_$size $size >> output/result.txt

echo "===============\nopenmp解决数据冲突（critial）\n" >> output/result.txt
gcc openmp_critical.c -fopenmp -o openmp_critical
./openmp_critical >> output/result.txt

echo "===============\nopenmp解决数据冲突（reduction）\n" >> output/result.txt
gcc openmp_reduction.c -fopenmp -o openmp_reduction
./openmp_reduction >> output/result.txt