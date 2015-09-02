function [z_piezo_NM_c,prc_readout_adjusted_c]=level_indentation_data(z_piezo_NM,prc_readout);
ind_peak=find(z_piezo_NM==max(z_piezo_NM));
z_piezo_NM_c{1}=z_piezo_NM(1:ind_peak);
z_piezo_NM_c{2}=z_piezo_NM(ind_peak:end);
prc_readout_c{1}=prc_readout(1:ind_peak);
prc_readout_c{2}=prc_readout(ind_peak:end);

%% select flat roi for adjusting leveling
[sx,sy,ind]=manual_select_curve_roi(z_piezo_NM_c{1},prc_readout_c{1},'select flat roi');

%% adjust leveling
cfL=createFit_line_poly_N(sx,sy,1);
clear sx sy
prc_readout_drift=feval(cfL,z_piezo_NM);
prc_readout_adjusted=prc_readout-prc_readout_drift;

prc_readout_adjusted_c{1}=prc_readout_adjusted(1:ind_peak);
prc_readout_adjusted_c{2}=prc_readout_adjusted(ind_peak:end);
end