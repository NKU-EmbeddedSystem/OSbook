#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sys/shm.h>
#include <time.h>

#define MAX_PROCESS 2
#define MAX_FILE_NAME_LEN 256

int main(int argc, char *argv[])
{
    int shmid;
    int *shmaddr;
    int i;
    pid_t pid;
    char file_name[MAX_FILE_NAME_LEN];
    int fd;
    char buf[1024];
    int count;
    clock_t start,end;
    // int *status, *status2;
    start = clock();
    // 创建共享内存
    shmid = shmget(IPC_PRIVATE, sizeof(int), 0666);
    if (shmid < 0) {
        perror("shmget error");
        exit(1);
    }

    // 将共享内存映射到当前进程的地址空间
    shmaddr = (int *)shmat(shmid, NULL, 0);
    if (shmaddr == (int *)-1) {
        perror("shmat error");
        exit(1);
    }

    // 将共享内存初始化为0
    *shmaddr = 0;

    pid_t pid1, pid2;
    int status1, status2;
    
    if ((pid1 = fork()) == 0) {
        // 子进程1
        execl("./mmap", "mmap","input/f1", NULL);
    } else if ((pid2 = fork()) == 0) {
        // 子进程2
        execl("./mmap", "mmap","input/f2", NULL);
    } else {
        // 父进程
        waitpid(pid1, &status1, 0);
        waitpid(pid2, &status2, 0);
        // printf("子进程1返回值：%d\n", WEXITSTATUS(status1));
        // printf("子进程2返回值：%d\n", WEXITSTATUS(status2));
    }


    // printf("status1: %d\n", WEXITSTATUS(*status1));
    // printf("status2: %d\n", WEXITSTATUS(*status2));
    *shmaddr+=WEXITSTATUS(status1);
    *shmaddr+=WEXITSTATUS(status2);
    end = clock();
    double total_time = (end-start)/1000;
    // 输出文件夹中文件的总行数
    printf("\nTotal count: %d\nTotal time: %f\n", *shmaddr, total_time);

    // 删除共享内存
    shmctl(shmid, IPC_RMID, NULL);

    return 0;
}
