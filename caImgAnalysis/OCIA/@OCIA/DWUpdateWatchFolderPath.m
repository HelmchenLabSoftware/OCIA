function DWUpdateWatchFolderPath(this, varargin)
% DWUpdateWatchFolderPath - [no description]
%
%       DWUpdateWatchFolderPath(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% warn the user that changing the watch folder path flushes all data
if ~this.dw.ignoreDataFlushWarning;
    doFlush = questdlg('Changing the watch folder flushes all loaded data. Continue ?', ...
        '/!\ Warning ! Data flush !', 'Yes', 'No', 'Yes');
    if strcmp(doFlush, 'No'); return; end;
end;

% get the location of data: local imaging folder or in the raw data
rawOrLocal = get(get(this.GUI.handles.dw.rawLocGroup, 'SelectedObject'), 'String');

o('#DWUpdateWatchFolderPath(): rawOrCurrent: %s ...', rawOrLocal, 4, this.verb);

% if there was a path as input argument, use that as watch folder path and store it as local/raw data path
if nargin > 1 && ischar(varargin{1});
    newPath = varargin{1};
    % if the new path is empty, show user interface to select a folder
    if isempty(newPath);
        newPath = uigetdir(this.path.([rawOrLocal 'Data']), 'Select a folder to use as watch folder');
        if ~ischar(newPath) && newPath == 0; % if user aborted the path selection, do not update anything
            return;
        end;
    end;
    % clean up the path for display
    newPath = [strrep(newPath, '\', '/'), '/'];
    newPath = strrep(newPath, '//', '/');
    this.path.([rawOrLocal 'Data']) = newPath;
% if there was no path as input argument, use as watch folder path the local/raw data path
else
    newPath = this.path.([rawOrLocal 'Data']);
end;

% update the watch folder's path and its display
this.dw.watchFolder = newPath;
set(this.GUI.handles.dw.watchFoldDisp, 'String', sprintf('Watch folder: " %s "', this.dw.watchFolder));
showMessage(this, sprintf('New watch folder path: %s ...', this.dw.watchFolder));

% empty the selected rows and the table and display the table
this.dw.selectedTableRows = [];
this.dw.table(:, :) = { [] };
DWDisplayTable(this, false); % false is for no warning

% process automatically the watch folder if requested
if this.dw.autoProcessWatchFolder;
    DWProcessWatchFolder(this);
end;

end
