function [ field ] = Init(n,w,w_,locationPos,barrierPos)
    field=ones(n,n);
    humanRange=[1 10;5 20;30 50;1 20;40 60;50 70;10 30];
    values = ones(1,size(locationPos,2));
    for i=2:size(humanRange,1)
        number=randi([humanRange(i,1),humanRange(i,2)]);
        for j=1:number
            positive=1;
            if rand(1,1)<0.5
                positive=0.1;
            end
            individuality=[positive randi([1,4])/(1+2+3+4) randi([1,5])/(1+2+3+4+5)];
            if i==7
                values(i-1)=values(i-1) + individuality*w_;
            else
                values(i-1)=values(i-1) + individuality*w;
            end
        end
    end
    for i=1:(n*n)
        if isempty(find(locationPos==i))==1
            number=randi(humanRange(1,1),humanRange(1,2));
            for j=1:number
                positive=1;
                if rand(1,1)<0.5
                    positive=0.1;
                end
                individuality=[positive randi([1,4]) randi([1,5])];
                field(i)=field(i) + individuality*w;
            end
        else
            field(i)=values(find(locationPos==i));
        end
    end
    field(barrierPos) = Inf;   
end

