#include <iostream>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string>
#include <cstring>
#include <cstdlib>
#include <fstream>

using namespace std;

int main() {
    int sockfd, connfd;
    struct sockaddr_in servaddr, clientaddr;
    socklen_t len = sizeof(clientaddr);

    // TODO 创建socket
    sockfd = [TODO];
    if (sockfd == -1) {
        cout << "Socket creation failed...\n";
        return 0;
    }

    int opt = 1;
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    memset(&servaddr, 0, sizeof(servaddr));
    // TODO 创建客户端地址和端口
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = [TODO];
    servaddr.sin_port = [TODO];

    // 绑定客户端地址和端口
    if( [TODO] == -1 ){
        cout << "Connect failed...\n";
        return 0;
    }

 
    char word[1024];
    recv(sockfd, word, sizeof(word), 0);
        

    string cmd = string("./word_count_basic.sh ") + word;
    system(cmd.c_str());

    close(sockfd);
    return 0;
}
