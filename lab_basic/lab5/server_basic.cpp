#include <iostream>
#include <fstream>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <sstream>
using namespace std;

int main() {
    int sockfd, connfd;
    struct sockaddr_in servaddr, clientaddr;
    socklen_t len = sizeof(clientaddr);

    //创建socket

    if (sockfd == -1) {
        cout << "Socket creation failed...\n";
        return 0;
    }

    int opt = 1;
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    memset(&servaddr, 0, sizeof(servaddr));
    //设置servaddr即server端地址和端口
    
    //绑定servaddr和socket
    if (  ) {
        cout << "Socket bind failed...\n";
        return 0;
    }

    //服务端开始监听
    if (   ) {
        cout << "Listen failed...\n";
        return 0;
    }

    //接收客户端连接请求
    
    if (connfd < 0) {
        cout << "Server accept failed...\n";
        return 0;
    }

    ifstream inputFile("input/input_basic.txt");

    if (!inputFile.is_open()) {
        cout << "Failed to open input or output file...\n";
        return 0;
    }

    string line;
    getline(inputFile, line);
    int a, b;
    string c;
    stringstream ss(line);
    ss >> a >> b >> c;

    string message = to_string(a) + " " + to_string(b) + " \"" + c + "\"";
    send(connfd, message.c_str(), message.length(), 0);
    cout << "Message sent to client: " << message << endl;


    inputFile.close();
    close(sockfd);
    return 0;
}
