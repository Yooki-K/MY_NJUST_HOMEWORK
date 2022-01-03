%感知机
clear
x=load('../ex4x.dat');
y=load('../ex4y.dat');
[r,c]=size(x);
%w=zeros(c,1);
w=[0.2 0.2]';
b=-16;
a=0.00002;
y(~y)=-1;
pos = find(y == 1);
neg = find(y == -1);
xx=1:0.1:80;
L=[];
while(true)
    tag=0;
    index=[];
    l=0;
    for i=1:r
        temp=h(w,b,x(i,:)');
        l=l+temp*y(i);
        if(y(i)*temp<=0)
            tag=tag+1;
            index=[index i];
        end
    end
    L=[L l];
    if(tag<15)
        subplot(1,2,1)
        plot(x(pos, 1), x(pos,2), '+');hold on;
        plot(x(neg, 1), x(neg,2), 'o');hold on;
        plot(xx,(-w(1)*xx-b)/w(2))
        xlabel('Exam 1 score');ylabel('Exam 2 score');
        subplot(1,2,2)
        plot(1:size(L,2),L)
        xlabel('迭代次数');ylabel('最大似然估计');
        break;
    else
           w=w+a*y(index(fix(rand(1)*tag)+1))*x(index(fix(rand(1)*tag)+1),:)';
           b=b+a*y(index(fix(rand(1)*tag)+1));
       disp(w')
       disp(b)
       disp(tag)
       plot(x(pos, 1), x(pos,2), '+');hold on;
       plot(x(neg, 1), x(neg,2), 'o');hold on;
       plot(xx,(-w(1)*xx-b)/w(2))
       pause(0.1)
       clf
    end
end     

