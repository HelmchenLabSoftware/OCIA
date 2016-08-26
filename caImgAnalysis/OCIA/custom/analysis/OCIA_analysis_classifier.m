function OCIA_analysis_classifier(this, iDWRows)
% OCIA_analysis_classifier - [no description]
%
%       OCIA_analysis_classifier(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% %% plotting parameter UI controls
% paramConf = cell2table({ ...
% ... categ  id                   UIType      valueType               UISize  isLabAbove      label                   tooltip
%     'img', 'plotLimits',        'text',     { 'array' },            [1 0],  false,          'Plot limits',          'Adjust the Y-axis limits of the plot.';
% }, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% % append the new configuration to the table and update the row names using the ids
% this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
% this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

%% get the imaging data
ANShowHideMessage(this, 1, 'Loading data ...');
loadDataTic = tic; % for performance timing purposes
% get the per-stimulus calcium traces
[PSCaTraces, ROINames, stimIDs, hashStruct] = OCIA_analysis_getPSCaTracesMatrix(this, iDWRows);

showMessage(this, sprintf('Loading data done (%3.1f sec).', toc(loadDataTic)));

% abort if no data
if isempty(PSCaTraces);
    ANShowHideMessage(this, 1, 'No data to show.');
    return;
end;

%% prepare data
% get the stimulus IDs to use
stimIDs = regexprep(reshape(stimIDs, 1, numel(stimIDs)), '_', ' ');
% rename stim IDs
stimIDs = OCIA_analysis_renameStimIDs(stimIDs);

%% calculate ROC curves
isROIResponsive = OCIA_analysis_testROIsForResponse(this, PSCaTraces, hashStruct);

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
plotROCCurves(this.GUI.handles.an.axe, truePX, truePY, shufPX, shufPY, ROIAUCs, ROINames, stimIDs, '', false);
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);
        
% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');

end
