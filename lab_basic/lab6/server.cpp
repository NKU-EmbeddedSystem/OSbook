#include"data.h"
#include<fstream>


using namespace std;

bool Check(int seq, int received)
{
	return seq = received;
}


int main()
{
	long long head, tail, freq;

	WORD sockVersion = MAKEWORD(2, 2);
	//winsock版本为2.2

	WSADATA wsaData;

	if (WSAStartup(sockVersion, &wsaData) != 0)
	{
		cout << "WSA启动失败!\n";
		return 0;
	}

	SOCKET UDPServer = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);   //UDP协议进行传输

	if (UDPServer == INVALID_SOCKET) //INVALID_SOCKET=−1
	{
		cout << "socket建立失败! \n";
		return 0;
	}

	//设置套接字为非阻塞模式 
	int iMode = 1; //1：非阻塞，0：阻塞 
	ioctlsocket(UDPServer, FIONBIO, (u_long FAR*) & iMode);//非阻塞设置 

	sockaddr_in sin;
	char ip[20] = { 0 };
	int port = 0;
	cout << "请输入服务器ip地址:";
	cin >> ip;
	cout << "请输入服务器端口号:";
	cin >> port;
	cout << "服务器的地址为:" << ip << ":" << port << endl;


	sin.sin_family = AF_INET;
	sin.sin_port = htons(port);
	sin.sin_addr.S_un.S_addr = inet_addr(ip);

	sockaddr_in Client;

	if (bind(UDPServer, (LPSOCKADDR)&sin, sizeof(sin)) == SOCKET_ERROR)
	{
		cout << "绑定失败!\n";
		return 0;
	}
	UDP_Package* pkt;


	int length = sizeof(sockaddr);

	char SendBuff[1024];

	char FileName[1024] = "1.jpg";
	cout << "请输入要传输的文件名:";
	cin >> FileName;

	cout << "5" << endl;
	ifstream is(FileName, ifstream::in | ios::binary);//以二进制方式打开文件
	if (!is.is_open()) {
		cout << "错误的文件名!无法打开文件!" << endl;
		exit(1);
	}
	cout << "4" << endl;
	is.seekg(0, std::ios_base::end);  //将文件流指针定位到流的末尾
	int length1 = is.tellg();
	int totalpacket = length1 / 1024 + 1;
	cout << "3" << endl;
	FinalLog.FileSize = length1;
	is.seekg(0, std::ios_base::beg);  //将文件流指针重新定位到流的开始
	//begin connecting...
	bool connecting = 0, sending = 0, end = 0, name = 0;
	cout << "1" << endl;
	while (1)
	{
		cout << "2" << endl;
		int e;
		int wait = 0;
		pkt = new UDP_Package;
		e = recvfrom(UDPServer, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&Client, &length);
		while (e < 0)
		{
			wait++;
			Sleep(200);
			if (wait == 10)
			{
				cout << "等待客户端连接!\n";
				break;
			}
		}
		wait = 0;
		if (pkt->GetSYN() == 0)
		{
			cout << "开始确认连接...\n";
			connecting = 1;
			//发送确认信息
			while (connecting)
			{
				pkt = new UDP_Package();
				pkt->SetSYN(1);
				sendto(UDPServer, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&Client, length);
				pkt = new UDP_Package;
				if (!recvfrom(UDPServer, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&Client, &length))
				{
					Sleep(200);
					wait++;
					if (wait == 10)
					{
						cout << "确认连接失败!\n";
						cout << pkt->GetSYN() << endl;
						continue;
					}
					continue;
				}
				else if (pkt->GetSYN() == 2)
				{
					cout << "确认连接成功，开始发送...\n";
					cout << "文件: " << FileName << ", 总大小: " << length1 << "比特, 数据包数目: " << totalpacket << endl;
					connecting = 0;
					pkt = new UDP_Package;
					name = 1;
					sending = 1;
					break;
				}
			}
		}
		int total = 0;
		int error_num = 0;
		int seq = 1;
		wait = 0;
		bool timeout = 0;
		QueryPerformanceFrequency((LARGE_INTEGER*)&freq);
		QueryPerformanceCounter((LARGE_INTEGER*)&head);

		while (name)
		{
			pkt = new UDP_Package;
			pkt->setSeq(0);
			pkt->SetData(FileName, 255);
			sendto(UDPServer, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&Client, length);
			pkt = new UDP_Package;
			while (!recvfrom(UDPServer, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&Client, &length)) {}
			if (pkt->getSeq() == 0)
			{
				name = 0;
				break;
			}
		}
		while (sending)
		{
			if (length1 > 1024)
			{
				is.read(SendBuff, 1024);
				length1 -= 1024;
			}
			else
			{
				is.read(SendBuff, length1);
			}
			while (seq <= totalpacket)
			{
				if (length1 <= 1024)
				{
					pkt->SetData(SendBuff, length1);
				}
				else
				{
					pkt->SetData(SendBuff, 1024);
				}

				pkt->setSeq(seq);
				Check(pkt);
				//cout << pkt->getCSum() << endl;
				sendto(UDPServer, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&Client, length);
				cout << "发送文件，序号 " << seq << "...\n";
				//Sleep(299);
				pkt = new UDP_Package;
				//sendto(UDPServer, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&Client, length);
				while (!recvfrom(UDPServer, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&Client, &length))
				{
					//Sleep(200);
					wait++;
					if (wait == 10)
					{
						cout << "超时! 进行重传文件，序号 " << seq << "...\n";
						wait = 0;
						timeout = 1;
						break;
					}
					continue;
				}
				cout << "首次接受pkt的seq为" << pkt->getSeq()<<endl;
				if (timeout)
				{
					timeout = 0;
					continue;
				} 
				if (pkt->getSeq() != seq)
				{
					cout << pkt->getSeq() << endl;
					total++;
					error_num++;
					cout << "文件序号" << seq << "发送失败，收到NAK，重新发送...\n";
					continue;
				}
				else 
				{
					cout << pkt->getSeq() << endl;
					total++;
					cout << "已发送文件序号" << seq << ", 收到ACK，发送成功!\n";
					wait = 0;
					seq++;
					break;
				}
			}
			if (seq > totalpacket)
			{
				pkt = new UDP_Package;
				pkt->SetSYN(100);//结束标识
				sendto(UDPServer, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&Client, length);
				cout << "传输完毕!\n";
				sending = 0;
				end = 1;

			}
		}
		if (end)
		{
			QueryPerformanceCounter((LARGE_INTEGER*)&tail);
			FinalLog.Times = (tail - head) * 1000.0 / freq;
			cout << "文件大小: " << FinalLog.FileSize << "bytes,传输时间: " << FinalLog.Times << "ms, 速度: " << FinalLog.FileSize / FinalLog.Times << "bytes/ms.\n ";
			break;
		}
	}
	closesocket(UDPServer);
	WSACleanup();
	return 0;
}

