% %%%%%%%%%%%%%%%%%%%%%
% S=sgy;
% ind=find(S<-0.3);
% while( ~isempty(ind))
%     S(ind)=(S(ind-1)+S(ind+1))./2;
%    ind=find(S<-0.3);
% 
% end
% S([1097 1098])=[0.774 0.782];
% S([2641 2642  ])=[0.773 0.784];
% sgy=S;
% %%%%%%%%%%%%
% S=sgz;
% ind=find(S<-0.3);
% while( ~isempty(ind))
%     S(ind)=(S(ind-1)+S(ind+1))./2;
%    ind=find(S<-0.3);
% 
% end
% S([1097 1098])=[0.774 0.782];
% S([2641 2642  ])=[0.773 0.784];
% sgz=S;
% 
% 
% 
% sgx=(sgx-min(sgx))./(max(sgx)-min(sgx));
% sgy=(sgy-min(sgy))./(max(sgy)-min(sgy));
% sgz=(sgz-min(sgz))./(max(sgz)-min(sgz));
% ind=find(V==1);
% sgx(ind)=1;
% sgy(ind)=1;
% sgz(ind)=1;
% % k=2
% % ind=find(V==0)
% % sgx(ind)=sgx(ind)./k;
% % sgz(ind)=sgy(ind)./k;
% % sgz(ind)=sgy(ind)./k;
% % sgy(ind)=0;
% % sgz(ind)=0;
% 
% % V=[V(2:end) V(1)];
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a= 1.0e+03 .*[1.0960
%     1.0970
%     1.0980
%     2.6410
%     2.6420
%     2.6430
%     4.5190
%     4.5200
%     4.5210]
% 
% b=[
%     0.6744
%     0.6694
%     0.6634
%     0.0610
%     0.0544
%     0.0501
%     0.6810
%     0.6704
%     0.6607]
% a=round(a);
% sgy(a)=b;
% 
% a=[1095.99768326759;1097.00237909735;1097.99880582563;2641.00092786467;2641.99402547417;2643.01611863432;3243.99919821396;3245.00067902781;3246.00963357907;4519.00521152704;4520.01582728173;4521.00952896520];
% b=[0.711992027624048;0.708901105496534;0.705098457879131;0.197570118073821;0.192897909059461;0.188919592472976;0.978355941657574;0.980545465492745;0.984087342284932;0.708096470640775;0.697870620251428;0.689584155280750];
% a=round(a);
% sgz(a)=b;
% sgz=normalize(sgz);
