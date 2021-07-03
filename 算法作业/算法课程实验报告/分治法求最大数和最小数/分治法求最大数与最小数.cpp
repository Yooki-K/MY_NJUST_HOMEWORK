#include<bits/stdc++.h>
using namespace std;
vector<int> m;

void find(int &maxnum, int &minnum, int l, int r)
{
	if (l > r) return;
	int mid = (r + l) / 2;
	if (l == r)
	{
		maxnum = maxnum > m[l] ? maxnum : m[l];
		minnum = minnum < m[l] ? minnum : m[l];
		return;
	}
	find(maxnum, minnum, l, mid);
	find(maxnum, minnum, mid + 1, r);
}
int main()
{
	fstream f("input1.txt");
	int x;
	printf("数组：");
	while(f>>x){
		m.push_back(x);
		printf("%d ", x);
	}
	cout << endl;
	int maxnum = -1<<20, minnum = 1<<20;
	find(maxnum, minnum, 0, m.size()-1);
	cout << "max:" << maxnum << " " << "min:" << minnum<<endl;
}
