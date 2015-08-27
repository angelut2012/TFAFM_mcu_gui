function [num,den]=sos_C_header_show(Hq,filename);
clc
% sos_C_header(Hq,mode,filename): Used to create a C-style header file
% containing filter coefficients. This reads Hq filter objects assuming a
% direct-form II cascade of second-order sections is present
%
% MATLAB Design Functions
% ECE 5655/4655 Real-Time DSP 8–33
% Hq = quantized filter object containing desired coefficients
% mode = specify 'float' (plan for fixed and hex to be added later
% file_name = string name of file to be created
%Check to see what type of Hq object we have
% if strcmp(Hq.FilterStructure,'Direct-Form II, Second-Order Sections') == 0,
%     disp('Wrong structure type, no file written.')
%     disp(['Type found is: ' Hq.FilterStructure ' not Direct-Form II, SecondOrder Sections!'])
%     return
% end
dimSOS = size(Hq.SOSMatrix);
Ns = dimSOS(1); % Number of biquad sections
num = zeros(Ns,3);
den = zeros(Ns,3);
for i=1:Ns,
    num(i,:) = Hq.SOSMatrix(i,1:3);
    num(i,:) = num(i,:)*Hq.ScaleValues(i);
    den(i,:) = Hq.SOSMatrix(i,4:6);
end
if length(Hq.ScaleValues) == Ns+1
    scalevalue = Hq.ScaleValues(Ns+1);
else
    scalevalue = 1.0;
end
% fid = fopen(filename,'w'); % use 'a' for append
fprintf( '//define number of 2nd-order stages\n');
fprintf( '#define STAGES %d\n',Ns);
kk = 1;
% switch lower(mode)
% case 'float '
fprintf( 'float b[STAGES][3] = { ');
fprintf( '/*numerator coefficients */\n');
for i=1:Ns,
    if i==Ns
        fprintf( '{%15.12f, %15.12f, %15.12f} ',...
            num(i,1),num(i,2),num(i,3));
    else
        fprintf( '{%15.12f, %15.12f,%15.12f},',num(i,1),num(i,2),num(i,3));
    end
    fprintf( ' /*b0%1d, b1%1d, b2%1d */\n',i,i,i);
end
fprintf( '};\n');
% Chapter 8 • Real-Time IIR Digital Filters
% 8–34 ECE 5655/4655 Real-Time DSP
fprintf( 'float a[STAGES][2] = { ');
fprintf( '/*denominator coefficients*/\n');
for i=1:Ns,
    if i==Ns
        fprintf( '{%15.12f, %15.12f} ',den(i,2),den(i,3));
    else
        fprintf( '{%15.12f, %15.12f},',den(i,2),den(i,3));
    end
    fprintf( ' /*a1%1d, a2%1d */\n',i,i);
end
fprintf( '};\n');
fprintf( 'float scalevalue = %15.12f;', scalevalue);
fprintf( ' /* final output scale value */\n');
% otherwise
% disp('Unknown mode!')
% end
fprintf( '/*******************************************************************/\n');
% fclose(fid);