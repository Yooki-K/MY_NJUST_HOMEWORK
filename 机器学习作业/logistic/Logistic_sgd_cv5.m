%随机梯度下降优化，加5倍交叉验证
x=load('../ex4x.dat');
y=load('../ex4y.dat');
rowrank = randperm(size(x, 1)); % 随机打乱的数字
%按照rowrank打乱矩阵
x = x(rowrank, :);
y = y(rowrank, :);
results=zeros(5,1);
n=size(x,1);
a=n/5;
index=1;
for i=1:a:n
    results(index)=Logistic_sgd_f([x(1:i-1,:);x(i+a:n,:)],[y(1:i-1,:);y(i+a:n,:)],x(i:i+a-1,:),y(i:i+a-1,:));
    w = waitforbuttonpress;
    index=index+1;
end
clf
plot(1:5,results,'b.','markerSize',10);
ylabel('正确率');
set(gca,'XTick',1:5);
set(gca,'XTicklabel',{'模型1','模型2','模型3','模型4','模型5'})
