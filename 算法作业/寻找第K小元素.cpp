#include <iostream>
#include <algorithm>
#define MAX 100
using namespace std;
int len = 51;
//[low,high]
int select(int *A, int low, int high,int k) {
	int p = high - low + 1;
	if (p < 44) {
		sort(A, A+p);
		return A[k-1];
	}
	int q = p / 5;
	int M[MAX];
	int i = 0;
	int num = 0;
	while (i < q) {
		sort(A + 5 * i, A + 5 * (i + 1));
		M[num++] = A[5 * i + 2];
		i++;
	}
	int mm = select(M, 0, num - 1,q/2);
	int a1[MAX], a2[MAX], a3[MAX];
	int n1 = 0, n2 = 0, n3 = 0;
	for (int i = low; i <= high; i++) {
		if (A[i] == mm) {
			a2[n2++] = A[i];
		}
		else if (A[i] < mm) {
			a1[n1++] = A[i];
		}
		else {
			a3[n3++] = A[i];
		}
	}
	if (n1 >= k) return select(a1, 0, n1 - 1, k);
	if (n1 + n2 >= k) return mm;
	else return select(a3, 0, n3 - 1, k-n1-n2);
}

int main()
{
	int A[MAX];
	int k = 2;
	for (int i = 0; i < len; ++i)
	{
		int a = rand() % 100 + 1;
		A[i] = a;
	}
	int p = select(A, 0, len - 1, k);
	cout << "第"<<k<<"小元素:" << p << endl;
	return 0;
}