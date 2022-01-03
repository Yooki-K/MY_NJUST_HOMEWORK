function [ result ] = h(r,j,X )
%softmax Ä£ÐÍ¼ÙÉè
    sum1 = 0;
    for jj=1:size(r,2)
        sum1 = sum1 + exp(r(:,jj)'*X);
    end
    result = exp(r(:,j)'*X)/sum1;
end

