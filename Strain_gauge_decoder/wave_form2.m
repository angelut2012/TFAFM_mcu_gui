clear
N=200;
V=(0:1/N:1)';
V=[V ; flipud(V)];
Vs=[V;V;V];

% Vr= rand(N*4,1);
V=[Vs; Vs];
t=(1:length(V))./length(V);
t=t';
w=10;
S=-0.5.*cos(2.*pi.*w.*t)+0.5;
V=[V;  S];
plot(V,'.-')
exeV=V;
% save('exeV_sin.mat','exeV')