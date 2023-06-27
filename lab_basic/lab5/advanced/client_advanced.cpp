#include <iostream>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <fstream>
#include <sstream>
#include <stdexcept>

using namespace std;

int count_word_occurrences(const string& filename, const string& word) {
    try {
        ifstream file(filename);
        if (!file.is_open()) {
            throw runtime_error("Cannot open file: " + filename);
        }

        string line;
        int count = 0;
        while (getline(file, line)) {
            stringstream ss(line);
            string token;
            while (ss >> token) {
                if (token == word) {
                    ++count;
                }
            }
        }

        file.close();
        return count;
    } catch (const exception& e) {
        cerr << "Exception caught: " << e.what() << endl;
        return 0;
    }
}

int main() {
    try {
        int sockfd;
        struct sockaddr_in servaddr;

        sockfd = socket(AF_INET, SOCK_STREAM, 0);
        if (sockfd == -1) {
            throw runtime_error("Socket creation failed...");
        }

        memset(&servaddr, 0, sizeof(servaddr));
        servaddr.sin_family = AF_INET;
        servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
        servaddr.sin_port = htons(8080);

        if (connect(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr)) != 0) {
            throw runtime_error("Connection failed...");
        }

        char buffer[128];
        if (recv(sockfd, buffer, sizeof(buffer), 0) == -1) {
            throw runtime_error("Error in receiving message from server.");
        }
        int start_file, end_file;
        string word;
        sscanf(buffer, "%d %d", &start_file, &end_file);
        const char* start_quote = strchr(buffer, '\"');
        const char* end_quote = strrchr(buffer, '\"');
        word.assign(start_quote + 1, end_quote - start_quote - 1);

        int total_count = 0;
        for (int i = start_file; i <= end_file; ++i) {
            string filename = "file" + to_string(i) + ".txt";
            int count = count_word_occurrences(filename, word);
            total_count += count;
        }

        sprintf(buffer, "%d", total_count);
        if (send(sockfd, buffer, strlen(buffer), 0) == -1) {
            throw runtime_error("Error in sending message to server.");
        }

        close(sockfd);
    } catch (const exception& e) {
        cerr << "Exception caught: " << e.what() << endl;
    }

    return 0;
}
