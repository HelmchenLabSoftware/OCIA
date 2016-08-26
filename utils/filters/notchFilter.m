function y = notchFilter(x,Fs,f,Q)
% implementation of Matlab notch-filter
% x ... time series
% Fs ... sampling frequency
% f ... notch frequency
% Q ... quality factor (larger => narrower notch band)

% this file written by Henry Luetcke (hluetck@gmail.com)

% t = 1/Fs:1/Fs:1;
% x=0.7*sin(2*pi*10*t);
% 
% noize = 0.4;
% x = x + (-noize+2*noize.*rand(1,numel(x)));
% plot(t,x,'k'), hold on

wo = f/(Fs/2); bw = wo/Q;
[b,a] = iirnotch(wo,bw);
y=filter(b,a,x);

% plot(t,y,'r')