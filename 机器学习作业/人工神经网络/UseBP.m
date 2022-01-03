%使用BP算法和5倍交叉验证
clear
x=load('../ex4x.dat');
y=load('../ex4y.dat');
x=x/100;%归一化
y(find(y))=0.99;
y(find(y==0))=0.01;
rowrank = randperm(size(x, 1)); % 随机打乱的数字，从1~行数打乱
x = x(rowrank, :);%按照rowrank打乱矩阵的行数
y = y(rowrank, :);%按照rowrank打乱矩阵的行数
results=zeros(5,1);
n=size(x,1);
a=n/5;
index=1;
for i=1:a:n
    results(index)=BP([x(1:i-1,:);x(i+a:n,:)],[y(1:i-1,:);y(i+a:n,:)],x(i:i+a-1,:),y(i:i+a-1,:));
    index=index+1;
end
plot(1:5,results,'bo');
ylabel('正确率');
set(gca,'XTick',1:5);
set(gca,'XTicklabel',{'模型1','模型2','模型3','模型4','模型5'})