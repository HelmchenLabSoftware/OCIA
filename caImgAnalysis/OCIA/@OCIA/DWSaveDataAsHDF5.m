function DWSaveDataAsHDF5(this, savePath)
% DWSaveDataAsHDF5 - [no description]
%
%       DWSaveDataAsHDF5(this, savePath)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
showMessage(this, sprintf('Saving data to "%s" ...', savePath), 'yellow');

% get the rows of the current selection
rows = this.dw.selectedTableRows;    
nRows = numel(rows); % get the number of rows

% init wait bar
DWWaitBar(this, 0);

% get the data type IDs to flush from memory (if required)
dataTypeIDsToFlush = this.dw.dataTypesToFlushAfterSaving;
% if non required, get the data types from the selection
if isempty(dataTypeIDsToFlush);
    dataTypeIDsToFlush = this.main.dataConfig.id(get(this.GUI.handles.dw.SLROptDataList, 'Value'));
end;

% counter the number of rows processed
nRowWithoutParallelPoolRestart = 0;

saveDataTic = tic; % for performance timing purposes
% go through each row   
for iRow = 1 : nRows;

    iDWRow = rows(iRow); % get the DataWatcher's table index
    rowID = DWGetRowID(this, iDWRow); % get the row's ID

    % create the generic save text and show a message
    saveText = sprintf('Saving data for %s (%03d)', rowID, iDWRow);
    showMessage(this, sprintf('%s ...', saveText), 'yellow');

    % if the overwriting of the data is not selected, check for presence of calcium data
    if ~get(this.GUI.handles.dw.SLROpts.HDF5OverwriteData, 'Value');
        
        % get the path parts for this run
        pathParts = get(this, iDWRow, this.dw.HDF5.savePathConfig);
        % fill-in the empty parts
        emptyIndexes = find(cellfun(@isempty, pathParts));
        if ~isempty(emptyIndexes);
            for iEmpty = 1 : numel(emptyIndexes);
                pathParts{emptyIndexes(iEmpty)} = ...
                    sprintf('unknown_%s', this.dw.HDF5.savePathConfig{emptyIndexes(iEmpty)});
            end;
        end;
        % create the data set's path
        dataSetRoot = sprintf(repmat('/%s', 1, numel(pathParts)), pathParts{:});
        % get the dataset's path with a replaceable item tag '_DATA:TYPE_'
        datasetPathData = sprintf('%s/caTraces/%s', dataSetRoot, rowID);
        
        % if calcium data is already present, skip the row
        if h5exists(savePath, datasetPathData);
            showMessage(this, sprintf('%s skipped.', saveText));
            DWWaitBar(this, 100 * (iRow / nRows));
            continue;
        end;
    end;
    
    % if required, process the row with the requested options
    if get(this.GUI.handles.dw.SLROpts.procBefSave, 'Value');        
        OCIA_dataWatcherProcess_processRows(this, [], rows(iRow));
    end;

    % save the data for this single row
    DWSaveDataAsHDF5SingleRow(this, iDWRow, rowID, saveText, savePath);

    % if required, flush the data for the current row to avoid memory overflow
    if get(this.GUI.handles.dw.SLROpts.flushAfterSave, 'Value');
        showMessage(this, sprintf('%s ...', strrep(saveText, 'Saving', 'Flushing')), 'yellow');
        DWFlushData(this, iDWRow, true, dataTypeIDsToFlush{:});
    end;

    showMessage(this, sprintf('%s done.', saveText));
    DWWaitBar(this, 100 * (iRow / nRows));
    
    % update counter and restart parallell pool
    if this.GUI.noGUI;
        nRowWithoutParallelPoolRestart = nRowWithoutParallelPoolRestart + 1;
        o('#%s: nRowWithoutParallelPoolRestart = %d, nRowBeforeParallelPoolRestart = %d.', mfilename(), ...
            nRowWithoutParallelPoolRestart, this.an.an.nRowBeforeParallelPoolRestart, 0, this.verb);
        if nRowWithoutParallelPoolRestart >= this.an.an.nRowBeforeParallelPoolRestart;
            nRowWithoutParallelPoolRestart = 0;
            delete(gcp);
            pause(1);
            parpool(feature('numCores'));
        end;
    end;

end;

% get information about the saved file
saveFile = dir(savePath);
% show information if file is found
if ~isempty(saveFile);
    showMessage(this, sprintf('Saving data to "%s" done (%.3f sec, %.3f MB).', savePath, ...
        toc(saveDataTic), saveFile.bytes / (2^10 * 2^10)));
else
    showMessage(this, sprintf('Saving data to "%s" done but file not found (%.3f sec).', savePath, ...
        toc(saveDataTic)), 'yellow');
end;
    
end
