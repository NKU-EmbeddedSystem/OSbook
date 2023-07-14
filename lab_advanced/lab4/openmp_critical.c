#include<stdio.h>
#include<omp.h>

/**
// 发生数据冲突代码示例
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
  printf("%d\n", sum);
  return 0;
}

