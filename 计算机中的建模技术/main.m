clc,clear,close all;
%计算权重
clc
A=[1 5 2;1/5 1 1/3;1/2 3 1];
%餐厅的成对比较表
A_=[1 4 5;
    1/4 1 3;
    1/5 1/3 1;];
[lambad,w,n] = cal(A);
[lambad_,w_,n_] = cal(A_);
re=[lambad,n;lambad_,n_;];
isOK=1;
%一致性检验%
for i=1:size(re,1)
    RI=0.58;
    if ((re(i,1)-re(i,2))/(re(i,2)-1))/RI>=0.1
        sprintf('%d 不通过一致性检验',i)
        isOK=0;
    else
        sprintf('%d 通过一致性检验',i)
    end
end
if isOK==0
    return
end

%创建地图
n = 5;   
startposind=1;
goalposind=25;
barrierPos=[7 8 10 17 19];
locationPos=[4 12 14 16 18 22];
locationName=['公交站' '菜市场' '便利店' '医院 ' '地铁站' '餐厅 '];
field = Init(n,w,w_,locationPos,barrierPos);
field(startposind) = 0; field(goalposind) = 0;  %把矩阵中起始点和终止点处的值设为0
all = sum(field(field<Inf));
field=field/all; 
%进行地图的绘制
if isempty(gcbf)                                 
    figure('Position',[460 65 700 700]);
    axes('position', [0 0 1 1]);%设置坐标轴的位置
else
    gcf; cla;
end
pcolor(1:n+1,1:n+1,[field field(:,end); field(end,:) field(end,end)]);

cmap = flipud(colormap('summer'));  
cmap(1,:) = zeros(3,1); cmap(end,:) = ones(3,1); 
colormap(flipud(cmap)); %进行颜色的倒转 
hold on;
[goalposy,goalposx] = ind2sub([n,n],goalposind);
[startposy,startposx] = ind2sub([n,n],startposind);
text(goalposx+0.5,goalposy+0.5,'B点','HorizontalAlignment','center');
text(startposx+0.5,startposy+0.5,'A点','HorizontalAlignment','center');
for i=1:size(locationPos,2)
    [y,x] = ind2sub([n,n],locationPos(i));
    text(x+0.5,y+0.5,locationName((i-1)*3+1:(i-1)*3+3),'HorizontalAlignment','center');
end
%转换成邻接矩阵
p=n*n;
G = ones(p,p)*Inf;
for i=1:n
    for j=1:n
        if field(i,j)<Inf
            ind = sub2ind([n n],i,j);
            if i>1 && field(i-1,j)<Inf
                ind_=sub2ind([n n],i-1,j);
                G(ind,ind_)=field(i-1,j);
            end
            if j>1 && field(i,j-1)<Inf
                ind_=sub2ind([n n],i,j-1);
                G(ind,ind_)=field(i,j-1);
            end
            if i<n && field(i+1,j)<Inf
                ind_=sub2ind([n n],i+1,j);
                G(ind,ind_)=field(i+1,j);
            end
            if j<n && field(i,j+1)<Inf
                ind_=sub2ind([n n],i,j+1);
                G(ind,ind_)=field(i,j+1);
            end
        end
    end
end
for i=1:p
    G(i,i)=0;
end

% 初始化操作
S(1) = goalposind;
U = 1:p;
U(goalposind) = [];         
Value = zeros(2,p);  
Value(1,:) = 1:p;   
Value(2,1:p) = G(goalposind,1:p); 
new_Distance = Value;
D = Value;           
D(:,goalposind) = []; 
path = zeros(2,p);  
path(1,:) = 1:p;   
path(2,Value(2,:)~=inf) = goalposind; 
 
% 寻找最安全路径
while ~isempty(U)  
    index = find(D(2,:)==min(D(2,:)),1);
    k = D(1,index); 
    S = [S,k];     
    U(U==k) = [];
    new_Distance(2,:) = G(k,1:p)+Value(2,k); 
    D = min(Value,new_Distance); 
    %更新路径
    path(2,D(2,:)~=Value(2,:)) = k;
    Value = D;  
    D(:,S) = [];   
end
%总共风险值
All = Value(2,startposind);  
% 绘制安全路径
pxs=[1];
pys=[1];
v=[0];
while startposind ~= goalposind    
    next = path(2,startposind);    
    startposind = next;            
    [py,px]=ind2sub([n n],next);
    pxs=[pxs;px];
    pys=[pys;py];
    v=[v;field(py,px)];
end
plot(pxs+0.5,pys+0.5,'Color','red','LineWidth',4); 
drawnow;
drawnow;
V = max(v);
VV = max(field(field<Inf));
result='';
if V==0 && VV==0
    result='选择不带口罩';
else
    if V/VV>0.8 && V>0.7
        result='选择穿防护服';
    else
        if V/VV>0.8
            result='选择带N95口罩';
        else
            result='选择带普通口罩';
        end
    end
end
hold on;
text(goalposx+0.5,goalposy+0.2,result,'HorizontalAlignment','center');
field
 