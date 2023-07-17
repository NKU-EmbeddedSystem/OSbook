#include <arpa/inet.h>
#include <cstring>
#include <fstream>
#include <iostream>
#include <netinet/in.h>
#include <sstream>
#include <sys/socket.h>
#include <unistd.h>
using namespace std;

int main()
{
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
    // TODO 设置servaddr即server端地址和端口
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = [TODO];
    servaddr.sin_port = [TODO];

    // TODO 绑定servaddr和socket
    if ([TODO] != 0) {
        cout << "Socket bind failed...\n";
        return 0;
    }

    // TODO 服务端开始监听
    if ([TODO] != 0) {
        cout << "Listen failed...\n";
        return 0;
    }

    // TODO 接收客户端连接请求
    connfd = [TODO];
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
