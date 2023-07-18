#include <stdio.h>
#include <omp.h>

int main()
{
	int sum = 0;
// 使用reduction解决openmp所遇到的数据冲突问题
#pragma omp parallel for reduction(+ : sum)
	for (int i = 0; i < 10; i++)
	{
		sum = sum + i;
	}
  FILE* fp = fopen("./output/result/openmp_reduction.txt","w");
  fprintf(fp,"%d",sum);
  fclose(fp);
	return 0;
}
