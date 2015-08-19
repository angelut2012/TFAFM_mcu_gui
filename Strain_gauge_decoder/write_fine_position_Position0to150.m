
function write_fine_position_Position0to150(obj_rs232,d,xyz_0to3)
d=min(d,150);
d=d/150*(2^18-1);
% d=196094
D(1)=floor(d/2^16);
d=d-D(1)*2^16;
D(2)=floor(d/2^8);
D(3)=d-D(2)*2^8;
%% D
initial_global_define;
if isempty(busy) busy=0; end
if busy==0
    busy=1;
    
%     str=[ 170 85, 'D', 255, 0  D(1), D(2), D(3), 85 170 ];
if nargin<3 
    xyz_0to3=255;
end
    str=[ 170 85, 'F', xyz_0to3, 0  D(1), D(2), D(3), 85 170 ];
    %  com=hex_str2uint8(str);
    com= uint8(str);
    fwrite(obj_rs232, com);
    pause(0.01)
    
    busy=0;
else
    disp('com  busy')
    pause(0.01)
end

