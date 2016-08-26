function DWChangeWatchType(this, h, e)
% DWChangeWatchType - [no description]
%
%       DWChangeWatchType(this, h, e)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
 
    watchTypeHands = this.GUI.handles.dw.watchTypes; % get the watch type handles
    watchTypes = this.dw.watchTypes; % get the watchTypes table
    nWatchTypes = size(watchTypes, 1); % get the number of watch types
        
    % if change was requested by a string input
    if ischar(h);
        o('#DWChangeWatchType(): h: %s.', h, 3, this.verb);
        % switch the checkbox value
        checkState = get(watchTypeHands.(h), 'Value');
        set(watchTypeHands.(h), 'Value', ~checkState);
    else
        
        selWatchTypeLabel = get(h, 'Text'); % get the clicked watch type
        
        % if the select all / none was clicked, select all or none of the watch types
        if strcmpi(selWatchTypeLabel, get(this.GUI.handles.dw.watchTypesAllNone, 'String'));
            
            % get the IDs of the visible watch types
            visibleWatchTypeIDs = watchTypes{watchTypes.visible, 'id'};
            % get the number of checked watch types
            nChecked = sum(cellfun(@(x)get(watchTypeHands.(x), 'Value'), visibleWatchTypeIDs));
            % set the value of the visible watch types to:
            %   - 0 if all of them are clicked
            %   - 1 if some or none are clicked
            arrayfun(@(i) set(watchTypeHands.(visibleWatchTypeIDs{i}), 'Value', nChecked ~= nWatchTypes), ...
                1 : numel(visibleWatchTypeIDs));
            
        % if right click, select only the right-clicked element and it's "parents"
        elseif e.getButton == 3;
            % get the selected watch type's ID
            selWatchTypeID = watchTypes{strcmp(watchTypes.label, selWatchTypeLabel), 'id'};
            % set all *visible* watch types to not checked
            for iType = 1 : nWatchTypes;
                set(watchTypeHands.(char(watchTypes{iType, 'id'})), 'Value', ~watchTypes{iType, 'visible'});
            end;
            % create a list of watch types to check
            watchTypeIDsList = selWatchTypeID;
            % recursively check each watch type until the parent
            while ~isempty(watchTypeIDsList);
                set(watchTypeHands.(char(watchTypeIDsList{1})), 'Value', 1); % check this watch type
                % get the parent of the current watch type
                parentWatchTypeIDs = watchTypes{strcmp(watchTypes.id, char(watchTypeIDsList{1})), 'parent'};
                watchTypeIDsList(1) = []; % remove it from the list
                parentWatchTypeIDs(cellfun(@isempty, parentWatchTypeIDs)) = []; % remove empty parents
                if isempty(parentWatchTypeIDs); continue; end; % skip if no parent
                % add them to the list
                if iscell(parentWatchTypeIDs{1}); % if its a cell, add all elements of it
                    watchTypeIDsList(end + 1 : end + numel(parentWatchTypeIDs{1})) = parentWatchTypeIDs{1};
                elseif ischar(parentWatchTypeIDs{1}); % if its a string, add only that string
                    watchTypeIDsList(end + 1) = parentWatchTypeIDs; %#ok<AGROW>
                end;
            end;
        end;
    end;

end