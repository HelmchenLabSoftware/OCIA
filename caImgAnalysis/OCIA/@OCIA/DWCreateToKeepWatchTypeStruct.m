function toKeepWatchTypes = DWCreateToKeepWatchTypeStruct(this, doUseGUIValues, defaultValue)
% DWCreateToKeepWatchTypeStruct - Creates the "toKeepWatchType" structure used in the watch folder's processing
%
%       toKeepWatchTypes = DWCreateToKeepWatchTypeStruct(this, useGUI, defaultValue)
%
% Creates a 'toKeepWatchTypes' structure which defines which watch types (file types) should be included in the 
%   DataWatcher's table at the moment when the watch folder is processed. If the 'doUseGUIValues' logical is true, the 
%   structure is initiated with values based on the GUI checkboxes. If 'doUseGUIValues' is false, the 'defaultValue'
%   logical is used for all watch types.

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

toKeepWatchTypes = struct();

% go through all watch types
for iWatchType = 1 : size(this.dw.watchTypes, 1);
    watchTypeID = this.dw.watchTypes.id{iWatchType}; % get the watch type's ID
    if doUseGUIValues; % update using GUI
        toKeepWatchTypes.(watchTypeID) = get(this.GUI.handles.dw.watchTypes.(watchTypeID), 'Value');
    else % update using input value
        toKeepWatchTypes.(watchTypeID) = defaultValue;
    end;
end;

end















