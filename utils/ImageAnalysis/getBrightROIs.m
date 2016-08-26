function brighROISet = getBrightROIs(ROISet, avgImg, nBrightROIs, percBoundBox, doPlots)

% get the image's dimension
imgDim = size(avgImg);
% exclude neuropil
if strcmp(ROISet{end, 1}, 'NPil');
    ROISet(end, :) = [];
end;
    
% get the ROISet's dimension
nROIs = size(ROISet, 1);
% stores the brightness of the ROIs
ROISet(:, 3) = cell(1, nROIs);
% stores the bounding box mask of the ROIs
ROISet(:, 4) = cell(1, nROIs);
% procces the ROIs one by one
for iROI = 1 : nROIs;
    
    % get the ROI's mask
    ROIMask = ROISet{iROI, 2};
    
    % get the x and y positions of this ROI's pixels
    ROIPixels = unique(find(ROIMask > 0));
    [yVals, xVals] = ind2sub(imgDim([1, 2]), ROIPixels);
    
    % skip if the mask is empty
    if isempty(ROIPixels);
        continue;
    end;
    
    % get the bounding box of this ROI
    ROIXRange = round([min(xVals) * (1 - percBoundBox), max(xVals) * (1 + percBoundBox)]);
    ROIYRange = round([min(yVals) * (1 - percBoundBox), max(yVals) * (1 + percBoundBox)]);
    
    % skip if the ROI with bounding box is not completely in the image 
    if ROIXRange(1) < 1 || ROIXRange(end) > imgDim(2) || ROIYRange(1) < 1 || ROIYRange(end) > imgDim(1);
        continue;
    end;
    
    % get the bounding box of this ROI
    ROISet{iROI, 4} = false(imgDim);
    ROISet{iROI, 4}(ROIYRange(1) : ROIYRange(end), ROIXRange(1) : ROIXRange(end)) = true;
    
    % get the maximum brightness of the ROI within the bounding box
    ROISet{iROI, 3} = max(avgImg(ROISet{iROI, 4}));
    
end;
% exclude ROIs that are out of bound
ROISet(cellfun(@isempty, ROISet(:, 3)), :) = [];
% sort the brightness
[~, ROIBrightnessIndex] = sort(-cell2mat(ROISet(:, 3)));
brighROISet = ROISet(ROIBrightnessIndex(1 : min(nBrightROIs, size(ROIBrightnessIndex, 1))), :);
% if requested, plot a figure illustrating the ROIs
if doPlots > 0;
    
    figure('Name', 'ROI brightness', 'NumberTitle', 'off');
    M = ceil(sqrt(nROIs)); N = M;
    if (N - 1) * M >= nROIs; N = N - 1; end;
    
    % plot each ROI
    for iROILoop = 1 : nROIs;
        subplot(M, N, iROILoop);
        % get the ROIs in the brightness order
        iROI = ROIBrightnessIndex(iROILoop);
        % get the indexes of the mask
        [maskYVals, maskXVals] = ind2sub(imgDim([1, 2]), find(ROISet{iROI, 4}));
        % plot the ROI
        h = imshow(linScale(avgImg(unique(maskYVals), unique(maskXVals))));
        % plot a rectangle to show if it's selected or not
        xlims = get(h, 'XData'); ylims = get(h, 'YData');
        color = 'green'; if iROILoop > nBrightROIs; color = 'red'; end;
        rectangle('Position', [0.5 0.5 xlims(end) ylims(end)], 'EdgeColor', color);
        % add a title
        title(sprintf('ROI%s', ROISet{iROI, 1}));
    end;
    
end;

end
