function force=calc_force_distance_curve(D,E_sample,para)
Ex=1/((1-para.v_tip^2)/para.E_tip+(1-para.v_sample^2)/E_sample);
force=4/3*Ex*sqrt(para.R).*D.^1.5;
