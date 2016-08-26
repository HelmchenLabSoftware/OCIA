function [cc,p,cc_mc] = xcorr_mc(x,y,maxlags,n)
% monte-carlo cross-correlation of x and y
% Input
% x ... input vector 1 (will be shuffled)
% y ... input vector 2 (will NOT be shuffled)
% lag ... lag for xcorr
% n ... number of samples for shuffled data
% Output
% cc ... the true cross-correlation between x and y
% p ... probability of correlation for each time point
% cc_mc ... the matrix of shuffled cross-correlation values

% this file written by Henry Luetcke (hluetck@gmail.com)

% force columns vectors
x = reshape(x,numel(x),1);
y = reshape(y,numel(y),1);

% true cross-correlation
cc = xcorr(x,y,maxlags,'coeff');

% shuffled cross-correlation
cc_mc = doShuffledXcorr(x,y,maxlags,n);

% estimate the 2-tailed probability of true cc at each timepoint
p = doStats(cc_mc,cc);

function cc_mc = doShuffledXcorr(x,y,maxlags,n)
cc_mc = zeros(maxlags*2+1,n);
for i = 1:n
    xPerm = x(randperm(numel(x)));
    cc_mc(:,i) = xcorr(xPerm,y,maxlags,'coeff');
end

function p = doStats(A,c)
p = zeros(size(A,1),1);
for n = 1:size(A,1)
    [mu,sigma] = normfit(A(n,:));
    p(n) = 1 - (normcdf(abs(c(n)),mu,sigma));
end


