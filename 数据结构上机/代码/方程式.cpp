#include<bits/stdc++.h>
using namespace std;
#define MAX 105
struct point {
	int coef;
	int exp;
	point*next = NULL;
};
int n;
int compare(point *p1, point *p2) {
	if (p1->exp >= p2->exp) {
		if (p1->exp == p2->exp) {
			return 0;
		}
		return 1;
	}
	return -1;
}
void print(point *a) {
	while (1) {
		a = a->next;
		if (a == NULL) break;
		if (a->coef == 0) continue;
		cout << a->coef << "X" << a->exp << " ";
	}
	cout << endl;
}
void deletep(point *pp) {
	if (pp->next == NULL) {
		return;
	}
	pp->next = pp->next->next;
}
int main()
{
	fstream file("input1.txt");
	file >> n;
	int n1, n2;
	file >> n1;
	point *pa = new point();
	point *pb = new point();
	point *q;
	pa->exp = -1;
	pb->exp = -1;
	point *ha = pa, *hb = pb;
	for (int i = 0; i < n1; i++) {
		int aa, bb;
		point *p = new point();
		file >> aa >> bb;
		p->exp = bb;
		p->coef = aa;
		pa->next = p;
		pa = p;
	}
	file >> n2;
	for (int i = 0; i < n2; i++) {
		int aa, bb;
		point *p = new point();
		file >> aa >> bb;
		p->exp = bb;
		p->coef = aa;
		pb->next = p;
		pb = p;
	}
	cout << "��һ����ʽ��" << endl;
	print(ha);
	cout << "�ڶ�����ʽ��" << endl;
	print(hb);
	if (n1 < n2) {
		swap(ha, hb);
	}
	point *begin_l = ha;
	q = ha;
	ha = ha->next;
	while (hb->next != NULL) {
		if (ha == NULL) {
			ha = hb->next;
			break;
		}
		int result = compare(ha, hb->next);
		if (result == 1) {//���� �����haǰ��,hb++
			point *temp;
			temp = hb->next->next;
			q->next = hb->next;
			q->next->next = ha;
			hb->next = temp;
		}
		else if (result == 0) {//���� �ϲ�,hb++
			ha->coef += hb->next->coef;
			q = q->next;
			ha = ha->next;
			deletep(hb);
		}
		else {//С�� ha��q++
			q = q->next;
			ha = ha->next;
		}
	}
	cout << "���:" << endl;
	print(begin_l);
	system("pause");
	return 0;
}
