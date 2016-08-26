function OCIA_analysis_widefield_stdEvokedMapsTrials(this, iDWRows)
% OCIA_analysis_widefield_stdEvokedMapsTrials - [no description]
%
%       OCIA_analysis_widefield_stdEvokedMapsTrials(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize  isLabAbove  label               tooltip
    'wf',  'excludeTrials',     'text', { 'cellArray' }, [1 0], true,       'Excl. trials',     'List of trials to exclude.';
    'wf',  'stimIDs',           'text', { 'cellArray' }, [1 0], true,       'Stim. IDs',        'List of stimulus IDs.';
    'wf',  'powerMapCLim',      'text', { 'array' },    [1 0],  false,      'Average CLim',     'Color limits.';
    'wf',  'phaseMapCLim',      'text', { 'array' },    [1 0],  false,      'Trial CLim',       'Color limits.';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(Corr|Delay|Shift)', paramConf);

%% get the data
trialMaps = OCIA_analysis_widefield_getEvokedMapsTrials_standard(this, iDWRows(1));
% abort if no bins
nBins = this.an.wf.nBins;
nTrials = size(trialMaps, 3);
if isempty(nBins) || nBins == 0; return; end;
% no plot if no data
if isempty(trialMaps); return; end;

% get reference image
try
    [~, ~, ~, refImg] = OCIA_analysis_widefield_getFileInfo_standard(this, iDWRows(1));
catch
    [~, ~, ~, refImg, ~, ~, ~, pitchLims] = OCIA_analysis_widefield_getFileInfo(this, iDWRows(1));
    if pitchLims(1) ~= 0; stimID = sprintf('%dkHz', pitchLims(1) / 1000);
    else stimID = 'no sound';
    end;
    iStim = find(strcmp(stimID, this.an.wf.stimIDs));
end;
% crop image if needed
if ~isempty(refImg) && ~isempty(this.an.wf.cropRect);
    refImg = refImg(this.an.wf.cropRect(2) + (0 : this.an.wf.cropRect(4) - 1), ...
        this.an.wf.cropRect(1) + (0 : this.an.wf.cropRect(3) - 1));
end;
imgH = size(refImg, 1); imgW = size(refImg, 2);

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);     

% create the axe configuration cell-array with the reference image
if isempty(this.an.wf.cropRect);
    refImgTitle = 'Reference';
else
    refImgTitle = sprintf('Reference  \\fontsize{9}[%dX,%dY,%dW,%dH]', this.an.wf.cropRect);
end;
axeConfig = { refImg, refImgTitle, 'gray', 'Intensity', true, true, false, [], [], [], [], [] };
    
% get excluded trials
exclTrials = [];
if iStim <= numel(this.an.wf.excludeTrials);
    exclTrials = str2double(regexp(this.an.wf.excludeTrials{iStim}, '-', 'split'));
end;

% for iTrial = 1 : nTrials;
%     if ismember(iTrial, exclTrials); continue; end;
%     axeConfig(end + 1, :) = { reshape(trialMaps(:, :, iTrial), nBins, nBins), sprintf('Trial %02d', iTrial), ...
%         'jet', '\DeltaF / F [%]', false, false, false, [], this.an.wf.powerMapCLim, 1:2, [], [] }; %#ok<AGROW>
% end;
% 
% % get subplot sizes
% nTrials = nTrials - numel(exclTrials);
% M = ceil(sqrt(nTrials)); M = iff(M * M >= nTrials + 2, M, M + 1); N = iff(M * (M - 1) >= (nTrials + 2), M - 1, M);

xPad = 10; yPad = 10;
nRealTrials = nTrials - numel(exclTrials);
M = ceil(sqrt(nRealTrials)); M = iff(M * M >= nRealTrials, M, M + 1); N = iff(M * (M - 1) >= nRealTrials, M - 1, M);
allTrials = nan(nBins * M + yPad * (M + 1), nBins * N + xPad * (N + 1));
iY = 1; iX = 1;
filtSet = this.an.wf.phaseMapFilt;
for iTrial = 1 : nTrials;
    if ismember(iTrial, exclTrials); continue; end;
    xRange = 1 + (((iX - 1) * nBins) : (iX * (nBins) - 1)) + iX * xPad;
    yRange = 1 + (((iY - 1) * nBins) : (iY * (nBins) - 1)) + iY * yPad;
    iX = iX + 1;
    trialMap = trialMaps(:, :, iTrial);
    % if gaussian filtering is requested, apply it
    if all(filtSet(1 : 3)) > 0; trialMap = imfilter(trialMap, fspecial('gaussian', filtSet(1 : 2), filtSet(3))); end;
    % if median filtering is requested, apply it
    if all(filtSet(4 : 5)) > 0; trialMap = medfilt2(trialMap, filtSet(4 : 5)); end;
    allTrials(xRange, yRange) = trialMap;
    if iX > N;
        iX = 1;
        iY = iY + 1;
    end;
end;
axeConfig(end + 1, :) = { allTrials, 'Trials', 'jet', '\DeltaF / F [%]', true, false, false, [], this.an.wf.phaseMapCLim, 1:2, [], [] };

filtSet = this.an.wf.powerMapFilt;
averageMap = reshape(nanmean(trialMaps(:, :, ~ismember(1 : nTrials, exclTrials)), 3), nBins, nBins);
% if gaussian filtering is requested, apply it
if all(filtSet(1 : 3)) > 0; averageMap = imfilter(averageMap, fspecial('gaussian', filtSet(1 : 2), filtSet(3))); end;
% if median filtering is requested, apply it
if all(filtSet(4 : 5)) > 0; averageMap = medfilt2(averageMap, filtSet(4 : 5)); end;
    
% add the average of all trials
axeConfig(end + 1, :) = { averageMap, 'Average', ...
    'jet', '\DeltaF / F [%]', false, false, false, [], this.an.wf.powerMapCLim, 1:2, [], [] };

% plot the maps
axeHandles = OCIA_analysis_widefield_plotMaps(this, 3, 1, axeConfig, imgW, imgH, []);

% plot labels
iY = 1; iX = 1;
for iTrial = 1 : nTrials;
    if ismember(iTrial, exclTrials); continue; end;
    xRange = 1 + (((iX - 1) * nBins) : (iX * (nBins) - 1)) + iX * xPad;
    yRange = 1 + (((iY - 1) * nBins) : (iY * (nBins) - 1)) + iY * yPad;
    iX = iX + 1;
    scaleX = size(allTrials, 2) / imgW; scaleY = size(allTrials, 1) / imgH;
    text(yRange(1) / scaleX, xRange(1) / scaleY, sprintf('%02d', iTrial), 'Color', 'white', 'Parent', axeHandles(2));
    if iX > N;
        iX = 1;
        iY = iY + 1;
    end;
end;

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
