function frameCorrsROI = getFrameToFrameCorrROI(ROISet, percBoundBox, imgMovie, showDbgImg)

% get the number of ROIs
nROIs = size(ROISet, 1);

% get the size of the imaging data set
imgDim = size(imgMovie);
if numel(imgDim) < 3; imgDim(3) = 1; end;

% store the correlation of each ROI's image to the average image
frameCorrsROI = zeros(nROIs, imgDim(3) - 1);

% loop on ROIs
for iROI = 1 : nROIs;

    % get the ROI's mask
    ROIMask = ROISet{iROI, 2};
    % get the x and y positions of this ROI's pixels
    ROIPixels = unique(find(ROIMask > 0));
    [yVals, xVals] = ind2sub(imgDim([1, 2]), ROIPixels);
    
    localPercBoundBox = percBoundBox;
    localImgMovie = imgMovie;
    if percBoundBox == -1;
        localPercBoundBox = 0;
%         localImgMovie(repmat(~ROIMask, [1, 1, imgDim(3)])) = NaN;
%         for iFrame = 1 : size(localImgMovie, 3);
%             localImgFrame = localImgMovie(:, :, iFrame);
%             localImgFrame(~ROIPixels) = NaN;
%             localImgMovie(:, :, iFrame) = localImgFrame;
%         end;
    end;
    
    % get the bounding box of this ROI
    ROIXRange = round([min(xVals) * (1 - localPercBoundBox), max(xVals) * (1 + localPercBoundBox)]);
    ROIYRange = round([min(yVals) * (1 - localPercBoundBox), max(yVals) * (1 + localPercBoundBox)]);
    % skip if the ROI with bounding box is not completely in the image 
    if ROIXRange(1) < 1 || ROIXRange(end) > imgDim(2) || ROIYRange(1) < 1 || ROIYRange(end) > imgDim(1);
        continue;
    end;
    
    % movie of the ROI's bounding box
    ROIImgMovie = localImgMovie(ROIYRange(1) : ROIYRange(end), ROIXRange(1) : ROIXRange(end), :);
    % get the pixels to NaN out in the ROI img movie
    ROIMaskROIImgMovie = ROIMask(ROIYRange(1) : ROIYRange(end), ROIXRange(1) : ROIXRange(end));

    % debug plot
    if showDbgImg;
        figure(12346);
        imagesc(nanmean(ROIImgMovie, 3));
    end;
    
    % calculate frame-wise correlation
    parfor iFrame = 1 : (imgDim(3) - 1);
        localImgFrame = localImgMovie(:, :, iFrame);
        localImgFrame(~ROIPixels) = NaN;
        % get the correlation coefficient of each frames compared to the average
        frameCorrMat = corrcoef(ROIImgMovie(:, :, iFrame + 1), ROIImgMovie(:, :, iFrame), 'rows', 'pairwise'); %#ok<PFBNS>
        % extract the inter-frame correlation coefficient
        frameCorrsROI(iROI, iFrame) = frameCorrMat(1, 2);
    end;

end; % end of ROI for loop

end
