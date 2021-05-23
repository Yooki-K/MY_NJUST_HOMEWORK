#include<bits/stdc++.h>
using namespace std;
#define MAX 105
int n;
map<int, set<pair<int, int>>>e;//�ڽӾ����
multimap<int, pair<int, int>>ee;//�ߵļ���
vector<int>Rank;
bool isv[MAX];
int nOf=0;
void bfs(int root) {
	queue<int>q;
	q.push(root);
	while (!q.empty()) {
		int u = q.front();
		q.pop();
		if (isv[u]) continue;
		cout << u << " ";
		isv[u] = 1;
		for (set<pair<int, int>>::iterator it = e[u].begin(); it != e[u].end(); ++it)//r�����
		{
			if (!isv[it->second]) {
				q.push(it->second);
			}
		}
	}
	cout << endl;
}
void dfs(int root) {
	stack<int>q;
	q.push(root);
	while (!q.empty()) {
		int u = q.top();
		if (!isv[u]) {
			isv[u] = 1;
			cout << u << " ";
		}
		bool ishave = 0;
		for (set<pair<int, int>>::iterator it = e[u].begin(); it != e[u].end(); ++it)//r�����
		{
			if (!isv[it->second]) {
				q.push(it->second);
				ishave = 1;
				break;
			}
		}
		if (!ishave) {
			q.pop();
		}
	}
	cout << endl;
}
int find(int *p, int root) {
	int temp = root;
	while (p[root]!=root)
	{
		root = p[root];
	}
	// ·��ѹ��
	while (temp != root) {
		int t = p[temp];
		p[temp] = root;
		temp = t;
	}
	return root;
}
bool unite(int *p, int x,int y) {
	int xx = find(p,x);
	int yy = find(p,y);
	if (xx == yy)return 0;
	if (Rank[xx] <= Rank[yy]) {
		p[xx] = yy;
		if (Rank[xx] == Rank[yy]) {
			Rank[yy]++;
		}
	}
	else {
		p[yy] = xx;
	}
	return 1;
}
int Kruskal() {
	int sum=0;
	int parent[MAX];
	Rank.push_back(-1);
	for (int i = 1; i <= n; i++)
	{
		parent[i] = i;
		Rank.push_back(1);
	}
	int num = 0;
	multimap<int, pair<int, int>>::iterator it = ee.begin();
	while (it!=ee.end()) {
		pair<int, int> N=it->second;
		if (unite(parent, N.first, N.second)) {
			num++;
			sum+=it->first;
			it++;
		}
		else {
			multimap<int, pair<int, int>>::iterator temp = it;
			it++;
			ee.erase(temp);
		}
	}
	
	if (num < n - nOf) {
		cout << "����������С������" << endl;
		return -1;
	}
	else {
		map<int,vector<pair<int, int>>>mp;
		for (multimap<int, pair<int, int>>::iterator i = ee.begin(); i != ee.end(); i++) {
			int p = parent[i->second.first];
			if (mp.find(p)==mp.end()) {
				mp.emplace(p, vector<pair<int, int>>());
			}
			mp[p].push_back(i->second);
		}
		for (map<int, vector<pair<int, int>>>::iterator it = mp.begin(); it != mp.end(); it++) {
			printf("��Ϊ%d����С����������\n", it->first);
			for (vector<pair<int, int>>::iterator i = it->second.begin(); i != it->second.end();i++) {
				printf("(%d,%d) ", i->first, i->second);
			}
			cout << endl;
		}
	}
	return sum;

}
void Prim(int root) {
	int dis[MAX];
	for (int i = 1; i <= n; i++) {
		dis[i] = 1 << 20;
	}
	dis[root] = 0;
	while (1) {
		int m = 1<<20;
		int u = -1;
		for (int i = 1; i <= n; i++) {
			if (!isv[i] && m > dis[i]) {
				m = dis[i];
				u = i;
			}
		}
		if (u == -1) break;
		isv[u] = 1;
		cout << u << " ";
		for (set<pair<int, int>>::iterator it = e[u].begin(); it != e[u].end(); it++) {
			int w = it->first;
			int j = it->second;
			if (!isv[j] && dis[j] > dis[u] + w) {
				dis[j] = dis[u] + w;
			}
		}

	}
	cout << endl;
}
int main()
{
	//�����ڽӾ��������ͼ
	fstream file("input3.txt");
	file >> n;
	for (int i = 1; i <= n; i++) {
		int a, b;
		file >> a >> b;
		set<pair<int, int>>v;
		for (int i = 0; i < b; ++i)
		{
			int c, d;
			file >> c >> d;
			v.insert(pair<int, int>(d, c));
			ee.emplace(d, pair<int, int>(a, c));
		}
		e[a] = v;
	}
	 cout << "bfs:" << endl;
	 for (int i = 1; i <= n; ++i)
	 {
	 	if (!isv[i]) {
	 		bfs(i);
	 	}
	 }
	 memset(isv, 0, sizeof(isv));
	 cout << "dfs:" << endl;
	 for (int i = 1; i <= n; ++i)
	 {
	 	if (!isv[i]) {
	 		dfs(i);
			nOf++;
	 	}
	 }

	//������С������
	cout << "����Kruskal����С������:" << endl;
	cout<<Kruskal()<<endl;
	cout << "����Prim����С������:" << endl;
	memset(isv, 0, sizeof(isv));
	// for (int i = 1; i <= n; ++i)
	// {
	// 	if (!isv[i]) {
	// 		printf("��Ϊ%d����С����������\n", i);
			Prim(1);

	// 	}
	// }
	 system("pause");
	return 0;
}

