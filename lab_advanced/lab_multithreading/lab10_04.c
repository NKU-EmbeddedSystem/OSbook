#include<stdio.h>
#include<omp.h>

void* test_thread(int* n){
    for(int i = 0;i<10;i++){
        printf("n:%d  num:%d\n",*n,i);
    }
    return NULL;
}
 
int main()
{
	#pragma omp parallel for
	for (int i = 0; i < 3; i++) {
		test_thread();
	}
	printf("finish\n");
	return 0;
}
