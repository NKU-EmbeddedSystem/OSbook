// 服务器端代码
#include <arpa/inet.h>
#include <cstring>
#include <fstream>
#include <iostream>
#include <netinet/in.h>
#include <sstream>
#include <stdexcept>
#include <sys/socket.h>
#include <unistd.h>
#include <vector>

using namespace std;

int main()
{
  int sockfd, connfd;
  struct sockaddr_in servaddr, clientaddr;
  socklen_t len = sizeof(clientaddr);

  try {
    // TODO 创建socket
    sockfd = [TODO];
    if (sockfd == -1) {
      throw runtime_error("Socket creation failed...");
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
      throw runtime_error("Socket bind failed...");
    }

    //服务端开始监听
    if ([TODO] != 0) {
      throw runtime_error("Listen failed...");
    }

    cout << "Server is running and waiting for connections..." << endl;

    vector<int> clientSockets;
    while (true) {
      // TODO 接收客户端连接请求
      connfd = [TODO];
      if (connfd < 0) {
        throw runtime_error("Server accept failed...");
      }

      cout << "Client connected. Socket ID: " << connfd << endl;
      clientSockets.push_back(connfd);

      if (clientSockets.size() == 5) { // Assuming there will be exactly 5 clients
        int m = 5;
        ifstream inputFile("input/input_advanced.txt");
        string line;
        getline(inputFile, line);
        int n;
        string word;
        stringstream ss(line);
        ss >> n >> word;

        int filesPerClient = n / m;
        int remainingFiles = n % m;

        for (int i = 0; i < clientSockets.size(); i++) {
          int startFile = i * filesPerClient + 1;
          int endFile = (i + 1) * filesPerClient;
          if (i == clientSockets.size() - 1) {
            endFile += remainingFiles;
          }

          // TODO 发送客户端起始文件，截止文件即查询word
          string message = to_string(startFile) + " " + to_string(endFile) + " \"" + word + "\"";
          ssize_t sendBytes = [TODO];
          if (sendBytes <= 0) {
            throw runtime_error("Error sending message to client " + to_string(i + 1));
          }
          cout << "Message sent to client " << i + 1 << ": " << message << endl;
        }

        int totalOccurrences = 0;
        for (int i = 0; i < clientSockets.size(); i++) {
          char buffer[1024];
          memset(buffer, 0, sizeof(buffer));
          // TODO 接收客户端回信
          ssize_t recvBytes = [TODO];
          if (recvBytes <= 0) {
            throw runtime_error("Error receiving result from client " + to_string(i + 1));
          }
          int occurrences = atoi(buffer);
          totalOccurrences += occurrences;
        }

        ofstream outfile("output/output_advanced.txt");
        streambuf* coutBuf = cout.rdbuf();
        cout.rdbuf(outfile.rdbuf());
        cout << "Word '" << word << "' appears " << totalOccurrences << " times from file No.1 to file No." << n << endl;
        cout.rdbuf(coutBuf);
        outfile.close();
        break;
      }
    }

    for (int i = 0; i < clientSockets.size(); i++) {
      close(clientSockets[i]);
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
