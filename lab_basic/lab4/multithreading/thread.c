#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>
#include <regex.h>
#include <time.h>
#include<fcntl.h>
#include <pthread.h>
#include <dirent.h>
#include<sys/mman.h>
#include<sys/stat.h>
#include<string.h>
#include<sys/time.h>
#include<sys/types.h>
#define MAX_THREAD_NUM 4

FILE *fp;
char *pattern = "^From ilug-admin@linux.ie.*Aug.*";
int total_count;
pthread_mutex_t mutex;

void *thread_func(void *arg)
{
    char buf[1024];
    int thread_num = *(int *)arg;
    char file_name[1024];
    sprintf(file_name, "%s%d%s", "input/test", thread_num+1,".txt");
    
    int fd=open(file_name,O_RDONLY); 
    if(fd==-1){
        printf("can't open the file");
        return 1;
    }
    struct stat sb;
    if(fstat(fd,&sb)==-1) printf("fstat error!");
    char *mmapped;
    if((mmapped=mmap(NULL,sb.st_size,PROT_READ,MAP_SHARED,fd,0))==(void *)-1) printf("mmapped error!");
    close(fd);

    int status=0;
    regmatch_t pmatch[1];
    regex_t reg;
    int count=0;
    char pattern[]="^From ilug-admin@linux.ie.*Aug.*";//查找ilug-admin@linux.ie在八月份发送的邮件
     
    status=regcomp(&reg,pattern,REG_EXTENDED|REG_NEWLINE);
    if(status!=0){
        printf("compile error!\n");
        return -1;
    }

    char output[1024]={"\0"};
    char str[51];
    while(1){
        status=regexec(&reg,mmapped,1,pmatch,0);
        if(status==0){
            // 加锁
            if (pthread_mutex_lock(&mutex) != 0){
                fprintf(stdout, "lock error!\n");
            }
            sprintf(str,"%s",buf);
            printf("%s",str);
            total_count++;
            // 释放锁
            pthread_mutex_unlock(&mutex);
            strncpy(output,mmapped+pmatch[0].rm_so,pmatch[0].rm_eo-pmatch[0].rm_so);
            sprintf(str,"%s\n\0",output);
            printf("%s",str);
            mmapped += pmatch[0].rm_eo;
        }
        else break;
    }
    regfree(&reg);
    pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
    int i, ret;
    pthread_t tid[MAX_THREAD_NUM];
    int thread_num[MAX_THREAD_NUM];
    clock_t start,end;
    total_count = 0;
    start = clock();

    // 初始化互斥锁
    if (pthread_mutex_init(&mutex, NULL) != 0){
    // 互斥锁初始化失败
        return 1;
    }

    for (i = 0; i < MAX_THREAD_NUM; i++)
    {
        thread_num[i] = i;
        // 创建多线程执行thread_func任务
        ret = pthread_create(&tid[i], NULL, thread_func, &thread_num[i]);
        if (ret != 0)
        {
            printf("Create thread %d failed\n", i);
            exit(1);
        }
    }

    for (i = 0; i < MAX_THREAD_NUM; i++)
    {
        //等待线程结束
        pthread_join(tid[i], NULL);
    }
    //fclose(fp);
    // 销毁互斥锁
    pthread_mutex_destroy(&mutex);
    end = clock();
    double total_time = (end-start)/*/CLOCKS_PER_SEC*/;
    printf("Total count=%d\nTotal time = %f\n",total_count,total_time);
    return 0;
}
