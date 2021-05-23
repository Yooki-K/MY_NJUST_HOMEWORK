#include<cstdio>
#include<iostream>
#include<algorithm>
#include<random>
using namespace std;
#define MAXN 10000
int n;
void Sift_up(int *h, int i){
	if (i==1) return;
	int a=i/2;
	while (a!=1 && h[i]>h[a]){
		swap(h[a],h[i]);
		i/=2;
		a=i/2;
	}
}
void Sift_down(int *h, int i){
	if(i*2>n) return;
	while(i*2<=n){
		i*=2;
		if(i+1<=n && h[i]<h[i+1]){
			i=i+1;
		}
		if(h[i]>h[i/2]) swap(h[i/2],h[i]);
		else break;
	}
}
void insert(int *h,int value){
	n+=1;
	h[n]=value;
	Sift_up(h,value);
}
void Delete(int *h,int i){
	int a=h[n];
	int b=h[i];
	n-=1;
	if(i==n+1) return;
	h[i]=a;
	if(a<b) Sift_down(h,i);
	else Sift_up(h,i);

}
int delete_max(int *h){
	int x=h[1];
	Delete(h,1);
	return x;
}
void makeheap(int*h){
	for (int i = n/2; i >0; --i)
	{	
		Sift_down(h,i);
	}
}
void print(int *h){
	for (int i = 1; i <= n; ++i)
	{
		cout<<h[i]<<' ';
	}
	cout<<endl;
}
int main(){
	int h[MAXN];
	n=5;
	for (int i = 1; i <= n; ++i)
	{
		int a=rand();
		h[i]=a;
	}
	cout<<"初始值："<<endl;
	print(h);
	makeheap(h);
	cout<<"堆："<<endl;
	print(h);
	delete_max(h);
	cout<<"删除最大值后："<<endl;
	print(h);
	Delete(h,2);
	cout<<"删除第二个后："<<endl;
	print(h);
	insert(h,5);
	cout<<"添加5后："<<endl;
	print(h);
	cout<<"结束"<<endl;
	return 0;
}