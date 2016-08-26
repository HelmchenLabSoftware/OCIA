function  dff0 = FindBaselineWithSlidingMean(dff, frameRate, windowsiz)

% FindBaselineWithSlidingMean - 
% To determine reasonable baseline value. Principle: calculate mean values in
% sliding window of siz 'windowsiz' (in sec), and then take the minimal
% value, assuming that there are periods representing baseline noise
%
% F. Helmchen, 7.1.2015

lim = length(dff);
win = round(windowsiz*frameRate/2);

out = zeros(1,length(dff));
out(1:length(dff)) = NaN;

idelta = round(win/4);

for ii = win:idelta:lim-win
    out(1,ii)=mean(dff(ii-win+1:ii+win));
end

dff0 = nanmin(out);


