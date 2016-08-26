function keep = DWKeepFile(this, toKeepWatchTypes, fileName)
% DWKeepFile - [no description]
%
%       keep = DWKeepFile(this, toKeepWatchTypes, fileName)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
% Returns whether the specified filename is to be kept using the toKeepWatchTypes structure's content

watchTypeIDs = this.dw.watchTypes.id; % get all watch type IDs

keep = false; % default is false
% go through all watch types
for iWatchType = 1 : numel(watchTypeIDs);
    watchTypeID = watchTypeIDs{iWatchType}; % get the watch type's ID
    % if the file type is to be kept and the item's ID matches the watchType's ID, keep it
    if toKeepWatchTypes.(watchTypeID) ...
            && ~isempty(regexp(fileName, char(this.dw.watchTypes{strcmp(watchTypeIDs, watchTypeID), 'pattern'}), 'once'));
        keep = true;
        break;
    end;
end;

end