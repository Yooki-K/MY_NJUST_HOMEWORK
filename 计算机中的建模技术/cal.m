function [ lambad,w,n ] = cal( A )
%计算特征向量和最大特征值
    n=size(A,1);
    %列向量归一化%
    B=repmat(sum(A),n,1);
    B=A./B;
    %横向求和%
    C=sum(B')';
    %归一化%
    w=C./sum(C);
    %最大特征值%
    lambad = mean((A*w)./w);
end

