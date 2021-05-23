#include<iostream>
#include<cstdio>
#include<vector>
#include<algorithm>
#include<stack>
#include<queue>
#include<fstream>
using namespace std;
#define MAX 100
struct Node {
	char u;//字符
	int v;//权重
	Node* p = NULL;//父母
	Node* l = NULL;
	Node* r = NULL;//左、右儿子
	vector<char> bm;
};
char s[MAX];
int temp[MAX];
priority_queue <pair<int,Node*> > hfm;
int main()
{
	ifstream file("D:/mixed_file/daima/C++/input.txt");
	int num;
	file >> num;
	for (int i = 0; i < num; i++) {
		file >> s[i];
	}
	for (int i = 0; i < num; i++) {
		int a;
		file >> a;
		temp[i] = -a;
	}
	for (int i = 0; i < num; i++)
	{
		Node *node=new Node;
		node->v = temp[i];
		node->u = s[i];
		hfm.push(pair<int, Node*>(node->v,node));
	}
	 Node*root;
	 for(int i=1;i<=num-1;i++) {
		pair<int, Node*> c=hfm.top();
	 	hfm.pop();
		pair<int, Node*> cc=hfm.top();
	 	hfm.pop();
	 	Node *node = new Node;
		pair<int, Node*> result = pair<int, Node*>(c.first + cc.first, node);
		node->v = c.first + cc.first;
	 	node->l = c.second;
	 	node->r = cc.second;
	 	c.second->p = node;
	 	cc.second->p = node;
	 	hfm.push(result);
	 	root = node;
	 }
	 //哈夫曼树已经构造好了，现在输出哈夫曼编码
	 stack<Node*>Q;
	 vector<Node*>q;
	 Q.push(root);
	 while (!Q.empty()) {
		Node* pop = Q.top();
	 	Q.pop();
		if (pop->l == NULL && pop->r == NULL) {
			q.push_back(pop);
			continue;
		}
	 	if (pop->l != NULL) {
			pop->l->bm = pop->bm;
			pop->l->bm.push_back('0');
	 		Q.push(pop->l);

	 	}
	 	if(pop->r!=NULL) {
	 		pop->r->bm = pop->bm;
	 		pop->r->bm.push_back('1');
	 		Q.push(pop->r);
	 	}
	 }
	 int sum=0;
	 int i = 0;
	 while(i<num) {
		 Node *node;
		for (int j = 0; j < num; j++) {
			if (q[j]->u == s[i]) {
				i++;
				node = q[j];
				break;
			}
		}
	 	cout << node->u << "  ";
	 	for (vector<char>::iterator it = node->bm.begin(); it != node->bm.end(); it++) {
	 		cout << *it;
	 	}
	 	cout << endl;
	 	sum += node->bm.size()*(-node->v);
	 }
	 cout << sum << "---->sum" << endl;
	 return 0;
}
