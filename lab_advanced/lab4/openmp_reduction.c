#include <stdio.h>
#include <omp.h>

int main()
{
	int sum = 0;
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
