close all
% SG=load('data.txt')
load SG_data.mat
for k=1:3
    SG(:,k)=SG(:,k)-SG(end,k);
end
SG=SG(3:end,:);
V=V(3:end,:);
sgx=SG(:,1);
sgx=sgx./max(sgx);
sgy=SG(:,2);

sgy=sgy./max(sgy);
sgz=SG(:,3);

sgz=sgz./max(sgz);

figure(1)
clf

plot(V,sgx,'r.-')
hold on
plot(V,sgy,'g.-')
plot(V,sgz,'b.-')
legend('x','y','z')
grid on
title('normalized')
figure(2)
plot(sgx,'r.-')
hold on
plot(sgy,'g.-')
plot(sgz,'b.-')
grid on
legend('x','y','z')