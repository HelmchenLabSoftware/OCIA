function DWLoad(this, loadPath)
% DWLoad - [no description]
%
%       DWLoad(this, loadPath)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the data type(s) that need to be loaded
toLoadDataTypeIndexes = get(this.GUI.handles.dw.SLROptDataList, 'Value');
toLoadDataTypeIDs = this.main.dataConfig.id(toLoadDataTypeIndexes);
toLoadFormats = this.main.dataConfig.saveFormat(toLoadDataTypeIndexes);

% if no data types selected for loading and GUI is also not to load, abort with a warning
if isempty(toLoadDataTypeIDs) && ~get(this.GUI.handles.dw.SLROpts.saveGUI, 'Value');
    showWarning(this, 'OCIA:DWLoad:NoDataTypes', 'No data type(s) selected for loading !');
    return;
end;

% get the rows that need to be loaded
rowsToLoad = this.dw.selectedTableRows;

% if no rows are selected for loading, abort with a warning
if isempty(rowsToLoad) && ~get(this.GUI.handles.dw.SLROpts.saveGUI, 'Value');
    showWarning(this, 'OCIA:DWLoad:NoRows', 'No rows selected for loading !');
    return;
end;


% if no load path specified, try to get one via the user interface
if isempty(loadPath);
    [loadName, loadPath] = uigetfile('*.*', 'Select a file to load', this.path.OCIASave);
    % if a path was specified, use that one
    if ischar(loadName);
        loadPath = [loadPath loadName];
    else % otherwise abort the loading
        return;
    end;
end;

% clean up the load path
loadPath = strrep(loadPath, '\', '/');
loadPath = sprintf('%s.h5', loadPath); % add .h5 extension
loadPath = regexprep(loadPath, '[\.,]h5\.h5$', '.h5'); % remove .h5 extension if present twice
loadPath = regexprep(loadPath, '[\.,]hdf5\.h5$', '.h5'); % remove .h5 extension if present twice
loadPath = regexprep(loadPath, '[\.,]mat\.h5$', '.h5'); % clean-up .mat.h5 extension

% if GUI is required to be loaded, load it from the MAT-file
if get(this.GUI.handles.dw.SLROpts.saveGUI, 'Value');
    GUILoadPath = regexprep(loadPath, '\.\h5$', '.mat'); % replace extension by .mat
    DWLoadGUIFromMAT(this, GUILoadPath);
end;

% check if the file exists
if ~exist(loadPath, 'file') && isempty(regexp(loadPath, 'GUI.h5$', 'once'));
    showWarning(this, 'OCIA:DWLoad:FileNotFound', sprintf('Cannot find file "%s" for loading. Aborting.', loadPath));
    return;
end;

%{
% if GUI is required to be loaded, load it from the HDF5 file
if get(this.GUI.handles.dw.SLROpts.saveGUI, 'Value');
    DWLoadGUIFromHDF5(this, loadPath);
end;
%}

% if any HDF5-type data is required to be loaded, load the data from the HDF5 file
if any(strcmp('HDF5', toLoadFormats));
    DWLoadDataFromHDF5(this, loadPath);
end;

% % if any mat-type data is required to be loaded, load the data from the MAT-file
% if any(strcmp('mat', toLoadFormats));
%     loadPath = regexprep(loadPath, '\.\h5$', '.mat'); % replace extension by .mat
%     DWLoadDataAsMat(this, loadPath);
% end;
    
end
