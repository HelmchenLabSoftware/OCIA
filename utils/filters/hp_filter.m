function img = hp_filter(img,kernel)
% high-pass filter time series
% simple mean-based filter (subtract smoothed version of the time series of
% each pixel)
% smoothing span given by size(img,3)/kernel, so kernel should be in the
% range 2 - 4
% inputs: timeseries vector or 3D (timeseries) image

% this file written by Henry Luetcke

img = double(img);
if ~isvector(img) && numel(size(img)) ~= 3
    error('First input must be timeseries vector or 3D timeseries image');
end

if isvector(img)
    span = length(img);
    % force column-vector
    if size(img,2) > 1
        img = reshape(img,numel(img),1);
    end
    ts_mean = mean(img);
    ts_smooth = smooth(img,span);
    img = img - ts_smooth;
    img = img + ts_mean;
    return
end
span = round(size(img,3)/kernel);
for x = 1:size(img,1)
    for y = 1:size(img,2)
        current_ts(1:size(img,3)) = img(x,y,:);
        ts_mean = mean(current_ts);
        current_ts_smooth = smooth(current_ts,span)';
        current_ts = current_ts - current_ts_smooth;
        current_ts = current_ts + ts_mean;
        img(x,y,:) = current_ts;
    end
end

