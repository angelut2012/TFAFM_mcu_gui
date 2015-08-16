sensitivity=86.9e9
z_tip=z_tip./sensitivity;% convert adc value to m
z_piezo=z_piezo./(1e9);
%% use m 
k=40;%N/m
%k = 0.01994 N/m for MSCT-D beam;
R = 2000e-9; %3883.4952 radius of the tip sphere, unit nm;
v_tip= 0.28;
E_tip=[185]*1e9
v_sample=0.28;
% E_tip=E_tip

% z_tip=z_tip./(1e9);

force=k.*(z_tip);
z_piezo=z_piezo-z_tip;
z_piezo = z_piezo(:)-min(z_piezo);

mag=1e3;
z_piezo=z_piezo.*mag;
force=force.*mag;


% plot(z_piezo,force)
% cftool(z_piezo,force)
cf= createFit_HertzModel(z_piezo, force);
K=cf.K./(mag)^1.5

Ex=K/4*3/R^0.5
E_sample=(1-v_sample^2)./(1./Ex-(1-v_tip^2)./E_tip)
E_sample=E_sample./1e18