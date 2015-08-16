sensitivity=86.9
z_tip=z_tip./sensitivity;% convert adc value to m
% z_piezo=z_piezo./(1e9);
%% use m 
k=40;%N/m
%k = 0.01994 N/m for MSCT-D beam;
R = 20; %3883.4952 radius of the tip sphere, unit nm;
v_tip= 0.28;
E_tip=[185]
v_sample=0.28;
% E_tip=E_tip

% z_tip=z_tip./(1e9);
if z_tip(round(length(z_tip)/10))>max(z_tip)
    z_tip=max(z_tip)-z_tip;
end
force=k.*(z_tip);
z_piezo=z_piezo-z_tip;
z_piezo = z_piezo(:)-min(z_piezo);



figure(2)
plot(z_piezo,force,'.-')
mag=1/max(z_piezo);
z_piezo=z_piezo.*mag;
force=force.*mag;


% plot(z_piezo,force)
% cftool(z_piezo,force)
cf= createFit_HertzModel(z_piezo, force);
K=cf.K
K=K./(mag)^1.5

Ex=K/4*3/R^0.5
E_sample=(1-v_sample^2)./(1./Ex-(1-v_tip^2)./E_tip)
E_sample=abs(E_sample)