function show_indentation_data(z_piezo_NM,prc_readout);
%% show data in color
    
ind_peak=find(z_piezo_NM==max(z_piezo_NM));
ind_peak=ind_peak(1);
z_piezo_NM_c{1}=z_piezo_NM(1:ind_peak);
z_piezo_NM_c{2}=z_piezo_NM(ind_peak:end);
prc_readout_c{1}=prc_readout(1:ind_peak);
prc_readout_c{2}=prc_readout(ind_peak:end);
figure(52)
clf
plot(z_piezo_NM_c{1},prc_readout_c{1},'r.-')
hold on
plot(z_piezo_NM_c{2},prc_readout_c{2},'b.-')
grid on
legend('indent','withdraw',2)
xlabel('indentation depth (nm)')
ylabel('PRC readout')
title('show indentation data')