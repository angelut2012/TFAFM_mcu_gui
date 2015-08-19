close all
clear
% SG=load('data.txt')
f='SG_data_triangle_sin_double_sine_noise.mat'
load(f)
% V(1)=[];
% V=V';
V=V./150;
for k=1:3
    SG(:,k)=SG(:,k)-SG(end,k);
end
% st=2
% SG=SG(st:end,:);
% V=V(st-1:end-1,:);
% SG=SG(1800:end,:);
% V=V(1800:end,:);




sgx=SG(:,1);

sgy=SG(:,2);
sgz=SG(:,3);


sgx=normalize(sgx);
sgy=normalize(sgy);
sgz=normalize(sgz);
sgx=sgx-mean(sgx)+mean(V);
% sgx=sgx./max(sgx);
% sgy=sgy./max(sgy);
% sgz=sgz./max(sgz);

% show_data_manual_adjust

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

figure(3)
clf

plot(V,'r.-')

hold on
plot(sgx,'g.-')
exeV=V;
save(['processed_' f],'exeV','sgx','sgy','sgz')


%%%%%%%%%%%%%%%%%%%%%%%%%
ExcitationVoltage=sgx;
num_data = length(V);
range=1:num_data;
data_error = abs(V-ExcitationVoltage);

figure(10)
subplot(2,1,1)
title('actual output and model output');
plot(range,V,'b',range,ExcitationVoltage,'r');
legend('position input','Sensor output','Location','NorthEast');
grid on 

axis([1 num_data 0 max(ExcitationVoltage)])
subplot(2,1,2)
plot(range,data_error,'r.');
legend('position error','Location','NorthEast');
grid on 
% axis([1 num_data 0 max(data_error)])
axis([1 num_data 0 0.1])
figure(11)
hist(data_error,0:0.01:0.15)
xlabel('position error')
grid on
d=data_error;
mean(d)
std(d)
