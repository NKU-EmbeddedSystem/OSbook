// 客户端代码
#include <iostream>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <cstring>
#include <stdexcept>

using namespace std;

int main() {
    int sockfd;
    struct sockaddr_in servaddr;

    try {
      //创建socket
        
      if (sockfd == -1) {
            throw runtime_error("Socket creation failed...");
        }

        memset(&servaddr, 0, sizeof(servaddr));

      //创建客户端地址和端口

      //绑定客户端地址和端口
      if( ){
            throw runtime_error("Connect failed...");
        }

        char word[1024];
        memset(word, 0, sizeof(word));
        ssize_t recvBytes = recv(sockfd, word, sizeof(word), 0);
        if (recvBytes <= 0) {
            throw runtime_error("Error receiving word from the server...");
        }

        string cmd = "./word_count_advanced.sh " + string(word);
        cout << cmd << endl;
        system(cmd.c_str());

        FILE *fp = popen(cmd.c_str(), "r");
        if (fp == NULL) {
            throw runtime_error("Error executing command: " + cmd);
        }

        char result[1024];
        memset(result, 0, sizeof(result));
        fgets(result, sizeof(result), fp);
        pclose(fp);

        ssize_t sendBytes = send(sockfd, result, strlen(result), 0);
        if (sendBytes <= 0) {
            throw runtime_error("Error sending result to the server...");
        }

    close(sockfd);
    } catch (const exception& e) {
        cerr << "Error: " << e.what() << endl;
        if (sockfd != -1) {
            close(sockfd);
        }
        return 1;
    }

    return 0;
}


