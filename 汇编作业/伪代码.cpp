#include<cstdio>
#include<iostream>
#define ull unsigned long long
using namespace std;
char buffer[10];
const char*err1="\nIt's a empty string!\n";
const char*err2="\nIt's a error string!\n";
const char*err3="\nA nonpositive is not allowed!\n";
const char*err4="\nIt's a number that is not allowed!\n";
const char*start_screen="-----------------Fibonacci-----------------\n-------------------menu--------------------\n\n1.Print first N numbers of Fiboaccai\n2.Print the N number of Fibonacci\n3.Judge if a number belongs to Fibonacci\n4.exit\n\n";
const char*exit_screen="\n-----------------byebye-----------------\n\n";

// 包括出错处理的输入函数
int Decin(int type){
	while(1){
		int state=0;//状态
		if (type==0)
		{
			cout<<"Please input a dec value(<1000000000):";
		}else{
			cout<<"Please input your choice:";
		}
		cin.getline(buffer,10);
		char sp=' ';
		char enter='\n';
		char fh='-';
		char *fp=buffer;
		char temp;
		//do_space1
		do{
			temp=*fp;
			fp++;
			if(temp==0 || temp==enter) {cout<<err1;state=1;break;}//检测出空串
			if(temp==fh) {cout<<err3;state=3;break;}//检测出负号
		}while(temp==sp);
		if(state!=0) continue;
		//do_zero
		while(temp=='0'){
			temp=*fp++;
			if(temp==0 || temp==enter) {cout<<err3;state=3;break;}//检测出0
		}
		if(state!=0) continue;
		int m=0;
		int basis=10;
		//loop1
		do{
			if(temp==sp){
				//do_space2
				do{
					temp=*fp;
					fp++;								
				}while(temp==sp);
				if(temp!=0 && temp!=enter){state=2;cout<<err2;break;}//检测出错误数字
			}
			if(temp==0 ||temp==enter) break;
			if(temp>'9' || temp<'0'){state=2;cout<<err2;break;}//检测出错误数字
			//计算数字
			m*=basis;
			m+=temp-'0';
			temp=*fp;
			fp++;
		}while(1);
		if(state!=0) continue;
		return m;
	}
}
// 使用迭代实现的斐波那契数列
void print_Fibonacci_iteration(int n){
	ull pre=0;//前一个数
	ull cur=1;//当前数
	cout<<"1 ";
	while(--n>0){
		ull temp=cur;
		cur+=pre;
		pre=temp;
		cout<<cur<<" ";
	}
	cout<<endl;
}
// 使用迭代实现的斐波那契数列 找到返回下标(从1开始)，找不到返回-1
int find_Fibonacci_iteration(int n){
	ull pre=0;//前一个数
	ull cur=1;//当前数
	int index=1;
	while(1){
		if(cur==n) return index;
		else if(cur>n){
			return -1;
		}
		index++;
		ull temp=cur;
		cur+=pre;
		pre=temp;
	}
}
// 使用递归实现的斐波那契数列
ull Fibonacci_recursive(int n){
	ull re = 1;
	if(n<=2){
		return re;
	}
	re = Fibonacci_recursive(n-1)+Fibonacci_recursive(n-2)
	return re;
}
int main(){
	cout<<start_screen;//输出开始屏幕
	while(1){
		int type = Decin(1);
		if(type==4){
			cout<<exit_screen;//输出结束屏幕
			return 0;			
		}
		int m = Decin(0);
		if(type==2)
			cout<<Fibonacci_recursive(m)<<endl;
		else if(type==1)
			print_Fibonacci_iteration(m);
		else if(type==3){
			cout<<find_Fibonacci_iteration(m)<<endl;
		}
		else{
			cout<<err4;
			continue;
		}
		
	}
}