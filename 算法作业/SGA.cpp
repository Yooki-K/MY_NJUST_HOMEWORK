#include<bits/stdc++.h>
using namespace std;
#define MAX 101
#define ALL 3000000
#define PI acos(-1)
#define EPS 1e-7
#define LEN 22
int M = MAX - 1; //种群规模
int T = 100;//终止进化的代数150
double Pc = 0.5;//交叉概率
double Pm = 0.005;//变异概率
double syd[MAX];
double p[MAX];
double psum[MAX];
int slist[MAX];
double sumv = 0;
// 使用简单遗传算法SGA解决下面的问题：求下列一元函数的最大值 f(x) = x*sin(10*PAI*x)+2.0,其中，-1<=x<=2,求解结果精确到六位小数
string encode(int a) {
	char s[25];
	string ss(LEN,'0');
	itoa(a, s, 2);
	for (int i = strlen(s),j=LEN; i>=0; i--,j--)
	{
		ss[j] = s[i];
	}
	return ss;
}
int decode(string s) {
	return stoi(s,nullptr,2);
}
int compare(double &x, double &y) {
	if (fabs(x - y) < EPS) return 0;
	if (x > y + EPS)   return 1;
	else return -1;
}
double f(int x) {
	double xx = -1 + x * 0.000001;
	double yy = sin(10.0 * PI*xx) * xx  + 2.0;
	//std::cout << xx <<"  "<<yy<< endl;
	return yy;
}
// 返回[1,3000000]的随机数
int random() {
	int i = rand() % 6;
	int j = rand() + 1;
	switch (i)
	{
	case 0:
		return j % 10 + 1;
	case 1:
		return j % 100 + 1;
	case 2:
		return j % 1000 + 1;
	case 3:
		while (j < 10000) {
			j = j * (rand() % 10 + 1);
		}
		return j % 10000 + 1;
	case 4:
		while (j < 100000) {
			j = j * (rand() % 10 + 1);
		}
		return j % 100000 + 1;
	default:
		while ( j < 3000000) {
			j = j * (rand() % 5 + 1);
		}
		return j % 3000000 +1;
		
	}
}
void sum() {
	p[1] = syd[1]/sumv;
	psum[1] = p[1];
	for (int i = 2; i <= M; i++) {
		p[i] = syd[i] / sumv;
		psum[i] = p[i] + psum[i - 1];
	}
	return;
}
int binary_find(int l,int r,double x) {
	if (compare(x, psum[1]) == -1) return 1;
	while (l < r) {
		int mid = (l + r) / 2;
		if (compare(x, psum[mid]) == 0) return mid;
		if (compare(psum[mid],x) == -1 && compare(psum[mid+1],x) != -1 ) return mid + 1;
		if (compare(psum[mid] , x) == 1) r = mid;
		else l = mid;
	}
	return 0;
}
int main()
{
	srand((int)time(0));
	int temp[MAX];
	int changeNum = M * Pc;
	int mutateNum = M * LEN * Pm;
	//printf("changeNum:%d\n", changeNum);
	cout << "按回车进行求解一次" << endl;
	while (1) {
		getchar();
		for (int i = 1; i <= M; i++) {
			temp[i] = random();
		}// 初始化生成随机种群
		int t = T;
		while (t--) {
			copy(begin(temp), end(temp), begin(slist));
			sumv = 0.0;
			//计算 syd sumv
			for (int i = 1; i <= M; i++) {
				syd[i] = f(slist[i]);
				sumv += syd[i];
			}
			// 计算 p psum
			sum();
			//选择复制
			for (int i = 1; i <= M; i++)
			{
				double ran = (rand() % 100) / 100.0;
				int index = binary_find(1, M, ran);
				//cout << index << endl;
				temp[i] = slist[index];
			}
			//交叉
			int changeIndex = rand() % (LEN-1) + 1;
			//printf("changeIndex:%d\n", changeIndex);
			for (int i = changeNum; i <= LEN; i=i+2)
			{	
				string a = encode(slist[i]);
				string b = encode(slist[i + 1]);
				//cout << "交换前：" << a << " " << b << endl;
				for (int j = 1; j <= changeIndex; j++)
				{
					swap(a[j], b[j]);
				}
				slist[i] = decode(a);
				slist[i+1] = decode(b);
				//cout << "交换后：" << a << " " << b << endl;
			}
			//变异
			for (int i = 0; i < mutateNum; i++)
			{
				int a = rand() % M + 1;
				int b = rand() % (LEN - 1) + 1;
				string temp = encode(slist[a]);
				//cout << "变异前：" << temp;
				if (temp[b] == '0') temp[b] = '1';
				else temp[b] = '0';
				slist[a] = decode(temp);
				//cout << " 变异后：" << temp << endl;
			}
		}
		double* maxIndex = max_element(begin(syd), end(syd));
		std::cout << "最大值为：" << *maxIndex << endl;
		int maxValue = slist[maxIndex-begin(syd)];
		printf("值为：%.6lf\n" , -1.0 + maxValue * 0.000001);
		std::cout<<"染色体为："<< encode(maxValue) << endl;
	}

	// system("pause");
	return 0;
}

