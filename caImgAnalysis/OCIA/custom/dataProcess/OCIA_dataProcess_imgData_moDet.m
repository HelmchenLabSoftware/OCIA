%% #OCIA:OCIA_dataProcess_imgData_moDet
function [isValid, unvalidReason] = OCIA_dataProcess_imgData_moDet(this, iDWRow, varargin)

% by default, row is valid
isValid = true;
unvalidReason = '';

% get the selected processing steps and this row's processing state
selProcOpts = this.an.procOptions.id(get(this.GUI.handles.dw.procOptsList, 'Value'));
rowProcState = getData(this, iDWRow, 'procImg', 'procState');
% if this processing is not required or if data is not imaging data or if data was already processed, abort
if ~any(strcmp(selProcOpts, 'moDet')) || ~strcmp(get(this, iDWRow, 'rowType'), 'Imaging data') ...
        || any(strcmp(rowProcState, 'moDet'));
    return;
end;

% get whether to do plots or not
if nargin > 2;  doPlots = varargin{1};
else            doPlots = 0;
end;

% get whether to do plots or not
if nargin > 3;  iRun = varargin{2};
else            iRun = 1;
end;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%% init
rowID = DWGetRowID(this, iDWRow);
rowIDTitle = sprintf('Motion detection (Z) for %s (%d)', rowID, iDWRow);

% figCommons = {'NumberTitle', 'off'}; % figure options
figCommons = {'NumberTitle', 'off', 'WindowStyle', 'docked'}; % figure options

% get the ROISet for this row and the row of the reference image
[ROISet, ~, ~, ~, avgImgRefCell] = ANGetROISetForRow(this, iDWRow);
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
        avgImgRef = nanmean(imgDataRefRow.procImg.data{this.an.img.preProcChan}, 3);
    end;
end;

% if no reference average image, abort
if isempty(avgImgRef);
    showWarning(this, 'OCIA:OCIA_dataProcess_imgData_moDet:NoReferenceImage', ...
        sprintf('%s: No reference image found. Aborting.', rowIDTitle));
    isValid = false;
    return;
end;

% if no ROISet found, create fake ROISet
if ~nROIs;
    o('%s: no ROISet found, using fake ROIs ...', mfilename(), 2, this.verb);
    % make sure data is fully loaded
    DWLoadRow(this, iDWRow, 'full');
    % check if the processing should be aborted
    [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;
    % get the imaging data
    imgData = get(this, iDWRow, 'data');
    imgData = imgData.procImg.data;
    imgDim = size(imgData{this.an.img.preProcChan});
    % create the fake ROISet
    [ROISet, nROIs] = createFakeROISet(imgDim(1:2), imgDim(1) * 0.05, 10, 10);
end;

showMessage(this, sprintf('%s ...', rowIDTitle), 'yellow');

% make sure the data is fully loaded
DWLoadRow(this, iDWRow, 'full');
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%% prepare reference image and frames
% get the imaging data
imgData = get(this, iDWRow, 'data');
imgData = imgData.procImg.data;

% get the average of all frames of the pre-processing channel
avgImg = nanmean(imgData{this.an.img.chanVect(1)}, 3);
avgImgOri = avgImg; % save a copy of the original

% get the movie of all frames of pre-processing channel
imgMovie = imgData{this.an.img.chanVect(1)};
imgMovieOri = imgMovie; % save a copy of the original
imgDim = size(imgMovie);

%% filter frames if requested
% if requested, apply a "small" filtering on the movie to have enhanced correlations
if this.an.moDet.useFilt;
    filtTic = tic; % for performance timing purposes
    imgMovie = zeros(imgDim);
    f = fspecial('gaussian', 2, 1);
    parfor iFrame = 1 : imgDim(3);
        imgMovie(:, :, iFrame) = imfilter(imgMovieOri(:, :, iFrame), f, 'replicate');
%         imgMovie(:, :, iFrame) = medfilt2(imgMovieOri(:, :, iFrame), [2 2], 'symmetric');
    end;
    
    % get a filtered version of the reference average
    avgImgRef = imfilter(avgImgRef, f, 'replicate');
    o('%s: filtering done (%3.1f sec).', rowIDTitle, toc(filtTic), 2, this.verb);
end;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

% %{
%% ROI-pooled frame correlation based on a "bright" ROISet
percBoundBox = 0.04; % percent of image around the ROI's bounding box
% use only the 50% brightest ROIs, but at least 25 ROIs but not more than "nROIs" ROIs
nBrightROIs = min(max(round(nROIs * 0.5), 25), nROIs);
% get the ROISet of the brightest ROIs
brightROISet = getBrightROIs(ROISet, avgImgRef, nBrightROIs, percBoundBox, doPlots - 1);

% calculate and store the correlation of each ROI's image to the average image
frameCorrsROI = getFrameCorrROI(brightROISet, percBoundBox, avgImgRef, imgMovie);
% average the correlations obtained from the bright ROIs
frameCorrs = nanmean(frameCorrsROI);
%}

%{
%% Frame-wise correlation
frameCorrs = getFrameCorr(avgImgRef, imgMovie);
%}

%% calculate thresholds
frameCorrMed = nanmedian(frameCorrs); % get the median if the correlations obtained from the bright ROIs
frameCorrStd = nanstd(frameCorrs); % get the standard deviation of the correlations obtained from the bright ROIs

% get the out of focuse correlation drop tolerance based on the standard deviation
correlationDropTolerance = max(this.an.moDet.threshFactor * frameCorrStd, 0.1);
% create a threshold under which frames are classified as out of focus and should be excluded
outOfFocusThresh = frameCorrMed - correlationDropTolerance;
% create a threshold where the correlation is good enough again that frames can be classified as in focus again
backInFocusThresh = frameCorrMed - correlationDropTolerance * 0.25;
o('%s: thresholds: median: %.3f, correlation drop tolerance: %.3f, out of focus: %.3f, back in focus: %.3f.', ...
    rowIDTitle, frameCorrMed, correlationDropTolerance, outOfFocusThresh, backInFocusThresh, 2, this.verb);


%% get frames to exclude
% get the excluded frames and the "mask" corresponding to them
exclFrameMask = frameCorrs < outOfFocusThresh;
exclFrames = find(exclFrameMask); % get the excluded frames' indexes

% if removing single frames is allowed, do not exclude no-neighbor frames
if ~this.an.moDet.removeSingleFrames;
    % do not exclude frames that have no neighboring excluded frames
    toRemoveExclFrames = false(1, imgDim(3));
    nMinNeighbors = 3;
    for iFrame = 2 : imgDim(3) - 1;
        if ismember(iFrame, exclFrames);
            nNeighbors = sum(ismember(iFrame - (nMinNeighbors - 1) : iFrame + (nMinNeighbors - 1), exclFrames));
            toRemoveExclFrames(iFrame) = nNeighbors < nMinNeighbors;
        end;
    end;
    % remove the frames that had no neighbors
    exclFrames(ismember(exclFrames, find(toRemoveExclFrames))) = [];
end;

% build the excluded frame "mask"
exclFrames = sort(exclFrames);
exclFrameMask = false(1, imgDim(3));
exclFrameMask(exclFrames) = true;
exclFrameMaskBeforeExt = exclFrameMask; % get a copy before exclusion extension
% show message
plurFrame = ''; if exclFrames; plurFrame = 's'; end; % get the plural mark
o('%s: found %d frame%s to exclude before extension (%.1f%%).', ...
    rowIDTitle, numel(exclFrames), plurFrame, 100 * numel(exclFrames) / imgDim(3), 2, this.verb);
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%% frame exclusion extension to neighbors
% extend the excluded frames to the neighboring frames so that all motion is removed. The excluded frames are
%   processed as a queue
extTic = tic; % for performance timing purposes
exclFrameQueue = exclFrames; % create the queue
if doPlots > 2; figure('Name', sprintf('%s: frame correlations', rowIDTitle), figCommons{:}); end;
while ~isempty(exclFrameQueue);
    iFrame = exclFrameQueue(1); % get the first element
    elemReplaced = 0; % set a flag to see if element was replaced, otherwise it should be removed
    
    % check if the previous frame should be excluded: not first frame & not already in queue or in excluded frames & 
    %   corr. coef. not above back in focus threshold & corr. coef. higher than current frame (going up the slope)
%     if iFrame > 1 && ~ismember(iFrame - 1, exclFrameQueue) && ~ismember(iFrame - 1, exclFrames) ...
%             && frameCorrs(iFrame - 1) < backInFocusThresh && frameCorrs(iFrame - 1) > frameCorrs(iFrame);
    if iFrame > 1 && ~ismember(iFrame - 1, exclFrameQueue) && ~ismember(iFrame - 1, exclFrames) ...
            && frameCorrs(iFrame - 1) < backInFocusThresh;
        % add the frame to the excluded frames
        exclFrames(end + 1) = iFrame - 1; %#ok<AGROW>
        % add the frame to the queue in place of the currently processed frame
        exclFrameQueue(1) = iFrame - 1;
        elemReplaced = true;
    end;
    
    % check if the next frame should be excluded: not last frame & not already in queue or in excluded frames & 
    %   corr. coef. not above back in focus threshold & corr. coef. higher than current frame (going up the slope)
%     if iFrame < imgDim(3) && ~ismember(iFrame + 1, exclFrameQueue) && ~ismember(iFrame + 1, exclFrames) ...
%             && frameCorrs(iFrame + 1) < backInFocusThresh && frameCorrs(iFrame + 1) > frameCorrs(iFrame);
    if iFrame < imgDim(3) && ~ismember(iFrame + 1, exclFrameQueue) && ~ismember(iFrame + 1, exclFrames) ...
            && frameCorrs(iFrame + 1) < backInFocusThresh;
        % add the frame to the excluded frames
        exclFrames(end + 1) = iFrame + 1; %#ok<AGROW>
        % if element was not already replaced, add the frame to the queue in place of the currently processed frame
        if ~elemReplaced;
            exclFrameQueue(1) = iFrame + 1;
        else % otherwise extend the queue
            exclFrameQueue(end + 1) = iFrame + 1; %#ok<AGROW>
        end;
        elemReplaced = true;
    end;
    
    % if the element was not replaced by another neighbor, remove it from the queue without any replacement
    if ~elemReplaced; exclFrameQueue(1) = []; end;
    
end

% sort the excluded frames and re-create the mask
exclFrames = sort(exclFrames);
exclFrameMask = false(1, imgDim(3));
exclFrameMask(exclFrames) = true;
plurFrame = ''; if exclFrames; plurFrame = 's'; end; % get the plural mark
o('%s: found %d frame%s to exclude after extension (%.1f%%) (%3.1f sec).', ...
    rowIDTitle, numel(exclFrames), plurFrame, 100 * numel(exclFrames) / imgDim(3), toc(extTic), 2, this.verb);
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%% debug plotting
if doPlots > 0; % if requested, plot a figure illustrating the motion correction procedure and result

    figure('Name', sprintf('%s: frame correlations', rowIDTitle), figCommons{:});
    
    axeHandles = zeros(2, 1);
    for iSub = 1 : 2;
        subplot(2, 1, iSub);
        plot(frameCorrs, 'g');
        hold on;
        axeHandles(iSub) = gca;
        
        % get the frame correlations and hide those from the excluded frames (before and after extension)
        exclFrameCorrs = frameCorrs;
        if iSub == 1;       exclFrameCorrs(~exclFrameMaskBeforeExt) = NaN;
        elseif iSub == 2;   exclFrameCorrs(~exclFrameMask)          = NaN; end;
        plot(exclFrameCorrs, 'r');
        
        plot([1 imgDim(3)], repmat(frameCorrMed, 1, 2), 'b');
        plot([1 imgDim(3)], repmat(backInFocusThresh, 1, 2), 'k:');
        plot([1 imgDim(3)], repmat(outOfFocusThresh, 1, 2), 'r:');
        
        ylim([0 1]);
        legend({'Valid frame corr.', 'Exc. frame corr.', 'Median', 'back-in-focus thres.', ...
            'out-of-focus thresh.'}, 'FontSize', 8, 'Location', 'SouthEast');
    end;
    linkaxes(axeHandles, 'xy');

    % get the average of all valid frames of the pre-processing channel channel
    avgImgCorr = nanmean(imgData{this.an.img.chanVect(1)}(:, :, ~exclFrameMask), 3);
    % get the average of all non-valid frames of the pre-processing channel channel
    avgImgBadFrames = nanmean(imgData{this.an.img.chanVect(1)}(:, :, exclFrameMask), 3);

    figure('Name', sprintf('%s: average', rowIDTitle), figCommons{:});
    subplot(2, 2, 1); imshow(linScale(avgImgOri)); title('Original');
    subplot(2, 2, 2); imshow(linScale(avgImgRef)); title('Reference');
    subplot(2, 2, 3); imshow(linScale(avgImgBadFrames)); title('Bad frames average');
    subplot(2, 2, 4); imshow(linScale(avgImgCorr)); title('Corrected');
    
end; % end of plotting if case
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%% create a mask
if ~isempty(exclFrames); % if there are some excluded frames, add those to the mask
    
    % create an exclusion mask as a matrix of nROIs x nFrames (similar to the caTraces mask)
    exclMask = ones(nROIs, imgDim(3));
    exclMask(1 : nROIs, exclFrames) = NaN;
    
    % store the exclusion mask
    this.dw.table{iDWRow, strcmp(this.dw.tableIDs, 'data')}.exclMask.data = exclMask;
end;

%{
%% --- #OCIA:AN:MotionDetection: process and store data with motion detection
if ~isempty(exclFrames); % if there are some excluded frames, replace them with NaNs
        % create a corrected data set
    imgDataCorr = imgData;
    % go through each channel
    for iChan = 1 : numel(imgDataCorr);
        % replace the exlcuded frames with NaNs
        imgDataChan = imgDataCorr{iChan};
        % go through each frame and replace it if necessary
        parfor iFrame = 1 : size(imgDataChan, 3);
            if exclFrameMask(iFrame);
                imgDataChan(:, :, iFrame) = nan(size(imgDataChan(:, :, iFrame))); % replace with NaN
            end;
        end;
        imgDataCorr{iChan} = imgDataChan; % copy back the corrected data
    end;

    imgData = imgDataCorr; % copy back the corrected data
    setData(this, iDWRow, 'procImg', 'data', imgData); % store the corrected data
end;

%}

% if a lot of frames where to be excluded, re-run the motion detection
if numel(exclFrames) > imgDim(3) * 0.08 && iRun < 3;
    [isValid, unvalidReason] = OCIA_dataProcess_imgData_moDet(this, iDWRow, doPlots, iRun + 1);
    return;
end;

% mark row as processed for motion detection
setData(this, iDWRow, 'procImg', 'procState', [rowProcState { 'moDet' }]);

end
