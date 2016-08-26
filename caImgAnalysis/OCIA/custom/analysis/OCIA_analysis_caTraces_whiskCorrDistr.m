function OCIA_analysis_caTraces_whiskCorrDistr(this, DWRows)
% OCIA_analysis_caTraces_whiskCorrDistr - [no description]
%
%       OCIA_analysis_caTraces_whiskCorrDistr(this, DWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


    ANShowHideMessage(this, 1, 'Analysis not available.');
    return;
    
    
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

if ~isfield(this.data, 'whisk');
    ANShowHideMessage(this, 1, 'This plot is not available for this dataset.');
    return;
end;

this.GUI.an.paramPanConfig = { };
    
% get the axe handle where all the plotting elements should be displayed
axeH = this.GUI.handles.an.axe;

% get the number of runs
nRuns = numel(DWRows);

% get a unique ID for the rows with the format 'DATE_SPOT_DEPTH
rowIDs = arrayfun(@(iRow) sprintf('%s:%s', this.dw.table{iRow, [2, 7]}), DWRows, 'UniformOutput', false);
rowIDs = regexprep(rowIDs, '(Spot\d+)_(\d+)', '$1:$2');
rowIDs = regexprep(rowIDs, '_', '');
rowIDs = regexprep(rowIDs, ':', '_');
uniqueRowIDs = unique(rowIDs);
nGroups = numel(uniqueRowIDs);
groupIDs = arrayfun(@(iRow) find(strcmp(rowIDs{iRow}, uniqueRowIDs)), 1 : nRuns);

% go through each group and get the correlation coefficients for that group
corrCoeffs = cell(nGroups, 1);
corrCoeffsGroup = cell(nGroups, 1);
for iGroup = 1 : nGroups;

    DWRowsGroup = DWRows(strcmp(uniqueRowIDs{iGroup}, rowIDs));
    
    % get the ROISet of the first row
    ROISet = ANGetROISetForRow(this, DWRowsGroup(1));

    % convert to 3-digits format
    nROIs = size(ROISet, 1);
    for iROI = 1 : nROIs;
        if strcmp(ROISet{iROI, 1}, 'NPil'); continue; end;
        ROISet{iROI, 1} = sprintf('%03d', str2double(ROISet{iROI, 1}));
    end;

    % get the number of runs
    nRunsGroup = numel(DWRowsGroup);

    % get the calcium traces
    caTracesCell = this.data.img.caTraces(DWRowsGroup);
    nImgFrames = size(caTracesCell{1}, 2);
    % reshape in a matrix of nROIs x nRuns x nFrames
    caTraces = reshape(cell2mat(caTracesCell), nROIs, nRunsGroup, nImgFrames);

    % get the imaging frame rate and number of frames
    imgFrameRate = this.an.img.defaultFrameRate;
    nImgFrames = size(caTraces, 3);
    % get the sampling rate of the whisker data
    whiskSampRate = this.data.whisk(DWRowsGroup(1)).frameRate;

    % get the whisker data and truncate it
    whiskAngles = arrayfun(@(iRow)this.data.whisk(iRow).angle, DWRowsGroup, 'UniformOutput', false);
    % calculate the real number of points it should contain
    nRealPointsWhiskData = round((nImgFrames / imgFrameRate) * whiskSampRate);
    % only take the last points
    whiskAngles = arrayfun(@(iRow)whiskAngles{iRow}(end - nRealPointsWhiskData + 1 : end), 1 : numel(whiskAngles), ...
        'UniformOutput', false);
    % calculate the new number of frames for the whisker data
    nWhiskFrames = size(whiskAngles{1}, 2);

    % loop through each run and calculate the enveloppe
    whiskAngleEnvs = cell(whiskAngles);
    for iRun = 1 : nRunsGroup;
        % calculate the envelope
        whiskAngle = whiskAngles{iRun};
        winSize = round(nWhiskFrames * 0.005);
        whiskAngleEnvs{iRun} = zeros(1, nWhiskFrames);
        for iFrame = 1 : nWhiskFrames;
            r = iFrame - winSize : iFrame + winSize;
            r(r < 1 | r > nWhiskFrames) = [];
            whiskAngleEnvs{iRun}(iFrame) = max(whiskAngle(r));
        end;
    end;

    % calculate the correlation on all traces concatenated
    corrCoeffs{iGroup} = zeros(1, nROIs);
    corrCoeffsGroup{iGroup} = zeros(1, nROIs) + iGroup;
    allWhiskAngleEnvs = cell2mat(whiskAngleEnvs);
    for iROI = 1 : nROIs;
        % up-sample the calcium trace for this run and this ROI
        caTraceUSAllRuns = interp1DS(imgFrameRate, whiskSampRate, reshape(squeeze(caTraces(iROI, 1 : nRunsGroup, :))', ...
            nRunsGroup * nImgFrames, 1)');
        caTraceUSAllRuns(end + 1 : numel(allWhiskAngleEnvs)) = 0;
        % filter the trace if required
        if this.an.an.sgFiltFrameSize > 1 && mod(this.an.an.sgFiltFrameSize, 2) ~= 0;
            caTraceUSAllRuns = sgolayfilt(caTraceUSAllRuns, 1, this.an.an.sgFiltFrameSize);
        end;
        % calculate the correlation between the whisker angle and the calcium data
        corrValue = corr([caTraceUSAllRuns; allWhiskAngleEnvs]', 'rows', 'pairwise');
        % store the correlation coefficient
        corrCoeffs{iGroup}(iROI) = corrValue(1, 2);
    end;
    
end;



% figure();
% hold all;
% for iGroup = 1 : nGroups;
%     cumDistr = hist(corrCoeffs{iGroup}, sqrt(numel(corrCoeffs{iGroup})));
%     cumDistr = cumsum(hist(corrCoeffs{iGroup}, numel(corrCoeffs{iGroup})));
%     plot(cumDistr);
%     plot(cumDistr / max(cumDistr));
%     scatter(repmat(iGroup, numel(corrCoeffs{iGroup}), 1), corrCoeffs{iGroup});

    corrs = cell2mat(corrCoeffs');
    groups = cell2mat(corrCoeffsGroup');
% end;

boxplot(axeH, corrs, groups, 'labels', uniqueRowIDs);
ylabel(axeH, 'Correlation');


% show plot and display message
ANShowHideMessage(this, 0, 'Update analyser plot done.');
    
end
