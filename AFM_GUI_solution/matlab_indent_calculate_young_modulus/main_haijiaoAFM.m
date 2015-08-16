clear
close all

%% parameter
para.sensitivity_PRC_ReadoutPerNM=102;
para.probe_stiffness_nN_per_NM=0.106;

para.R=50;%nm

% sio2
para.v_sample=0.3;
para.v_tip=0.15;
para.E_tip=135;%GPa
% bkr
para.v_sample=0.138;
para.v_tip=0.15;
para.E_tip=135;%GPa


for k=1
% f=['sio'    num2str(k) 'i.txt']

f='AFM.txt'%2:3%

c0=load(f);
% c=c0.*1e9;
c=c0;
dep=-c(:,1).*1e3;
F=c(:,2);
dep=flipud(dep);
F=flipud(F);
cfL=createFit_line_poly_N(dep,F,1,1)

grid on
xlabel( 'indent depth (nm)' );
ylabel( 'force (nN)' );

Fj=feval(cfL,dep);
F=F-Fj;
th=(max(F)-mean(F))*0.01+mean(F);
ind=F>th;
depc=dep(ind);
Fc=F(ind);
figure(2)
clf
plot(dep,F,'.-')
grid on
hold on
plot(depc,Fc,'r.-')
grid on
xlabel( 'indent depth (nm)' );
ylabel( 'force (nN)' );

%%
% depc=max(depc)-depc;
depc=depc-min(depc);
figure(3)
plot(depc,Fc,'r.-')
grid on
xlabel( 'indent depth (nm)' );
ylabel( 'force (nN)' );

%% hertz model

Eout(k)=fit_youngs_modulus(depc,Fc,para)
title(f)

end
Eout*1e3