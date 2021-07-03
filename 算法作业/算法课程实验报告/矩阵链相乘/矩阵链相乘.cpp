#include<bits/stdc++.h>
using namespace std;
#define INF 1<<20
#define MAX 100
int main()
{
	int C[MAX][MAX];
	int D[MAX][MAX]; //记录路径
	int r[MAX + 1];	
	int n;
	fstream f("input2.txt");
	f >> n;//矩阵个数
	cout << "矩阵个数:" << n << endl;
	for (int i = 1; i <= n; i++)
	{
		C[i][i] = 0;//填充对角线
		f >> r[i] >> r[i + 1];
		cout << r[i] << " " << r[i + 1] << endl;
	}
	for (int d = 1; d <= n - 1; d++)//填充对角线1->n-1
	{
		for (int i = 1; i <= n - d; i++)//填充对角线项目
		{
			int j = i + d;
			C[i][j] = INF;
			for (int k = i + 1; k <= j; k++)
			{
				if (C[i][j] > C[i][k - 1] + C[k][j] + r[i] * r[k] * r[j + 1])
				{
					C[i][j] = C[i][k - 1] + C[k][j] + r[i] * r[k] * r[j + 1];
					D[i][j] = k;
				}
			}
		}
	}
	cout << "最小总乘法次数：" << C[1][n] << endl;
	queue<pair<int, int> > q;
	q.push(make_pair(1, n));
	cout << "从下往上相乘路径：" << endl;
	while (!q.empty())
	{
		int front = q.front().first;
		int end = q.front().second;
		q.pop();
		if (D[front][end] != end)
		{
			q.push(make_pair(D[front][end], end));
			cout <<front<<" "<< D[front][end] <<" "<< end<<endl;
		}
		else {
			cout << front << " " << end << endl;
		}
		if (D[front][end] - 1 != front)
		{
			q.push(make_pair(front, D[front][end] - 1));
			cout << front <<" "<< D[front][end]-1 << " " <<end<<endl;
		}
		else {
			cout << front << " " << D[front][end] - 1 << endl;
		}
	}

}






