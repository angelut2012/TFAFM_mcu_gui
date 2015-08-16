clear
close all
clc
% function AFM_show_indent_data()
F=dir('*.txt')

for k=1%:length(F)
% f=F(k).name

% f='IndentData_step_size5_start_position7500_depth1500_time184840572_20150518174748.txt'
% f='su8_2\IndentData_step_size2_start_position5100_depth950_time231953267_20150519125723.txt'
% data=load(f);

fn=('..\bin\IndentData.txt');
dat=importdata(fn);
if length(dat)==1
    data=dat.data;
else
    data=dat;% compatible with old version
end
nm=data(:,1);
data(nm==0,:)=[];
% data=data(1:end-1,:);
data=data(20:end-20,:);
nm=data(:,1);
prc=data(:,2);

nm=nm-nm(1);
prc=prc-prc(1);
ft=createFit_line_poly_N(nm,prc,1)
L=length(nm);
Lh=round(L/2);
nm1=nm(1:Lh);
nm2=nm(1+Lh:end);

prc1=prc(1:Lh);
prc2=prc(1+Lh:end);
% ind=(nm~=0);
% nm=data(ind,1);
% prc=data(ind,2);
% prc(prc>5e6)=nan;

figure(4)
clf
% plot(nm,prc,'.-')
plot(nm1,prc1,'r.-')
hold on
plot(nm2,prc2,'b.-')
grid on
legend('indent','withdraw')
xlabel('nm')
ylabel('PRC')
% figure(5)
% clf
% plot(nm,'r.-')
% hold on
% plot(prc,'b.-')
% grid on
end