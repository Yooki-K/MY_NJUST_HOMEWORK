#include<bits/stdc++.h>
using namespace std;
#define MAX 100
#define INF 1<<20
#define END(n) n[n.size()-1]
int num;
int dis[MAX][MAX];
int C[MAX];//第i结点找到的结点
int cur = 1;
int minN = INF;
vector<int>s;//记录找到的结点
vector<int>sum;//记录找到的边
void print(int ss) {
	for (auto iter = s.cbegin(); iter != s.cend(); iter++)
	{
		cout << (*iter)<<" " ;
	}
	cout <<" 开销："<<ss<< endl;
}
int getSum() {
	int mm = 0;
	for (auto iter = sum.cbegin(); iter != sum.cend(); iter++)
	{
		mm+=*iter;
	}
	return mm;
}
void dfs(int root) {
	s.push_back(root);
	while (root >=1)
	{
		while (C[root] < num) {
			C[root] += 1;
			if (root == C[root]) continue;//不满足条件
			vector<int>::iterator index = find(s.begin(), s.end(), C[root]);
			if (index != s.end()) continue;//不满足条件
			//部分解
			cur++;
			sum.push_back( dis[END(s)][C[root]]);
			s.push_back(C[root]);
			root++;
			if (cur == num){//解
				int ss = getSum();
				int a = dis[END(s)][*s.begin()];
				minN = minN > ss + a ? ss + a : minN;
				s.push_back(*s.begin());
				print(ss + a);
				s.pop_back();
				break;
			}

		}
		//回溯
		C[root] = 0;
		root--;
		s.pop_back();
		if (!sum.empty())
			sum.pop_back();
		cur--;
	}

 }
int main()
{
	fstream f("input3.txt");
    f >> num ;
    for(int i = 1;i <= num;i++)
    {		
		for (int j = 1; j <= num; j++)
		{
			if (i == j) {
				int x;
				dis[i][j] = INF;
				f >> x;
			}else f>>dis[i][j];
		}
    }
	dfs(1);
    cout << "最小开销"<< minN << endl;
    return 0;
}
