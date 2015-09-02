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

FN=dir([pa 'IndentData_SiN_no_cover_20150901164842.txt'])
% FN=dir('IndentData_KBR*.txt')%2:3%

for n=1:length(FN)
    %     n=2
    fn=[pa FN(n).name]
    fn_store{n}=fn;
    %% read data
    [z_piezo_NM,prc_readout,paras]=read_indentation_file(fn);
    prc_readout=-prc_readout;
    %% level_indentation_data
    [z_piezo_NM_c,prc_readout_adjusted_c]=level_indentation_data(z_piezo_NM,prc_readout);
    %%  calculate sensitivity and vibration noise
    [Sensitivity(n),noise_rms_nm(n)]=calculate_sensitivity_vibration_noise(z_piezo_NM_c{1},prc_readout_adjusted_c{1},paras);
end