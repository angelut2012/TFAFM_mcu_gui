% global   DELTA_F_RATE_V_PER_NM%1x1%%     8  double%%
global   DX DXin%%%% 1x2%%    16  double    global
global   DY DYin%%%% 1x2%%    16  double%%
% global   N%%%%  1x2%%    16  double%%
% global   P_z0%%%     1x2%%    16  double%%
% global   V0%%%% 1x2%%    16  double%%
global   V_working_set  V_working_delta V_inf%%  1x2%%    16  double%%

global   XL%%%% 1x2%%    16  double    global
global   YL%%%% 1x2%%    16  double%%
% global   arr%%%%1x2%%    16  double%%
% global   error_thresh_nm%%   1x2%%    16  double%%
% global   miss_tick%%%1x1%%     8  double%%
% global   rate_V2nm%%%1x1%%     8  double%%
global   sys sys_state%%%%1x5%%    10  char%%
global   ts%%%% 1x1%%     8  double
%%
global obj_Image_data
global im_buffer_L im_buffer_R  im_buffer_EL  im_buffer_ER
global size_buffer
global timer_update timer_monitor
global obj_system_monitor
% global buffer_Image_data
global image_show_buffer image_show_buffer_E
global im_range  im_range_E
global sampling_channel_01
global N_sampling
global N_x N_y
global dt_sampling
global scan_rate
global sys_state% 1== scan
global TF_rate_V2nm
%%
global  g_handles h_rect
% global para_table

%% rs232
global obj_serial  obj_serial_coarse_positioner

global current_position_nm


global rate_sg2nm
global sg_null sg_raw_data_now
%% engage
global sys_engage
global engage_abort
global image_show_on_off
global error_hold


global VDF
global frame_counter
global busy

global SG_readout  lock_data_new SG 
global switch_show_SG_out
