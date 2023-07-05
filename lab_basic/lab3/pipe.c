#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>

#define BUFFER_SIZE 4096

int main() {
    int pipefd[2];  // 管道文件描述符数组
    pid_t pid;
    char buffer[BUFFER_SIZE];

    // 创建管道
    if (pipe(pipefd) == -1) {
        perror("pipe");
        exit(EXIT_FAILURE);
    }

    // 创建子进程
    pid = fork();

    if (pid < 0) {
        perror("fork");
        exit(EXIT_FAILURE);
    }

    if (pid > 0) {  // 父进程
        // 关闭读取端
        close(pipefd[0]);

        //开启阻塞模式
        /*int flags = fcntl(pipefd[1], F_GETFL);
        flags |= O_NONBLOCK; 
        fcntl(pipefd[1], F_SETFL, flags);*/

        // 打开要传输的文件
        FILE* file = fopen("new.txt", "rb");
        if (file == NULL) {
            perror("fopen");
            exit(EXIT_FAILURE);
        }

        // 从文件中读取数据，并写入管道
        int bytesRead;
        while ((bytesRead = fread(buffer, sizeof(char), BUFFER_SIZE, file)) > 0) {
            if (write(pipefd[1], buffer, bytesRead) == -1) {
                perror("write");
                exit(EXIT_FAILURE);
            }
        }

        // 关闭写入端
        close(pipefd[1]);

        // 等待子进程结束
        wait(NULL);
    } else {  // 子进程
        // 关闭写入端
        close(pipefd[1]);

        // 创建目标文件
        FILE* file = fopen("destination.txt", "wb");
        if (file == NULL) {
            perror("fopen");
            exit(EXIT_FAILURE);
        }

        // 从管道中读取数据，并写入文件
        int bytesRead;
        while ((bytesRead = read(pipefd[0], buffer, BUFFER_SIZE)) > 0) {
            if (fwrite(buffer, sizeof(char), bytesRead, file) == -1) {
                perror("fwrite");
                exit(EXIT_FAILURE);
            }
        }

        // 关闭读取端
        close(pipefd[0]);

        // 关闭文件
        fclose(file);
    }

    return 0;
}