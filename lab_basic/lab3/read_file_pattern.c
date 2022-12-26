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

int main(){
    int fd=open("new.txt",O_RDONLY);
    //int fd=open("/home/kjr/OSbook/bible10.txt",O_RDONLY);
    if(fd==-1){
        printf("can't open the file");
        return 1;
    }
    int len=1;
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
    while(len>0){
        char buf[2048]={"\0"};
        len=read(fd,buf,2048);
        char *temp=buf;
        while(1){
            status=regexec(&reg,temp,1,pmatch,0);
            if(status==0){
                count++;
                strncpy(output,temp+pmatch[0].rm_so,pmatch[0].rm_eo-pmatch[0].rm_so);
                printf("matched:%s\n",output);
                temp += pmatch[0].rm_eo;
            }
            else break;
        }
    }
    regfree(&reg);
    printf("the number of matched string:%d\n",count);
    return 0;
}
