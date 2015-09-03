clear
clc
% line 398: \@Sens. DeflSens: V 35.00000 nm/V
% str=load('raw.txt')
%  raw;
% for k=1:length(str)/4
% %     k=216
%     ind=((k-1)*4+1);
%     s1=str(ind:ind+1);
%     x1=hex2dec(s1);
%     s2=str(ind+2:ind+3);
%     x2=hex2dec(s2);
%     t=x2*256+x1;
%     if t>65536/2-1
%         t=65535-t;
%         t=-t;
%     end
%     X(k)=t;
% end
% plot(X,'*-')

t={};
fn='AR_MMC_4hour_20.001'
% fn='AR_DHA_4hour_19.003'
fid=fopen(fn)
for n=1:910
t{n}=fgetl(fid);
end
% A = fread(fid);
A = fread(fid,'int16');
fclose(fid)
figure(1)
clf
plot(A.*1.386,'*-')
%%

fn='AR_MMC_4hour_20_001.txt'
fn='test.txt'
fid=fopen(fn,'w')
for n=1:910
% fprintf(fid,'');
fprintf(fid,['\' t{n} '\r\n']);
end

% for n=1:910
% t{n}=fgetl(fid);
% end
% A = fread(fid);
% B=ones(size(A)).*10000;
s1=A(1:2678)
s2=A(3674:3702)
s3=A(5722:5750)

te=ones(1,995);
tr=ones(1,1024);
ze=1995:-1:1001;
zr=2024:-1:1001;

b=[s1; te';s2;tr';ze';s3;zr']
va=10000/0.0003750000
B=A;
% sensor
ind=2680:3672% indent
B(2680:3000)=1;
% B(ind)=B(ind);%ones(1,length(ind));
ind=3703:4726%retract
% B(ind)=ones(1,length(ind)).*2;
% z piezo
% ind=4727:5721%retract
% B(ind)=1;

% ind=5751:6774%retract
% B(ind)=10;

fwrite(fid,int16(B),'int16');
fclose(fid)
