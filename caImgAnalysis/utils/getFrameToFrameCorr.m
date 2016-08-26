function frameCorrs = getFrameToFrameCorr(imgMovie)

% get the size of the imaging data set
imgDim = size(imgMovie);
if numel(imgDim) < 3; imgDim(3) = 1; end;

% calculate frame-wise correlation
frameCorrs = zeros(1, imgDim(3) - 1);
parfor iFrame = 1 : imgDim(3) - 1;
    % get the correlation coefficient of each frames compared to the average
    frameCorrMat = corrcoef(imgMovie(:, :, iFrame + 1), imgMovie(:, :, iFrame), 'rows', 'pairwise'); %#ok<PFBNS>
    % extract the inter-frame correlation coefficient
    frameCorrs(iFrame) = frameCorrMat(1, 2);
end;

end
