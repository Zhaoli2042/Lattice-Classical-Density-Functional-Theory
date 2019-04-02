%count single point energy
function [e,abcd]=count_rou_NN(x,y,rou)
w=0;
size1=size(rou); sizeL=size1(2);sizeH=size1(1);
sum=0;
if y==1
    w=1;
else 
    down=y-1;
end
if y==sizeH
    w=1;
else
    up=y+1;
end
if x==1
    left=sizeL;
else 
    left=x-1;
end
if x==sizeL
    right=1;
else
    right=x+1;
end
if w==0
    summ=rou(y,left)+rou(y,right)+rou(up,x)+rou(down,x);
else
    if y==1
        summ=rou(y,left)+rou(y,right)+rou(up,x);
    elseif y==sizeH
        summ=rou(y,left)+rou(y,right)+rou(down,x);
    end
end
e=summ;
abcd=w;