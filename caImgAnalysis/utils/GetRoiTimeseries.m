function roi_mat = GetRoiTimeseries(data,mask)
% extract the timeseries from masked data points
% gets timeseries from those points in data where mask == 1
% mask should be 2D, data either 2D or 3D (or empty to include all pixels)
% roi_mat contains data from different pixels in rows, timeseries in
% columns

% TODO: weighted masking
% this file written by Henry Luetcke (hluetck@gmail.com)

if isempty(mask)
    mask = ones(size(data,1),size(data,2));
end

if numel(size(mask)) ~= 2
   error('Mask must be 2D.');
end
if numel(size(data)) > 3 || numel(size(data)) < 2
   error('Data must be 2D or 3D.');
end
if size(mask,1) ~= size(data,1) || size(mask,2) ~= size(data,2)
    error('Mask and data dimensions must be consistent.');
end

masked_pixel = find(mask==1);
[mask_row,mask_col] = ind2sub(size(mask),masked_pixel);
roi_mat = zeros(numel(mask_row),size(data,3));
for n = 1:numel(mask_row)
    roi_mat(n,:) = data(mask_row(n),mask_col(n),:);
end