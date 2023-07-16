#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>
#include <regex.h>
#include <time.h>
#define MAX_THREAD_NUM 10

FILE *fp;
char *pattern = "^From ilug-admin@linux.ie.*Aug.*";
int total_count;

void *thread_func(void *arg)
{
    char buf[1024];
    int thread_num = *(int *)arg;

    while (fgets(buf, 1024, fp) != NULL)
    {
        // printf("Thread %d: %s", thread_num, buf);
        // TODO: match special substring
        regex_t reg;
        int status;
        if (regcomp(&reg, pattern, REG_EXTENDED) != 0) {
            printf("regcomp failed\n");
            // return -1;
        }
        status = regexec(&reg, buf, 0, NULL, 0);
        if (status == REG_NOMATCH) {
            // printf("no match\n");
        } else if (status == 0) {
            printf("match\n");
            total_count++;
        } else {
            printf("regexec failed\n");
        }
        regfree(&reg);
    }

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

    if ((fp = fopen("input/new.txt", "r")) == NULL)
    {
        printf("open file failed\n");
        return -1;
    }

    for (i = 0; i < MAX_THREAD_NUM; i++)
    {
        thread_num[i] = i;
        ret = pthread_create(&tid[i], NULL, thread_func, &thread_num[i]);
        if (ret != 0)
        {
            printf("Create thread %d failed\n", i);
            exit(1);
        }
    }

    for (i = 0; i < MAX_THREAD_NUM; i++)
    {
        pthread_join(tid[i], NULL);
    }
    fclose(fp);
    end = clock();
    double total_time = (end-start)/CLOCKS_PER_SEC;
    printf("\nTotal count=%d\nTotal time: %f\n",total_count,total_time);
    return 0;
}
