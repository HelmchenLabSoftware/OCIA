function OCIA_analysis_AUROC(this, iDWRows)
% OCIA_analysis_AUROC - [no description]
%
%       OCIA_analysis_AUROC(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% get the imaging data
ANShowHideMessage(this, 1, 'Loading data ...');
loadDataTic = tic; % for performance timing purposes
% get the per-stimulus calcium traces
[PSCaTraces, ROINames, stimIDs] = OCIA_analysis_getPSCaTracesMatrix(this, iDWRows);

showMessage(this, sprintf('Loading data done (%3.1f sec).', toc(loadDataTic)));

% abort if no data
if isempty(PSCaTraces);
    ANShowHideMessage(this, 1, 'No data to show.');
    return;
end;

% abort if more than two stimulus types are compared
if numel(stimIDs) ~= 2;
    ANShowHideMessage(this, 1, 'This analysis needs exactly two stimulus IDs to compare.');
    return;
end;

% get the stimulus IDs to use
stimIDs = regexprep(reshape(stimIDs, 1, numel(stimIDs)), '_', ' ');
% rename stim IDs
stimIDs = OCIA_analysis_renameStimIDs(stimIDs);

%% calculate ROC curves
[ROIAUCs, truePX, truePY, shufPX, shufPY] = OCIA_analysis_calculateROC(this, iDWRows, PSCaTraces);

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
plotROCCurves(this.GUI.handles.an.axe, truePX, truePY, shufPX, shufPY, ROIAUCs, ROINames, stimIDs, '', false);
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);
        
% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');

end
