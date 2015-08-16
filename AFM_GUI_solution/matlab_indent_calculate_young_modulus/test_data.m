d=load('df.txt');
ind=1:290;
d=d.*1e9;
def=d(ind,1);
F=d(ind,2);
cfL=createFit_line_poly_N(def,F,1,1)