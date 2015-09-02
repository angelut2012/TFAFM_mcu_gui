% function rangeofanalysisNI_spherical_probe()
clear
clc
close all
sensitivity=28
dt=104;% us
% para.sensitivity_PRC_ReadoutPerNM=102;
% para.probe_stiffness_nN_per_NM=40;

% para.R=500;%nm
% 
% % % sio2
% para.v_sample=0.17;
% para.v_tip=0.15;
% para.E_tip=135;%GPa

% %% bkr
% para.v_sample=0.138;
% para.v_tip=0.15;
% para.E_tip=135;%GPa
% pa='.\sensitivity_calibration_on_StainlessSteel\'
% pa='sensitivity_calibration\'
% pa='graphite_probe8\'
pa='..\bin\'

FN=dir([pa 'IndentData_SiN_no_cover_20150901170105.txt'])
% FN=dir('IndentData_KBR*.txt')%2:3%

 for n=1:length(FN)
%     n=2
    fn=[pa FN(n).name]
    fn_store{n}=fn;
%     fn='sio2\IndentDataSiO2_TriggerForce_nN1500_LoopDelay_uS3000_20150610234532.txt'
dat=importdata(fn);
if length(dat)==1
    data=dat.data;
    
    str=dat.textdata{8};
    ind=find(str=='%');
    T(n)=str2num(str(1:ind-1));
    
else
    data=dat;% compatible with old version
end  

nm=data(:,1);
data(nm==0,:)=[];
% data=data(1:end-1,:);

z_piezo_NM=data(:,1);
prc_readout=-data(:,2);

% prc_readout=prc_readout;%./para.sensitivity_PRC_ReadoutPerNM;

cfL=createFit_line_poly_N(z_piezo_NM,prc_readout,1,1)
prc_readout_drift=feval(cfL,z_piezo_NM);
prc_readout_base=prc_readout-prc_readout_drift;

plot(z_piezo_NM,prc_readout_base,'b*-')

% ind=3794:3800
cfC=createFit_line_poly_N(z_piezo_NM,prc_readout_base,1,1)


plot(z_piezo_NM-min(z_piezo_NM),'r*-')
hold on
plot(prc_readout_base-min(prc_readout_base),'b*-')

%% use indent data only
L=find(z_piezo_NM==max(z_piezo_NM))-1;
z_piezo_NM=z_piezo_NM(1:L);
prc_readout_base=prc_readout_base(1:L);

prc_readout_base=-prc_readout_base;

th=(max(prc_readout_base)-mean(prc_readout_base))*0.01281+mean(prc_readout_base);
ind=prc_readout_base>th;
prc_readout=prc_readout_base(ind);
z_piezo_NM=z_piezo_NM(ind);

% L=length(prc_readout);
% ind=round([0.1 0.9].*L);
% ind=ind(1):ind(2);
% prc_readout=prc_readout(ind);
% z_piezo_NM=z_piezo_NM(ind);

createFit_line_poly_N(z_piezo_NM-min(z_piezo_NM),prc_readout./2^18.*3.3,1,1)

grid on 
xlabel('displacement of Z actuator (nm)')
ylabel('sensor readout voltage (V)')


cfC=createFit_line_poly_N(z_piezo_NM,prc_readout,1,1)

q=feval(cfC,z_piezo_NM);
Q=prc_readout-q;


% plot(z_piezo_NM-min(z_piezo_NM),Q./89.2,'*-')
t=(1:length(Q)).*dt;%./length(Q);
% t=t./(9.46);
plot(t,Q./sensitivity,'*-')

grid on 
xlabel('time (us)')
ylabel('displacement (nm)')
K(n)=cfC.p1

title(num2str(n))
end
K=K'
T=T';
% f=1./T.*1e6;
celldisp(fn_store)
disp('sensitivity ADC18 value / nm')
disp(mean(K))
% std(K)
% close all
% figure(10)
