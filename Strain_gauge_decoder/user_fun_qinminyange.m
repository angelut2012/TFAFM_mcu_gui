function user_fun_qinminyange()
initial_global_define;
switch_show_SG_out=0;
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SG_readout(1), SG_readout(2), SG_readout(3)
% write_fine_position_V(obj_serial,voltage_0_150V)



N=50;
dn=1/N;
V=[0:dn:1 1-dn:-dn:dn];
V=V.*150;

L=6*60*2
% L=3
% time=length(V)/50*60/3600
% V=round(V);
N=length(V);
SG=zeros(N*L,3);
write_fine_position_V(obj_serial,150);%test
write_fine_position_V(obj_serial,0);%test
for p=1:L
    for k=1:length(V)
        write_fine_position_V(obj_serial,V(k))
%         write_fine_position_Position0to150(obj_serial,V(k))
        lock_data_new=0;
        while(lock_data_new==0)
            pause(0.1)
        end
        
        fprintf('%.1f\t%.1f\t%.1f\t%.1f\t%.1f\t', k, V(k), SG_readout(1), SG_readout(2), SG_readout(3))%SG_readout=[x,y,z])
        ind=(p-1)*N+k;
        SG(ind,:)=SG_readout;
        if mod(ind,500)==0
            save([num2str(ind) '_SG_data.mat'],'SG')%'V',
        end
    end
end
% SG
save('SG_data.mat','V','SG')
toc
switch_show_SG_out=1;