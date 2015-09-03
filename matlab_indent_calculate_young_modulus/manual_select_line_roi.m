function [sx,sy,index]=manual_select_line_roi(x,y,str);
% w=round(length(y)/200);
% y=medfilt1(y,w);

nx=normal_scale(x);
ny=normal_scale(y);

% n=1:length(ny);
% cfS=createFit_FFT8(n,ny);
% cfS=createFit_line_poly_N(n,ny,8);
% fy=feval(cfS,n);
% dfy=diff(fy,2);
% ind=find()
h=figure(500);
clf
plot(nx,'k.-')
hold on
plot(ny,'c.-')
grid on
title(str)
[a,b]=ginput(2);
a=round(a);
N=length(x);
a(a>N)=N;
a(a<1)=1;
% ind=x>a(1)&x<a(2);
ind=a(1):a(2);
sx=x(ind);
sy=y(ind);
% inds=find(ind==1);
index=a;
close(h)
end

function d=normal_scale(d);
mL=min(d);
mH=max(d);
d=(d-mL)./(mH-mL);
end
