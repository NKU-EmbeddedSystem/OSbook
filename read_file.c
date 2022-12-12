#include<stdio.h>
#include<unistd.h>
#include<fcntl.h>
#include<string.h>
#include<time.h>
#include<sys/time.h>
#include<stdlib.h>
#include<stdbool.h>

#define VMRSS_LINE 22

unsigned int get_proc_mem(unsigned int pid){
	char file_name[64]={0};
	sprintf(file_name,"/proc/%d/status",pid);
	
    FILE *fd;
	char line_buff[512]={0};
	fd =fopen(file_name,"r");
	if(fd==NULL) return 0;
	char name[64];
	int vmrss;
	for (int i=0; i<VMRSS_LINE-1;i++){
		fgets(line_buff,sizeof(line_buff),fd);
	}
	
	fgets(line_buff,sizeof(line_buff),fd);
	sscanf(line_buff,"%s %d",name,&vmrss);
	fclose(fd);
 
	return vmrss;//程序使用的物理内存
}

int main(){
    int pid=getpid();
    printf("pid=%d\n",pid);
    struct timeval tv;
    long startTime=0;
    long endTime=0;
    gettimeofday(&tv,NULL);
    startTime=tv.tv_sec*1000000+tv.tv_usec;//tv_sec=s;tv_usec=us;
    printf("startTime:%ld\n",startTime);

    int fd=open("/home/kjr/OSbook/bible10.txt",O_RDONLY);
    //int fd=open("test.txt",O_RDONLY);
    if(fd==-1){
        printf("can't open the file");
        return 1;
    }
    char find_str[100]={"\0"};
    printf("input string to find:\n");
    scanf("%s",find_str);
    int find_str_length=strlen(find_str);
    int len=1;
    int line=1;
    int count=0;
    //char buf[3]={"\0"};
    bool temp_buf_is_empty=true;
    int k=0;
    int offset=0;
    //printf("%d\n",find_str_length);
    while(len>0){
        char buf[1024]={"\0"};
        len=read(fd,buf,1024);
        if(!temp_buf_is_empty){
            int n=0;
            for(;n<offset;n++){
                if(buf[n]!=find_str[k]) break;
                if((k+1) < find_str_length) k++;
            }
            if(n==offset){
                count++;
                printf("the line of the find_str:%d\n",line);
                temp_buf_is_empty=true;
                k=0;
                offset=0;
            }
            else{
                temp_buf_is_empty=true;
                k=0;
                offset=0;
            }
        }
        if(strstr(buf,find_str) || strstr(buf,"\n")){
            for(int i=0;i<1024;i++){
                if(buf[i]=='\n') line++;
                if(strstr(buf,find_str)){
                    if(buf[i]==find_str[0]){
                        int j=1;
                        if(1024-i >= find_str_length){
                            for(;j<find_str_length;j++){
                                if(buf[i+j]!=find_str[j] || (i+j)>=1024) break;
                            }
                            if(j==find_str_length) {
                                count++;
                                printf("the line of the find_str:%d\n",line);
                            }
                        }
                        else{
                            int m=1;
                            for(;m<1024-i;m++){
                                if(buf[i+m]!=find_str[m]) break;
                            }
                            if(m==1024-i){
                                temp_buf_is_empty=false;
                                offset=find_str_length-1024+i;
                                if(k<100) k++;
                            }
                        }
                    }
                    else continue;
                }
                else continue;
            }
        }
        //printf("%s\n",buf);
    }
    if(count==0) printf("can't find the string\n");
    else printf("the number of the find_str in the file is:%d\n",count);
    close(fd);
    gettimeofday(&tv,NULL);
    endTime=tv.tv_sec*1000000+tv.tv_usec;
    printf("endTime:%ld\n",endTime);
    printf("used time is %ld us\n",(endTime-startTime));

    printf("used memory=%d kB\n",get_proc_mem(pid));
    return 0;
}