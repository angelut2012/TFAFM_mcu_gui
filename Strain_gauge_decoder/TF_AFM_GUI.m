function varargout = TF_AFM_GUI(varargin)
% TF_AFM_GUI MATLAB code for TF_AFM_GUI.fig
%      TF_AFM_GUI, by itself, creates a new TF_AFM_GUI or raises the existing
%      singleton*.
%
%      H = TF_AFM_GUI returns the handle to a new TF_AFM_GUI or the handle to
%      the existing singleton*.
%
%      TF_AFM_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TF_AFM_GUI.M with the given input arguments.
%
%      TF_AFM_GUI('Property','Value',...) creates a new TF_AFM_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TF_AFM_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TF_AFM_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TF_AFM_GUI

% Last Modified by GUIDE v2.5 11-Dec-2014 21:25:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TF_AFM_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @TF_AFM_GUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
function varargout = TF_AFM_GUI_OutputFcn(hObject, eventdata, handles)


% --- Executes just before TF_AFM_GUI is made visible.
function TF_AFM_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TF_AFM_GUI (see VARARGIN)

% Choose default command line output for TF_AFM_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TF_AFM_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure_GUI);


initial_parameter;
g_handles=handles;

% --- Executes when user attempts to close figure_GUI.
function figure_GUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
initial_global_define;


try
    
    fclose(obj_serial)
    delete(obj_serial)
catch
end

delete(hObject);

%%%%%%%%%%%%%%

% function open_AR_rs232()
% initial_global_define;
%
% try
%     fclose(obj_AR_serial)
%     delete(obj_AR_serial)
% catch
%
% end
% com=get(g_handles.edit_com_NO,'String');
% try
%     obj_AR_serial = serial(['COM' 28]);
%     set(obj_AR_serial,'BaudRate',115200,'DataBits',8,'StopBits',1,'Parity','none','FlowControl','none');
%     obj_AR_serial.BytesAvailableFcnMode = 'byte'; % byte number
%     obj_AR_serial.BytesAvailableFcnCount = 17*2;
%     obj_AR_serial.BytesAvailableFcn = @AFM_rs232_data_ready_callback;
%     fopen(obj_AR_serial);
%
%     disp('open com ar OK')
% catch
%     disp('open com ar error')
% end


function togglebutton_connect_rs232_Callback(hObject, eventdata, handles)
open_rs232();
tic


function edit_com_NO_Callback(hObject, eventdata, handles)

function edit_com_NO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_com_NO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function open_rs232()
initial_global_define;

try
    fclose(obj_serial)
    delete(obj_serial)
catch
    
end
com=get(g_handles.edit_com_NO,'String');
try
    obj_serial = serial(['COM' com]);
    set(obj_serial,'BaudRate',115200,'DataBits',8,'StopBits',1,'Parity','none','FlowControl','none');
    obj_serial.BytesAvailableFcnMode = 'byte'; % byte number
    obj_serial.BytesAvailableFcnCount = (16);
    obj_serial.BytesAvailableFcn = @AFM_rs232_data_ready_callback;
    fopen(obj_serial)
    
    switch_show_SG_out=1;
    disp('open com SG OK')
catch
    disp('open com SG error')
end




function current_position_nm=AFM_rs232_data_ready_callback(obj_serial,BytesAvailable)
initial_global_define;

persistent position_data_last count
if isempty(count) count=0; end
if isempty(position_data_last)
    position_data_last = [0 0 0 0];
end
st=3;
persistent position_data_store
if isempty(position_data_store)
    position_data_store=zeros(st,4);
end
if obj_serial.BytesAvailable<1 
    return 
end
byte_data=fread(obj_serial,obj_serial.BytesAvailable);% obj_serial.BytesAvailableFcnCount)';

%SG_readout= AFM_rs232_convert(byte_data);
sg_raw=com_data_frame_grab(byte_data);
% disp(sg_raw) 
sg_raw_store=sg_raw;
null=[  105737      238091      409440]+[   4437        3285        2879]...
    +[ 37   104   158];
null=[116268	240885	419390]; 
sg_raw=sg_raw-null;
m=[59862       77327       70113];
m=[177575	318435	489888]-null;
z= (21.387973775678940*1000.0);
x= (27.067266247186911*1000.0);
y= (27.209844045785250*1000.0);
R=[ x y z];
sg_raw=sg_raw./m.*R;

if prod(sg_raw_store)~=0% all are not zero
    
 %% 
     if (lock_data_new==0) 
         disp(SG_readout) 
     end
     lock_data_new=1;
%     SG_readout=sg_raw;
    SG_readout=sg_raw_store;
  %%   
     if (switch_show_SG_out==1 && sg_raw_store(1)~=0) 
         fprintf('%.0f\t\%.0f\t\%.0f\t\t\t',sg_raw_store(1),sg_raw_store(2),sg_raw_store(3)) 
         sg_raw=sg_raw-sg_raw(2);   
         fprintf('%.1f\t\%.1f\t\%.1f\t\n',sg_raw(1),sg_raw(2),sg_raw(3)) 
           fprintf('%.3f\t',toc)
         fprintf('\n')
     end   
end
function sg=com_data_frame_grab(byte_data)
sg=[0 0 0];
byte_data=byte_data(:)';
header=[170 85]; %
tailer=[ 85 170]; %
ind1=strfind(char(byte_data), char(header));
ind2=strfind(char(byte_data), char(tailer));

if isempty(ind1) return;end
if isempty(ind2) return; end
ind1=ind1(1);
ind2(ind2<ind1)=[];
ind2(ind2>ind1+16)=[];
if isempty(ind2) return; end
ind2=ind2(1);
if ind1>=ind2 return; end
byte_data=byte_data(ind1+2:ind2-1);
if length(byte_data)<12 disp(byte_data); return; end

if sum(byte_data(1:3)==double(['S','G',9]))==3
        byte_sg=byte_data(4:end);
        X=data_convert(1,byte_sg);
        Y=data_convert(4,byte_sg);
        Z=data_convert(7,byte_sg);
        sg=[X  Y  Z ];
end

function t=data_convert(k,r)
t=r(k)*2^16+r(k+1)*2^8+r(k+2); %new arduino protocol
% t=r(k+2)*2^16+r(k+1)*2^8+r(k);

%% chao's code will overflow
% if r(k)>=254
%     t=t- 2^24;
% end

% raw_p
% end
% 		ps2x=((((long)(Sensor_data[2]))<<24 | ((long)(Sensor_data[3]))<<16 | ((long)(Sensor_data[4]))<<8)+0x3C0000)<<4;
% 		ps1x=((((long)(Sensor_data[11]))<<24 | ((long)(Sensor_data[12]))<<16 | ((long)(Sensor_data[13]))<<8)+0xA00000)<<4;//+0xC10000
% 		ps1y=((((long)(Sensor_data[8]))<<24 | ((long)(Sensor_data[9]))<<16 | ((long)(Sensor_data[10]))<<8)+0x8D0000)<<4;//0x2F0000
% 		ps1z=((((long)(Sensor_data[5]))<<24 | ((long)(Sensor_data[6]))<<16 | ((long)(Sensor_data[7]))<<8)-0x500000)<<4;//0x670000


%% %%%%%%%%%%%%%%%%%%%%%%%%%%
function y= AFM_rs232_convert(u)
% FF FE 00x6
% LMH LMH LMH
% FF FE 00 00 00 00 00 00 01 02 03 04 05 06 07 08 09
u=u';

% y=-[1 1 1 1];
y=-ones(1,4+12);

h=[255 254]; %
if isempty(u)
    return;
end
u=u(1,:);

ind=strfind(char(u), char(h));
if isempty(ind)
    return;
end
ind=ind(1);
if ind+8+9-1>length(u)
    return;
end

ud=double(u(ind+8:ind+8+9-1));
ud=ud(:)';
X=data_convert(1,ud);
Y=data_convert(3+1,ud);
Z=data_convert(6+1,ud);
y=[X  Y  Z ];



% --- Executes on button press in pushbutton_read_manipulator.
function pushbutton_read_manipulator_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_manipulator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
initial_global_define;
if isempty(busy) busy=0; end
if busy==0
    busy=1;
    
    %     AA 00x6 AD 00 00 01
    A=get(g_handles.edit_manipulator,'String');
    A=str2num(A);
    rs232_com=uint8([hex2dec('AA')  , 0 0 0 0 0 0 , hex2dec('AD') ,0 0, A]);
    %% for com2com
    %     com=uint8([    170   85   82    3    5   85  170]);
    %     for x=0:3:255
    %         com(5)=uint8(x);
    %         x
    %     fwrite(obj_serial, com);
    %     pause(3)
    %     end
    
    fwrite(obj_serial, rs232_com);
    pause(0.01)
    busy=0;
else
    disp('com  busy')
    pause(0.01)
end
% --- Executes on button press in pushbutton_command.


function pushbutton_hysterisis_test_Callback(hObject, eventdata, handles)
user_fun_qinminyange();

function pushbutton_command_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_command (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
initial_global_define;
if isempty(busy) busy=0; end
if busy==0
    busy=1;
    
    %     AA 00x6 AD 00 00 01
    try
        A=get(g_handles.edit_COM_command,'String');
        com=hex_str2uint8(A);
    catch
        busy=0;
        return
    end
    fwrite(obj_serial, com);
    pause(0.01)
    
    busy=0;
else
    disp('com  busy')
    pause(0.01)
end

function com=hex_str2uint8(A)
A=[' ' A ' '];
ind=find(A==' ');
di=diff(ind);
ind=ind(di==3);
com=[];
for k=1:length(ind)
    s=A(ind(k):ind(k)+2);
    com=[com uint8(hex2dec(s))];
end


function edit_manipulator_Callback(hObject, eventdata, handles)
% hObject    handle to edit_manipulator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_manipulator as text
%        str2double(get(hObject,'String')) returns contents of edit_manipulator as a double


% --- Executes during object creation, after setting all properties.
function edit_manipulator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_manipulator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function edit_COM_command_Callback(hObject, eventdata, handles)
% hObject    handle to edit_COM_command (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_COM_command as text
%        str2double(get(hObject,'String')) returns contents of edit_COM_command as a double


% --- Executes during object creation, after setting all properties.
function edit_COM_command_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_COM_command (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
