function [ lambad,w,n ] = cal( A )
%���������������������ֵ
    n=size(A,1);
    %��������һ��%
    B=repmat(sum(A),n,1);
    B=A./B;
    %�������%
    C=sum(B')';
    %��һ��%
    w=C./sum(C);
    %�������ֵ%
    lambad = mean((A*w)./w);
end

