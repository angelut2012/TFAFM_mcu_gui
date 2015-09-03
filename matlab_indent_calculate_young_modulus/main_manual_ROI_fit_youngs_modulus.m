% function rangeofanalysisNI_spherical_probe()
clear
clc
close all
para.sensitivity_PRC_ReadoutPerNM=38.19252768;%41.659518789132420%41.4506;%%110.602534853964968%279.83%167.5%[76.9865632572905];
para.probe_stiffness_nN_per_NM=40;

para.R=200;%nm
para.v_tip=0.15;
para.E_tip=135;%GPa
% % sio2
para.v_sample=0.17;
% %% bkr
para.v_sample=0.138;
para.v_sample=0.34;
% graphite
para.v_sample=0.2;
%%%%%%%%%%%%%%%%%%%%%%%%%
pa='..\AFM_GUI_solution\bin\'
filename='IndentData.txt'
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
    %% convert and use extend data
    [Displacement,Force]=convert_ZpiezoNMPRCreadout_to_DisplacementForce(z_piezo_NM_c{1},prc_readout_adjusted_c{1},para.sensitivity_PRC_ReadoutPerNM,para.probe_stiffness_nN_per_NM);
    %% select select indentation roi    
    %[sDisplacement,sForce,ind]=manual_select_curve_roi(Displacement,Force,'select indentation roi');
    [sDisplacement,sForce,ind]=manual_select_line_roi(Displacement,Force,'select indentation roi');
    %% calculate young's modulus
    Esample(n)=fit_youngs_modulus_linear_show_simulation(sDisplacement,sForce,para,0,1,para.fn)
end