function localTable = DWProcessGenericFolder(this, parentTemplateTableRow, fullPath, parentFolder, folderName, ~, ~, ...
    toKeepWatchTypes, percentToFill)
% DWProcessGenericFolder - [no description]
%
%       localTable = DWProcessGenericFolder(this, parentTemplateTableRow, fullPath, parentFolder, folderName, ~, ~, ...
%                       toKeepWatchTypes, percentToFill)
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    

processTic = tic; % for performance timing purposes
o('#DWProcessGenericFolder(): fullFolderPath: "%s", parentFolder: "%s".', fullPath, parentFolder, 3, this.verb);

% check if the processing should be aborted
if DWCheckProcessAbort(this, [], []); localTable = -1; return; end;

% make sure there's a backslash at the end of the path
if isempty(regexp(fullPath, '/$', 'once')); fullPath = [fullPath '/']; end;
if exist(fullPath, 'dir') ~= 7;
    localTable = -1;
    showWarning(this, 'OCIA:DWProcessGenericFolder:FolderNotFound', ...
        sprintf('Cannot find the specified folder at "%s"! Aborting.', fullPath));
    return;
end;

% get the content of the curently processed folder
items = dir(fullPath);

% exclude everything that is not in one of the required formats or that shouldn't be included in the DataWatcher's table
items(arrayfun(@(x)~DWKeepFile(this, toKeepWatchTypes, x.name), items)) = [];

% get the folders sorted out by name
sortedItemNames = sort(arrayfun(@(x)x.name, items, 'UniformOutput', false));

% count the number of folders
nItems = numel(sortedItemNames);
o('#DWProcessGenericFolder(): found %d file(s)/folder(s).', nItems, 3, this.verb);

% initialize the row counter and the local table for the current folder, pre-allocated with 100 rows
localTable = cell(300, size(this.dw.table, 2));
iRow = 1;

% intialize the waiting bar
currPercent = 0;
if isGUI(this) && isfield(this.GUI.handles.dw, 'waitBarRect') && ishandle(this.GUI.handles.dw.waitBarRect);
    percentPos = get(this.GUI.handles.dw.waitBarRect, 'Position');
    currPercent = percentPos(3);
end;

watchTypeIDs = this.dw.watchTypes.id; % get all watch type IDs
watchTypePatterns = this.dw.watchTypes.pattern; % get the watch type patterns

% loop trough all existing folders and process them depending on the type of the folder
for iItem = 1 : nItems;
    % get the name of the file/folder, without the full path
    itemName = sortedItemNames{iItem};
    newFullPath = [fullPath itemName]; % get the new full path
    foundWatchTypeMatch = false; % set to true when a watch type is matched
    
    % go through all file types
    for iWatchType = 1 : numel(watchTypeIDs);
        watchTypeID = watchTypeIDs{iWatchType}; % get the current file types        
        
        % check if the processing should be aborted
        if DWCheckProcessAbort(this, [], []); localTable = -1; return; end;
        
        % try to match the current file type
        if regexp(itemName, char(watchTypePatterns{strcmp(watchTypeIDs, watchTypeID)}));
            
            % mark that a matching watchType was found
            foundWatchTypeMatch = true;
            
            % check whether the current item is in the right place regarding the file structure:
            % get the parent watch types where this item should be
            parentWatchTypeIDs = this.dw.watchTypes{strcmp(watchTypeIDs, watchTypeID), 'parent'};
            % extract the sub-cell
            if ~isempty(parentWatchTypeIDs) && iscell(parentWatchTypeIDs{1});
                parentWatchTypeIDs = parentWatchTypeIDs{1};
            end;
            parentWatchTypeIDs(cellfun(@isempty, parentWatchTypeIDs)) = []; % remove emptys parents
            % if the parent watch type is empty (root watch type), or if this folder is the root folder (empty), 
            %   then we are okay to process further. Otherwise check the parent folder to make sure this folder is
            %   under the "right" parent folder.
            if ~isempty(parentWatchTypeIDs) && ~isempty(folderName);
                % check all parent watch type IDs
                foundParent = false;
                for iParent = 1 : numel(parentWatchTypeIDs);
                    % get this watch type's parent's pattern
                    parentPattern = watchTypePatterns{strcmp(watchTypeIDs, parentWatchTypeIDs{iParent})};
                    % check if the parent folder is supposed to be a parent of the current folder
                    if ~isempty(regexp(folderName, parentPattern, 'once'));
                        foundParent = true;
                        break;
                    end;
                end;
                % if no parent watch type matched the parent folder's name, this folder is misplaced and should be
                % skipped
                if ~foundParent;
                    showWarning(this, 'OCIA:DWProcessGenericFolder:MisplacedFolder', sprintf(['Folder "%s" might be ', ...
                        'misplaced: it matches the watch type "%s" but has not parent watch type matching its parent ', ...
                        'folder "%s" (full path: "%s")'], itemName, watchTypeID, parentFolder, [fullPath itemName]));
                    continue;
                end;
            end;

            % do not process again any potential folders of the same watch type: so make a copy of the 
            %   toKeepWatchTypes structure and set current watch type to 0. 
            localToKeepWatchTypes = toKeepWatchTypes;
            localToKeepWatchTypes.(watchTypeID) = 0;
            
            % create a template table which extracts information at this level of processing
            templateTableRow = DWProcessFileOrFolderCommon(this, parentTemplateTableRow, fullPath, watchTypeID, itemName);
            
            % check whether a folder processing function exists for this watch type
            if exist(['OCIA_processFolder_' watchTypeID], 'file');
                o('  #DWProcessGenericFolder(): found "%s": "specific" folder: "%s".', watchTypeID, itemName, 4, this.verb);
                % get the common processing function's handle
                funcHandle = str2func('DWProcessCustomFolder');
                % get the specific folder processing function handle
                customFunctionHandle = str2func(['OCIA_processFolder_' watchTypeID]);
                
            % check whether a file processing function exists for this watch type
            elseif exist(['OCIA_processFile_' watchTypeID], 'file');
                o('  #DWProcessGenericFolder(): found "%s": "specific" file: "%s".', watchTypeID, itemName, 4, this.verb);
                % get the common processing function's handle
                funcHandle = str2func('DWProcessCustomFolder');
                % get the specific file processing function handle
                customFunctionHandle = str2func(['OCIA_processFile_' watchTypeID]);
                
            % check whether the current item is a folder
            elseif exist([fullPath itemName], 'dir');
                o('  #DWProcessGenericFolder(): found "%s": "generic" folder: "%s".', watchTypeID, itemName, 4, this.verb);
                % get the generic folder processing function handle
                funcHandle = str2func('DWProcessGenericFolder');
                % no custom function for the generic folder processing function
                customFunctionHandle = [];
                
            % no function could be found for this item - watchType
            else
                showWarning(this, 'OCIA:DWProcessGenericFolder:NoFunctionAndNotFolder', ...
                    sprintf('Cannot find a processing function for "%s" and item is not a folder. Skipping.', ...
                    [fullPath itemName]));
                continue;
            end;
            
            % update filter with new element if it is not already in there
            if isfield(this.dw, [watchTypeID 'IDs']) && ~ismember(itemName, this.dw.([watchTypeID 'IDs']));
                % append the new element to the list
                this.dw.([watchTypeID 'IDs']) = sort([this.dw.([watchTypeID 'IDs']), { itemName }]);
            end;
            
            % if there is a filter matching this watch type
            if isfield(this.GUI.handles.dw.filt, [watchTypeID 'ID']);
                % check for the filters to eventually interrupt search: get all items from the list
                filtIDs = get(this.GUI.handles.dw.filt.([watchTypeID 'ID']), 'String');
                % get the currently selected item
                filtID = filtIDs{get(this.GUI.handles.dw.filt.([watchTypeID 'ID']), 'Value')};
                % if it is not the dash (meaning no filtering) and the ID does not match, skip this folder
                if ~strcmp(filtID, '-') && ~strcmp(itemName, filtID);
                    continue;
                end;
            end;
            
            % process the file/folder with the appropriate function
            newTable = funcHandle(this, templateTableRow, newFullPath, folderName, itemName, customFunctionHandle, ...
                watchTypeID, localToKeepWatchTypes, percentToFill / nItems);
            
            % check if the processing should be aborted
            if DWCheckProcessAbort(this, [], []); localTable = -1; return; end;
            
            % if returned row is a summary row because no children items were found
            if ~isempty(newTable) && strcmp(get(this, 1, 'rowType', newTable), 'NoChildrenItemsFoundSummaryRow');
                newTable = set(this, 1, 'rowType', this.dw.watchTypes.label{iWatchType}, newTable); % re-label the row type
            end;
            
            % save the new table's rows in the local table
            localTable(iRow : (iRow + size(newTable, 1) - 1), :) = newTable;
            iRow = iRow + size(newTable, 1);

            % increment the counter and stop looping as only one watch type can be matched
            iRow = iRow + 1;
            break; % break out of watchType loop

        end; % end of watch type regexp match

    end; % end of watch type loop

    % if the current file didn't match any file types, display a warning
    if ~foundWatchTypeMatch;
        showWarning(this, 'OCIA:DWProcessGenericFolder:UnknownFolderType', ...
            sprintf('Unknown folder type found: "%s"! Skipping it.', itemName));
    end;
    
    % display information and update the waiting bar
    o('%40s: %d / %d, %.3f * %.3f = %.3f local, %.3f current, %.3f new', newFullPath, iItem, nItems, ...
        iItem / nItems, percentToFill, percentToFill * (iItem / nItems), currPercent, ...
        currPercent + percentToFill * (iItem / nItems), 5, this.verb);
    DWWaitBar(this, currPercent + percentToFill * (iItem / nItems));
    pause(0.0005);

end;

% clean up the local tables: delete empty cells
o('  #DWProcessGenericFolder(): folder(s) processing done, cleaning up local tables ...', 4, this.verb);
localTable(cellfun(@isempty, get(this, 'all', 'path', localTable)), :) = [];

% get the number of new rows
nNewRows = size(localTable, 1);

% if nothing was found inside the folder and summary line is required and the current folder
%   is not the watchFolder (folder name is empty), display a single row for this folder
if ~nNewRows && this.GUI.dw.showEmptyFolderSummary && ~isempty(folderName);
    % create a single row from the local table
    localTable = parentTemplateTableRow;
    localTable = set(this, 1, 'path', fullPath, localTable);
    % store the number of files found
    localTable = set(this, 1, 'rowType', 'NoChildrenItemsFoundSummaryRow', localTable);
end;

o('  #DWProcessGenericFolder(): done (%3.1f sec).', toc(processTic), 3, this.verb);

end
