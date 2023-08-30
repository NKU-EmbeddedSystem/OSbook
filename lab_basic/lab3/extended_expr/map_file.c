#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>

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
 
	return vmrss;//程序使用的内存
}

void get_baseaddr(unsigned int pid){
    char file_name[64]={0};
    int ch;//getc的返回值是整数
	sprintf(file_name,"/proc/%d/maps",pid);
    FILE *fp;
    fp = fopen(file_name,"r");	// 打开待读取文件
	if (fp == NULL)// 如果失败
	{
		printf("Bye\n");
		return; // 退出程序
	}
	// getc(fp)从打开的文件中获取一个字符
	while((ch=getc(fp))!=EOF)
		putchar(ch);
	fclose(fp);// 关闭文件
}

int main() {
    int pid=getpid();
    printf("pid=%d\n",pid);
    int fd;
    struct stat st;
    char *file_data;
    
    // 打开文件
    fd = open("test.txt", O_RDONLY);
    if (fd == -1) {
        perror("open");
        exit(EXIT_FAILURE);
    }
    
    // 获取文件大小
    if (fstat(fd, &st) == -1) {
        perror("fstat");
        close(fd);
        exit(EXIT_FAILURE);
    }
    
    // 将文件映射到内存
    file_data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    if (file_data == MAP_FAILED) {
        perror("mmap");
        close(fd);
        exit(EXIT_FAILURE);
    }
    
    int sum = 0;
    int num = 0;
    char *ptr = file_data;
    
    // 逐个字符解析字符串并累加
    while (ptr < file_data + st.st_size) {
        if (*ptr >= '0' && *ptr <= '9') {
            num = num * 10 + (*ptr - '0');
        } else if (*ptr == '\n' || ptr == file_data + st.st_size - 1) {
            sum += num;
            num = 0;
        }
        ptr++;
    }
    
    // 打印累加结果
    printf("Sum: %d\n", sum);

    printf("used memory=%d kB\n",get_proc_mem(pid));
    get_baseaddr(pid);
    
    // 解除内存映射
    if (munmap(file_data, st.st_size) == -1) {
        perror("munmap");
        close(fd);
        exit(EXIT_FAILURE);
    }
    
    // 关闭文件
    close(fd);

    return 0;
}