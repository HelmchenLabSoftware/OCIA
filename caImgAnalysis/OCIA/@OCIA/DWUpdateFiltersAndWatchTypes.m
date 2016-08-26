function DWUpdateFiltersAndWatchTypes(this)
% DWUpdateFiltersAndWatchTypes - [no description]
%
%       DWUpdateFiltersAndWatchTypes(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% if some DataWatcher filters have been provided, set them
GUIDWFiltH = this.GUI.handles.dw.filt;
if ~isempty(this.GUI.dw.DWFilt);
    % get the names of the filters from the GUI
    filterNames = fieldnames(GUIDWFiltH);
    % get the number of provided filters but do not exceed available filters
    nFilters = min(numel(this.GUI.dw.DWFilt), numel(filterNames));
    % go through each input filter
    for iFilt = 1 : nFilters;
        % get the current filter name
        filtName = filterNames{iFilt};
        % if filter is a pop-up menu, add the filter as a string with the starting hyphen '-', which
        %   means no filter, and select the second item if there is at least 2 (since the first is '-')
        if strcmp(get(GUIDWFiltH.(filtName), 'Style'), 'popupmenu');
            this.dw.([filtName 's']) = [{'-'}, this.GUI.dw.DWFilt{iFilt}]; % extract and store as a cell array
            set(GUIDWFiltH.(filtName), 'String', this.dw.([filtName 's']), ...
                'Value', min(numel(this.dw.([filtName 's'])), 2));
        % if filter is an edit field, just add the filter as a string
        elseif strcmp(get(GUIDWFiltH.(filtName), 'Style'), 'edit');
            set(GUIDWFiltH.(filtName), 'String', this.GUI.dw.DWFilt(iFilt));
        end;
    end;
end;

% if some DataWatcher watch types have been provided, set them
if ~isempty(this.GUI.dw.DWWatchTypes);
    watchTypeIDs = this.dw.watchTypes.id; % get all watch type IDs
    % go through each input watch type
    for iWT = 1 : numel(watchTypeIDs);
        % get the current watch type's GUI handle
        WTHand = this.GUI.handles.dw.watchTypes.(watchTypeIDs{iWT});
        % set the value of the watch type depending on whether it is in the input list or not and on the visibility
        %   (invisible elements are always selected)
        set(WTHand, 'Value', any(strcmp(this.GUI.dw.DWWatchTypes, 'all')) ...
            || ismember(watchTypeIDs{iWT}, this.GUI.dw.DWWatchTypes) ...
            || ~this.dw.watchTypes{watchTypeIDs{iWT}, 'visible'}); %#ok<BDSCA>
    end;
end;

% set the skip meta-data information processing GUI element
set(this.GUI.handles.dw.skipMeta, 'Value', this.GUI.dw.DWSkiptMeta);

% set if data should be fetched from raw or local folders
set(this.GUI.handles.dw.rawLocGroup, 'SelectedObject', this.GUI.handles.dw.rawLocSel.(this.GUI.dw.DWRawOrLocal(1:3)));

end
