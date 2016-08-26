%% #OCIA:OCIA_dataProcess_imgData_moCorr_TurboReg
function [isValid, unvalidReason] = OCIA_dataProcess_imgData_moCorr_TurboReg(this, iDWRow, varargin)

% by default, row is valid
isValid = true;
unvalidReason = '';

% get the selected processing steps and this row's processing state
selProcOpts = this.an.procOptions.id(get(this.GUI.handles.dw.procOptsList, 'Value'));
rowProcState = getData(this, iDWRow, 'procImg', 'procState');
% if this processing is not required or if data is not imaging data or if data was already processed, abort
if ~any(strcmp(selProcOpts, 'moCorr')) || ~strcmp(get(this, iDWRow, 'rowType'), 'Imaging data') ...
        || any(strcmp(rowProcState, 'moCorr'));
    return;
end;

% get whether to do plots or not
if nargin > 2;  doPlots = varargin{1};
else            doPlots = 0;
end;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%% init
rowID = DWGetRowID(this, iDWRow);
rowIDTitle = sprintf('Motion correction (TurboReg) for %s (%d)', rowID, iDWRow);

% get the transformation for the registration
regTransf = this.an.moCorr.regTransf;

% figCommons = {'NumberTitle', 'off'}; % figure options
figCommons = {'NumberTitle', 'off', 'WindowStyle', 'docked'}; % figure options

% get the ROISet for this row and the row of the reference image
[ROISet, ~, ~, iDWRefRowForROISet, avgImgRefCell] = ANGetROISetForRow(this, iDWRow);
nROIs = size(ROISet, 1);
% make sure we have an image and not a cell, use the specified pre-procesing channel if required
if iscell(avgImgRefCell);   avgImgRef = avgImgRefCell{this.an.img.preProcChan};
else                        avgImgRef = avgImgRefCell;
end;

% if no reference average image, try to fetch it from the ROIDrawer
if isempty(avgImgRef);
    currentMode = this.main.modes{get(this.GUI.handles.changeMode, 'Value'), 1};
    selRDTableRow = get(this.GUI.handles.rd.tableList, 'Value');
    % if we are in ROIDrawer mode and there is a selected row in the run table
    if strcmp(currentMode, 'ROIDrawer') && ~isempty(this.rd.selectedTableRows) && ~isempty(selRDTableRow);
        % get the row index of the DataWatcher's table
        iDWRefRow = this.rd.selectedTableRows(selRDTableRow(1));
        % get the reference average image as the mean of pre-processed frames
        imgDataRefRow = get(this, iDWRefRow, 'data');
        avgImgRefCell = imgDataRefRow.procImg.data;
        avgImgRef = nanmean(avgImgRefCell{this.an.img.preProcChan}, 3);
    end;
end;

% if no reference average image, try to fetch it from this row's data
if isempty(avgImgRef);
    showWarning(this, 'OCIA:OCIA_dataProcess_imgData_moCorr_TurboReg:NoReferenceImage', ...
        sprintf('%s: No reference image found. Aligning this row to itself ...', rowIDTitle));
    % get the reference average image as the mean of pre-processed frames
    imgDataRefRow = get(this, iDWRow, 'data');
    avgImgRefCell = imgDataRefRow.procImg.data;
    avgImgRef = nanmean(avgImgRefCell{this.an.img.preProcChan}, 3);
end;

% if no reference average image, abort
if isempty(avgImgRef);
    showWarning(this, 'OCIA:OCIA_dataProcess_imgData_moCorr_TurboReg:NoReferenceImage', ...
        sprintf('%s: No reference image found. Aborting.', rowIDTitle));
    isValid = false;
    return;
end;

% if no ROIs, create a fake ROISet
if ~nROIs;
    % create the fake ROISet
    imgDim = size(avgImgRef);
    [ROISet, nROIs] = createFakeROISet(imgDim(1:2), imgDim(1) * 0.05, 20, 20);
end;

% make sure the data is fully loaded
DWLoadRow(this, iDWRow, 'full');
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%% prepare reference image and frames to register
% get the imaging data
imgData = getData(this, iDWRow, 'procImg', 'data');

% get the average of all frames of the pre-processing channel for this row
avgImg = nanmean(imgData{this.an.img.preProcChan}, 3);

% get the movie of all frames of pre-processing channel
imgMovie = imgData{this.an.img.preProcChan};
imgDim = size(imgMovie);

% if requested, apply a "small" gaussian filtering on the movie to have enhanced registration
if this.an.moCorr.useFilt;
    filtTic = tic; % for performance timing purposes    
    % save the unfiltered movie
    imgMovieUnFilt = imgMovie;
    imgMovie = zeros(imgDim);
    parfor iFrame = 1 : imgDim(3);
%         imgMovie(:, :, iFrame) = imfilter(imgMovieUnFilt(:, :, iFrame), fspecial('gaussian', 2, 1), 'replicate');
        imgMovie(:, :, iFrame) = medfilt2(imgMovieUnFilt(:, :, iFrame), [2 2], 'symmetric');
%         imgMovie(:, :, iFrame) = PseudoFlatfieldCorrect(imgMovieUnFilt(:, :, iFrame));
    end;
    o('%s: filtering done (%3.1f sec).', rowIDTitle, toc(filtTic), 2, this.verb);
end;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%% get reference point
percBoundBox = 0.04; % percent of image around the ROI's bounding box

% if an ROISet was found, take the brightest ROI as a reference point
if nROIs;
    
    % take brightest ROI(s) as reference point. Note that different registration methods need different
    %   number of reference points
    if strcmpi(regTransf, 'translation');
        nBrightROIs = 1;
    elseif any(strcmpi(regTransf, {'affine', 'rigidBody'}));
        nBrightROIs = 3;
    elseif strcmpi(regTransf, 'bilinear');
        nBrightROIs = 4;
    end;
    
    % get the ROISet of the brightest ROI(s)
    brightROISet = getBrightROIs(ROISet, avgImgRef, nBrightROIs, percBoundBox, doPlots - 1);
    % store the coordinates of those ROIs
    refPpoints = zeros(nBrightROIs, 2);
    for iBrightROI = 1 : nBrightROIs;
        % get the indexes of the mask and calculate the center of it
        [maskYVals, maskXVals] = ind2sub(imgDim([1, 2]), find(brightROISet{iBrightROI, 4}));
        refPpoints(iBrightROI, :) = round([nanmean(maskXVals), nanmean(maskYVals)]);
    end;
    
    if doPlots > 0;
        figure('Name', sprintf('%s: landmarks', rowIDTitle), figCommons{:});
        imshow(linScale(avgImgRef));
        hold on;
        scatter(refPpoints(:, 1), refPpoints(:, 2), 'bx');
        text(refPpoints(:, 1) - imgDim(1) * 0.03, refPpoints(:, 2) - imgDim(2) * 0.03, ...
            num2cell(1 : nBrightROIs), 'Color', 'red');
    end;
    
    % transform the coordinates into source-target pairs (src1X src1Y targ1X targ1Y src2X src2Y targ2X targ2Y ...)
    refPointsBlock = zeros(1, numel(refPpoints) * 2);
    for iBrightROI = 1 : nBrightROIs;
        refPointsBlock((iBrightROI - 1) * 4 + 1) = refPpoints(iBrightROI, 1);
        refPointsBlock((iBrightROI - 1) * 4 + 2) = refPpoints(iBrightROI, 2);
        refPointsBlock((iBrightROI - 1) * 4 + 3) = refPpoints(iBrightROI, 1);
        refPointsBlock((iBrightROI - 1) * 4 + 4) = refPpoints(iBrightROI, 2);
    end;

% otherwise leave empty and center of frame will be used
else
    refPointsBlock = [];
end;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%% perform the registration
% any NaN frame will remain NaN
showMessage(this, sprintf('%s: aligning frames ...', rowIDTitle), 'yellow');
pause(0.01);
regTic = tic; % for performance timing purposes
[imgMovieReg, targPoints, srcPoints, regTimes] = turboReg(imgMovie, avgImgRef, regTransf, 10, refPointsBlock, doPlots - 1);
showMessage(this, sprintf('%s: aligning frames done (%s, %.3f sec, align. time: %.0f +- %.0f msec).', ...
    rowIDTitle, regTransf, toc(regTic), nanmean(regTimes) * 1000, nanstd(regTimes) * 1000));

% get the non-empty reference points
nonEmptyPoints = sum(sum(srcPoints, 1), 3) ~= 0;
% remove the empty reference points
srcPoints = srcPoints(:, nonEmptyPoints, :);
targPoints = targPoints(:, nonEmptyPoints, :);
% get the number of points
nRegPoints = size(srcPoints, 2);

% if there are less than 3 reference points (translation, nRegPoints = 1), applying transformation with
%   affine transformation type will not work, so create new reference points with same translation
if nRegPoints == 1 && nROIs;
    
    % get a new ROISet of the brightest ROI(s)
    newBrightROISet = getBrightROIs(ROISet, avgImgRef, 3, percBoundBox, 0);
    % store the coordinates of those ROIs
    refPoints = zeros(size(newBrightROISet, 1), 2);
    for iNewBrightROI = 1 : size(newBrightROISet, 1);
        % get the indexes of the mask and calculate the center of it
        [maskYVals, maskXVals] = ind2sub(imgDim([1, 2]), find(newBrightROISet{iNewBrightROI, 4}));
        refPoints(iNewBrightROI, :) = round([nanmean(maskXVals), nanmean(maskYVals)]);
    end;
    
    % extract the translations
    translationShifts = squeeze(srcPoints(:, 1, :) - targPoints(:, 1, :));
    
    % recreate the source and target points using now 3 points
    targPoints = zeros(imgDim(3), 3, 2);
    srcPoints = zeros(imgDim(3), 3, 2);
    for iPoint = 1 : 3;
        targPoints(:, iPoint, :) = repmat(refPoints(iPoint, :), imgDim(3), 1);
        srcPoints(:, iPoint, :) = squeeze(targPoints(:, iPoint, :)) + translationShifts;
    end;
    
    % get the new number of points
    nRegPoints = size(srcPoints, 2);
    
end;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%% apply registration to channels
applyTic = tic; % for performance timing purposes
% apply the motion correction to all channels
imgDataReg = cell(size(imgData)); % create a holder for the data
% go through each required channel
for iChanLoop = 1 : numel(this.an.img.chanVect);
    
    % get the index of the current channel and it's imaging data
    iChan = this.an.img.chanVect(iChanLoop);
    imgDataChan = imgData{iChan};
    
    showMessage(this, sprintf('%s: applying transformation to channel %d ...', rowIDTitle, iChan), 'yellow');
    
    % go through each frame and apply the subpixel translation
    imgMovieTrans = zeros(imgDim);
    
    % transform all frames one by one
    parfor iFrame = 1 : imgDim(3);
        frame = imgDataChan(:, :, iFrame); % get the frame
        inPoints = squeeze(srcPoints(iFrame, :, :));
        basePoints = squeeze(targPoints(iFrame, :, :));
        % get the transformation matrix
        tForm = cp2tform(inPoints, basePoints, 'affine'); %#ok<DCPTF>
        % get the transformed frame
        tFrame = imtransform(frame, tForm, 'XData', [1, imgDim(2)], 'YData', [1, imgDim(1)], ...
            'FillValues', NaN); %#ok<DIMTRNS,PFBNS>
        % store the frame
        imgMovieTrans(:, :, iFrame) = tFrame;
    end;
    
    % store the corrected frames
    imgDataReg{iChan} = imgMovieTrans;
        
    % check if the processing should be aborted
    [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

end;

showMessage(this, sprintf('%s: applying transformation done (%.3f sec).', rowIDTitle, toc(applyTic)));


%% quality control & storage
qcTic = tic; % for performance timing purposes
% get the reference frame
if iscell(avgImgRefCell);   avgImgRefQC = avgImgRefCell{this.an.img.chanVect(1)};
else                        avgImgRefQC = avgImgRefCell;
end;
avgImgRefQC = nanmean(avgImgRefQC, 3);
% get the correlations for the frames before motion correction
framesBefore = imgData{this.an.img.chanVect(1)};
avgImgBefore = nanmean(framesBefore, 3);
frameCorrBefore = prctile(getFrameCorr(avgImgRefQC, framesBefore), 1);
frameCorrToRefBefore = getFrameCorr(avgImgRefQC, avgImgBefore);
% get the correlations for the frames after motion correction
framesAfter = imgDataReg{this.an.img.chanVect(1)};
avgImgAfter = nanmean(framesAfter, 3);
frameCorrAfter = prctile(getFrameCorr(avgImgRefQC, framesAfter), 1);
frameCorrToRefAfter = getFrameCorr(avgImgRefQC, avgImgAfter);
% get the thresholds
meanFrameCorrDiffThresh = this.an.moCorr.meanFrameCorrDiffThresh;
frameCorrToRefDiffThresh = this.an.moCorr.frameCorrToRefDiffThresh;
frameCorrToRefAbsThresh = this.an.moCorr.frameCorrToRefAbsThresh;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%% plotting

% get the average of all frames of corrected movie
avgImgRegTurboReg = nanmean(imgMovieReg, 3);
% get the average of all frames of the pre-processing channel
avgImgReg = nanmean(imgDataReg{this.an.img.preProcChan}, 3);
% use the functional channel if the alignement has not been applied to the pre-processing channel
if isempty(avgImgReg);
    avgImgReg = nanmean(imgDataReg{this.an.img.chanVect(1)}, 3);
end;

    
% get the shifts applied
shifts = srcPoints - targPoints;
maxShift = ceil(max(abs(shifts(:)))) + 1;

% get the imaging data, both none-registered and registerd
imgMovieNoReg = imgData{this.an.img.preProcChan};
imgMovieWithReg = imgDataReg{this.an.img.preProcChan};
% use the functional channel if the alignement has not been applied to the pre-processing channel
if isempty(imgMovieWithReg);
    imgMovieNoReg = imgData{this.an.img.chanVect(1)};
    imgMovieWithReg = imgDataReg{this.an.img.chanVect(1)};
   if iscell(avgImgRefCell);
        avgImgRef = avgImgRefCell{this.an.img.chanVect(1)};
    else
        avgImgRef = mean(imgMovieNoReg, 3);
    end;
end;

% get the ROISet of the brightest ROI(s)
frameCorrBrightROISet = getBrightROIs(ROISet, avgImgRef, nROIs - 1, percBoundBox, 0);

% calculate frame-wise correlation only on brightest ROIs
frameCorrNoReg = nanmean(getFrameCorrROI(frameCorrBrightROISet, percBoundBox, avgImgRef, imgMovieNoReg), 1);
frameCorrWithReg = nanmean(getFrameCorrROI(frameCorrBrightROISet, percBoundBox, avgImgRef, imgMovieWithReg), 1);

% if requested, plot a figure illustrating the result of the motion correction
if doPlots > 0;

    % summary images
    figure('Name', sprintf('%s: average images before/after correction', rowIDTitle), figCommons{:});
    subplot(2, 2, 1); imshow(linScale(avgImgRef));          title('Reference');
    subplot(2, 2, 2); imshow(linScale(avgImg));             title('Original');
    subplot(2, 2, 3); imshow(linScale(avgImgReg));          title('Transformed');
    subplot(2, 2, 4); imshow(linScale(avgImgRegTurboReg));  title('Registered');
    
    figure('Name', sprintf('%s: mean frame movements and correlation', rowIDTitle), figCommons{:});
    subplot(2, 1, 1);
    hold on;
    plot(1 : imgDim(3), nanmean(shifts(:, :, 1), 2), 'r');
    plot(1 : imgDim(3), nanmean(shifts(:, :, 2), 2), 'b');
    legend('XShift', 'YShift');
    ylim([-maxShift maxShift]); xlim([0 imgDim(3) + 1]);
    title('Frame movements');
    xlabel('Frames'); ylabel('Shift [pixel]');
    subplot(2, 1, 2);
    hold on;
    plot(1 : imgDim(3), frameCorrNoReg, 'r');
    plot(1 : imgDim(3) + 0.3, frameCorrWithReg, 'b');
    legend('No reg.', sprintf('%s reg.', regTransf));
    ylim([0 1]); xlim([0 imgDim(3) + 1]);
    title(sprintf('Frame-wise correlations (using bounding box area of %d ROIs)', size(frameCorrBrightROISet, 1)));
    xlabel('Frames'); ylabel('Correlation');

end;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

% check quality
if frameCorrAfter - frameCorrBefore < meanFrameCorrDiffThresh ...
        || frameCorrToRefAfter - frameCorrToRefBefore < frameCorrToRefDiffThresh ...
        || frameCorrToRefAfter < frameCorrToRefAbsThresh;
    
    % if the current row is not the reference row, quality control is failed
    if iDWRefRowForROISet ~= iDWRow;
        showWarning(this, 'OCIA:OCIA_dataProcess_imgData_moCorr_TurboReg:QualityControlFail', ...
            sprintf(['%s: registration quality control failed: mean frame-wise correlation to the reference: ', ...
            'before: %.4f, after: %.4f, correlation of average image to reference: before: %.4f, after: %.4f.'], ...
            rowIDTitle, frameCorrBefore, frameCorrAfter, frameCorrToRefBefore, frameCorrToRefAfter));
        
        % summary images
        figH = figure('Name', sprintf('%s: average images before/after correction', rowIDTitle), figCommons{:});
        colormap('gray');
        subplot(2, 2, 1); imagesc(linScale(avgImgRef));
        title('Reference'); set(gca, 'XTick', [], 'YTick', []); axis('square');
        subplot(2, 2, 2); imagesc(linScale(avgImg));
        title('Original'); set(gca, 'XTick', [], 'YTick', []); axis('square');
        subplot(2, 2, 3); imagesc(linScale(avgImgReg));
        title('Transformed'); set(gca, 'XTick', [], 'YTick', []); axis('square');
        subplot(2, 2, 4); imagesc(linScale(avgImgRegTurboReg)); 
        title('Registered'); set(gca, 'XTick', [], 'YTick', []); axis('square');
        
        if exist('moCorrFailedQC', 'dir') ~= 7; mkdir('moCorrFailedQC'); end;
        rowInfos = get(this, iDWRow, { 'animal', 'spot', 'day', 'time' });
        rowInfos = regexprep(regexprep(rowInfos, '_', ''), 'moubl', '');
        savePath = sprintf('%s/moCorrFailedQC/%s_%s_%s_%s_moCorrFailedQCImages', regexprep(pwd(), '\', '/'), rowInfos{:});
        tightfig(figH);
        set(figH, 'Position', [10 10 1200 1200]);
        saveas(figH, savePath, 'png');
        close(figH);
        
        figH = figure('Name', sprintf('%s: mean frame movements and correlation', rowIDTitle), figCommons{:});
        subplot(2, 1, 1);
        hold on;
        plot(1 : imgDim(3), nanmean(shifts(:, :, 1), 2), 'r');
        plot(1 : imgDim(3), nanmean(shifts(:, :, 2), 2), 'b');
        legend('XShift', 'YShift');
        ylim([-maxShift maxShift]); xlim([0 imgDim(3) + 1]);
        title('Frame movements');
        xlabel('Frames'); ylabel('Shift [pixel]');
        subplot(2, 1, 2);
        hold on;
        plot(1 : imgDim(3), frameCorrNoReg, 'r');
        plot(1 : imgDim(3) + 0.3, frameCorrWithReg, 'b');
        legend('No reg.', sprintf('%s reg.', regTransf));
        ylim([0 1]); xlim([0 imgDim(3) + 1]);
        title(sprintf('Frame-wise correlations (using bounding box area of %d ROIs)', size(frameCorrBrightROISet, 1)));
        xlabel('Frames'); ylabel('Correlation');
        savePath = sprintf('%s/moCorrFailedQC/%s_%s_%s_%s_moCorrFailedQCShifts', regexprep(pwd(), '\', '/'), rowInfos{:});
        tightfig(figH);
        set(figH, 'Position', [10 10 1200 1200]);
        saveas(figH, savePath, 'png');
        close(figH);
        
        % if the non-corrected should nevertheless be used, return by specifiying the row as valid
        if this.an.moCorr.useNonCorrectedIfQualityControlFailed;
            isValid = true;
            showMessage(this, sprintf('%s: quality control failed, using the non-corrected frames (row is valid).', ...
                rowIDTitle));
            return;
            
        % if the non-corrected should not be used, return by specifiying the row as not valid
        else
            showMessage(this, sprintf('%s: quality control failed, row is not valid.', rowIDTitle));
            isValid = false;
        end;
        
    % if the current row is the reference row, quality control is not really failed since the correlations can anyway
    % not improve
    else
        showMessage(this, sprintf(['%s: quality control done (mean corr. diff.: %+.4f, corr. avg. diff: %+.4f, ', ...
            'corr. to ref: %.4f, ref row, %.3f sec).'], rowIDTitle, frameCorrAfter - frameCorrBefore, ...
            frameCorrToRefAfter - frameCorrToRefBefore, frameCorrToRefAfter, toc(qcTic)));
    end;
    
% quality control passed
else
    showMessage(this, sprintf(['%s: quality control done (mean corr. diff.: %+.4f, corr. avg. diff: %+.4f, ', ...
        'corr. to ref: %.4f, %.3f sec).'], rowIDTitle, frameCorrAfter - frameCorrBefore, ...
        frameCorrToRefAfter - frameCorrToRefBefore, frameCorrToRefAfter, toc(qcTic)));
end;

% store the pre-processed data (only for non-empty channels)
for iChan = 1 : numel(imgDataReg);
    if ~isempty(imgDataReg{iChan});
        this.dw.table{iDWRow, strcmp(this.dw.tableIDs, 'data')}.procImg.data{iChan} = imgDataReg{iChan};
    end;
end;

% mark row as processed for motion correction
setData(this, iDWRow, 'procImg', 'procState', [rowProcState { 'moCorr' }]);

end
