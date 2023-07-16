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
    int fd=open("input/new.txt",O_RDONLY);
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

    //read 系统调用
    while(len>0){
      //循环调用read读取数据  
      
      while(1){
        //判断read读取的数据是否匹配正则表达式pattern
            if(  ){
                count++;
                //打印匹配到的数据
            
            }
            else break;
        }
    }



    //mmap 系统调用
    struct stat sb;
    if(fstat(fd,&sb)==-1) printf("fstat error!");
    char *mmapped;
    //调用mmap映射数据  
    
    close(fd);

    while(1){
        //判断mmap映射的数据是否匹配正则表达式pattern
        if(    ){
            count++;
                //打印匹配到的数据
        }
        else break;
    }


    regfree(&reg);
    printf("the number of matched string:%d\n",count);
    return 0;
}
