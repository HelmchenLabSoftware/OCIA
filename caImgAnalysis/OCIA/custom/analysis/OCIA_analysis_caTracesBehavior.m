function OCIA_analysis_caTracesBehavior(this, DWRows)
% OCIA_analysis_caTracesBehavior - [no description]
%
%       OCIA_analysis_caTracesBehavior(this, DWRows)
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

if numel(DWRows) > 1;
    ANShowHideMessage(this, 1, 'This plot is not available for multiple runs.');
    return;
end;

if ~isfield(this.data, 'behav');
    ANShowHideMessage(this, 1, 'This plot is not available for this dataset.');
    return;
end;

% get the axe handle where all the plotting elements should be displayed
anAxe = this.GUI.handles.an.axe;

this.GUI.an.paramPanConfig = { };

% get the ROISet of the first row
ROISet = ANGetROISetForRow(this, DWRows(1));

% convert to 3-digits format
nROIs = size(ROISet, 1);
for iROI = 1 : nROIs;
    if strcmp(ROISet{iROI, 1}, 'NPil'); continue; end;
    ROISet{iROI, 1} = sprintf('%03d', str2double(ROISet{iROI, 1}));
end;

% if no ROI list exists yet, fill the list
if isempty(get(this.GUI.handles.an.ROIList, 'String'));
    set(this.GUI.handles.an.ROIList, 'String', ROISet(:, 1), 'Value', 1 : nROIs);
% otherwise, restrict the ROIs for the analysis to the selected ones
else
    ROISelRange = get(this.GUI.handles.an.ROIList, 'Value'); % get the selected range
    ROISet = ROISet(ROISelRange, :); % restrict the ROISet
    nROIs = size(ROISet, 1); % update the number of ROIs
end;

% get the calcium trace and the stimulus vector
caTrace = this.data.img.caTraces{DWRows}(ROISelRange, :);
stim = this.data.img.stim{DWRows};
nFrames = size(caTrace, 2);

% get the frame rate
localFrameRate = this.an.img.defaultFrameRate;
if ~isempty(this.data.behav(DWRows(1)).imgFrameRate); % if an extracted frame rate is available, use it
    if numel(DWRows) > 1;
        % get the mean imaging frame rate of all selected runs
        localFrameRate = mean(cell2mat(this.data.behav(DWRows).imgFrameRate));
    else
        localFrameRate = this.data.behav(DWRows).imgFrameRate;
    end;
end;

% get the sampling rate of the behavior data and the delay of the imaging start
behavSampRate = this.data.behav(DWRows).behavSampRate;
imgDelay = this.data.behav(DWRows).imgDelay;

limits = [-1.5 -1; -1 0; 0 0.5; 0.5 1.5; -3 -1.5; 1.5 2];
hold(anAxe, 'on');
if numel(DWRows) > 1;
    behavRec = cell2mat(this.data.behav(DWRows).rec);
else
    behavRec = this.data.behav(DWRows).rec;
end;
for iChan = 1 : size(behavRec, 1);
    behavRec(iChan, :) = linScale(behavRec(iChan, :), 0, limits(iChan, 2) - limits(iChan, 1)) + limits(iChan, 1);
%     behavRec(iChan, :) = behavRec(iChan, :) - mean(behavRec(iChan, :));
end;
nSamples = size(behavRec, 2);
tBehav = (1 : nSamples) / behavSampRate;

caTraceFiltNorm = zeros(size(caTrace));
for iROI = 1 : nROIs;
    caTraceFiltNorm(iROI, :) = linScale(caTrace(iROI, :), 0, limits(5, 2) - limits(5, 1)) + limits(5, 1);
end;
tImg = ((1 : nFrames) / localFrameRate) + imgDelay;
% for iROI = 1 : nROIs;
%     plot(anAxe, tImg, caTraceFiltNorm(iROI, :), 'Color', repmat(0.8, 3, 1));
% end;
if numel(DWRows) > 1;
    lickRate = cell2mat(this.data.behav(DWRows).lickRate);
else
    lickRate = this.data.behav(DWRows).lickRate;
end;

lickRate = linScale(lickRate, 0, limits(6, 2) - limits(6, 1)) + limits(6, 1);

plot(anAxe, tBehav, behavRec(1, :), 'magenta', 'DisplayName', 'yscan');
plot(anAxe, tBehav, behavRec(2, :), 'cyan', 'DisplayName', 'motion');
plot(anAxe, tBehav, behavRec(3, :), 'green', 'DisplayName', 'micr.');
plot(anAxe, tBehav, behavRec(4, :), 'red', 'DisplayName', 'piezo');
plot(anAxe, tBehav, lickRate, 'blue', 'DisplayName', 'lickRate');
ylim(anAxe, [min(limits(:)), max(limits(:))]);
plot(anAxe, tImg, mean(caTraceFiltNorm, 1), 'k', 'LineWidth', 2, 'DisplayName', 'caTrace');
yLimits = get(anAxe, 'YLim');
for iStimTime = 1 : numel(stim);
    if stim(iStimTime);
        plot(anAxe, repmat(tImg(iStimTime), 1, 2), yLimits, 'LineStyle', '--', 'Color', 'red', 'DisplayName', 'stim.');
    end;
end;
hLeg = legend(anAxe, 'toggle');
set(hLeg, 'Orientation', 'horizontal', 'Location', 'NorthOutside');
hold(anAxe, 'off');

ANShowHideMessage(this, 0, 'Update analyser plot done.');
    
end
