clear
close 
a=0.0000001;
v=0:a:1000*a;
s=cumsum(v);
% s=cumsum(s);
plot(s)