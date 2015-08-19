clear
load('SG_data.mat')
y=SG(:,2);
z=SG(:,3);
% Y=y-z;
Y=y;
Y=Y-min(Y);
Y=Y./max(Y);
Y=Y.*9500;
plot(Y,'*-')
z=z-mean(z);
z=z./7.8;
plot(z,'*-')
a=Y(2:100:end);
 plot(a,'*-')