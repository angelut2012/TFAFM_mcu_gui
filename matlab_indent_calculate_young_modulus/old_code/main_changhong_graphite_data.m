clear
close all
% E=[ 44.052473749362989
% 43.605485369012747
% 67.575286868217773
% 49.805001754100971]
% para.sensitivity_PRC_ReadoutPerNM=102;
para.probe_stiffness_nN_per_NM= 29.899999559179317;

para.R=300;%nm

% sio2
para.v_sample=0.17;
para.v_tip=0.15;
para.E_tip=135;%GPa
% bkr
para.v_sample=0.138;
para.v_tip=0.15;
para.E_tip=135;%GPa

range_min_threshold=0.021151511151
rangeL=0.0
rangeH=0.99


f='p65.xlsx'
% pa='.\sensitivity_calibration_on_StainlessSteel\'
% pa='sensitivity_calibration\'
% pa='graphite_probe8\'
% pa='..\bin\'
pa=[];
FN=dir([pa f])
% FN=dir('IndentData_KBR*.txt')%2:3%

 for n=1:length(FN)
    fn=[pa FN(n).name]
    fn_store{n}=fn;
%     fn='sio2\IndentDataSiO2_TriggerForce_nN1500_LoopDelay_uS3000_20150610234532.txt'
dat=importdata(fn);
if length(dat)==1
    data=dat.Sheet1;
    
else
    data=dat;% compatible with old version
end  

data=data.*1e9;
z_piezo_NM=data(:,1);
force=data(:,2);


z_tip_NM=force./para.probe_stiffness_nN_per_NM;

cfL=createFit_line_poly_N(z_piezo_NM,z_tip_NM,1,1)
z_tip_NM_drift=feval(cfL,z_piezo_NM);
z_tip_NM_base=z_tip_NM-z_tip_NM_drift;

plot(z_piezo_NM,z_tip_NM_base)

%% use indent data only
L=find(z_piezo_NM==max(z_piezo_NM))-1;
z_piezo_NM=z_piezo_NM(1:L);
z_tip_NM_base=z_tip_NM_base(1:L);
%% 
th=(max(z_tip_NM_base)-mean(z_tip_NM_base))*range_min_threshold+mean(z_tip_NM_base);
ind=z_tip_NM_base>th;
z_tip_NM_base=z_tip_NM_base(ind);
z_piezo_NM=z_piezo_NM(ind);


indent_depth_NM=z_piezo_NM-z_tip_NM_base;
indent_force=z_tip_NM_base*para.probe_stiffness_nN_per_NM;
plot(indent_depth_NM,indent_force,'*-')

% 
L=find(indent_force==max(indent_force));

D=indent_depth_NM(1:L);
F=indent_force(1:L);


% figure(30)
% clf
% plot(indent_depth_NM-min(indent_depth_NM),'r.-')
% hold on
% plot(indent_force-min(indent_force),'b.-')
% grid on
% D=D(1:end-2);
% F=F(1:end-2);
% E_sample=fit_youngs_modulus(D,F,para,0.1,0.9)
E_sample(n)=fit_youngs_modulus_linear_show_simulation(D,F,para,rangeL,rangeH,fn)

 end