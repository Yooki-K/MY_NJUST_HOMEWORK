function [ result ] = BiShiJie()
%UNTITLED 闭式解
%   此处显示详细说明
    x = linspace(2000, 2013, 14).';
    X = zeros(14,2);
    for i = 1:14
       X(i,1)=1;
       X(i,2)=x(i);
    end
    y=[2.000,2.500,2.9,3.147,4.515,4.903,5.365,5.704,6.853,7.971,8.561,10,11.28,12.9].';
    r = inv(X'*X)*X'*y;
    result = r;
    %plot(x,y,'o');hold on;
    %xx=[x; 2014];
    %plot(xx,(1.0e+03) * (-1.5969)+0.7990*xx,'r')
    %xlabel('年份')
    %ylabel('房价')
    %legend('data','y=(1.0e+03)*(-1.5969)+0.7990*x)')
end

