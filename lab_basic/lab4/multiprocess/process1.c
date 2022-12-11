#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>


int main(int argc, const char *argv[])
{
    if (-1 == execlp("ls", "ls", "-l", NULL)) {
            perror("process1");
            exit(-1);
        }
    exit(0);
}
