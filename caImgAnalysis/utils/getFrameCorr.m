function frameCorrs = getFrameCorr(avgImg, imgMovie)

% get the size of the imaging data set
imgDim = size(imgMovie);
if numel(imgDim) < 3; imgDim(3) = 1; end;

% calculate frame-wise correlation
frameCorrs = zeros(1, imgDim(3));
parfor iFrame = 1 : imgDim(3);
    % get the correlation coefficient of each frames compared to the average
    frameCorrMat = corrcoef(avgImg, imgMovie(:, :, iFrame), 'rows', 'pairwise');
    % extract the inter-frame correlation coefficient
    frameCorrs(iFrame) = frameCorrMat(1, 2);
end;

end
