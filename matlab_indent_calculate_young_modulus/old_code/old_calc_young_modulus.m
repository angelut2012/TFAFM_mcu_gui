function calc_young_modulus(z,d,R,v,k)
% 
% 
% [k_fit, gui.results] = load_displacement_fit(...
%     gui.variables.val2, gui.data.h, gui.data.P);
% gui.results.fac_fit = k_fit(1);
% gui.results.exp_fit = k_fit(2);
% 
% %% Energy calculation ==> Area below load-displacement curve
% gui.results.W_microJ = 1e-6 * trapz(gui.data.h, gui.data.P); % in µJ / 1J=1N.m
whileflag = 1;
file_name=' ';
while (whileflag ~= 0)
    clearvars -except file_name whileflag d z k R v
try
G(:,1) = nthroot(9*k^2*d.^2*(1-v^2)^2/(16*R),3);
G(:,2) = 1;
D = z(:)-d(:);

startuppoint = max(d)*0.5/400;
fitrange = (d(end)-startuppoint)/100;     % range of analysis deflection; 10 intervals;

flag = 1;
for i = startuppoint:fitrange:(d(end))
    ind(flag) = find(d<i, 1, 'last'); % index of certain deflection in d;
    flag = flag +1;
end
flag = 1; % for circle in use;
indindex = 1 + 1; % to increase the deflection analyze range one after one;
for i = 1:length(ind)
    if ind(i) ==0
    else if flag ==1 || flag == 2
            index(flag) = ind(i);
            flag = flag +1;
        else indindex = indindex + 1*(flag-1);
            if indindex > length(ind)
                break
            else
            index(flag) = ind(indindex); % staruppoint+fitrange*(flag-1)+fitrange*(flag-1)=startuppoint+fitrange*2*(flag-1);
            flag = flag +1;
            end
        end
    end
end

Property = {'Property','Evaluation'};
xlswrite(['c:\out_', file_name, '.xlsx'], Property,'Mechanical Property','F2');

flag = 1;
for nd = 1:length(index)-1
    c = inv(transpose(G(index(nd):index(nd+1),:))*G(index(nd):index(nd+1),:));
    %s = c*transpose(G(index(nd):index(nd+1),:))*D(index(nd):index(nd+1));
    m = G(index(nd):index(nd+1),:)\D(index(nd):index(nd+1));
    Dc = G * m;      % G*m =D;
    np = length(m);
    es = zeros(np,1);% dE = -2de/e^3; es = em;
    for j = index(nd):index(nd+1);
        es(1) = es(1)+(D(j)-Dc(j))^2;
    end;
    es(1) = sqrt(c(1,1)*es(1)/(index(nd+1)-index(nd)-np));
    for j = index(nd):index(nd+1);
        es(2) = es(2)+(D(j)-Dc(j))^2;
    end;
    es(2) = sqrt(c(2,2)*es(2)/(index(nd+1)-index(nd)-np));
    
    if flag
        E(flag) = 10^6/(m(1)^1.5);
        Z0(flag) = m(2);
    end;
    
    m(1) = 1/(m(1)^1.5);
    for i = 1:1:length(z); % using E and Z0 to calculate deflection from curve fitting;
        c1 = 16*R*m(1)^2/((1-v^2)^2);
        c2 = 9*k^2-48*R*m(1)^2*(z(i)-m(2))/((1-v^2)^2);
        c3 = 48*R*m(1)^2*(z(i)-m(2))^2/((1-v^2)^2); 
        c4 = -(16*R*m(1)^2*(z(i)-m(2))^3/((1-v^2)^2));
        p = [c1 c2 c3 c4];
        re = roots(p);
        dfit(i,3) = re(3);
    end;
    for i = 1:1:length(z)-1; % cut_off excess part of the fit curve and connect it to a horizontal line;
        if (dfit(length(z)-i,3)>=0)&&(dfit(length(z)-i,3)<dfit(length(z)+1-i,3))
                dfit(length(z)-i,3) = dfit(length(z)-i,3);
        else dfit(length(z)-i,3) = 0;
        end;
    end;
    
    xdata = z(:)-m(2)-d(:); % Indentation,for use whihout obvious substrate influence!!!!!!!!!;
    % If the tip sense the substrate, indentation will reach max value;
    
    SSreg = sum((d(1:index(nd+1))-dfit(1:index(nd+1),3)).^2); % Sum of square of difference between points and the fitting curve
    SStot = sum((d(1:index(nd+1))-mean(d(1:index(nd+1)))).^2); % Sum of square of difference between points and mean Y value
   
    if flag
        indtbe(flag) = int16(xdata(index(nd)));
        indtend(flag) = int16(xdata(index(nd+1)));
        defbe(flag) = d(index(nd));
        defend(flag) = d(index(nd+1));
        R2(flag) = 1 - SSreg/SStot; % Indicate how good a fit is;
        Syx(flag) = sqrt(SSreg/(index(nd+1)-2)); % Standard deviation of the vertical distance of the points from the line;
    end;
    
    figure(nd);
    if issorted(xdata)
        plot(xdata,d,'b-'); % indentation vs. deflection;
        hold on
        plot(xdata,dfit(:,3),'r');
        hold off
    else
        plot(z,d,'b-'); % sample height vs. deflection;
        hold on
        plot(z,dfit(:,3),'r'); % sample height vs fitting deflection;
        hold off
    end
    flag = flag+1;
end;

for i =1:length(defbe)
    defbe(i) = defbe(i)*1000;
    defbe(i) = int32(defbe(i)); % to prevent memory overflow caused by *1000;
    defbe(i) = double(defbe(i));
    defbe(i) = defbe(i)/1000;
end
Exindt = cat(2,transpose(indtbe), transpose(indtend));
Exdef = cat(2,transpose(defbe),transpose(defend));
indttitleline = {'indentation A','to B (nm)'};
deftitleline = {'deflection A','to B (nm)'};

for i =1:length(E)
    E(i) = E(i)*100;
    E(i) = int32(E(i));
    E(i) = double(E(i));
    E(i) = E(i)/100;
end %little trick to keep certain digits after dot, cited from Ehsan!~~~~

for i =1:length(Z0)
    Z0(i) = Z0(i)*10;
    Z0(i) = int16(Z0(i));
    Z0(i) = double(Z0(i));
    Z0(i) = Z0(i)/10;
end

for i =1:length(Syx)
    Syx(i) = Syx(i)*1000;
    Syx(i) = int32(Syx(i));
    Syx(i) = double(Syx(i));
    Syx(i) = Syx(i)/1000;
end
ExE = cat(2,transpose(E), transpose(R2), transpose(Syx)); % Data to write;
Etitleline = {'Youngs modulus (kPa)'};
Z0titleline = {'Contact point Z0 (nm)'};
results.textdata1 = Etitleline;
results.textdata2 = Z0titleline;
results.data1 = ExE;
results.data2 = transpose(Z0);
results = struct2cell(results);
xlswrite(['c:\out_', file_name, '.xlsx'], indttitleline,'Mechanical Property','A3');
xlswrite(['c:\out_', file_name, '.xlsx'], deftitleline,'Mechanical Property','C3');
xlswrite(['c:\out_', file_name, '.xlsx'], Exindt,'Mechanical Property','A4');
xlswrite(['c:\out_', file_name, '.xlsx'], Exdef,'Mechanical Property','C4');
xlswrite(['c:\out_', file_name, '.xlsx'], results{1,1},'Mechanical Property','F3');% write to an excel file
xlswrite(['c:\out_', file_name, '.xlsx'], results{3,1},'Mechanical Property','F4');
xlswrite(['c:\out_', file_name, '.xlsx'], results{2,1},'Mechanical Property','J3');
xlswrite(['c:\out_', file_name, '.xlsx'], results{4,1},'Mechanical Property','J4');
catch err
   if (strcmp(err.message,'Input to ROOTS must not contain NaN or Inf.'))
      disp('I will try with a different databegin point, wait...');
      z = z(2:end); % choose effective interval!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;
      d = d(2:end); % same as above!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;
      z = z(:)-z(1);
      d = d(:)-d(1);
      continue
   else
      rethrow(err);
   end
end
whileflag = 0;
end
end