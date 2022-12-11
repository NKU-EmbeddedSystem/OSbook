#include"data.h"
#include<fstream>

using namespace std;


bool NoCrush(UDP_Package* pkt)
{
	int count = sizeof(pkt->getData()) / 2;
	register unsigned long sum = 0;
	unsigned short* buf = (unsigned short*)(pkt->getData());
	while (count--) {
		sum += *buf++;
	}
	if (pkt->getCSum() == ~(sum & 0xFFFF))
		return true;
	return false;
}

int main()
{
	WORD wsa = MAKEWORD(2, 2);

	WSADATA wsaData;

	if (WSAStartup(wsa, &wsaData) != 0)
	{
		cout << "WSA����ʧ��!\n";
		return 0;
	}

	SOCKET Client = socket(AF_INET, SOCK_DGRAM, 0);
	if (Client == INVALID_SOCKET)
	{
		cout << "socket����ʧ��!\n";
		return 0;
	}

	char ip[20] = { 0 };
	int port = 0;
	cout << "������ip��ַ:";
	cin >> ip;
	cout << "������˿ں�:";
	cin >> port;
	cout << "����Ҫ�����ļ��ĵ�ַΪ:" << ip << ":" << port << endl;


	sockaddr_in server_addr;
	server_addr.sin_family = AF_INET;
	//server_addr.sin_port = htons(8888);
	server_addr.sin_port = htons(port);
	//server_addr.sin_addr.S_un.S_addr = inet_addr("127.0.0.1");
	server_addr.sin_addr.S_un.S_addr = inet_addr(ip);

	UDP_Package* pkt = new UDP_Package;
	bool end = 0, receiving = 0;
	char FileName[255] = { 0 };
	cout << "��Ҫ���ܵ��ļ�����Ϊ:";
	cin >> FileName;
	//cout << FileName;
	//memset(FileName, 0, 255);

	ofstream f;

	f.open(FileName, std::ios::out | std::ios::binary);
	if (!f.is_open())
	{
		cout << "������ļ���!�޷����ļ�!\n";
		exit(1);
	}

	int length = sizeof(sockaddr);
	int seq = 0;
	while (1)
	{
		pkt->SetSYN(0);
		sendto(Client, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&server_addr, sizeof(SOCKADDR));
		Sleep(100);
		pkt = new UDP_Package;

		while (1)
		{
			recvfrom(Client, (char*)pkt, sizeof(*pkt), 0, (sockaddr*)&server_addr, &length);
			if (pkt->GetSYN() == 1)
			{
				cout << "��ʼ����...��������ȷ��\n";
				pkt = new UDP_Package;
				pkt->SetSYN(2);
				sendto(Client, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&server_addr, sizeof(SOCKADDR));

				receiving = 1;

			}

			while (receiving)
			{
				bool changed = 0;
				pkt = new UDP_Package;
				recvfrom(Client, (char*)pkt, sizeof(*pkt), 0, (sockaddr*)&server_addr, &length);
				while (!recvfrom(Client, (char*)pkt, sizeof(*pkt), 0, (sockaddr*)&server_addr, &length)) {}
				if (pkt->GetSYN() == 1)
				{
					pkt = new UDP_Package;
					pkt->SetSYN(2);
					sendto(Client, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&server_addr, sizeof(SOCKADDR));
					continue;
				}
				if (pkt->GetSYN() == 100)
				{
					cout << "�������!\n";
					end = 1;
					f.close();
					break;
				}
				if (pkt->getSeq() == 0 && NoCrush(pkt))
				{
					if (changed)
					{
						pkt = new UDP_Package;
						pkt->setSeq(0);
						sendto(Client, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&server_addr, sizeof(SOCKADDR));
						continue;
					}
					changed = 1;
					cout << "�ļ���: " << pkt->getData() << endl;
					pkt = new UDP_Package;
					pkt->setSeq(0);
					sendto(Client, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&server_addr, sizeof(SOCKADDR));
					continue;
				}

				if (!NoCrush(pkt) && pkt->getSeq() == seq + 1)
				{
					seq++;
					cout << "�ɹ��յ��ļ���� " << seq << "!\n";
					f.write(pkt->getData(), pkt->getLength());
					f.flush();
					pkt = new UDP_Package;
					pkt->setSeq(seq);
					cout << "����ACK��Ϣ " << seq << " ...\n";
					sendto(Client, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&server_addr, sizeof(SOCKADDR));
				}
				else
				{
					pkt = new UDP_Package;
					pkt->setSeq(seq);
					cout << "�ļ�������ʧ�����·����ļ���� " << seq << " ...����NAK��Ϣ\n";
					sendto(Client, (char*)pkt, sizeof(UDP_Package), 0, (sockaddr*)&server_addr, sizeof(SOCKADDR));
				}
			}
			if (end)
			{
				break;
			}
		}
		if (end)
		{
			break;
		}
	}
	closesocket(Client);
	WSACleanup();
	return 0;
}


