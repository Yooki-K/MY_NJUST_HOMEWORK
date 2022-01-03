%梯度下降
x = linspace(2000, 2013, 14).';
x=x/1000;
X = zeros(14,2);
x_ = zeros(15,1);
x_(1)=1;
for i = 1:14
   X(i,1)=1;
   X(i,2)=x(i);
   x_(i+1)=x(i);
end
y=[2.000,2.500,2.9,3.147,4.515,4.903,5.365,5.704,6.853,7.971,8.561,10,11.28,12.9].';
r =0;
a=0.001;
for i = 1:14
   h = BiShiJie()'*X(i,:)';
   r = r + (h-y(i))*(X(i,:)');
end

thita = BiShiJie();

for index=1:500
    for i=1:2
        thita(i) = thita(i) - a * r(i);
    end
    r=0;
    for i = 1:14
       h = (thita') * (X(i,:)');
       r = r + (h-y(i))*(X(i,:)');
    end
end
result = thita;
plot(x*1000,y,'o');hold on;
xx=[x; 2014/1000];
plot(xx*1000,(thita(1)+thita(2)*xx),'r')
y=(thita(1)+thita(2)*2.014)
xlabel('年份')
ylabel('房价')
legend('data','y=(1.0e+03*(-1.2783)+640.2273*x)')