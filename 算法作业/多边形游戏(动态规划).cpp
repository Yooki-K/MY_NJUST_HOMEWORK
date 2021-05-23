#include <iostream>
#include<cstdio>
#include<string.h>
#include<algorithm>
#include<vector>

using namespace std;
#define MAX 1005

int n;//顶点数
int M[MAX];//值
char op[MAX];//符号
int f_max[MAX][MAX];
int f_min[MAX][MAX];
vector<pair<int, int>>result;

void Find() {
	for (int L = 2; L <= n; ++L)
	{
		for (int i = 1; i <= n; ++i)
		{
			for (int t = 1; t < L; ++t)
			{
				int r = (i + t - 1) % n + 1;
				int s = L - t;
				int e1 = f_min[i][t] * f_min[r][s];
				int e2 = f_max[i][t] * f_min[r][s];
				int e3 = f_min[i][t] * f_max[r][s];
				int e4 = f_max[i][t] * f_max[r][s];
				if (op[r] == '+') {
					f_min[i][L] = min(f_min[i][t] + f_min[r][s], f_min[i][L]);
					f_max[i][L] = max(f_max[i][t] + f_max[r][s], f_max[i][L]);
				}
				else {
					f_min[i][L] = min(min(min(min(e4, e1), e2), e3), f_min[i][L]);
					f_max[i][L] = max(max(max(max(e4, e1), e2), e3), f_max[i][L]);
				}
			}
			if (L == n) {
				result.push_back(pair<int, int>(f_max[i][L], i));
			}
		}
	}
}
bool subs(pair<int,int>p1, pair<int,int>p2) {
	return (p1.first > p2.first);
}

int main()
{
	cin >> n;
	for (int i = 1; i <= n; ++i)
	{
		
		cin >> op[i];
		cin >> M[i];
		f_min[i][1] = M[i];
		f_max[i][1] = M[i];
	}
	Find();
	sort(result.begin(), result.end(),subs);
	auto it = result.begin();
	long long maxf = it->first;
	cout << maxf << endl;
	cout<<it->second;
	it++;
	for (; it != result.end(); ++it) {
		if(it->first==maxf)
			cout<<" "<<it->second;
		else
			break;
	}
	cout << endl;
	return 0;
}