#include<bits/stdc++.h>
using namespace std;
#define MAX 105
struct point {
	int v;
	point* l = NULL;
	point* r = NULL;
};
int n;
point *root;
void insertTree(point *p, point *r) {
	if (r->v < p->v) {
		if (r->r != NULL)
			insertTree(p, r->r);
		else
			r->r = p;
	}
	else {
		if (r->l != NULL)
			insertTree(p, r->l);
		else
			r->l = p;
	}
}
point* getParent(point *p) {
	if (p == root) return NULL;
	point *parent = root;
	stack<point *>q;
	while (parent != NULL || !q.empty()) {
		if (parent != NULL) {
			if (parent->l == p) return parent;
			if (parent->r == p)return parent;
			q.push(parent);
			parent = p->l;
		}
		else {
			parent = q.top();
			q.pop();
			parent = parent->r;
		}
	}
	return NULL;
}
point* searchPoint(int k) {
	point *p = root;
	while (p != NULL) {
		if (p->v == k) return p;
		if (p->v > k) {
			p = p->l;
		}
		else {
			p = p->r;
		}
	}
	return NULL;
}
void deletePoint(int k) {
	point*p = searchPoint(k);
	if (p == NULL) return;//不存在
	point *parent = getParent(p);
	if (p->l == NULL) {//one subtree or leaf
		if (parent == NULL) {//删除根节点
			point *temp = root;
			root = root->r;
			delete temp;
		}
		else {
			if (parent->l == p) parent->l = p->r;
			else parent->r = p->r;
			delete p;
		}

	}
	else if (p->r == NULL) {//one subtree
		if (parent == NULL) {//删除根节点
			point *temp = root;
			root = root->l;
			delete temp;
		}
		else {
			if (parent->l == p) parent->l = p->l;
			else parent->r = p->l;
			delete p;
		}
	}
	else {
		point *temp=p;
		point *s = p->l;
		while (s->r != NULL) {
			temp = s;
			s = s->r;
		}
		p->v = s->v;
		if (p == temp) {
			temp->l = s->l;
		}
		else {
			temp->r = s->l;
		}
		delete s;

	}
}
void print_mid() {//非递归 中序遍历
	stack<point *>q;
	point *p = root;
	while (p != NULL || !q.empty()) {
		if (p != NULL) {
			q.push(p);
			p = p->l;
		}
		else {
			p = q.top();
			q.pop();
			cout << p->v <<" ";
			p = p->r;
		}
	}
	cout << endl;
	return;
}
void print_late() {//非递归 后序遍历
	stack<point *>q;
	point *p = root;
	point *parentvisited = NULL;
	while (p != NULL || !q.empty()) {
		if (p != NULL) {
			q.push(p);
			p = p->l;
		}
		else {
			point* temp = q.top();
			if (parentvisited == temp->r || temp->r == NULL) {
				q.pop();
				cout << temp->v << " ";
				parentvisited = temp;
			}
			else {
				p = temp->r;
			}
		}
	}
	cout << endl;
	return;
}
void print_pre() {//非递归	前序遍历
	stack<point *>q;
	q.push(root);
	while (!q.empty()) {
		point* u = q.top();
		q.pop();
		cout << u->v << " ";
		if (u->r != NULL) {
			q.push(u->r);
		}
		if (u->l != NULL) {
			q.push(u->l);
		}
	}
	cout << endl;
}
void searchTree(fstream &file) {
	//搜索二叉树
	for (int i = 0; i < n; i++) {
		int n1;
		file >> n1;
		if (root == NULL) {
			root = new point();
			root->v = n1;
		}
		else {
			point *p = new point();
			p->v = n1;
			insertTree(p, root);
		}	
	}
}
void print() {
	cout << "先序遍历：" << endl;
	print_pre();
	cout << "中序遍历：" << endl;
	print_mid();
	cout << "后序遍历：" << endl;
	print_late();
}
int main()
{
	fstream file("input2.txt");
	file >> n;
	cout << "构建搜索二叉树：" << endl;
	searchTree(file);
	print();
	system("pause");
	return 0;
}
