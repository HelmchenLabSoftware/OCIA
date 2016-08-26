%% Function - doROIRGBPlot
function figH = doROIRGBPlot(axeH, imgDims, ROISet, leftImg, meanImage, fileID, alphaVal)

% created by B. Laurenczy - 2013

% 2D matrix for the alpha transparency of each ROI on the final image
alphaMat = ones(imgDims(1), imgDims(2));
% 3D matrix for the RGB values of each ROI
ROIRGB = zeros(imgDims(1), imgDims(2), 3);
% colormap with a different color for each ROI
CMap = jet(size(ROISet, 1));
% 2D matrix containing the indexes of the ROIs for the text plotting
ROICounterImg = zeros(size(alphaMat));

% go trough each ROI to fill in the above variables
for iROI = 1 : size(ROISet, 1);
    % extract the ROIMask and the ROI's ID
    ROIMask = ROISet{iROI, 2};
    % set (a bit) transparent the regions where this ROI is
    alphaMat(ROIMask == 1) = alphaVal;
    ROICounterImg(ROIMask == 1) = iROI;
    [row, col] = ind2sub(size(alphaMat), find(ROIMask));
    % assign the color for each pixel
    for i = 1 : length(row);
        ROIRGB(row(i), col(i), :) = CMap(iROI, :);
    end
end

% display the ROIs on mean frame in RGB multi-color
if isempty(axeH);
    figH = figure('Name', sprintf('ROIs for %s', fileID), 'NumberTitle', 'off');
    if ~isempty(leftImg);
        subplot(1, 2, 1, 'Parent', figH);
        imshow(linScale(leftImg), 'Parent', gca);
        subplot(1, 2, 2, 'Parent', figH);
        axeH = gca;
    else
        axeH = axes('Parent', figH);
    end;
else
    figH = getParentFigure(axeH);
end;
imshow(ROIRGB, 'Parent', axeH);
hold(axeH, 'on');
imShowHandle = imshow(meanImage{1}, [], 'InitialMagnification', 'fit', 'Parent', axeH);
set(imShowHandle, 'AlphaData', alphaMat);
regionGroups = regionprops(ROICounterImg, ROICounterImg, 'MaxIntensity', 'Extrema');
hold(axeH, 'on');

for iGroup = 1 : numel(regionGroups)
    regionCenter = regionGroups(iGroup).Extrema;
    text(regionCenter(1,1), regionCenter(1,2)-1, ROISet{iGroup, 1}, 'Parent', axeH, ...
        'Clipping', 'on', 'Color', 'r', 'FontWeight', 'bold', 'Tag', 'CellLabel');
end
hold(axeH, 'off');

end
