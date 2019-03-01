%refined LDFT(2D)

%Wall Effect & Any size of lattice

%x direction: Periodic; y direction: Walls
clear all 
clc
L=50;                             %x direction length
H=70;                             %y direction height
Z=4;                              %coord number
bw=1;                             %wall interaction
mu=-2;
rT=1.5;
rou_new=zeros(H,L);
initial_guess=0.2;                %initial guess of rou_old
rou_old=zeros(H,L)+initial_guess;
count=0;
maximum=0.5;
while (maximum>0.0000001)
    maximum=0;
    count=count+1;
    if count>1
        rou_old=rou_new;
    end
    for x=1:1:L                   % x here means columns, y means rows
        for y=1:1:H               %rou_new(y,x) actually means coordinate(x,y) in the matrix, sometimes can confuse people
            [sum,w]=count_rou_NN(x,y,rou_old);
            if w==0
                rou_new(y,x)=1/(1+exp(-mu/rT-1/rT*sum));
            else
                rou_new(y,x)=1/(1+exp(-mu/rT-bw/rT-1/rT*sum));
            end
            diff=rou_new(y,x)-rou_old(y,x);
            maximum=max(abs(diff),maximum);
        end
    end
end

var1=mean(mean(rou_new));
var2=mean(mean(rou_old));
fprintf('Computed New Density is %d \n Old Density is %d',var1,var2)
computed_mu=-Z*var1+rT*log(var1/(1-var1))
x_axis=linspace(0,H,H);
se=randi(L);
y_axis=rou_new(:,se);
plot(x_axis,y_axis)
yy_axis=linspace(0,L,L);
mu_1=zeros(H,L);
for x=1:1:L
    for y=1:1:H
        [sum,w]=count_rou_NN(L/2,y,rou_new);
        if (w==1)
            mu1=rT*log(rou_new(y,x)/(1-rou_new(y,x)))-sum-bw;
        else
            mu1=rT*log(rou_new(y,x)/(1-rou_new(y,x)))-sum;
        end
        mu_1(y,x)=mu1;
    end
end
surf(yy_axis,x_axis,mu_1)

