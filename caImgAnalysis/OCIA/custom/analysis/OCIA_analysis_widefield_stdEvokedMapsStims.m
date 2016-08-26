function OCIA_analysis_widefield_stdEvokedMapsStims(this, iDWRows)
% OCIA_analysis_widefield_stdEvokedMapsStims - [no description]
%
%       OCIA_analysis_widefield_stdEvokedMapsStims(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize  isLabAbove  label               tooltip
    'wf',  'stimIDs',           'text', { 'cellArray' }, [1 0], true,       'Stim. IDs',        'List of stimulus IDs.';
    'wf',  'powerMapCLim',      'text', { 'array' },    [1 0],  false,      'CLim',             'Color limits.';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(Corr|phaseMapFilt|Delay|Shift)', paramConf);

%% get the data
% if 
    [stimMaps, refImg, stimIDs, ~, imgH, imgW] = OCIA_analysis_widefield_getEvokedMapsStims_standard(this, iDWRows);
%     [stimMaps, refImg, stimIDs, ~, imgH, imgW] = OCIA_analysis_widefield_getEvokedMapsStims_fourier(this, iDWRows);
% end;
nStims = size(stimMaps, 3);
% abort if no bins
nBins = this.an.wf.nBins;
if isempty(nBins) || nBins == 0; return; end;
% no plot if no data
if isempty(stimMaps); return; end;

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
    
% params
thresh = this.an.wf.powerMapThresh;
filtSet = this.an.wf.powerMapFilt;

% add trials to the config
for iStim = 1 : nStims;
    stimMap = reshape(stimMaps(:, :, iStim), nBins, nBins);
    % if gaussian filtering is requested, apply it
    if all(filtSet(1 : 3)) > 0; stimMap = imfilter(stimMap, fspecial('gaussian', filtSet(1 : 2), filtSet(3))); end;
    % if median filtering is requested, apply it
    if all(filtSet(4 : 5)) > 0; stimMap = medfilt2(stimMap, filtSet(4 : 5)); end;
    
    axeConfig(end + 1, :) = { stimMap, stimIDs{iStim}, ...
        'jet', '\DeltaF / F [%]', false, false, false, [], this.an.wf.powerMapCLim, (1:2) + 2 * (iStim - 1), [], [] }; %#ok<AGROW>
end;

% plot the maps
axeH = OCIA_analysis_widefield_plotMaps(this, round((nStims + 1) / 2), 2, axeConfig, imgW, imgH, []);

for iStim = 1 : nStims;
    stimMap = reshape(stimMaps(:, :, iStim), nBins, nBins);
    % if gaussian filtering is requested, apply it
    if all(filtSet(1 : 3)) > 0; stimMap = imfilter(stimMap, fspecial('gaussian', filtSet(1 : 2), filtSet(3))); end;
    % if median filtering is requested, apply it
    if all(filtSet(4 : 5)) > 0; stimMap = medfilt2(stimMap, filtSet(4 : 5)); end;
    % apply thresholding
    stimBW = stimMap > thresh(min(iStim, numel(thresh)));
    stimBW = linScale(stimBW);
    stimPolys = bwboundaries(stimBW, 'noholes');
    [~, sortInd] = sort(-cellfun(@numel, stimPolys));
    stimPolys = stimPolys(sortInd);
    % plot outlines
    hold(axeH(iStim + 1), 'on');
    for iPoly = 1 : min(numel(stimPolys), 2);
        stimPoly = stimPolys{iPoly};
        if numel(stimPoly) < 10; continue; end;
        stimPoly = stimPoly * (imgW / nBins);
        plot(stimPoly(:, 2), stimPoly(:, 1), 'Color', 'black', 'LineWidth', 2, 'Parent', axeH(iStim + 1));
    end;
    hold(axeH(iStim + 1), 'off');
end;

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
