clear
close all

%% parameter
para.sensitivity_PRC_ReadoutPerNM=102;
para.probe_stiffness_nN_per_NM=36.4;

para.R=100;%nm

% sio2
para.v_sample=0.17;
para.v_tip=0.15;
para.E_tip=135;%GPa
% bkr
para.v_sample=0.138;
para.v_tip=0.15;
para.E_tip=135;%GPa


for k=1:5
% f=['sio'    num2str(k) 'i.txt']
f=['kbr'    num2str(k) 'i.txt']
c0=load(f);
c=c0.*1e9;
% c=c0;
dep=c(:,1);
F=c(:,2);

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

Eout(k)=fit_youngs_modulus_linear(depc,Fc,para)
title(f)

end
Eout'