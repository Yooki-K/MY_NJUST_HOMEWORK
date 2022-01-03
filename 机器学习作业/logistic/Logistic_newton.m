%牛顿法优化
x=load('../ex4x.dat');
y=load('../ex4y.dat');

thita=[0 0 0]';
h = @(x,thita) 1.0 ./ (1.0 + exp(-thita'*x));
[n,~]=size(y);
x=[ones(n,1) x];
%最大似然估计
L=[];
num=15;
for j=1:num
    A=zeros(n,n);
    temp=zeros(n,1);
    for i=1:n
        A(i,i)=h(x(i,:)',thita)*(1-h(x(i,:)',thita));
        temp(i)=h(x(i,:)',thita);
    end
    Hession = x'*A*x;
    J = x'*(y-temp);
    thita = thita + (inv(Hession)*J);
    l=[];
    for i=1:n
        l=[l y(i)*log(h(x(i,:)',thita))+(1-y(i))*log(1-h(x(i,:)',thita))];
    end
    L=[L max(l)];
end
subplot(1,2,1);
pos = find(y == 1);
neg = find(y == 0);
plot(x(pos, 2), x(pos,3), '+');hold on;
plot(x(neg, 2), x(neg,3), 'o');
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
thita
