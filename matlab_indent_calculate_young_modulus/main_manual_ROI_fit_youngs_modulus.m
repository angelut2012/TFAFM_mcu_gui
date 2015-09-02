% function rangeofanalysisNI_spherical_probe()
clear
clc
close all
para.sensitivity_PRC_ReadoutPerNM=41.4506;%%110.602534853964968%279.83%167.5%[76.9865632572905];
para.probe_stiffness_nN_per_NM=40;

para.R=435;%nm
para.v_tip=0.15;
para.E_tip=135;%GPa
% % sio2
para.v_sample=0.17;
% %% bkr
para.v_sample=0.138;
para.v_sample=0.34;

%%%%%%%%%%%%%%%%%%%%%%%%%
pa='..\bin\'
filename='IndentData_SiN_no_cover_20150901170105.txt'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FN=dir([pa filename])
for n=1:length(FN)
    %     n=2
    fn=[pa FN(n).name]
    fn_store{n}=fn;
    para.fn=fn;
    %% read data
    [z_piezo_NM,prc_readout,paras]=read_indentation_file(fn);
    prc_readout=-prc_readout;
    %% show data in color
    show_indentation_data(z_piezo_NM,prc_readout);
    
    %% level_indentation_data
    [z_piezo_NM_c,prc_readout_adjusted_c]=level_indentation_data(z_piezo_NM,prc_readout);
%     %%  calculate sensitivity and vibration noise
%     [Sensitivity(n),noise_rms_nm(n)]=calculate_sensitivity_vibration_noise(z_piezo_NM_c{1},prc_readout_adjusted_c{1},paras);

    Esample(n)=calc_youngs_modulus(z_piezo_NM_c{1},prc_readout_adjusted_c{1},para)
end