%ʹ��BP�㷨��5��������֤
clear
x=load('../ex4x.dat');
y=load('../ex4y.dat');
x=x/100;%��һ��
y(find(y))=0.99;
y(find(y==0))=0.01;
rowrank = randperm(size(x, 1)); % ������ҵ����֣���1~��������
x = x(rowrank, :);%����rowrank���Ҿ��������
y = y(rowrank, :);%����rowrank���Ҿ��������
results=zeros(5,1);
n=size(x,1);
a=n/5;
index=1;
for i=1:a:n
    results(index)=BP([x(1:i-1,:);x(i+a:n,:)],[y(1:i-1,:);y(i+a:n,:)],x(i:i+a-1,:),y(i:i+a-1,:));
    index=index+1;
end
plot(1:5,results,'bo');
ylabel('��ȷ��');
set(gca,'XTick',1:5);
set(gca,'XTicklabel',{'ģ��1','ģ��2','ģ��3','ģ��4','ģ��5'})