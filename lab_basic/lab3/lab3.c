#include<stdio.h>
#include<unistd.h>
#include<sys/mman.h>
#include<sys/stat.h>
#include<string.h>
#include<fcntl.h>
#include<time.h>
#include<sys/time.h>
#include<sys/types.h>
#include<regex.h>

//read 系统调用
int readSystemCall(int fd, regex_t reg, char* output) {
    int len = 1;
    int status = 0;
    regmatch_t pmatch[1];
    int count = 0;
    
    while (len > 0) {
        char buf[2048] = {"\0"};
        // TODO 循环调用read读取数据  
        len = [TODO];
        char* temp = buf;
        while (1) {
            // TODO 判断read读取的数据是否匹配正则表达式pattern
            status = [TODO];
            if (status == 0) {
                count++;
                // TODO 打印匹配到的数据
                strncpy(output, [TODO], [TODO]);
                printf("matched: %s\n", output);
                temp += pmatch[0].rm_eo;
            } else {
                break;
            }
        }
    }

    return count;
}

//mmap 系统调用
int mmapSystemCall(int fd, regex_t reg, char* output) {
    struct stat sb;
    if (fstat(fd, &sb) == -1) {
        printf("fstat error!\n");
        return -1;
    }

    char* mmapped;
    // TODO 调用mmap映射数据  
    if ((mmapped = [TODO]) == (void*)-1) {
        printf("mmapped error!\n");
        return -1;
    }

    close(fd);

    int status = 0;
    regmatch_t pmatch[1];
    int count = 0;

    while (1) {
        // TODO 判断read读取的数据是否匹配正则表达式pattern
        status = [TODO];
        if (status == 0) {
            count++;
            // TODO 打印匹配到的数据
            strncpy(output, [TODO], [TODO]);
            printf("matched: %s\n", output);
            temp += pmatch[0].rm_eo;
        } else {
            break;
        }
    }

    return count;
}

int main() {
    int fd = open("input/new.txt", O_RDONLY);
    if (fd == -1) {
        printf("can't open the file\n");
        return 1;
    }

    int len = 1;
    int status = 0;
    regmatch_t pmatch[1];
    regex_t reg;
    int count = 0;
    char pattern[] = "^From ilug-admin@linux.ie.*Aug.*"; // 查找ilug-admin@linux.ie在八月份发送的邮件

    status = regcomp(&reg, pattern, REG_EXTENDED | REG_NEWLINE);
    if (status != 0) {
        printf("compile error!\n");
        return -1;
    }

    char output[1024] = {"\0"};

    // Using read system call
    count = readSystemCall(fd, reg, output);
    printf("The number of matched strings (read): %d\n", count);

    // Reopening the file for mmap system call
    close(fd);
    fd = open("input/new.txt", O_RDONLY);
    if (fd == -1) {
        printf("can't open the file\n");
        return 1;
    }

    // Using mmap system call
    count = mmapSystemCall(fd, reg, output);
    printf("The number of matched strings (mmap): %d\n", count);

    regfree(&reg);
    return 0;
}

