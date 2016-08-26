function OCIA_analysis_widefield_mappingMultiFreqTrialMaps(this, iDWRows)
% OCIA_analysis_widefield_mappingMultiFreqTrialMaps - [no description]
%
%       OCIA_analysis_widefield_mappingMultiFreqTrialMaps(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% get the data
[trialsPSFramesMap, tPS, ~] = OCIA_analysis_widefield_getTrialsMappingMultiFreq(this, iDWRows(1));
if isempty(tPS); tPS = [1 2]; this.an.wf.iFrame = 1; end;
if this.an.wf.iFrame > numel(tPS); this.an.wf.iFrame = numel(tPS); end;

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize  isLabAbove  label                   tooltip
    'wf',  'phaseMapCLim',      'text', { 'array' },    [1 0],  false,      'Trial col. lim.',      'Color limits.';
    'wf',  'powerMapCLim',      'text', { 'array' },    [1 0],  false,      'Avg. col. lim.',       'Color limits.';
    'wf',  'excludeTrials',     'text', { 'cellArray' }, [1 0], true,       'Excl. trials',         'List of trials to exclude.';
    'wf',  'iFrame',            'slider', { @OCIA_analysis_wideField_changeIFrame, 1, numel(tPS), 1 / numel(tPS), 10 / numel(tPS) }, [1 0], true, ...
                                                                            'Frame', 'Frame to display.';
    'wf',  'makeMovie',         'button', { @OCIA_analysis_wideField_makeMovie }, [1 0], false, 'Make movie', 'Create a movie.';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(CLim|powerMapFiltDelay|Shift|BLCorr|Thresh|Delay|stimFreqInterval)', paramConf);

%% get the data
% abort if no bins
nBins = this.an.wf.nBins;
if isempty(nBins) || any(nBins == 0); return; end;
% no plot if no data
if isempty(trialsPSFramesMap); return; end;

% get the current frame
iFrame = round(this.an.wf.iFrame);

% get dataset's size
[~, ~, ~, ~, nPSFrames] = size(trialsPSFramesMap);
if iFrame > nPSFrames; iFrame = nPSFrames; end;

% get reference image
[~, ~, ~, refImg] = OCIA_analysis_widefield_getFileInfo(this, iDWRows(1));
% crop image if needed
if ~isempty(refImg) && ~isempty(this.an.wf.cropRect);
    refImg = refImg(this.an.wf.cropRect(2) + (0 : this.an.wf.cropRect(4) - 1), ...
        this.an.wf.cropRect(1) + (0 : this.an.wf.cropRect(3) - 1));
end;
imgH = size(refImg, 1); imgW = size(refImg, 2);

% get filtered trial maps
[trialsMaps, stimIDs, tPS] = OCIA_analysis_widefield_getTrialMaps(this, iDWRows(1));
if numel(iDWRows) > 1 && size(trialsMaps, 3) == 1;
    trialsMapsForRow = trialsMaps;
    stimIDsForRow = stimIDs;
    
    trialsMaps = nan(size(trialsMapsForRow, 1), size(trialsMapsForRow, 2), numel(iDWRows), 1, size(trialsMapsForRow, 5));
    stimIDs = cell(numel(iDWRows), 1);
    
    trialsMaps(:, :, 1, :, :) = trialsMapsForRow;
    stimIDs(1) = stimIDsForRow;
    
    for iRow = 2 : numel(iDWRows);
        [trialsMapsForRow, stimIDsForRow] = OCIA_analysis_widefield_getTrialMaps(this, iDWRows(iRow));
        trialsMaps(:, :, iRow, :, :, :) = trialsMapsForRow;
        stimIDs(iRow) = stimIDsForRow;
    end;
end;
if isempty(trialsMaps); return; end;

% get dataset's size
[~, ~, nTrials, nStims, nPSFrames] = size(trialsMaps);

if numel(unique(stimIDs)) == nTrials;
    % swap trial and stim types
    trialsMaps = permute(trialsMaps, [1, 2, 4, 3, 5]);
    % get dataset's size
    [~, ~, nTrials, nStims, nPSFrames] = size(trialsMaps);
end;

%% plotting
ANShowHideMessage(this, 1, 'Putting together data to plot ...');

% create the axe configuration cell-array with the reference image
if isempty(this.an.wf.cropRect);
    refImgTitle = 'Reference';
else
    refImgTitle = sprintf('Reference  \\fontsize{9}[%dX,%dY,%dW,%dH]', this.an.wf.cropRect);
end;

%% ref
axeConfig = cell(20, 12);
iConfig = 1;
axeConfig(iConfig, :) = { refImg', refImgTitle, 'gray', '', true, true, false, [], [], [], [], [] };
iConfig = iConfig + 1;

%% create trial structure image
trialStructImg = ones(size(refImg));

trialTimes = [1, 3, 5, 6.5];
trialTimeNames = { 'baseline', 'start', 'sensation', 'delay', 'report' };
frameRate = 20;
trialFrames = trialTimes * frameRate;
trialPixels = round((trialFrames / nPSFrames) * size(trialStructImg, 2));
for iTime = 1 : numel(trialTimes);
    trialStructImg(:, (trialPixels(iTime) - 2) : (trialPixels(iTime))) = 0;
end;

axeConfig(iConfig, :) = { trialStructImg, sprintf('%+.2f sec (frame %d)', tPS(iFrame), iFrame), ...
    'gray', '', false, false, false, [], [], [], [], [] };
iConfig = iConfig + 1;

% store averages and trials
this.an.wf.storeData.allTrialsCell = cell(nStims, 1);
this.an.wf.storeData.allTrialsAverageCell = cell(nStims, 1);

%% trial for each stim
xPad = 0.05; yPad = 0.05;
for iStim = 1 : nStims;
    
    if nTrials > 1;
        
        M = ceil(sqrt(nTrials)); N = iff(M * (M - 1) >= nTrials, M - 1, M);
        allTrials = nan(round(nBins(1) * N + xPad * (N + 2)), round(nBins(2) * M + yPad * (M + 2)), nPSFrames);
        iY = 1; iX = 1;
        o('#%s: stim %d: nTrials = %d, M = %d, N = %d', mfilename(), iStim, nTrials, M, N, 2, this.verb);
        for iTrial = 1 : nTrials;
            xRange = round(1 + (((iX - 1) * nBins(1)) : ((iX * nBins(1)) - 1)) + iX * xPad);
            yRange = round(1 + (((iY - 1) * nBins(2)) : ((iY * nBins(2)) - 1)) + iY * yPad);
            iX = iX + 1;
            allTrials(xRange, yRange, :) = reshape(trialsMaps(:, :, iTrial, iStim, :), nBins(1), nBins(2), nPSFrames);
            if iX > N;
                iX = 1;
                iY = iY + 1;
            end;
        end;

        % add all trial map to the config
        axeConfig(iConfig, :) = { squeeze(allTrials(:, :, iFrame))', sprintf('Trials - %s', stimIDs{iStim}), 'mapgeog', ...
            iff(iStim == 1, '\DeltaF / F [%]', ''), false, false, false, [], this.an.wf.phaseMapCLim, 1:2, [], [] };
        iConfig = iConfig + 1;
        
        % store
        this.an.wf.storeData.allTrialsCell{iStim} = allTrials;
        
    end;
    
    % get average of all trials
    averageMap = permute(reshape(nanmean(trialsMaps(:, :, :, iStim, :), 3), [nBins, nPSFrames]), [2, 1, 3]);
    

    % add the average of all trials
    axeConfig(iConfig, :) = { averageMap(:, :, iFrame), sprintf('Average - %s', stimIDs{iStim}), 'mapgeog', ...
        '', false, false, false, [], this.an.wf.powerMapCLim, 1:2, [], [] };
    iConfig = iConfig + 1;

    % store
    this.an.wf.storeData.allTrialsAverageCell{iStim} = averageMap;
end;

% plot the maps
ANShowHideMessage(this, 1, 'Plotting ...');
M = iff(nTrials == 1, ceil(nStims * 0.5), nStims) + 1; N = 2;
axeHandles = OCIA_analysis_widefield_plotMaps(this, M, N, axeConfig, imgW, imgH, [], [0.00, 0.00]);


% store handles and time
this.an.wf.storeData.axeHandles = axeHandles;
this.an.wf.storeData.tPS = tPS;

nanMask = mask2poly(~isnan(averageMap(:, :, 1)), 'Inner', 'MINDIST');
hold(axeHandles(1), 'on');
plot(axeHandles(1), nanMask(:, 1), nanMask(:, 2), 'LineWidth', 1, 'Color', 'green');
hold(axeHandles(1), 'off');

% text(10, 10, sprintf('frame %d, ', iFrame), 'Color', 'white', 'Parent', axeHandles(2), 'HorizontalAlignment', 'left', ...
%     'VerticalAlignment', 'top', 'FontSize', 6);

hold(axeHandles(2), 'on');
this.an.wf.storeData.lineHandle = plot(axeHandles(2), repmat((iFrame / nPSFrames) * size(refImg, 1), 1, 2), ...
    [1, size(refImg, 2)], 'Color', 'red');
xTicks = trialPixels;
xTickLabels = trialTimes;
xTicks = [1, xTicks];
xTickLabels = [0, xTickLabels];
set(axeHandles(2), 'XTick', xTicks, 'XTickLabel', xTickLabels, 'XAxisLocation', 'bottom');
xlabel(axeHandles(2), 'Time [s]');
text(0, size(refImg, 2) * 0.8, trialTimeNames{1}, 'Parent', axeHandles(2), 'Color', 'black', ...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 7, 'Rotation', 90);
for iTime = 1 : numel(trialPixels);
    text(trialPixels(iTime), size(refImg, 1) * 0.8, trialTimeNames{iTime + 1}, 'Parent', axeHandles(2), ...
        'Color', 'black', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 7, 'Rotation', 90);
end;
hold(axeHandles(2), 'off');

% plot labels
for iStim = 1 : nStims;

    allTrialsForStim = this.an.wf.storeData.allTrialsCell{iStim};

    M = ceil(sqrt(nTrials)); N = iff(M * (M - 1) >= nTrials, M - 1, M);
    scaleX = size(allTrialsForStim, 1) / imgW; scaleY = size(allTrialsForStim, 2) / imgH;
    iY = 1; iX = 1;
    for iTrial = 1 : nTrials;
        xRange = round(1 + (((iX - 1) * nBins(1)) : ((iX * nBins(1)) - 1)) + iX * xPad);
        yRange = round(1 + (((iY - 1) * nBins(2)) : ((iY * nBins(2)) - 1)) + iY * yPad);
        iX = iX + 1;
        if size(allTrialsForStim, 1) >= xRange(end) && size(allTrialsForStim, 2) >= yRange(end) ...
            && ~all(all(isnan(allTrialsForStim(xRange, yRange, iFrame))));
            text(xRange(1) / scaleX, yRange(1) / scaleY, sprintf('%02d', iTrial), 'Color', 'white', ...
                'Parent', axeHandles(3 + (iStim - 1) * 2), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
                'FontSize', 6);
        end;
        if iX > N;
            iX = 1;
            iY = iY + 1;
        end;
    end;
end;

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');

% update frame
OCIA_analysis_wideField_changeIFrame(this);


end
