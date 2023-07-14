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
	printf("%d", sum);
	return 0;
}
