#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, const char *argv[])
{
    int i;
    pid_t pid1 = 0, pid2 = 0, pid = 0;
    int *status1, *status2;
    int k=0;

    for (i = 0; i < 2; i++) {
        if (0 == i) pid = pid1 = fork();
        else        pid = pid2 = fork();

        if (pid < 0) {
            perror("pid fork");
            exit(-1);
        } else if (pid == 0) {   //子进程
            break;
        } else {   //父进程处理
            waitpid(pid1, status1, 0);         //阻塞方式等待
            
            do {                               //非阻塞方式等待
                k = waitpid(pid2, status2, WNOHANG);  
                if (k == 0) {
                    printf("process2 still runing\n");
                    sleep(1);
                } 
            }while (k == 0);

        }

    }

    /************ 子进程处理 *******************/
   
    if (0 == i) {      // 进程1 
        if (-1 == execl("./process1", NULL)) {
            perror("process1 exec");
            exit(-1);
        }
    } else if (1 == i) {   // 进程2  切记这里要i == 1，因为上面结束后没有判断i==1的话回执行两次，相当于在process2中又调用了process2
        if (-1 == execl("./process2", NULL)) {
            perror("process2 exec");
            exit(-1);
        }
    }

    printf("parent process exit!!!\n"); //父进程结束
    exit(0);
}

