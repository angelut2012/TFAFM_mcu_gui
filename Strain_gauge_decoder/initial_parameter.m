
format long
warning ('off','all')
initial_global_define;
busy=0;
frame_counter=0;
ts=1/10000;
% ts=1/5000
% ts=1/100;
scan_rate=0.25;%1/10;% line scan frequency
miss_tick=1e20;

% dt_sampling=line_time/(N_scan./N_sampling)*64/2;
sampling_channel_01=0;% 0,L2R, 1 R2L

rs232_com=[255 170 85 2 -1 0 12 21 85 170];
ts_rs232=0.01

piezo_pid_p=0.97;
piezo_pid_i=0.05;   
piezo_pid_d=0.001;

piezo_z_pid_p=1;%1
piezo_z_pid_i=0.0000005;
piezo_z_pid_d=0.00000001;

% sg_min =[0.015847834831461   1.674608620224719   1.674798841573034   0.016767797752809].* 1.0e+07;
% sg_min=[158316    16748230    16752874      167126];
% sg_max =   [0.008411760194175   1.666847277669903   1.667512333009709   0.016768911650485].* 1.0e+07;
% =-sg_min;
% nulling_x=+sg_null(1);
% nulling_y= +sg_null(2);
% nulling_z=  +sg_null(3);
% nulling_t= +sg_null(4);
%%
% range_sg_max=[      73368       76895       73596         -86];%[ 73740       77034       73872         -26 ]
% range_sg_max=abs(sg_max+sg_null)
% range_nm=[25000 25000 25000 1];
% rate_sg2nm=range_nm./range_sg_max ; % implemented in gain
sg_null=[   153483    16744274    16678785      168128];
rate_sg2nm =[ 1 1 1 1];
sg_raw_data_now=sg_null;
max_voltage=10;
% rate_piezo_nm2V=max_voltage./range_nm ;% implemented in gain

%%
% sys_engage='TF_AFM_engage_coarse_positioiner_command';
sys='TF_AFM_kernel';
% sys='TF_AFM_kernel_pid_test_model'
% % sys='TF_AFM_kernel_outter_pid'
% sys='TF_AFM_kernel_outter_pid_engage'
% sys='TF_AFM_kernel_outter_pid_adjusted_engage'
%sys='TF_AFM_kernel_outter_pid_adjusted_engage_open'
% sys='TF_AFM_kernel_pid_test';
% sys='TFAFM_Z_servo_external_fs15kHz_OK';
%% para
DELTA_F_RATE_V_PER_NM=(3.7084/1000.0);%		// voltage/ nm
TF_rate_V2nm=3.7084\1000.0;
%%
% image_buffer_size=512;% buffer in rtos
size_buffer=1024;
% N=512% scanning point resolution,
N_x=256;
N_y=256;
% N_scan=256;%4096% scanning point resolution,
% N_sampling=N_scan;

%%
V_inf=-0.5;
V_working_delta=0.3;
V_working_set=0;%=Vinf-V_working_delta, determined in engage
%%
gain_position_syzt=[1 1 1 1];

%%

% start point nm
% XL=6000;
% DX=15000 ;
% 
% YL=6000;
% DY=DX ;
% para_table=[XL YL DX DY]';
%  error_thresh_nm_tf=10;%nm if the z error measured is larger than this, xy stop scan
image_show_on_off=1;
switch_show_SG_out=1;
error_hold=1;
% rtctrl
% rtwintgt -install
% y
% rtctrl
% rtdemo