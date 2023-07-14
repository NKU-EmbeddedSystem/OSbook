#include<stdio.h>
#include"/home/zby/local/include/omp.h"

/**
int main() {
  int sum = 0;
  #pragma omp parallel for
  for (int i = 0; i < 10; i++) {
    sum = sum + i;
  }
  printf("%d", sum);
  return 0;
}
**/
// reduction
/**
int main() {
	int sum = 0;
 #pragma omp parallel for reduction(+:sum)
 	for (int i = 0; i < 10; i++) {
 		sum = sum + i;
 	}
 	printf("%d", sum);
 	return 0;
 }
**/

//critical
int main() {
  int sum = 0;
  #pragma omp parallel for
  for (int i = 0; i < 10; i++) {
    #pragma omp critical
    {
      sum = sum + i;
    }
  }
  printf("%d", sum);
  return 0;
}

