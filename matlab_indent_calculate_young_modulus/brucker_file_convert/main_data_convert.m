% function rangeofanalysisNI_spherical_probe()
clear
clc
close all
para.sensitivity_PRC_ReadoutPerNM=102;
para.probe_stiffness_nN_per_NM=40;

para.R=300;%nm

% % sio2
% para.v_sample=0.17;
% para.v_tip=0.15;
% para.E_tip=135;%GPa

% %% bkr
para.v_sample=0.138;
para.v_tip=0.15;
para.E_tip=135;%GPa


% fn='AL1_IndentData_step_size2_start_position3400_depth500_time183170476_20150519140416.txt'
% fn='su8_IndentData_step_size5_start_position5000_depth1500_time157108986_20150519124124.txt'
% fn='steel_IndentData_step_size10_start_position7500_depth2500_time152858743_20150519162638.txt'
% fn='PAVIC_CM_MSCT_D+sphere_3kPa_Gel_spot.002 - Line Plot.txt'
% fn='dish_1_IndentData_step_size2_start_position7500_depth1500_time377641600_20150518174629.txt'
FN=dir('data*.txt')
FN=dir('IndentData_KBR*.txt')%2:3%

% for n=[4 7 8 9]%kbr
    for n=1:length(FN)
%     n=6
    fn=FN(n).name
%     fn='sio2\IndentDataSiO2_TriggerForce_nN1500_LoopDelay_uS3000_20150610234532.txt'
dat=importdata(fn);
if length(dat)==1
    data=dat.data;
else
    data=dat;% compatible with old version
end  
nm=data(:,1);
data(nm==0,:)=[];
% data=data(1:end-1,:);

z_piezo_NM=data(:,1);
prc_readout=data(:,2);

z_tip_NM=prc_readout./para.sensitivity_PRC_ReadoutPerNM;
    
figure(1)
plot(z_piezo_NM,z_tip_NM)
end