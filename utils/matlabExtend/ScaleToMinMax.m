function data = ScaleToMinMax(data,ymin,ymax)
% linearly scales the input data (in1) between in2 (min) and in3 (max)

% this file written by Henry Luetcke (hluetck@gmail.com)
if ymin >= ymax
    error('Input 2 must be smaller than input 3');
end
xmin = min(reshape(data,1,numel(data)));
xmax = max(reshape(data,1,numel(data)));
slope = (ymax-ymin)/(xmax-xmin);
intercept = ymin - (slope*xmin);
data = slope .* data + intercept;
