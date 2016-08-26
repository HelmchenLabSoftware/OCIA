function OCIA_analysis_caTraces_whisk_corrAnalysis(this, iDWRows)
% OCIA_analysis_caTraces_whisk_corrAnalysis - [no description]
%
%       OCIA_analysis_caTraces_whisk_corrAnalysis(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% get the data
% get the calcium traces
[caTraces, stims, ROINames, concatCaTraces, concatStims] = OCIA_analysis_getCaTracesMatrix(this, iDWRows, 1);
% abort if no traces were returned
if isempty(caTraces); return; end;

% get the concatenated trace (raw and filtered), the stimuli, the selected ROI names and the time vector
[concatCaTraces, concatStims, concatCaTracesSGFilt, ROINames, t] = OCIA_analysis_getConcatCaData(this, iDWRows);
% abort if no traces were returned
if isempty(concatCaTracesSGFilt); return; end;

% get the matrix of the whisker traces
whiskTraces = OCIA_analysis_getWhiskTracesMatrix(this, iDWRows, true);

% extend the whisker traces by one NaN frame at the end to be aligned to the calcium traces
%   (this is also done on the calcium traces)
selWhiskTraces = [whiskTraces{4}, nan(size(whiskTraces{4}, 1), 1)];

% concatenate the whisker traces
procWhiskTracesConcat = reshape(selWhiskTraces', 1, numel(selWhiskTraces));

% get the correlation matrix of the concatenated data
corrMatrixConcat = OCIA_analysis_getWhiskTracesCorrelation(this, iDWRows, concatCaTracesSGFilt, procWhiskTracesConcat, true);

% get the correlation matrix for each trial
corrMatrixTrials = OCIA_analysis_getWhiskTracesCorrelation(this, iDWRows, caTraces, selWhiskTraces, true);

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes

% get the axe handle where all the plotting elements should be displayed
axeH = this.GUI.handles.an.axe;
imagesc(1 : size(corrMatrixTrials, 2), 1 : size(corrMatrixTrials, 1), corrMatrixTrials, 'Parent', axeH);
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
