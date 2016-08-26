function DWSave(this, savePath)
% DWSave - [no description]
%
%       DWSave(this, savePath)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the data type(s) that need to be saved
toSaveDataTypeIndexes = get(this.GUI.handles.dw.SLROptDataList, 'Value');
toSaveDataTypeIDs = this.main.dataConfig.id(toSaveDataTypeIndexes);
toSaveFormats = this.main.dataConfig.saveFormat(toSaveDataTypeIndexes);

% if no data types selected for saving and GUI is also not to save, abort with a warning
if isempty(toSaveDataTypeIDs) && ~get(this.GUI.handles.dw.SLROpts.saveGUI, 'Value');
    showWarning(this, 'OCIA:DWSave:NoDataTypes', 'No data type(s) selected for saving !');
    return;
end;

% get the rows that need to be saved
rowsToSave = this.dw.selectedTableRows;

% if no rows are selected for saving, abort with a warning
if isempty(rowsToSave) && ~get(this.GUI.handles.dw.SLROpts.saveGUI, 'Value');
    showWarning(this, 'OCIA:DWSave:NoRows', 'No rows selected for saving !');
    return;
end;

% if no save path specified, try to get one via the user interface
if isempty(savePath);
    [saveName, savePath] = uiputfile('*.*', 'Select a file where to save', this.path.OCIASave);
    % if a path was specified, use that one
    if ischar(saveName);
        savePath = [savePath saveName];
    else % otherwise abort the saving
        return;
    end;
end;

% clean up the save path
savePath = strrep(savePath, '\', '/');
savePath = sprintf('%s.h5', savePath); % add .h5 extension
savePath = regexprep(savePath, '[\.,]h5\.h5$', '.h5'); % remove .h5 extension if present twice
savePath = regexprep(savePath, '[\.,]hdf5\.h5$', '.h5'); % remove .h5 extension if present twice
savePath = regexprep(savePath, '[\.,]mat\.h5$', '.h5'); % clean-up .mat.h5 extension

% overwrite the file if required
if exist(savePath, 'file') && get(this.GUI.handles.dw.SLROpts.overwriteSaveFile, 'Value');
    showMessage(this, sprintf('Overwritting file "%s" ...', savePath), 'yellow');
    delete(savePath);
end;

%{
% if GUI is required to be saved, save it in the HDF5 file
if get(this.GUI.handles.dw.SLROpts.saveGUI, 'Value');
    DWSaveGUIAsHDF5(this, savePath);
end;
%}

% if GUI is required to be saved, save it in a MAT-file
if get(this.GUI.handles.dw.SLROpts.saveGUI, 'Value');
    savePathGUI = regexprep(savePath, '\.\h5$', '.mat'); % replace extension by .mat
    DWSaveGUIAsMAT(this, savePathGUI);
end;

% if any HDF5-type data is required to be saved, save the data in a HDF5 file
if any(strcmp('HDF5', toSaveFormats));
    DWSaveDataAsHDF5(this, savePath);
end;

% % if any mat-type data is required to be saved, save the data in a MAT-file
% if any(strcmp('mat', toSaveFormats));
%     savePath = regexprep(savePath, '\.\h5$', '.mat'); % replace extension by .mat
%     DWSaveDataAsMat(this, savePath);
% end;
    
end
