#include<opencv2\opencv.hpp>
#include <bits\stdc++.h> 
#define PI 3.1415926
#define ll long long
#pragma warning( disable : 4996 )
using namespace cv;
using namespace std;

struct point
{
	int x, y;
	point() {}
	point(int xx, int yy) { x = xx; y = yy; }
};
enum fill_type { ZERO=0, COPY, MIRROR };

//获取文件名
string getFileName(string s,string add, bool setPng = 0)
{
	auto r = s.find(".");
	if (setPng) {
		return s.substr(0, r)+"_"+add+".png";
	}
	return s.substr(0, r)+"_"+add+s.substr(r);

}
//获取文件扩展名
string getType(string s) {
	auto r = s.find(".");

	return s.substr(r+1);
}
//图片灰度化
Mat toGray(Mat &src) {
	Mat dst(src.size(), CV_8UC1);
	if (src.channels() != 3) return src;
	for (int i = 0; i < src.rows; i++)
	{
		for (int j = 0; j < src.cols; j++) {
			Vec3b temp = src.at<Vec3b>(i, j);
			uchar t = 0.299 *temp[0] + 0.578*temp[1] + 0.114*temp[2];
			dst.at<uchar>(i, j) = t;
		}
	}
	return dst;
}
//创建二维高斯滤波器模板
vector<vector<double>> createGSModel2(int a, double sigma) {
	vector<vector<double>> model(a,vector<double>(a));
	double sum = 0;
	for (int i = 0; i < model.size(); i++)
	{
		int x = i - a / 2;
		for (int j = 0; j < model[i].size(); j++)
		{
			int y = j - a / 2;
			double temp = exp(-(x*x + y * y) / (2 * sigma*sigma));
			sum += temp;
			model[i][j]= temp;
		}
	}
	for (int i = 0; i < model.size(); i++)
	{
		for (int j = 0; j < model[i].size(); j++)
		{
			model[i][j] /= sum;
		}
	}
	return model;
}
//创建一维高斯滤波器模板
vector<double> createGSModel1(int a, double sigma) {
	vector<double> model(a);
	double sum = 0;
	for (int i = 0; i < model.size(); i++)
	{
		int x = i - a / 2;
		double temp = exp(-x*x  / (2 * sigma*sigma));
		sum += temp;
		model[i] = temp;
	}
	for (int i = 0; i < model.size(); i++)
	{
			model[i] /= sum;
	}
	return model;
}
//返回边界填充时对应的点坐标
point getClostPoint(point p, int a,int b,int dt,int type){
	int x=0, y=0;
	if (p.x < dt) { 
		if(type==COPY)x = 0;
		else if (type == MIRROR) x = dt - (p.x + 1);
	}
	else if (p.x >= a + dt) {
		if (type == COPY)x = a - 1;
		else if (type == MIRROR) x = a - ((p.x+1)-(dt + a));
	}
	else x = p.x - dt;
	if (p.y < dt) {
		if (type == COPY)y = 0;
		else if (type == MIRROR) y = dt - (p.y + 1);
	}
	else if (p.y >= b + dt) {
		if (type == COPY)y = b - 1;
		else if (type == MIRROR) y = b - ((p.y + 1) - (dt + b));
	}
	else y = p.y - dt;
	return point(x, y);
}
//三种填充，0零填充、1复制填充、2镜像填充
Mat fillMat(Mat& src,int ma, int type) {
	int dt = ma / 2;
	Mat m(src.rows+dt*2, src.cols + dt*2, src.type());
	for (int i = 0; i < m.rows; i++)
	{
		for (int j = 0; j < m.cols; j++)
		{
			if (i < dt || j < dt || i >= src.rows + dt || j >= src.cols + dt) {
				if (type == ZERO)
				{
					if (src.channels() == 3) {
						m.at<Vec3b>(i, j)[0] = 0;
						m.at<Vec3b>(i, j)[1] = 0;
						m.at<Vec3b>(i, j)[2] = 0;
					}
					else if(src.channels() == 1) {
						m.at<uchar>(i,j)= 0;
					}

				}else
				{
					point p = getClostPoint(point(i, j), src.rows, src.cols, dt,type);
					if (src.channels() == 3) {
						m.at<Vec3b>(i, j)[0] = src.at<Vec3b>(p.x, p.y)[0];
						m.at<Vec3b>(i, j)[1] = src.at<Vec3b>(p.x, p.y)[1];
						m.at<Vec3b>(i, j)[2] = src.at<Vec3b>(p.x, p.y)[2];
					}
					else if (src.channels() == 1) {
						m.at<uchar>(i, j) = src.at<uchar>(p.x, p.y);
					}
				}
			}
			else {

				if (src.channels() == 3) {
					m.at<Vec3b>(i, j)[0] = src.at<Vec3b>(i - dt, j - dt)[0];
					m.at<Vec3b>(i, j)[1] = src.at<Vec3b>(i - dt, j - dt)[1];
					m.at<Vec3b>(i, j)[2] = src.at<Vec3b>(i - dt, j - dt)[2];
				}
				else if (src.channels() == 1) {
					m.at<uchar>(i, j) = src.at<uchar>(i - dt, j - dt);
				}
			}
		}
	}
	imwrite("填充图.jpg", m);
	return m;
}
//高斯滤波
string GS2(Mat &src,int ma, string filename, int filltype=1) {
	Mat cur = fillMat(src, ma, filltype);
	Mat m(src.rows, src.cols, src.type());
	vector<vector<double>> v = createGSModel2(ma, 1);
	for (int i = 0; i < m.rows; i++)
	{
		for (int j = 0; j < m.cols; j++) {
			double sum[3] = { 0 };
			for (int ii = 0; ii < ma; ii++)
			{
				for (int jj = 0; jj < ma; jj++)
				{
					Vec3b rgb = cur.at<Vec3b>(i + ii, j + jj);
					double k = v[ii][jj];
					sum[0] += k * int(rgb[0]);
					sum[1] += k * int(rgb[1]);
					sum[2] += k * int(rgb[2]);
				}
			}
			for (int k = 0; k < cur.channels(); k++)
			{
				if (sum[k] < 0)sum[k] = 0;
				else if (sum[k] > 255)sum[k] = 255;
			}
			m.at<Vec3b>(i, j) = Vec3b(static_cast<uchar>(sum[0]), static_cast<uchar>(sum[1]), static_cast<uchar>(sum[2]));
		}
	}
	string path = getFileName(filename, "高斯滤波");
	imwrite(path, m);
	return path;
}
//快速高斯滤波
string GS1(Mat &src, int ma, string filename, int filltype=1) {
	Mat cur = fillMat(src, ma, filltype);
	Mat m(src.rows, src.cols, src.type());
	vector<double> v = createGSModel1(ma, 1);
	//行卷积
	for (int i = 0; i < m.rows; i++)
	{
		for (int j = 0; j < m.cols; j++) {
			if (src.channels() == 3) {
				double sum[3] = { 0 };
				for (int jj = 0; jj < ma; jj++)
				{
					Vec3b rgb = cur.at<Vec3b>(i+ma/2, j + jj);
					sum[0] += v[jj] * int(rgb[0]);
					sum[1] += v[jj] * int(rgb[1]);
					sum[2] += v[jj] * int(rgb[2]);
				}
				for (int k = 0; k < cur.channels(); k++)
				{
					if (sum[k] < 0)sum[k] = 0;
					else if (sum[k] > 255)sum[k] = 255;
				}
				m.at<Vec3b>(i, j) = Vec3b(static_cast<uchar>(sum[0]), static_cast<uchar>(sum[1]), static_cast<uchar>(sum[2]));
			}
			else if (src.channels() == 1) {
				double sum = 0;
				for (int jj = 0; jj < ma; jj++)
				{
					sum += v[jj] * int(cur.at<uchar>(i, j + jj));
				}
				if (sum < 0)sum = 0;
				else if (sum > 255)sum = 255;
				m.at<uchar>(i, j) = static_cast<uchar>(sum);
			}

		}
	}
	//列卷积
	cur = fillMat(m, ma, filltype);
	for (int i = 0; i < m.rows; i++)
	{
		for (int j = 0; j < m.cols; j++) {
			if (src.channels() == 3) {
				double sum[3] = { 0 };
				for (int ii = 0; ii < ma; ii++)
				{
					Vec3b rgb = cur.at<Vec3b>(i + ii, j+ma/2);
					sum[0] += v[ii] * int(rgb[0]);
					sum[1] += v[ii] * int(rgb[1]);
					sum[2] += v[ii] * int(rgb[2]);
				}
				for (int k = 0; k < cur.channels(); k++)
				{
					if (sum[k] < 0)sum[k] = 0;
					else if (sum[k] > 255)sum[k] = 255;
				}

				m.at<Vec3b>(i, j) = Vec3b(static_cast<uchar>(sum[0]), static_cast<uchar>(sum[1]), static_cast<uchar>(sum[2]));
			}
			else if (src.channels() == 1) {
				double sum = 0;
				for (int ii = 0; ii < ma; ii++)
				{
					sum += v[ii] * int(cur.at<uchar>(i + ii, j));
				}
				if (sum < 0)sum = 0;
				else if (sum > 255)sum = 255;
				m.at<uchar>(i, j) = static_cast<uchar>(sum);
			}

		}
	}
	string path = getFileName(filename, "快速高斯滤波");
	imwrite(path, m);
	return path;
}
//拉普拉斯锐化
string LPLS(Mat &src, string filename, int filltype=1) {
	int ma = 3;
	Mat cur = fillMat(src, ma, filltype);//填充
	Mat m(src.rows, src.cols, src.type());
	vector<vector<double>> v = { {-1,-1,-1},{-1,8,-1},{-1,-1,-1} };//拉普拉斯核
	for (int i = 0; i < m.rows; i++)
	{
		for (int j = 0; j < m.cols; j++) {
			if (src.channels() == 3) {
				Vec3b t = cur.at<Vec3b>(i + ma/2, j + ma/2);
				double sum[3] = { t[0],t[1],t[2] };
				for (int ii = 0; ii < ma; ii++)
				{
					for (int jj = 0; jj < ma; jj++)
					{
						Vec3b rgb = cur.at<Vec3b>(i + ii, j + jj);
						double k = v[ii][jj];
						sum[0] += k * int(rgb[0]);
						sum[1] += k * int(rgb[1]);
						sum[2] += k * int(rgb[2]);
					}
				}
				for (int k = 0; k < cur.channels(); k++)
				{
					if (sum[k] < 0)sum[k] = 0;
					else if (sum[k] > 255)sum[k] = 255;
				}
				m.at<Vec3b>(i, j) = Vec3b(static_cast<uchar>(sum[0]), static_cast<uchar>(sum[1]), static_cast<uchar>(sum[2]));
			}
			else if (src.channels() == 1) {
				double sum = 0;
				for (int ii = 0; ii < ma; ii++)
				{
					for (int jj = 0; jj < ma; jj++)
					{
						sum += v[ii][jj] * int(cur.at<uchar>(i + ii, j + jj));
					}
				}
				if (sum < 0)sum = 0;
				else if (sum > 255)sum = 255;
				m.at<uchar>(i, j) = static_cast<uchar>(sum);
			}
		}
	}
	string path = getFileName(filename, "拉普拉斯锐化");
	imwrite(path, m);
	return path;
}
//实现0-255归一化
void gyh(Mat &src,Mat &dst) {
	double Max = -1;
	double Min = 1 << 30;
	for (int i = 0; i < src.rows; i++)
	{
		for (int j = 0; j < src.cols; j++) {
			double t = src.at<double>(i, j);
			if (t < Min)Min = t;
			if (t > Max)Max = t;
		}
	}
	for (int i = 0; i < src.rows; i++)
	{
		for (int j = 0; j < src.cols; j++) {
			double t = src.at<double>(i, j);
			dst.at<double>(i, j) = (t-Min) / (Max - Min) * 255;
		}
	}
}
//分离傅里叶变换，得到频谱
string dft_pp(Mat &src, string filename) {
	if (src.channels() > 1) {
		src = toGray(src);
	}
	Mat m = src.clone();
	vector<vector<double>> sb(src.rows, vector<double>(src.cols));//实部
	vector<vector<double>> xb(src.rows, vector<double>(src.cols));//虚部
	//按行对y做一维DFT
	for (int x = 0; x < src.rows; x++)
	{
		for (int v = 0; v < src.cols; v++)
		{
			double sum1 = 0, sum2 = 0;
			for (int y = 0; y < src.cols; y++) {
				//频域中心化
				sum1 += src.at<uchar>(x, y)*pow(-1,x+y)*cos(2*PI*v*y/m.rows);
				sum2 += -src.at<uchar>(x, y)*pow(-1,x+y)*sin(2*PI*v*y/m.rows);
			}
			sb[x][v] = sum1;
			xb[x][v] = sum2;
		}
	}
	//按列对x做一维DFT
	for (int u = 0; u < src.rows; u++)
	{
		for (int v = 0; v < src.cols; v++)
		{
			double sum1 = 0, sum2 = 0;
			for (int x = 0; x < src.rows; x++)
			{
				sum1 += sb[x][v]*cos(2 * PI*u*x / m.rows);
				sum2 += -xb[x][v]*sin(2 * PI*u*x / m.rows);
			}
			double t = 20*log(sqrt(sum1*sum1 + sum2 * sum2));//0-255分布
			if (t > 255)t = 255;
			m.at<uchar>(u, v) = t;
		}
	}
	string path = getFileName(filename, "频谱");
	imwrite(path, m);
	return path;
}
//分离傅里叶变换，得到相位谱
string dft_xwp(Mat &src, string filename) {
	if (src.channels() > 1) {
		src = toGray(src);
	}
	Mat m(src.size(), CV_64FC1);
	vector<vector<double>> sb(src.rows, vector<double>(src.cols));//实部
	vector<vector<double>> xb(src.rows, vector<double>(src.cols));//虚部
	//按行对y做一维DFT
	for (int x = 0; x < src.rows; x++)
	{
		for (int v = 0; v < src.cols; v++)
		{
			double sum1 = 0, sum2 = 0;
			for (int y = 0; y < src.cols; y++) {
				sum1 += src.at<uchar>(x, y)*cos(2 * PI*v*y / m.rows);
				sum2 += -src.at<uchar>(x, y)*sin(2 * PI*v*y / m.rows);
			}
			sb[x][v] = sum1;
			xb[x][v] = sum2;
		}
	}
	//按列对x做一维DFT
	for (int u = 0; u < src.rows; u++)
	{
		for (int v = 0; v < src.cols; v++)
		{
			double sum1 = 0, sum2 = 0;
			for (int x = 0; x < src.rows; x++)
			{
				sum1 += sb[x][v] * cos(2 * PI*u*x / m.rows);
				sum2 += -xb[x][v] * sin(2 * PI*u*x / m.rows);
			}
			double t = atan(sum2/sum1);
			m.at<double>(u, v) = t;
		}
	}
	gyh(m, m);
	string path = getFileName(filename, "相位谱");
	imwrite(path, m);
	return path;
}
//基于Sobel算子的边缘检测
string Sobel(Mat &src, string filename) {
	int ma = 3;
	double r1[3][3] = {{ -1,-2,-1 }, { 0,0,0 }, { 1,2,1 }};
	double r2[3][3] = { {-1,0,1},{-2,0,2}, {-1,0,1} };
	if (src.channels() > 1) {
		src = toGray(src);
	}
	Mat cur = fillMat(src, ma, 1);
	Mat dst(src.size(), CV_64FC1);
	for (int i = 0; i < src.rows; i++)
	{
		for (int j = 0; j < src.cols; j++) {
			double sum1 = 0, sum2 = 0;
			for (int ii = 0; ii < ma; ii++)
			{
				for (int jj = 0; jj < ma; jj++)
				{
					sum1 += r1[ii][jj] * (double)cur.at<uchar>(i + ii, j + jj);
					sum2 += r2[ii][jj] * (double)cur.at<uchar>(i + ii, j + jj);
				}
			}
			dst.at<double>(i, j) = sqrt(sum1 * sum1 + sum2 * sum2);
		}
	}
	gyh(dst, dst);
	string path = getFileName(filename, "边缘检测");
	imwrite(path, dst);
	return path;
}
//直方图均衡化 转为灰度图
string zft(Mat &src, string filename) {
	src = toGray(src);
	int ma = 3;
	Mat m(src.rows, src.cols, src.type());
	double arr[256] = { 0 };
	ll size = m.rows*m.cols;
	for (int i = 0; i < m.rows; i++)
	{
		for (int j = 0; j < m.cols; j++){
			arr[src.at<uchar>(i, j)]++;
		}
	}
	for (int i = 0; i < 256; i++)
	{
		if(i>0)
			arr[i] = (arr[i] / size + arr[i - 1] / 255) * 255;
		else
			arr[i] = arr[i] / size  * 255;
	}
	for (int i = 0; i < m.rows; i++)
	{
		for (int j = 0; j < m.cols; j++) {
			m.at<uchar>(i,j) = (uchar) arr[src.at<uchar>(i, j)];
		}
	}
	string path1 = getFileName(filename, "直方图均衡化");
	string path2 = getFileName(filename, "灰度图");
	imwrite(path1, m);
	imwrite(path2, src);
	return path1+"::"+path2;
}
//直方图均衡化 不转为灰度图
string zft_(Mat &src, string filename) {
	int ma = 3;
	Mat m(src.rows, src.cols, src.type());
	double arr[256][3] = { 0 };
	ll size = m.rows*m.cols;
	for (int i = 0; i < m.rows; i++)
	{
		for (int j = 0; j < m.cols; j++) {
			Vec3b v = src.at<Vec3b>(i, j);
			arr[v[0]][0]++;
			arr[v[1]][1]++;
			arr[v[2]][2]++;
		}
	}
	for (int i = 0; i < 256; i++)
	{
		for (int k = 0; k < 3; k++)
		{
			if (i > 0){
				arr[i][k] = (arr[i][k] / size + arr[i - 1][k] / 255) * 255;
			}
			else
				arr[i][k] = arr[i][k] / size * 255;
		}

	}
	for (int i = 0; i < m.rows; i++)
	{
		for (int j = 0; j < m.cols; j++) {
			Vec3b v = src.at<Vec3b>(i, j);
			m.at<Vec3b>(i, j) = Vec3b(static_cast<uchar>(arr[v[0]][0]), static_cast<uchar>(arr[v[1]][1]), static_cast<uchar>(arr[v[2]][2]));
		}
	}
	string path1 = getFileName(filename, "直方图均衡化");
	imwrite(path1, m);
	return path1 ;
}
int dx[3] = { -1,0,1 };
int dy[3] = { -1,0,1 };
//区域生长
string growth(Mat &src, string filename,int px = 0, int py = 0,int d = 5) {
	Mat src_ = toGray(src);
	queue<point> q;
	q.push(point(px, py));
	vector<vector<double>> isVisited(src.rows, vector<double>(src.cols));
	for (int i = 0; i < src.rows; i++)
	{
		for (int j = 0; j < src.cols; j++) {
			isVisited[i][j]=0;
		}
	}
	isVisited[px][py] = 1;
	while (!q.empty())
	{
		point u = q.front();
		q.pop();
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < 3; j++)
			{
				if (i == 1 && j == 1) continue;
				int xx = u.x + dx[i], yy = u.y + dy[j];
				if (xx >= 0 && xx < src.rows && yy < src.cols && yy >= 0) {
					if (isVisited[xx][yy]==0 && abs(src_.at<uchar>(xx, yy) - src_.at<uchar>(u.x, u.y)) <= d ) {
						q.push(point(xx, yy));
						isVisited[xx][yy] = 1;
					}
				}
			}
		}
	}
	Mat m;
	if (getType(filename) == "png") 
		m = imread(filename, -1);
	else
		m = imread(filename);
	string filename1 = getFileName(filename, "抠图", 1);
	Mat dst(m.size(), CV_8UC4);
	for (int i = 0; i < src.rows; i++)
	{
		for (int j = 0; j < src.cols; j++) {
			if (m.channels() == 3) {
				Vec3b t = m.at<Vec3b>(i, j);
				if (isVisited[i][j]==1) {
				
					dst.at<Vec4b>(i,j) = Vec4b(t[0],t[1],t[2], 0);
				}
				else {
					dst.at<Vec4b>(i,j) = Vec4b(t[0],t[1],t[2], 255);
				}
			}
			else if (m.channels() == 4) {
				if (isVisited[i][j] == 1) {
					m.at<Vec4b>(i, j)[3] = 0;
				}
				dst.at<Vec4b>(i, j) = m.at<Vec4b>(i, j);
			}

		}
	}
	imwrite(filename1, dst);
	return filename1;
}
//
//int main() {
//	string filename = "D:\\ChromeCoreDownloads\\luna_抠图.png";
//	Mat f = imread(filename);
//	string filename1 = Sobel(f, filename);
//	Mat f1 = imread(filename1);
//	growth(f1, filename,1);
//	return 0;
//}

int main(int argc, char** argv)
{
	
	argc--;
	if (argc == 0) return 0;
	string filename = argv[1];
	int model = atoi(argv[2]);
	int filltype = 1;
	int ma = 15;
	int px = 0, py = 0, d = 5;
	if (argc == 3)
	{
		filltype = atoi(argv[3]);
	}
	if (argc == 4)
	{
		ma = atoi(argv[4]);
	}
	if (argc == 5)
	{
		px = atoi(argv[3]);
		py = atoi(argv[4]);
		d = atoi(argv[5]);
	}
	Mat frame = imread(filename);
	Mat temp;
	if (!frame.data) {
		cout << "文件不存在" << endl;
		return 0;
	}
	string path;
	switch (model)
	{
	case 1:
		path = GS1(frame, ma, filename, filltype);
		break;
	case 2:
		path = LPLS(frame, filename, filltype);
		break;
	case 3:
		path = dft_pp(frame, filename);
		break;
	case 4:
		path = dft_xwp(frame, filename);
		break;
	case 5:
		path = Sobel(frame, filename);
		break;
	case 6:
		path = zft(frame, filename);
		break;
	default:
		temp = imread(Sobel(frame, filename));
		path = growth(temp, filename, px,py,d);
	} 
	cout << path;
	return 0;
}

