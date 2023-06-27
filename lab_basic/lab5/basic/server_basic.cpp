#include <iostream>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <thread>
#include <vector>

using namespace std;

void process_client(int connfd, int start_file, int end_file, const string& word) {
    string message = to_string(start_file) + " " + to_string(end_file) + " \"" + word + "\"";
    send(connfd, message.c_str(), message.length(), 0);

    char buffer[128];
    int count = 0;
    recv(connfd, buffer, sizeof(buffer), 0);
    sscanf(buffer, "%d", &count);
    cout << "Client processed files " << start_file << " to " << end_file << ", count: " << count << endl;
}

int main() {
    int sockfd;
    struct sockaddr_in servaddr;

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

    if ((bind(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr))) != 0) {
        cout << "Socket bind failed...\n";
        return 0;
    }

    if ((listen(sockfd, 5)) != 0) {
        cout << "Listen failed...\n";
        return 0;
    }

    int n, m;
    string word;
    cout << "Enter number of files: ";
    cin >> n;
    cout << "Enter number of clients: ";
    cin >> m;
    cout << "Enter word to count: ";
    cin.ignore();
    getline(cin, word);

    vector<int> clientfds;
    for (int i = 0; i < m; ++i) {
        struct sockaddr_in clientaddr;
        socklen_t len = sizeof(clientaddr);
        int connfd = accept(sockfd, (struct sockaddr *)&clientaddr, &len);
        if (connfd < 0) {
            cout << "Server accept failed...\n";
            return 0;
        }
        clientfds.push_back(connfd);
    }

    int files_per_client = n / m;
    int extra_files = n % m;
    int start_file = 1;

    vector<thread> threads;
    for (int i = 0; i < m; ++i) {
        int end_file = start_file + files_per_client - 1;
        if (extra_files > 0) {
            ++end_file;
            --extra_files;
        }

        threads.emplace_back(process_client, clientfds[i], start_file, end_file, word);
        start_file = end_file + 1;
    }

    for (auto& t : threads) {
        t.join();
    }

    for (int connfd : clientfds) {
        close(connfd);
    }

    close(sockfd);
    return 0;
}