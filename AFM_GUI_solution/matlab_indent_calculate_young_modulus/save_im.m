figure(2)
plot(z_piezo,force,'.-')
nm=z_piezo;
prc=force;
L=length(nm);
Lh=round(L/2);
nm1=nm(1:Lh);
nm2=nm(1+Lh:end);

prc1=prc(1:Lh);
prc2=prc(1+Lh:end);
% ind=(nm~=0);
% nm=data(ind,1);
% prc=data(ind,2);
% prc(prc>5e6)=nan;

h=figure(4)

clf
% plot(nm,prc,'.-')
plot(nm1,prc1,'r.-')
hold on
plot(nm2,prc2,'b.-')
grid on
legend('indent','withdraw')
% legend( h, 'force vs. indent depth', 'Hertz model', 'Location', 'NorthEast' );
% Label axes
xlabel( 'indent depth (nm)' );
ylabel( 'force (nN)' );
% title(fn)
saveas(h,[fn(1:end-4) '.bmp'])