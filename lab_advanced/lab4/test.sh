size=100

rm -r ./input
rm -r ./output

python3 ./data_gen.py $size

gcc matrix_single_thread.c -o matrix_single_thread -lpthread
./matrix_single_thread ./input/shape_$size $size 
echo "单线程矩阵乘法 finish"

gcc matrix_dual_thread.c -o matrix_dual_thread -lpthread
./matrix_dual_thread ./input/shape_$size $size  
echo "双线程矩阵乘法 finish"  

gcc matrix_multi_thread.c -o matrix_multi_thread -lpthread
./matrix_multi_thread ./input/shape_$size $size 4  
echo "多线程优化分块矩阵乘法(4) finish"  

gcc matrix_lock.c -o matrix_lock -lpthread
./matrix_lock ./input/shape_$size $size  
echo "分块矩阵乘法（锁）finish"  

gcc matrix_signal.c -o matrix_signal -lpthread
./matrix_signal ./input/shape_$size $size  
echo "分块矩阵乘法（信号量）finish"  

gcc matrix_openmp.c -lgomp -o matrix_openmp
./matrix_openmp ./input/shape_$size $size  
echo "openmp实现多线程优化矩阵乘法 finish"  

gcc openmp_critical.c -lgomp -o openmp_critical
./openmp_critical  
echo "openmp解决数据冲突（critial）finish"  

gcc openmp_reduction.c -lgomp -o openmp_reduction
./openmp_reduction  
echo "openmp解决数据冲突（reduction）finish"  