function  corrdff = FitExpBaselineWithSlidingMean(dff, frameRate, windowsiz)

% FitExpBaselineWithSlidingMean - 
% To determine reasonable baseline fit for data showing slow exponential decay (e.g. bleaching or Pockels cell problem).
% Principle: calculate 10th percentile values in sliding window segments of siz 'windowsiz' (in sec). 
% Pick values at intervals of segment/2'interv'. , and then take the minimal
% value, assuming that there are periods representing baseline noise
%
% F. Helmchen, 7.1.2015

lim = length(dff);
win = round(windowsiz*frameRate);

out = zeros(1,length(dff));
out(1:length(dff)) = NaN;

xx = 1:1:length(dff);

outx = [];
outy = [];
outx(1) = 2;
outy(1) = mean(dff(1:2));
jj = 2;
for ii = 1:win:lim-win
    outx(jj) = ii+round(win/2);
    outy(jj) = min(dff(ii:ii+win));
    jj = jj+1;
end

basefit = fit(outx',outy','exp2', 'StartPoint', [outy(1),-1/(win/2),0,0], 'Lower', [-Inf -1/(win/frameRate) -Inf -0.000001], 'Upper', [Inf -1/(5*win) Inf 0.0000001]);
coeffvals = coeffvalues(basefit);
ffit = basefit(xx)-coeffvals(3);
corrdff = dff - ffit; 


