%����ݶ��½��Ż�����5��������֤
x=load('../ex4x.dat');
y=load('../ex4y.dat');
rowrank = randperm(size(x, 1)); % ������ҵ�����
%����rowrank���Ҿ���
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
ylabel('��ȷ��');
set(gca,'XTick',1:5);
set(gca,'XTicklabel',{'ģ��1','ģ��2','ģ��3','ģ��4','ģ��5'})
