function f0 = findF0(f,r,t,p)
% dynamically updated f0 calculation
% f ... fluorescence vector
% r ... frame rate / Hz
% t ... length of segment for sliding window
% p ... fraction of SD below mean

% this file written by Henry Luetcke (hluetck@gmail.com)

% data points corresponding to t
points = round(r*t);

% fMean = slidefun(@mean,points,f);
% fSD = slidefun(@std,points,f);
fMean = moving_average(f,points);
fSD = movingstd(f,points);

f0 = fMean - (p.*fSD);



% if numel(f) <= (points-1)*3
%     points = floor((numel(f)/3)-1);
%     warning('Adjusted F0 filter to %1.2f s!',points/r);
% end
% try
%     f = filtfilt(ones(1,points)/points,1,f);
% end
% 
% % we may need to pad f with points
% f0 = zeros(size(f));
% for n = 1:points:length(f)-points
%     currentSegment = f(n:n+points);
%     currentF0 = prctile(currentSegment,p);
%     f0(n:n+points) = currentF0;
% end
% f0(n+1:end) = currentF0;
% try
%     f0 = filtfilt(ones(1,points)/points,1,f0);
% end

