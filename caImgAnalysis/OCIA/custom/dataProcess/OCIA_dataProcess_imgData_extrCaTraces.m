%% #OCIA:OCIA_dataProcess_imgData_extrCaTraces
function [isValid, unvalidReason] = OCIA_dataProcess_imgData_extrCaTraces(this, iDWRow, varargin)

% by default, row is valid
isValid = true;
unvalidReason = '';

% get the selected processing steps and this row's calcium data
selProcOpts = this.an.procOptions.id(get(this.GUI.handles.dw.procOptsList, 'Value'));
rawChanData = get(this, iDWRow, 'data'); rawChanData = rawChanData.rawChan.data;
caTracesData = get(this, iDWRow, 'data'); caTracesData = caTracesData.caTraces.data;
% if this processing is not required or if data is not imaging data or if data was already processed, abort
if ~any(strcmp(selProcOpts, 'extrCaTraces')) || ~strcmp(get(this, iDWRow, 'rowType'), 'Imaging data') ...
        || (~isempty(caTracesData) && ~isempty(rawChanData));
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
rowIDTitle = sprintf('Extracting calcium trace for %s (%d)', rowID, iDWRow);

% display message
showMessage(this, sprintf('%s ...', rowIDTitle), 'yellow');

% get the ROISet for this row
ROISet = ANGetROISetForRow(this, iDWRow);
nROIs = size(ROISet, 1); % number of ROIs

% if no ROIs, abort
if ~nROIs; return; end;

% make sure the data is at least partially loaded
DWLoadRow(this, iDWRow, 'partial');
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

% get the imaging data
imgData = get(this, iDWRow, 'data');
imgData = imgData.procImg.data;

% get the first channel to use for the trace extraction from the configuration
firstChan = this.an.img.chanVect(1);
imgDim = size(imgData{firstChan}); % get the image's dimension

% initialize the data set
this.data.img.caTraces{iDWRow} = nan(nROIs, size(imgData{firstChan}, 3));

% background substract images for each channel using the first percentile
for iChan = 1 : numel(imgData); % go through all channels

    if isempty(imgData{iChan}) || imgDim(1) == 0; continue; end;

    % calculate cutoff on the first 10% frames
    nFrames = fix(imgDim(3) * 0.1);
    bgPrctileCutOff = prctile(reshape(imgData{iChan}(:, :, 1 : nFrames), 1, prod(imgDim(1 : 2)) * nFrames), ...
        this.an.img.bgPrctile);
    imgData{iChan} = imgData{iChan} - bgPrctileCutOff; % remove cutoff
    imgData{iChan}(imgData{iChan} < 0) = 0; % flatten so that there are no negative values
        
    % check if the processing should be aborted
    [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

end;

% get the YFP or GFP data
YFPData = imgData{this.an.img.chanVect(1)};

% use CFP if there is a second channel
if numel(this.an.img.chanVect) > 1;
    CFPData = imgData{this.an.img.chanVect(2)};
else
    CFPData = [];
end;

downSampFactor = this.an.an.channelDownSampFactor;
if ~downSampFactor; downSampFactor = 1; end;
caTraces = nan(nROIs, floor(size(YFPData, 3) / downSampFactor));
chanStats = nan(nROIs, floor(size(YFPData, 3) / downSampFactor), numel(this.an.img.chanVect));
defaultFrameRate = this.an.img.defaultFrameRate;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

% process each ROI
for iROI = 1 : nROIs;

    % extract the time series for each pixel
    YFPTimeSeries = GetRoiTimeseries(YFPData, ROISet{iROI, 2});
    % get a threshold for the number of NaN pixels
    nonNaNPixelNumberThreshold = round(size(YFPTimeSeries, 1) * 0.15);
    % get how many pixels are NaN for each frame
    NaNPixelsTimeSeries = sum(~isnan(YFPTimeSeries));
    % remove bad frames where more than the threshold pixels are NaN, which gives an unreliable average
    YFPTimeSeries(:, NaNPixelsTimeSeries < nonNaNPixelNumberThreshold) = NaN;    
    % get the average of all pixels
    YFP = nanmean(YFPTimeSeries, 1)';
    
    % apply the same for the CFP data (second channel) if it exists
    if ~isempty(CFPData);
        % extract the time series for each pixel
        CFPTimeSeries = GetRoiTimeseries(CFPData, ROISet{iROI, 2});
        % remove bad frames where more than the threshold pixels are NaN, which gives an unreliable average
        CFPTimeSeries(:, NaNPixelsTimeSeries < nonNaNPixelNumberThreshold) = NaN;    
        % get the average of all pixels
        CFP = nanmean(CFPTimeSeries, 1)';
    else
        CFP = [];
    end;

    % apply filter on traces if required
    if this.an.an.channelSFGiltFrameSize > 1;
        YFP = sgolayfilt(YFP, 1, this.an.an.channelSFGiltFrameSize);
        if ~isempty(CFP);
            CFP = sgolayfilt(CFP, 1, this.an.an.channelSFGiltFrameSize);
        end;
    end;

    % apply downsampling on traces if required
    if downSampFactor > 1;
        YFP = interp1DS(defaultFrameRate, defaultFrameRate / downSampFactor, YFP);
        YFP = YFP(1 : size(caTraces, 2));
        if ~isempty(CFP);
            CFP = interp1DS(defaultFrameRate, defaultFrameRate / downSampFactor, CFP);
            CFP = CFP(1 : size(caTraces, 2));
        end;
    end;

    % get the raw traces for each channel
    chanStats(iROI, :, 1) = YFP;
    if ~isempty(CFP);
        chanStats(iROI, :, 2) = CFP;
    end;

    % extract the dFF/dRR from the channels    
    caTraces(iROI, :) = extractDFFDRR(YFP, CFP, this.an.img.f0method, this.an.img.f0params, ...
        this.an.img.polyfitCorrect, this.an.img.polyfitFraction, this.an.img.expfitCorrect, ...
        this.an.img.expfitWindow, defaultFrameRate, sprintf('%s_%03d_ROI%s', rowID, iDWRow, ...
        ROISet{iROI, 1}), [], doPlots);
        
    % check if the processing should be aborted
    [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

end;

% store the raw traces 
this.dw.table{iDWRow, strcmp(this.dw.tableIDs, 'data')}.rawChan.data = chanStats;
this.dw.table{iDWRow, strcmp(this.dw.tableIDs, 'data')}.rawChan.loadStatus = 'full';

% store the calcium traces
this.dw.table{iDWRow, strcmp(this.dw.tableIDs, 'data')}.caTraces.data = caTraces;
this.dw.table{iDWRow, strcmp(this.dw.tableIDs, 'data')}.caTraces.loadStatus = 'full';

end
