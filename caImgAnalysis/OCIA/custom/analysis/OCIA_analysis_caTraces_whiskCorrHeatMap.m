function OCIA_analysis_caTraces_whiskCorrHeatMap(this, iDWRows)
% OCIA_analysis_caTraces_whiskCorrHeatMap - [no description]
%
%       OCIA_analysis_caTraces_whiskCorrHeatMap(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% %% plotting parameter UI controls
% paramConf = cell2table({ ...
% ... categ  id                   UIType      valueType       UISize    isLabAbove    label           tooltip
%     
% }, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% % append the new configuration to the table and update the row names using the ids
% this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
% this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

%% get the data
% get the concatenated trace (raw and filtered), the stimuli, the selected ROI names and the time vector
[concatCaTraces, ~, ~, ~, ~] = OCIA_analysis_getConcatCaData(this, iDWRows);
% abort if no traces came out
if isempty(concatCaTraces); return; end;

% get the matrix of the whisker traces
[whiskTraces, ~] = OCIA_analysis_getWhiskTracesMatrix(this, iDWRows, true);

selWhiskTrace = whiskTraces{4};

% extend the whisker traces by one NaN frame at the end to be aligned to the calcium traces
%   (this is also done on the calcium traces)
selWhiskTrace = [selWhiskTrace, nan(size(selWhiskTrace, 1), 1)];

% concatenate the whisker traces
selWhiskTracesConcat = reshape(selWhiskTrace', 1, numel(selWhiskTrace));

% get the correlation matrix
corrMatrix = OCIA_analysis_getWhiskTracesCorrelation(this, iDWRows, concatCaTraces, selWhiskTracesConcat, true);

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes

% get the axe handle where all the plotting elements should be displayed
axeH = this.GUI.handles.an.axe;
imagesc(1 : size(corrMatrix, 2), 1 : size(corrMatrix, 1), corrMatrix, 'Parent', axeH);
axis(axeH, 'image');
if ~isempty(this.an.img.plotLimits); set(axeH, 'CLim', this.an.img.plotLimits); end;
hColBar = colorbar('peer', axeH);
set(get(hColBar, 'YLabel'), 'String', 'Correlation');
colormap(axeH, this.an.img.colormap);
if isempty(regexp(get(gcf, 'Name'), 'OCIA', 'once')); close(gcf); end;

o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');

end
