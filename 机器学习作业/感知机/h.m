function [ result ] = h(w,b,X)
%感知机 模型假设
    if(w'*X+b>=0)
        result=1;
    else
        result=-1;
    end
end

