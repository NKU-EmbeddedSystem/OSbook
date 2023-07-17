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

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd == -1) {
        cout << "Socket creation failed...\n";
        return 0;
    }

    int opt = 1;
    setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servaddr.sin_port = htons(8080);

    if (connect(sockfd, (struct sockaddr *) &servaddr, sizeof(servaddr)) == -1) {
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
