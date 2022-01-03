function [result]=BP(x,y,xx,yy)
%使用BP算法
    d=size(x,2);
    n=size(x,1);
    l=size(y,2);
    q=2;
    v=rand(d,q); w=rand(q,l); thita=rand(l,1); r=rand(q,1);%参数初始化
    a=0.000001;%学习率
    sigmoid = @(x) 1.0 ./ (1.0 + exp(-x));
    E=[];
    num=6000;
    for index=1:num
        Y=zeros(n,l);
        e=0;
        for k=1:n
            beta=zeros(1,l);
            b=zeros(l,q);
            errorOut=zeros(1,l);
            errorHidden=zeros(l,q);
            for j=1:l
                for h=1:q
                    arfa=0;
                    for i=1:d
                        arfa=arfa+v(i,h)*x(k,i);
                    end
                    b(j,h)=sigmoid(r(h)+arfa);
                    beta(j)=beta(j)+w(h,j)*b(j,h);
                end
                Y(k,j)=sigmoid(beta(j)+thita(j));
                errorOut(j)=Y(k,j)-y(k,j)*Y(k,j)*(1-Y(k,j));
                for h=1:q
                    errorHidden(j,h)=errorOut(j)*w(h,j)*b(j,h)*(1-b(j,h));
                end
            end
            for j=1:l
                diffThita=errorOut(j);
                thita(j)=thita(j)-a*diffThita;
                for h=1:q
                    diffW=errorOut(j)*b(j,h);
                    diffR=errorHidden(j,h);
                    w(h,j)=w(h,j)-a*diffW;
                    r(h)=r(h)-a*diffR;
                    for i=1:d
                        diffV=errorHidden(j,h)*x(k,i);
                        v(i,h)=v(i,h)-a*diffV;
                    end
                end
            end
            e=e+0.5*sum((Y(k)-y(k)).^2);
        end
        E=[E e];
    end
    if(isempty(yy))
        subplot(1,2,1);
        pos = find(y == 0.99);
        neg = find(y == 0.01);
        plot(x(pos, 1), x(pos,2), '+');hold on;
        plot(x(neg, 1), x(neg,2), 'o');
        xlabel('Exam 1 score');ylabel('Exam 2 score');
        subplot(1,2,2)
        plot(1:num,E)
        xlabel('迭代次数');ylabel('损失函数');
    end
    nn=size(xx,1);
    result=0;
    for k=1:nn
        for j=1:l
            beta=0;
            for h=1:q
                arfa=0;
                for i=1:d
                    arfa=arfa+v(i,h)*xx(k,i);
                end
                b=sigmoid(r(h)+arfa);
                beta=beta+w(h,j)*b;
            end
            YY(k,j)=sigmoid(beta+thita(j));
            if(~isempty(yy))
                if((YY(k,j)>0.5&&yy(k,j)==0.99)||(YY(k,j)<0.5&&yy(k,j)==0.01))
                    result=result+1;
                end
            end
        end
    end
    result=result/nn;
end