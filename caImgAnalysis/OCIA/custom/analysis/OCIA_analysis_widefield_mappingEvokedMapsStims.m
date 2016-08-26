function OCIA_analysis_widefield_mappingEvokedMapsStims(this, iDWRows)
% OCIA_analysis_widefield_mappingEvokedMapsStims - [no description]
%
%       OCIA_analysis_widefield_mappingEvokedMapsStims(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize  isLabAbove  label               tooltip
    'wf',  'excludeTrials',     'text', { 'cellArray' }, [1 0], true,       'Excl. trials',     'List of trials to exclude.';
    'wf',  'powerMapCLim',      'text', { 'array' },    [1 0],  true,      'CLim',             'Color limits.';
    'wf',  'subRange',          'text', { 'array' },    [1 0],  false,      'SubRange',         'Evoked frames sub-range.';
    'wf',  'mainPoly',          'text', { 'array' },    [1 0],  true,      'MainPoly',         'Main polygon after thresholding';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(phaseMapFilt|CLim|Delay|Shift|BLCorr)', paramConf);

%% get the data
[averageMaps, stimIDs] = OCIA_analysis_widefield_getAverageMaps(this, iDWRows(1));
if numel(iDWRows) > 1 && size(averageMaps, 3) == 1;
    averageMapsForRow = averageMaps;
    stimIDsForRow = stimIDs;
    
    averageMaps = nan(size(averageMapsForRow, 1), size(averageMapsForRow, 2), numel(iDWRows), size(averageMapsForRow, 4));
    stimIDs = cell(numel(iDWRows), 1);
    
    averageMaps(:, :, 1, :) = averageMapsForRow;
    stimIDs(1) = stimIDsForRow;
    
    for iRow = 2 : numel(iDWRows);
        [averageMapsForRow, stimIDsForRow] = OCIA_analysis_widefield_getAverageMaps(this, iDWRows(iRow));
        averageMaps(:, :, iRow, :) = averageMapsForRow;
        stimIDs(iRow) = stimIDsForRow;
    end;
end;
if isempty(averageMaps); return; end;

% average all frames
averageMaps = nanmean(averageMaps, 4);

% get dataset's size
[~, ~, nStims] = size(averageMaps);

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
pause(0.02);
plotTic = tic; % for performance timing purposes 

% get reference image
[~, ~, ~, refImg] = OCIA_analysis_widefield_getFileInfo(this, iDWRows(1));
% crop image if needed
if ~isempty(refImg) && ~isempty(this.an.wf.cropRect);
    refImg = refImg(this.an.wf.cropRect(2) + (0 : this.an.wf.cropRect(4) - 1), ...
        this.an.wf.cropRect(1) + (0 : this.an.wf.cropRect(3) - 1));
end;
imgH = size(refImg, 1); imgW = size(refImg, 2);
    
% create the axe configuration cell-array with the reference image
if isempty(this.an.wf.cropRect);
    refImgTitle = 'Reference';
else
    refImgTitle = sprintf('Reference  \\fontsize{9}[%dX,%dY,%dW,%dH]', this.an.wf.cropRect);
end;

axeConfig = cell(20, 12);
iConfig = 1;
axeConfig(iConfig, :) = { refImg, refImgTitle, 'gray', '', true, true, false, [], [], [], [], [] };
iConfig = iConfig + 1;

% add average maps to axe config
for iStim = 1 : nStims;
%     axeConfig(iConfig, :) = { averageMaps(:, :, iStim)', stimIDs{iStim}, 'jet', iff(iStim == 1, 'Scaled \DeltaF / F [%]', ''), ...
%         false, false, false, [], this.an.wf.powerMapCLim, (iStim - 1) * 2 + 1 : (iStim - 1) * 2 + 2, [], []};
    axeConfig(iConfig, :) = { averageMaps(:, :, iStim)', stimIDs{iStim}, 'jet', 'DeltaF / F [%]', ...
        false, false, false, [], this.an.wf.powerMapCLim, (iStim - 1) * 2 + 1 : (iStim - 1) * 2 + 2, [], []};
    iConfig = iConfig + 1;
end;

axeConfig(cellfun(@isempty, axeConfig(:, 1)), :) = [];

% plot the maps
axeHandles = OCIA_analysis_widefield_plotMaps(this, ceil(size(axeConfig, 1) / 2), 2, axeConfig, imgW, imgH, [], [0.01, 0.05]);

offsetAxe = nStims < numel(axeHandles);
if imgW == 0 && imgH == 0;
    [imgW, imgH] = size(averageMaps(:, :, 1)');
end;

for iStim = 1 : nStims;
    stimMap = reshape(averageMaps(:, :, iStim), size(averageMaps, 1), size(averageMaps, 2));
    % apply thresholding
    stimBW = stimMap > this.an.wf.powerMapThresh(min(iStim, numel(this.an.wf.powerMapThresh)));
    stimBW = linScale(stimBW);
    stimPolys = bwboundaries(stimBW, 'noholes');
    [~, sortInd] = sort(-cellfun(@numel, stimPolys));
    stimPolys = stimPolys(sortInd);
    % plot outlines
    hold(axeHandles(iStim + offsetAxe), 'on');
    for iPoly = 1 : min(numel(stimPolys), 3);
        stimPoly = stimPolys{iPoly};
        if numel(stimPoly) < 10; continue; end;
        if isfield(this.an.wf, 'mainPoly') && ~isempty(this.an.wf.mainPoly) && numel(this.an.wf.mainPoly) >= iStim ...
                && this.an.wf.mainPoly(iStim) ~= 0 && this.an.wf.mainPoly(iStim) ~= iPoly;
            continue;
        end;
        stimPoly(:, 1) = stimPoly(:, 1) * (imgW / this.an.wf.nBins(1));
        stimPoly(:, 2) = stimPoly(:, 2) * (imgH / this.an.wf.nBins(2));
        plot(stimPoly(:, 1), stimPoly(:, 2), 'Color', 'black', 'LineWidth', 2, 'Parent', axeHandles(iStim + offsetAxe));
    end;
    hold(axeHandles(iStim + offsetAxe), 'off');
end;
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
