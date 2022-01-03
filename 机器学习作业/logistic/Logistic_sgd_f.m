function [ result ] = Logistic_sgd_f(x,y,xx,yy)
%函数
%输入训练集和测试集
%随机梯度下降优化
thita=[-16 0.2 0.2]';
h = @(x,thita) 1.0 ./ (1.0 + exp(-thita'*x));
[n,~]=size(y);
%步长
a=0.000001;
%最大似然估计
num=1000;
clf
L = [];
for j=1:num  
    diff=zeros(1,3);
    temp = fix(rand(1,n/2)*(n))+1;%从数据中随机选取一半
    for i=1:n/2
        diff = diff + (y(temp(i))-h([1 x(temp(i),:)]',thita))*[1 x(temp(i),:)];
    end
    thita = thita + (a*diff');
    %最大似然估计
    l=[];
    for i=1:n
        l=[l (y(i)*log(h([1 x(i,:)]',thita))+(1-y(i)*log(1-h([1 x(i,:)]',thita))))];
    end
    L=[L max(l)];
end

subplot(1,3,1);
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
subplot(1,3,2)
plot(1:num,L);
xlabel('迭代次数');ylabel('最大似然估计');

subplot(1,3,3)
n = size(xx,1);
rights=0;
for i=1:n
    r=h([1 xx(i,:)]',thita);
    if((r>=0.5 && yy(i)==1) || (r<0.5 && yy(i)==0))
        rights=rights+1;
        if(yy(i)==1)
            plot(xx(i,1),xx(i,2),'b+','markerSize',10);hold all;
        else
            plot(xx(i,1),xx(i,2),'b.','markerSize',10)
        end
    else
        if(yy(i)==1)
            plot(xx(i,1),xx(i,2),'r+','markerSize',10)
        else
            plot(xx(i,1),xx(i,2),'r.','markerSize',10)
                end
    end
end
result = rights/n;
xlabel('Exam 1 score');ylabel('Exam 2 score');
title(['正确率为' num2str(result*100) '%'])
end

