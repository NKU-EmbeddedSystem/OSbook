#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include<stdbool.h>

bool finish[2] = {false,false}; 

void* test_thread(int* n){
    int thread_n = *n;
    for(int i = 0;i<5;i++){
        printf("n:%d  num:%d\n",thread_n,i);
    }
    finish[*n - 1] = true;
    return NULL;
}


int main(){
    int n1 = 1,n2 = 2;
    pthread_t tid0,tid1;
    pthread_create(&tid0,NULL,test_thread,&n1);
    pthread_create(&tid1,NULL,test_thread,&n2);

    pthread_detach(tid0);
    pthread_detach(tid1);

     while((!finish[0])||(!finish[1]));    
    // pthread_join(tid0,NULL);
    // pthread_join(tid1,NULL);

    printf("finish\n");
    return 0;
}