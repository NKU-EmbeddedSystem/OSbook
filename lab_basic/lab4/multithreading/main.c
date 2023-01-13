#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

void exec1(void);
void exec2(void);

void exec1(void){
    FILE * fp;
    char buffer[80];
    fp = popen("./lab1.sh","r");
    fgets(buffer,sizeof(buffer),fp);
    //printf("%s",buffer);
    pclose(fp);
    return 0;
}

void exec2(void){
    FILE * fp;
    char buffer[80];
    fp = popen("./lab2.sh","r");
    fgets(buffer,sizeof(buffer),fp);
    //printf("%s",buffer);
    pclose(fp);
    return 0;
}

void main(){
    /*pthread_t tid1, tid2;
    pthread_attr_t pthread_attr1, pthread_attr2;
    void* retval1 = NULL;
    void* retval2 = NULL;
    
    pthread_attr_init(&pthread_attr1);
    pthread_attr_init(&pthread_attr2);
    pthread_attr_setdetachstate(&pthread_attr1, PTHREAD_CREATE_JOINABLE);
    pthread_attr_setdetachstate(&pthread_attr2, PTHREAD_CREATE_DETACHED);
    
    pthread_create(&tid1, &pthread_attr1, createThread, &mCount);
    pthread_create(&tid2, &pthread_attr2, createThread, &mCount);  
    
    pthread_join(tid1, &retval1);
    pthread_join(tid2, &retval2);
    
    printf("Thread 1 return : %s\n", (char*)retval1);
    printf("Thread 2 return : %s\n", (char*)retval2);
    
    pthread_attr_destroy(&pthread_attr1);
    pthread_attr_destroy(&pthread_attr2);*/
    pthread_t tid1, tid2;
    
    pthread_create(&tid1, NULL, (void *)func, NULL);
    pthread_create(&tid2, NULL, (void *)func, NULL);
    
    pthread_join(tid1, NULL);
    pthread_join(tid1, NULL);
    return 0;
}
  
