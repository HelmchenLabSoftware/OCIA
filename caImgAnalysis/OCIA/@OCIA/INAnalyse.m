function INAnalyse(this, hOrFileListCellArray, ~)
% INAnalyse - [no description]
%
%       INAnalyse(this)
%       INAnalyse(this, fileListCellArray)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


% coming from "DataWatcher" panel
if ~exist('hOrFileListCellArray', 'var')
    hOrFileListCellArray = [];
end;

if ~isempty(hOrFileListCellArray) && iscell(hOrFileListCellArray) || ischar(hOrFileListCellArray);
    
    showMessage(this, 'Switching to analyser mode ...');

    % get the files from the current folder
    files = hOrFileListCellArray;
    if ~iscell(files); files = { files }; end;
    nTotRows = numel(files);

    % create the list of files
    this.an.selectedTableRows = this.dw.selectedTableRows;
    rowToSelect = 1;
    
    
% coming from "Intrinsic" panel
else
    
    showMessage(this, 'Intrinsic: switching to analyser mode ...');

    % get the files from the current folder
    filesStruct = dir([this.path.intrSave '*.h5']);
    nTotRows = numel(filesStruct);
    files = arrayfun(@(iFile) filesStruct(iFile).name, 1 : nTotRows, 'UniformOutput', 'false');
    
    % create the list of files
    this.an.selectedTableRows = 1 : nTotRows;
    rowToSelect = 1;

end;
% generate labels for the selected rows
rowLabels = cell(nTotRows, 1);
for iRow = 1 : nTotRows;
    
    % use file name as label
    rowLabels{iRow} = files{iRow};
    
    % check if the current parameters are for one of the file
    if strcmp(rowLabels{iRow}, [INGetSaveName(this) '.h5']);
        rowToSelect = iRow;
    end;
    
    % clean up the label
    rowLabels{iRow} = regexprep(rowLabels{iRow}, '\.h5$', '');
    rowLabels{iRow} = regexprep(rowLabels{iRow}, '_', ' ');
    rowLabels{iRow} = regexprep(rowLabels{iRow}, 'Sweep', '');
    rowLabels{iRow} = regexprep(rowLabels{iRow}, 'FrameRate', 'FR');
    rowLabels{iRow} = regexprep(rowLabels{iRow}, '(\d{4})(\d{2})(\d{2}) - (\d{6})', '$1$2$3_$4');
    rowLabels{iRow} = regexprep(rowLabels{iRow}, '(\d+)p(\d+)', '$1.$2');
    
%     try
%         [~, ~, ~, ~, framesDim, ~, ~, pitchLims] = OCIA_analysis_widefield_getFileInfo(this, iRow, true);
%         rowLabels{iRow} = sprintf('%s - %dx%dx%d - %d-%dkHz', rowLabels{iRow}, framesDim, ...
%             pitchLims(1) / 1000, pitchLims(2) / 1000);
%     catch
%     end;
    
end;
% fill in the listBox items of the analyser panel
set(this.GUI.handles.an.plotList, 'Value', 1, 'ListBoxTop', 1);
set(this.GUI.handles.an.rowList, 'String', rowLabels, 'Value', rowToSelect, 'ListBoxTop', 1);

% clear the plot area and show the loading message
ANClearPlot(this);
OCIAChangeMode(this, 'Analyser');

% init to not doing anything and run first analysis function
ANUpdatePlot(this, 'force');

end