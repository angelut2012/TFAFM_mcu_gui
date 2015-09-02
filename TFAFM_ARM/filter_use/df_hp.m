% function Hd = df_hp;
clear
clc
%DF_HP Returns a discrete-time filter System object.

% MATLAB Code
% Generated by MATLAB(R) 8.1 and the DSP System Toolbox 8.4.
% Generated on: 24-Aug-2015 15:47:06

Fstop = 500;   % Stopband Frequency
Fpass = 700;   % Passband Frequency
Astop = 40;    % Stopband Attenuation (dB)
Apass = 3;     % Passband Ripple (dB)
Fs    = 2500;  % Sampling Frequency

h = fdesign.highpass('fst,fp,ast,ap', Fstop, Fpass, Astop, Apass, Fs);

Hd = design(h, 'cheby2', ...
    'MatchExactly', 'stopband', ...
    'SystemObject', true);
[num,den]=sos_C_header_show(Hd)
