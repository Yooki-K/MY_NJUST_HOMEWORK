%softmax 梯度下降
clear
x=load('../ex4x.dat');
y=load('../ex4y.dat');
X=[ones(size(x,1),1),x];
[r,c]=size(x);
thita=zeros(c,c+1)';
a=0.0000001;
L = [];
num=500;
for index=1:num
    for k=1:c-1
        thita(:,k)=thita(:,k)+a*grad(thita,k,X,y);
    end
    l=0;
    for i=1:r
        for j=1:c
            if(y(i)==j)
                l=l+log(h(thita,j,X(i,:)'));
            end
        end
    end
    L = [L l];
end
subplot(1,3,1);
pos = find(y == 1);
neg = find(y == 0);
plot(x(pos, 1), x(pos,2), 'ro');hold on;
plot(x(neg, 1), x(neg,2), 'ko');
xlabel('Exam 1 score');ylabel('Exam 2 score');
title('data')
subplot(1,3,2);
for i=1:r
    h(thita,1,X(i,:)')
   if(h(thita,1,X(i,:)')>=0.542)
       plot(x(i, 1), x(i,2), 'r+');hold on;
   else
       plot(x(i, 1), x(i,2), 'k+');hold on;
   end
   
end
title('模型得出')
xlabel('Exam 1 score');ylabel('Exam 2 score');
subplot(1,3,3)
plot(1:num,L);
xlabel('迭代次数');ylabel('最大似然估计');