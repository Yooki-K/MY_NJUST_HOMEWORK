function [ result ] = grad( r,k,X,y)
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    sum2 = 0;
    for i=1:size(y,1)
        sum2 = sum2 - h(r,k,X(i,:)')*X(i,:)';
        if(y(i)==k)
            sum2 =sum2 + X(i,:)';
        end
    end
    result = sum2;
end

