#include <stdio.h>
#include <dirent.h>
#include<unistd.h>
#include<sys/mman.h>
#include<sys/stat.h>
#include<string.h>
#include<fcntl.h>
#include<time.h>
#include<sys/time.h>
#include<sys/types.h>
#include<regex.h>

int final_count=0;

int mmap_file(char* file_name){
    int fd=open(file_name,O_RDONLY); 
    int fd_out = open("output/out.txt",O_CREAT|O_WRONLY);
    //int fd=open("/home/kjr/OSbook/bible10.txt",O_RDONLY);
    if(fd==-1){
        printf("can't open the file");
        return 1;
    }

    struct stat sb;
    if(fstat(fd,&sb)==-1) printf("fstat error!");
    char *mmapped;
    if((mmapped=mmap(NULL,sb.st_size,PROT_READ,MAP_SHARED,fd,0))==(void *)-1) printf("mmapped error!");
    close(fd);

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
    char str[51];
    while(1){
        status=regexec(&reg,mmapped,1,pmatch,0);
        if(status==0){
            count++;
            strncpy(output,mmapped+pmatch[0].rm_so,pmatch[0].rm_eo-pmatch[0].rm_so);
            //printf("matched:%s\n",output);
            sprintf(str,"%s\n\0",output);
            //printf("%s",str);
            write(fd_out,str,sizeof(str));
            mmapped += pmatch[0].rm_eo;
        }
        else break;
    }
    regfree(&reg);
    close(fd_out);
    return count;
}

int main(int argc, char *argv[])
{
    DIR *dir;
    struct dirent *ptr;
    char base[1000];

    //获取当前路径
    getcwd(base, sizeof(base));
    strcat(base,"/");
    strcat(base,argv[1]);
    printf("当前路径为：%s\n", base);

    //打开指定文件夹
    if ((dir = opendir(base)) == NULL)
    {
        perror("Open dir error...");
        return 1;
    }

    //遍历文件夹中的文件
    while ((ptr = readdir(dir)) != NULL)
    {
        //跳过'.'和'..'两个目录
        if (strcmp(ptr->d_name, ".") == 0 || strcmp(ptr->d_name, "..") == 0)
            continue;

        //如果是txt文件，则输出
        if (strstr(ptr->d_name, ".txt") != NULL)
            printf("txt文件名：%s\n", ptr->d_name);
            char buff[1024];
            sprintf(buff, "%s%s%s", base, "/", ptr->d_name);
            int temp=mmap_file(buff);
            printf("%s",buff);
            final_count+=temp;
    }
    closedir(dir);
    // printf("final_count:%d",final_count);
    return final_count;
}
