function [ result ] = h(w,b,X)
%��֪�� ģ�ͼ���
    if(w'*X+b>=0)
        result=1;
    else
        result=-1;
    end
end

