function E_sample=fit_youngs_modulus_linear_show_simulation(D,F,para,rangeL,rangeH,title_name)
D=D-min(D);
F=F-min(F);
E_sample=fit_youngs_modulus_linear(D,F,para,rangeL,rangeH)
% Eout(n)=fit_youngs_modulus(D,F,para)

N=1000;
D_sim=(0:N)./N.*(max(D));
F_sim=calc_force_distance_curve(D_sim,E_sample,para);
figure(10)
clf
plot(D,F,'b.-')
hold on
plot(D_sim,F_sim,'r-')
grid on
legend('experimental data','simulated curve')
title(title_name,'Interpreter','non')
xlabel( 'indent depth (nm)' );
ylabel( 'force (nN)' );