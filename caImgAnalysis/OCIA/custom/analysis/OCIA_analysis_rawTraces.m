function OCIA_analysis_rawTraces(this, DWRows, ~)
% OCIA_analysis_rawTraces - [no description]
%
%       OCIA_analysis_rawTraces(this, DWRows, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% remove rows where there is not caTraces data and set the run selecter accordingly
emptyRows = cellfun(@isempty, this.data.img.caTraces(DWRows));
if any(emptyRows)
    DWRows(emptyRows) = [];
    set(this.GUI.handles.an.rowList, 'Value', find(~emptyRows));
    ANShowHideMessage(this, 1, 'Some runs do not have imaging data.');
    pause(1);
end;

if isempty(DWRows);
    ANShowHideMessage(this, 1, 'Problem during plotting.');
    return;
end;
     
this.GUI.an.paramPanConfig = { ...
    'sgfilter', 'an', 'sgFiltFrameSize', 'text',  'numeric', 'Sav.-Gol. filt.', ...
        'Frame size of the Savitzky-Golay filter, value must be an odd number.';
    'downsamp', 'an', 'downSampFactor',  'text',  'numeric', 'Down-sampling factor', ...
        'Temporal down-sampling factor, value must be bigger than 0.';
    'f0method',  'img','f0method',       'text',  'numeric', 'F0/R0 calc. method', ...
        'F0 calculation method: 1 = mean, 2 = median, 3 = percentile, 4 = polyfit, 5 = polyfit averaged';
    'f0param',   'img','f0params',       'text',  'numeric', 'F0/R0 calc. params', ...
        'F0 calculation parameters: for percentile method: Nth percentile, for polyfit method: polyfit degree';
};

% get the axe handle where all the plotting elements should be displayed
anAxe = this.GUI.handles.an.axe;

ratioTempFilt = this.an.an.sgFiltFrameSize;
DSFactor = this.an.an.downSampFactor;

iDWRow = DWRows(1);
nRows = numel(DWRows);
rowID = regexprep(sprintf('rows_%s', sprintf('%d-', DWRows)), '-$', '');

% get the ROISet of the first row
ROISet = ANGetROISetForRow(this, iDWRow);

% convert ROI names to 3-digits format
nROIs = size(ROISet, 1);
for iROI = 1 : nROIs;
    if strcmp(ROISet{iROI, 1}, 'NPil'); continue; end;
    ROISet{iROI, 1} = sprintf('%03d', str2double(ROISet{iROI, 1}));
end;

% if no ROIs found, abort.
if ~nROIs;
    ANShowHideMessage(this, 1, 'No ROISet found.');
    return;
end;

% if no ROI list exists yet, fill the list
if isempty(get(this.GUI.handles.an.ROIList, 'String'));
    ROISelRange = 1 : nROIs;
    set(this.GUI.handles.an.ROIList, 'String', ROISet(:, 1), 'Value', 1 : nROIs);
% otherwise, restrict the ROIs for the analysis to the selected ones
else
    ROISelRange = get(this.GUI.handles.an.ROIList, 'Value'); % get the selected range
    ROISelRange(ROISelRange > nROIs) = [];
end;

% only plot one ROI
ROISelRange = ROISelRange(1);
iROI = ROISelRange(1);
set(this.GUI.handles.an.ROIList, 'Value', ROISelRange);

% loop through each run
ANShowHideMessage(this, 1, 'Background correction ...');
imgDataRows = cell(1, nRows);
for iRow = 1 : nRows;

    iDWRow = DWRows(iRow);
    DWLoadRow(this, iDWRow, 'full');
    
    % get the raw images for this row
    imgDataRows{iRow} = this.data.preProc{iDWRow};
    imgDim = size(imgDataRows{iRow}{this.an.img.preProcChan});

    % background substract images for each channel using the first percentile
    for iChan = 1 : this.an.img.nChans; % go through all channels

        if isempty(imgDataRows{iRow}{iChan}) || imgDim(1) == 0; continue; end;

        % calculate cutoff on the first 10% frames
        nFrames = fix(imgDim(3) * 0.1);
        bgPrctileCutOff = prctile(reshape(imgDataRows{iRow}{iChan}(:, :, 1 : nFrames), 1, prod(imgDim(1 : 2)) * nFrames), ...
            this.an.img.bgPrctile);
        imgDataRows{iRow}{iChan} = imgDataRows{iRow}{iChan} - bgPrctileCutOff; % remove cutoff
        imgDataRows{iRow}{iChan}(imgDataRows{iRow}{iChan} < 0) = 0; % flatten so that there are no negative values

    end;

end;

ANShowHideMessage(this, 1, 'Combining run(s) ...');
YFPDataCell = cellfun(@(imgData)imgData{this.an.img.chanVect(1)}, imgDataRows, 'UniformOutput', false);
YFPData = nan(imgDim(1), imgDim(2), 0);
nNaNs = round(imgDim(3) * 0.1);
for iRow = 1 : nRows;
    YFPData = cat(3, YFPData, YFPDataCell{iRow});
    YFPData = cat(3, YFPData, nan(imgDim(1), imgDim(2), nNaNs));
end;

% use CFP if there is a second channel
if numel(this.an.img.chanVect) > 1;
    CFPDataCell = cellfun(@(imgData)imgData{this.an.img.chanVect(2)}, imgDataRows, 'UniformOutput', false);
    CFPData = nan(imgDim(1), imgDim(2), 0);
    for iRow = 1 : nRows;
        CFPData = cat(3, CFPData, CFPDataCell{iRow});
        CFPData = cat(3, CFPData, nan(imgDim(1), imgDim(2), nNaNs));
    end;
else
    CFPData = [];
end;

defaultFrameRate = this.an.img.defaultFrameRate;

% extract the channels
ANShowHideMessage(this, 1, 'Extracting channels ...');
YFP = nanmean(GetRoiTimeseries(YFPData, ROISet{iROI, 2}), 1)';
if ~isempty(CFPData);
    CFP = nanmean(GetRoiTimeseries(CFPData, ROISet{iROI, 2}), 1)';
else
    CFP = [];
end;

% apply filter on traces if required
if ratioTempFilt > 1;
    ANShowHideMessage(this, 1, 'Filtering ...');
    YFP = sgolayfilt(YFP, 1, ratioTempFilt);
    if ~isempty(CFP);
        CFP = sgolayfilt(CFP, 1, ratioTempFilt);
    end;
end;

% apply downsampling on traces if required
if DSFactor > 1;
    ANShowHideMessage(this, 1, 'Down-sampling ...');
    YFP = interp1DS(defaultFrameRate, defaultFrameRate / DSFactor, YFP);
    YFP = YFP(1 : size(caTraces, 2));
    if ~isempty(CFP);
        CFP = interp1DS(defaultFrameRate, defaultFrameRate / DSFactor, CFP);
        CFP = CFP(1 : size(caTraces, 2));
    end;
end;

% extract the dFF/dRR from the channels
ANShowHideMessage(this, 0, 'Extracting DFF/DRR and plotting ...');
[~, ~, ~, axeHandles] = extractDFFDRR(YFP, CFP, this.an.img.f0method, this.an.img.f0params, ...
    this.an.img.polyfitCorrect, this.an.img.polyfitFraction, defaultFrameRate, ...
    sprintf('%s_%03d_ROI%s', rowID, iDWRow, ROISet{iROI, 1}), anAxe, 1);
this.GUI.handles.an.axe = axeHandles(1);

if ~isempty(this.data.img.exclMask{iDWRow});

    frameCorrRows = cell(1, nRows);
    for iRow = 1 : nRows;
        iDWRow = DWRows(iRow);
        frameCorrRows{iRow} = squeeze(this.data.img.exclMask{iDWRow}(:, :, 2));
    end;

    frameCorrCell = cellfun(@(frameCorr)frameCorr{2}, frameCorrRows, 'UniformOutput', false);
    frameCorr = nan(1, 0);
    for iRow = 1 : nRows;
        frameCorr = cat(2, frameCorr, frameCorrCell{iRow});
        frameCorr = cat(2, frameCorr, nan(1, nNaNs));
    end;

    t = (1 : numel(frameCorr)) / defaultFrameRate;
    hold(anAxe, 'on');
    yLims = get(anAxe, 'YLim');
    offsetY = round(yLims(2));
    plot(anAxe, t, frameCorr + offsetY, 'r');
    YTick = get(anAxe, 'YTick');
    YTickLabel = get(anAxe, 'YTickLabel');
    ylim(anAxe, yLims + [0 1.5]);
    set(anAxe, 'YTick', [YTick offsetY + 0.05 offsetY + 0.5 offsetY + 0.95], ...
        'YTickLabel', [YTickLabel; sprintf(sprintf('%%%ds', size(YTickLabel, 2)), '0'); ...
        sprintf(sprintf('%%%ds', size(YTickLabel, 2)), '0.5'); sprintf(sprintf('%%%ds', size(YTickLabel, 2)), '1')]);
    hLeg = legend(anAxe);
    legText = get(hLeg, 'String');
    legend(anAxe, 'Orientation', 'horizontal', 'String', [legText 'Corr.']);

end;

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
