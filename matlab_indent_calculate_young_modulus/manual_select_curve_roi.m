function [sx,sy,index]=manual_select_curve_roi(x,y,str);
h=figure(500);
clf
plot(x,y,'k.-')
grid on
title(str)
[a,b]=ginput(2);
a=round(a);
ind=x>a(1)&x<a(2);
sx=x(ind);
sy=y(ind);
inds=find(ind==1);
index=[inds(1) inds(end)];
close(h)
end