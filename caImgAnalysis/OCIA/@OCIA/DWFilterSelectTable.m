function DWFilterSelectTable(this, filterType)
% DWFilterSelectTable - [no description]
%
%       DWFilterSelectTable(this, filterType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    %% - DWFilterSelectTable: get the values of each filters
    nFilters = size(this.GUI.dw.filtElems, 1); % get the number of filters
    
    % create the filter text which will filter the whole table
    filtText = '';
    
    % go through each filter
    for iFilt = 1 : nFilters;
        filtID = char(this.GUI.dw.filtElems{iFilt, 'id'}); % get the ID of the filter
        % create a flag for regular expression filtering
        useRegexpFilt = false;
        % process differently depending on the filter's GUI type
        switch char(this.GUI.dw.filtElems{iFilt, 'GUIType'});
            % drop-down list
            case 'dropdown';
                % get all the IDs for this filter
                IDs = get(this.GUI.handles.dw.filt.([filtID 'ID']), 'String');
                % get the selected ID for this filter
                filtValue = IDs{get(this.GUI.handles.dw.filt.([filtID 'ID']), 'Value')};
                % if the drop-down list is on '-', it means no filtering should apply
                if strcmp(filtValue, '-'); filtValue = ''; end;
                
            % text field
            case 'textfield';
                % get the text of this filter
                filtValue = get(this.GUI.handles.dw.filt.(filtID), 'String');
                % make sure we have char not cell
                if iscell(filtValue); filtValue = cell2mat(filtValue); end;
                % if the filter supports range evaluation
                if this.GUI.dw.filtElems.rangeSupport(iFilt) && ~isempty(filtValue);
                    filtRange = []; % initialize the variable
                    eval(sprintf('filtRange = [%s];', filtValue)); % evaluate the range
                    % define the filter's text as an "OR" list: 001|002|003|etc.
                    filtValue = ['^(' regexprep(sprintf('[ 0]*%d|', filtRange), '\|$', '') ')$'];
                    % mark this filtering to use regular expression
                    useRegexpFilt = true;
                end;
        end;

        % if there is a filtering value, apply filter
        if ~isempty(filtValue);
            % if current filter is the "general" filtering string
            if strcmp(this.GUI.dw.filtElems.DWTableID{iFilt}, '*');
                % use the filter value directly as filter text
                filtText = sprintf('%s AND %s', filtText, filtValue);
            % if current filter is a data sub-column filter(like rawImg = partial)
            elseif strcmp(this.GUI.dw.filtElems.DWTableID{iFilt}, 'data');
                % use the filter value directly as filter text
                filtText = sprintf('%s AND %s', filtText, regexprep(filtValue, '(\w+) ([!~]{0,2}\=)', 'data.$1.loadStatus $2'));
            % otherwise use the standard pair-value syntax, with eventual regular expression matching
            else
                filtText = sprintf('%s AND %s %s= %s', filtText, this.GUI.dw.filtElems.DWTableID{iFilt}, ...
                    iff(useRegexpFilt, '~', ''), filtValue);
            end;
        end;
    end;
    
    % clean up the created filter string and use it filter the DataWatcher's table
    filtText = regexprep(filtText, '^ AND ', '');
    [~, filtRowIndexes] = DWFilterTable(this, filtText);
    
    %% - DWFilterSelectTable: select the rows
    switch filterType;
        
        % add the new rows to the existing selection
        case 'add';
            filtRowIndexes = unique([filtRowIndexes; this.dw.selectedTableRows]);
        % remove the new rows from the existing selection
        case 'rem';
            filtRowIndexes = setdiff(this.dw.selectedTableRows, filtRowIndexes);
        % just select the rows clearing up the previous selection
        case 'new';
            % nothing to do, previous rows will be discarded
    end;
    
    % actually select the rows
    DWSelTableRows(this, filtRowIndexes);
    
    % create a nicer display and show message
    filtTextDisplay = regexprep(filtText, '\^[^\$]+\$', '[...]');    
    showMessage(this, sprintf('Selected %d row(s) using filter text: "%s".', numel(this.dw.selectedTableRows), filtTextDisplay));

end
