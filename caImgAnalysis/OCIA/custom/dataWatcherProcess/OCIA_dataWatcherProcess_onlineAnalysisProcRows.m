function OCIA_dataWatcherProcess_onlineAnalysisProcRows(this, ~, ~)
% OCIA_dataWatcherProcess_onlineAnalysisProcRows - [no description]
%
%       OCIA_dataWatcherProcess_onlineAnalysisProcRows(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the selected rows
selRows = this.dw.selectedTableRows;
% abort if no rows
if isempty(selRows); return; end;

% create the filter for them
selRowsFiltStr = regexprep(sprintf('%03d|', selRows), '\|$', '');
selRowsFiltStr = sprintf(' AND rowNum ~= (%s)', selRowsFiltStr);

% get the days to use
refDay = this.dw.onlineAnalysisRefDay;
currDay = this.dw.onlineAnalysisCurrDay;
prevDay = this.dw.onlineAnalysisPrevDay;

% get the reference state of the selected rows
selRowsIsRefCell = get(this, selRows, 'isRef');
if ~iscell(selRowsIsRefCell); selRowsIsRefCell = { selRowsIsRefCell }; end;

% count how many of each
nSelRefRows = sum(cellfun(@(cont) strcmp(cont, 'REF'), selRowsIsRefCell));
nNonSelRefRows = sum(cellfun(@(cont) isempty(cont) || strcmp(cont, 'nop'), selRowsIsRefCell));

% if any reference rows selected, compare them to the reference days
if nSelRefRows;
    
    %% select the reference rows of the reference day (only once)
    % get the reference rows of the reference day
    refDayRefRows = DWFilterTable(this, sprintf('day = %s AND isRef = REF', refDay));
    % if no reference day reference rows found, get them
    while isempty(refDayRefRows);
        showMessage(this, 'OnlineAnalysis: please select the reference rows of the reference day ...', 'yellow');
        % wait before checking again
        pause(1);     
        % get any row of the reference day
        refDayRefRows = DWFilterTable(this, sprintf('day = %s AND isRef = REF', refDay));
    end;

    %% calculate correlations of reference to reference day's reference
    OCIA_onlineAnalysis_behavExp_calcCorrAndShiftAndBleach(this, refDay, 'isRef = REF', currDay, ...
        ['isRef = REF' selRowsFiltStr], 0);
    
end;

% if any non-reference rows selected, compare them to the current days
if nNonSelRefRows;
    
    %% select the reference rows of the current day (only once)
    % get all the spotIDs for the current day
    currDaySpotIDs = get(this, 'all', 'spot', DWFilterTable(this, [sprintf('day = %s', currDay) selRowsFiltStr]));
    if ~isempty(currDaySpotIDs) && ~iscell(currDaySpotIDs); currDaySpotIDs = { currDaySpotIDs }; end;

    % if no spot IDs, do not do anything
    if ~isempty(currDaySpotIDs)

        % get the unique spot IDs
        currDaySpotIDs(cellfun(@isempty, currDaySpotIDs)) = [];
        currDaySpotIDs = unique(currDaySpotIDs);

        % get the reference rows of the current day
        currDayRefRows = DWFilterTable(this, sprintf('day = %s AND isRef = REF', currDay));

        if ~isempty(currDayRefRows);
            % if the number of current day reference rows found does not match the number of current day spots
            while ~any(ismember(get(this, 'all', 'spot', currDayRefRows), currDaySpotIDs));
                showMessage(this, 'OnlineAnalysis: please select the reference rows of the current day ...', 'yellow');
                % wait before checking again
                pause(1);
                % get the reference rows of the current day
                currDayRefRows = DWFilterTable(this, sprintf('day = %s AND isRef = REF', currDay));
            end;
        end;
    end;

    %% calculate correlations and shifts of current day's non-reference rows to current day's reference row
    OCIA_onlineAnalysis_behavExp_calcCorrAndShiftAndBleach(this, currDay, 'isRef = REF', currDay, ...
        ['isRef != REF' selRowsFiltStr], 1);

end;

end
