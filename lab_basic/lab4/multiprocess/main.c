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
        if (i == 0) pid = pid1 = fork();
        else        pid = pid2 = fork();

        if (pid < 0) {
            perror("pid fork");
            exit(-1);
        } else if (pid == 0) {   //子进程
            break;
        } else {   //父进程处理
            waitpid(pid1, status1, 0);         //阻塞
            
            do {                               //非阻塞
                k = waitpid(pid2, status2, WNOHANG);  
                if (k == 0) {
                    printf("process2 still runing\n");
                    sleep(1);
                } 
            }while (k == 0);

        }

    }

    if (0 == i) {      // 进程1 
        if (execl("./process1", NULL) == -1) {
            perror("process1 exec");
            exit(-1);
        }
    } else if (i == 1) {   // 进程2 
        if (execl("./process2", NULL) == -1) {
            perror("process2 exec");
            exit(-1);
        }
    }

    printf("parent process exit\n");
    exit(0);
}

