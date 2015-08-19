clear
close all
N=4300;
T=10*pi;
t=(0:N)./N.*T;
w1=0.5
w2=w1*50
y=0.8.*sin(w1.*t+pi/2)+0.2.*sin(w2.*t+pi/4);
y=y./2+0.5;
y=1-y;
y=sin(y);
y=normalize(y);
ind=find(y<=0.01)
y=y(ind(1):ind(end));
y(1)=0;
y(end)=0;

n=0.1.*rand(1,length(y));
y=y+n;
y=normalize(y);

N=20;
t=(0:N)./N;
exeV=[t, fliplr(t) y t, fliplr(t)];
exeV=exeV';
plot(exeV,'.-')
% save('exeV_sin.mat','exeV')
save('exeV.mat','exeV')