#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>


int main(int argc, const char *argv[])
{
    // int i;
    // for (i = 1; i < 6; i++) {
    //     sleep(1);
    //     printf("%ds\n", i);
    // }

    //sleep(5);
    //exit(-1);
    FILE * fp;
    char buffer[80];
    fp = popen("./lab2.sh","r");
    fgets(buffer,sizeof(buffer),fp);
    //printf("%s",buffer);
    pclose(fp);
    exit(0);
}
