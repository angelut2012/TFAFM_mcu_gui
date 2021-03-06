% function rangeofanalysisNI_spherical_probe()
clear
clc
close all
para.sensitivity_PRC_ReadoutPerNM=110.602534853964968%279.83%167.5%[76.9865632572905];
para.probe_stiffness_nN_per_NM=40;

para.R=435;%nm
para.v_tip=0.15;
para.E_tip=135;%GPa
% % sio2
para.v_sample=0.17;
% %% bkr
para.v_sample=0.138;
para.v_sample=0.34;

range_min_threshold=0.0511151
rangeL=0.01
rangeH=0.99
% fn='AL1_IndentData_step_size2_start_position3400_depth500_time183170476_20150519140416.txt'
% fn='su8_IndentData_step_size5_start_position5000_depth1500_time157108986_20150519124124.txt'
% fn='steel_IndentData_step_size10_start_position7500_depth2500_time152858743_20150519162638.txt'
% fn='PAVIC_CM_MSCT_D+sphere_3kPa_Gel_spot.002 - Line Plot.txt'
% fn='dish_1_IndentData_step_size2_start_position7500_depth1500_time377641600_20150518174629.txt'


% FN=dir('IndentData_KBR_20150614153217*.txt')
% FN=dir('IndentData_KBR*.txt')%2:3%
pa='graphite_probe8\'
pa=''
pa='..\bin\'
% pa='PS\'
FN=dir([pa 'IndentData_AL_20150831182042.txt'])


% for n=[4 7 8 9]%kbr
    for n=1:length(FN)
%     for n=8
%     fn=FN(n).name

%     fn='sio2\IndentDataSiO2_TriggerForce_nN1500_LoopDelay_uS3000_20150610234532.txt'
    fn=[pa FN(n).name]
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



ind_peak=find(z_tip_NM==max(z_tip_NM));
z_tip_NM_indent=z_tip_NM(1:ind_peak);
z_tip_NM_withdraw=z_tip_NM(ind_peak:end);

figure(1)
plot(z_tip_NM_indent)
title('select start contact points')
[ind_contact,b]=ginput(1);

z_tip_NM_indent_approach=z_tip_NM_indent(1:ind_contact);

n=1:length(z_tip_NM_indent_approach);
cfL=createFit_line_poly_N(n,z_tip_NM_indent_approach,1,1)
n=1:length(z_tip_NM_indent);
z_tip_NM_indent_contact_drift=feval(cfL,n);
z_tip_NM_indent_contact_correct=z_tip_NM_indent-z_tip_NM_indent_contact_drift;

z_tip_NM_indent_contact_corrected_contact=z_tip_NM_indent_contact_correct(ind_contact:end);
z_piezo_NM_indent_contact=z_piezo_NM(ind_contact:ind_peak);

figure(2)
plot(z_piezo_NM_indent_contact,z_tip_NM_indent_contact_corrected_contact)

goon
% 
% %% use ind_contact data only
% L=find_contact(z_piezo_NM==max(z_piezo_NM))-1;
% z_piezo_NM=z_piezo_NM(1:L);
% z_tip_NM_base=z_tip_NM_base(1:L);
% %% 
% th=(max(z_tip_NM_base)-mean(z_tip_NM_base))*range_min_threshold+mean(z_tip_NM_base);
% ind_contact=z_tip_NM_base>th;
% z_tip_NM_base=z_tip_NM_base(ind_contact);
% z_piezo_NM=z_piezo_NM(ind_contact);


ind_contact_depth_NM=z_piezo_NM-z_tip_NM_base;
ind_contact_force=z_tip_NM_base*para.probe_stiffness_nN_per_NM;
plot(ind_contact_depth_NM,ind_contact_force,'*-')

% 
L=find_contact(ind_contact_force==max(ind_contact_force));

D=ind_contact_depth_NM(1:L);
F=ind_contact_force(1:L);


% figure(30)
% clf
% plot(ind_contact_depth_NM-min(ind_contact_depth_NM),'r.-')
% hold on
% plot(ind_contact_force-min(ind_contact_force),'b.-')
% grid on
% D=D(1:end-2);
% F=F(1:end-2);
% E_sample=fit_youngs_modulus(D,F,para,0.1,0.9)
E_sample=fit_youngs_modulus_linear_show_simulation(D,F,para,rangeL,rangeH,fn)

end
% Eout'
out=[E_sample' range_min_threshold rangeL rangeH]
return
% 
% Lh=find_contact(ind_contact_depth_NM==max(ind_contact_depth_NM));% asysmetric
% D1=ind_contact_depth_NM(1:Lh);
% D2=ind_contact_depth_NM(Lh:end);
% 
% F1=ind_contact_force(1:Lh);
% F2=ind_contact_force(Lh:end);
% 
% %% ind_contact and withdraw selection
% FF=F1;
% DD=D1;
% %%
% th=(max(ind_contact_force)-mean(ind_contact_force))*0.02+mean(ind_contact_force);
% ind_contact=FF>th;
% %% find_contact continuous points
% ind_contact=find_contact(ind_contact==1);
% ind_contact1=find_contact(diff(ind_contact)==1);
% ind_contact=[ind_contact(ind_contact1)' ind_contact(end)];
% 
% ind_contact1=find_contact(diff(ind_contact)==1);
% ind_contact=[ind_contact(ind_contact1) ind_contact(end)]
% 
% ind_contact1=find_contact(diff(ind_contact)==1);
% ind_contact=[ind_contact(ind_contact1) ind_contact(end)]
% 
% % ind_contact=3710:3769
% % ind_contact=1246:1258
% DI=DD(ind_contact);
% FI=FF(ind_contact);
% 
% 
% 
% plot(DI,FI,'*-')
% DI=DI-min(DI);
% FI-FI-min(FI);
% figure(50)
% plot(DI,FI,'*-')
% 
% figure(30)
% clf
% subplot(211)
% plot(DI,'r.-')
% hold on
% subplot(212)
% plot(FI,'b.-')
% grid on
% legend('d','F')
% % [a,b]=ginput(2)
% 
% % 
% % return
% % 
% % figure(1)
% % plot(z_tip_NM)
% % [range_select,b]=ginput(2)
% % databegin =range_select(1);
% % trimpoint=range_select(2);
% % % % load range_select.mat
% % 
% % 
% % 
% % z_piezo_NM = z_piezo_NM(databegin:trimpoint); % choose effective interval!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;
% % z_tip_NM = z_tip_NM(databegin:trimpoint); % same as above!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;
% % z_piezo_NM = z_piezo_NM(:)-min(z_piezo_NM);
% % z_tip_NM = z_tip_NM(:)-min(z_tip_NM);
% % 
% % %% calc_no_unit_adjust
% % sensitivity=86.9
% % z_tip_NM=z_tip_NM./sensitivity;% convert adc value to m
% % % z_piezo_NM=z_piezo_NM./(1e9);
% % %%use m 
% % k=40;%N/m
% % %k = 0.01994 N/m for MSCT-D beam;
% % R = 1000; %3883.4952 radius of the tip sphere, unit ind_contact_depth_NM;
% % v_tip= 0.28;
% % E_tip=[135]
% % v_sample=0.28;
% % % E_tip=E_tip
% % 
% % % z_tip_NM=z_tip_NM./(1e9);
% % if z_tip_NM(round(length(z_tip_NM)/10))>max(z_tip_NM)
% %     z_tip_NM=max(z_tip_NM)-z_tip_NM;
% % end
% % force=-k.*(z_tip_NM);
% % z_piezo_NM=z_piezo_NM-z_tip_NM;
% % z_piezo_NM = z_piezo_NM(:)-min(z_piezo_NM);
% % 
% % save_im
% % 
% % 
% % %%
% % mag=1/max(z_piezo_NM);
% % z_piezo_NM=z_piezo_NM.*mag;
% % force=force.*mag;
% % 
% % 
% % % plot(z_piezo_NM,force)
% % % cftool(z_piezo_NM,force)
% % cf= createFit_HertzModel(z_piezo_NM, force);
% % K=cf.K
% % K=K./(mag)^1.5
% % 
% % Ex=K/4*3/R^0.5
% % E_sample=(1-v_sample^2)./(1./Ex-(1-v_tip^2)./E_tip)
% % E_out(n)=abs(E_sample);
% % end