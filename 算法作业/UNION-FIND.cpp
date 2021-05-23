#include<cstdio>
#include<iostream>
using namespace std;
#define MAX 10000
#define null -1
int h[MAX];//每个结点的根的下标
int v[MAX];//每个结点的高度
int n;
int FIND(int x){
	int y=x;
	while(h[y]!=null){
		y=h[y];
	}
	int root=y;
	y=x;
	while(h[y]!=null){
		int w = h[y];
		h[y]=root;
		y=w;
	}
	return root;
}
void UNION(int x,int y){
	int a=FIND(x);
	int b=FIND(y);
	if(v[a]<=v[b]){
		h[a]=b;
		if(v[a]==v[b]) v[b]++;
	}else{
		h[b]=a;
	}
}
int main()
{
	n=10;
	for (int i = 1; i <= n; ++i)
	{
		h[i]=null;
		v[i]=1;
	}
	UNION(2,3);
	UNION(3,5);
	UNION(8,9);
	UNION(3,9);
	cout<<"find(3) "<<FIND(3)<<endl;
	cout<<"find(5) "<<FIND(5)<<endl;
	cout<<"find(9) "<<FIND(9)<<endl;
	cout<<"find(3) "<<FIND(3)<<endl;
	cout<<"find(5) "<<FIND(5)<<endl;
	return 0;
}