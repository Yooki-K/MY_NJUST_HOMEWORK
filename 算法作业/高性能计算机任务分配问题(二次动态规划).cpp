#include <iostream>
#include<cstdio>
#include<algorithm>
#include<string>
#include<fstream>
using namespace std;
#define MAX 65

int a, b, p;
int t[2][MAX];
int k[2][MAX];
int P[21][MAX][MAX][3];//P[i][a][b][2/1/0]节点i完成a个A任务、b个B任务所需的最短时间
int C[21][MAX][MAX];//讲a个A任务、b个B任务分配给前i给节点，所需要的最短时间
int main()
{
	// ifstream file("D:/mixed_file/daima/C++/input.txt");
	cin >> a >> b >> p;
	for (int i = 1; i <= p; i++) {
		cin >> t[0][i] >> t[1][i] >> k[0][i] >> k[1][i];
	}
	for (int i = 1; i <= p; i++) {
		for (int aa = 1; aa <= a; aa++) {
			P[i][aa][0][0] = t[0][i] + k[0][i] * aa * aa;
			P[i][aa][0][1] = 1<<20;
			P[i][aa][0][2] = P[i][aa][0][0];
			for (int bb = 1; bb <= b; bb++) {
				P[i][0][bb][1] = t[1][i] + k[1][i] * bb * bb;
				P[i][0][bb][2] = P[i][0][bb][1];
				P[i][0][bb][0] = 1 << 20;
				P[i][aa][bb][0] = 1 << 20;
				P[i][aa][bb][1] = 1 << 20;
				for (int w = 1; w <= aa; w++) {
					P[i][aa][bb][0] = min(P[i][aa][bb][0], P[i][aa - w][bb][1] + k[0][i] * w*w + t[0][i]);
				}
				for (int w = 1; w <= bb; w++) {
					P[i][aa][bb][1] = min(P[i][aa][bb][1], P[i][aa][bb - w][0] + k[1][i] * w*w + t[1][i]);
				}
				P[i][aa][bb][2] = min(P[i][aa][bb][0], P[i][aa][bb][1]);
			}
		}
	}
	for (int i = 1; i <= p; i++)
	{
		for (int aa = 0; aa <= a; ++aa)
		{
			for (int bb = 0; bb <= b; ++bb)
			{
				if (i == 1) {
					C[i][aa][bb] = P[i][aa][bb][2];
					continue;
				}
				C[i][aa][bb] = 1 << 20;
				for (int w1 = 0; w1 <= aa; ++w1)
				{
					int be, end;
					if (w1 == 0) be = 1;
					else be = 0;
					if (w1 == aa) end = bb - 1;
					else end = bb;
					for (int w2 = be; w2 <= end; ++w2)
					{
						C[i][aa][bb] = min(max(C[i - 1][aa - w1][bb - w2], P[i][w1][w2][2]), C[i][aa][bb]);
					}
				}
			}
		}
	}
	cout << C[p][a][b] << endl;
	return 0;
}
