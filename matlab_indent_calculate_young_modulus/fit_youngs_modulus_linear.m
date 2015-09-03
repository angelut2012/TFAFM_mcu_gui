%%
function E_sample=fit_youngs_modulus_linear(distance, force,para,rangeL,rangeH)
R=para.R;
v_sample=para.v_sample;
v_tip=para.v_tip;
E_tip=para.E_tip;

L=length(force);
% ind=round([0.1 0.9].*L);
ind=round([rangeL rangeH].*L);
if ind(1)==0
    ind(1)=1;
end
ind=ind(1):ind(2);
distance=distance(ind);
force=force(ind);

distance=distance-distance(1);
% cftool(distance, force)
%% linearized hertz model
L_force=force.^(2/3);
[cfL,fh]=createFit_line_poly_N(distance, L_force,1,54);
K=cfL.p1^(3/2);
%% hertz model
% cf= createFit_HertzModel(distance, force);
% K=cf.K
% K=K./(mag)^1.5

Ex=K/4*3/sqrt(R);
E_sample=(1-v_sample^2)./(1./Ex-(1-v_tip^2)./E_tip);
% E_sample=(1-v_sample^2).*Ex;
% E_out(k)=abs(E_sample)

title('fit youngs modulus linear')
grid on
legend('experimental data','curve fit')
% title(title_name,'Interpreter','non')
xlabel( 'indent depth (nm)' );
ylabel( 'force.^{(2/3)} (nN)' );