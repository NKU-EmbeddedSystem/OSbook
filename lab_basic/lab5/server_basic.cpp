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

    if ((bind(sockfd, (struct sockaddr *) &servaddr, sizeof(servaddr))) != 0) {
        cout << "Socket bind failed...\n";
        return 0;
    }

    if ((listen(sockfd, 5)) != 0) {
        cout << "Listen failed...\n";
        return 0;
    }

    connfd = accept(sockfd, (struct sockaddr *) &clientaddr, &len);
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
