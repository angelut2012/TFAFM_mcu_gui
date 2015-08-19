function user_fun()
initial_global_define;
switch_show_SG_out=0;
tic

load exeV_triangle_sin_double_sine_noise.mat


V=exeV.*150;
V=V(1:3:end);
V(end)=0;

time=length(V)/50*60/3600
% V=round(V);
N=length(V);
SG=zeros(N,3);
write_fine_position_V(obj_serial,150);%test 
write_fine_position_V(obj_serial,0);%test 
for k=1:length(V)
    %write_fine_position_V(obj_serial,V(k))
    write_fine_position_Position0to150(obj_serial,V(k))
    lock_data_new=0;
    while(lock_data_new==0)
        pause(0.1)
    end
    
 fprintf('%.1f\t%.1f\t%.1f\t%.1f\t%.1f\t', k, V(k), SG_readout(1), SG_readout(2), SG_readout(3))%SG_readout=[x,y,z])
    SG(k,:)=SG_readout;
    if mod(k,500)==0
        save([num2str(k) '_SG_data.mat'],'V','SG')
    end
end
% SG
save('SG_data.mat','V','SG')
toc
switch_show_SG_out=1;