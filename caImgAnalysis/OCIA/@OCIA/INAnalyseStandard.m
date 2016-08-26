function INAnalyseStandard(this, ~, ~)
% INAnalyseStandard - [no description]
%
%       INAnalyseStandard(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


showMessage(this, 'Intrinsic: switching to analyser mode ...');

% get the files from the current folder
files = dir([this.path.intrSave '*.h5']);
nTotFiles = numel(files);

% empty selecte table rows
this.an.selectedTableRows = [];

% generate labels for the selected rows
rowLabels = cell(0, 1);
for iFile = 1 : nTotFiles;
    
    % get file info
    [~, datasetPath, ~, ~, datasetDim, ~, ~, stimIDs] ...
        = OCIA_analysis_widefield_getFileInfo_standard(this, iFile, true);
    
    % create label
    datasetLabelParts = regexp(regexprep(datasetPath, '^/', ''), '/', 'split');
    for iStim = 1 : datasetDim(5);
        
        rowLabels{end + 1} = sprintf('%s - %s - %s', datasetLabelParts{[1, 3]}, stimIDs{iStim}); %#ok<AGROW>
        % clean up label
        rowLabels{end} = regexprep(rowLabels{end}, 'mou_bl_', '');
        rowLabels{end} = regexprep(rowLabels{end}, '_', '');
    
    end;
end;

% create the list of files
this.an.selectedTableRows = 1 : numel(rowLabels);
rowToSelect = 1;

% fill in the listBox items of the analyser panel
set(this.GUI.handles.an.plotList, 'Value', 1, 'ListBoxTop', 1);
set(this.GUI.handles.an.rowList, 'String', rowLabels, 'Value', rowToSelect, 'ListBoxTop', 1);

% clear the plot area and show the loading message
ANClearPlot(this);
OCIAChangeMode(this, 'Analyser');

% init to not doing anything and run first analysis function
ANUpdatePlot(this, 'force');

end