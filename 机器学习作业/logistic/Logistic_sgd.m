%随机梯度下降优化
x=load('../ex4x.dat');
y=load('../ex4y.dat');
thita=[-16 0.2 0.2]';
h = @(x,thita) 1.0 ./ (1.0 + exp(-thita'*x));
[n,~]=size(y);
%步长
a=0.000001;
%最大似然估计
L=[];
num=500;
for j=1:num  
    diff=zeros(1,3);
    temp = fix(rand(1,40)*(80))+1;
    for i=1:40
        diff = diff + (y(temp(i))-h([1 x(temp(i),:)]',thita))*[1 x(temp(i),:)];
    end
    thita = thita + (a*diff');
    l=[];
    for i=1:n
        l=[l (y(i)*log(h([1 x(i,:)]',thita))+(1-y(i)*log(1-h([1 x(i,:)]',thita))))];
    end
    L=[L max(l)];
end
thita
subplot(1,2,1);
pos = find(y == 1);
neg = find(y == 0);
plot(x(pos, 1), x(pos,2), '+');hold on;
plot(x(neg, 1), x(neg,2), 'o');
xlabel('Exam 1 score');ylabel('Exam 2 score');
rx=linspace(1,80,40)';
[row,~] = size(rx);
ry=zeros(row,1);
for i=1:row
    ry(i,1)=-thita(2,1)/thita(3,1)*rx(i,1)-thita(1,1)/thita(3,1);
end
hold on;
plot(rx,ry,1,[1 0 0]);
subplot(1,2,2)
plot(1:num,L);
xlabel('迭代次数');ylabel('最大似然估计');
