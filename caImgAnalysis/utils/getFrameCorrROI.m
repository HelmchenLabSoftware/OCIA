function frameCorrsROI = getFrameCorrROI(ROISet, percBoundBox, avgImg, imgMovie)

% get the number of ROIs
nROIs = size(ROISet, 1);

% get the size of the imaging data set
imgDim = size(imgMovie);
if numel(imgDim) < 3; imgDim(3) = 1; end;

% store the correlation of each ROI's image to the average image
frameCorrsROI = zeros(nROIs, imgDim(3));

% loop on ROIs
for iROI = 1 : nROIs;

    % get the ROI's mask
    ROIMask = ROISet{iROI, 2};
    % get the x and y positions of this ROI's pixels
    ROIPixels = unique(find(ROIMask > 0));
    [yVals, xVals] = ind2sub(imgDim([1, 2]), ROIPixels);
    
    % get the bounding box of this ROI
    ROIXRange = round([min(xVals) * (1 - percBoundBox), max(xVals) * (1 + percBoundBox)]);
    ROIYRange = round([min(yVals) * (1 - percBoundBox), max(yVals) * (1 + percBoundBox)]);
    % skip if the ROI with bounding box is not completely in the image 
    if ROIXRange(1) < 1 || ROIXRange(end) > imgDim(2) || ROIYRange(1) < 1 || ROIYRange(end) > imgDim(1);
        continue;
    end;
    
    % average image of the ROI's bounding box
    ROIAvgImg = avgImg(ROIYRange(1) : ROIYRange(end), ROIXRange(1) : ROIXRange(end));
    % movie of the ROI's bounding box
    ROIImgMovie = imgMovie(ROIYRange(1) : ROIYRange(end), ROIXRange(1) : ROIXRange(end), :);
    
    % do a frame-wise correlation
    parfor iFrame = 1 : imgDim(3);
        % get the correlation coefficient of each frames compared to the average
        ROICorrCoef = corrcoef(ROIAvgImg, ROIImgMovie(:, :, iFrame), 'rows', 'pairwise');
        frameCorrsROI(iROI, iFrame) = ROICorrCoef(1, 2); % extract the inter-frame correlation coefficient
    end;

end; % end of ROI for loop

end
