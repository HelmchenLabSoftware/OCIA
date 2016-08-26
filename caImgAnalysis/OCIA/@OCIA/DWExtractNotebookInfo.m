function DWExtractNotebookInfo(this, ~, ~)
% DWExtractNotebookInfo - Extracts the notebook file's informations to annotate the DataWatcher's table
%
%       DWExtractNotebookInfo(this)
%       DWExtractNotebookInfo(this, handles, event)
%
% Reads all the notebook files present in the table (notebook rows) and extract their information to annotate the
%   DataWatcher table's imaging rows. Each imaging row is temptatively associated with a notebook row and the
%   imaging informations are copied (frame rate, laser intensity, etc.). This function relies on the notebook parsing
%   function name configuration "this.dw.notebookParsingFunctionName".

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

extractTic = tic; % for performance timing purposes
DWWaitBar(this, 0);
o('#DWExtractNotebookInfo()', 3, this.verb);

% if there is no notebook parsing function or its specified to 'none', show a warning and abort
if isempty(this.dw.notebookParsingFunctionName) || strcmp(this.dw.notebookParsingFunctionName, 'none');
    showMessage(this, 'No notebook parsing function: skipping notebook parsing.', 'yellow');
    return;
end;

% if there are no rows in the table, show a warning and abort
if size(this.dw.table, 1) == 1 || all(cellfun(@isempty, get(this, 'rowType')));
     showWarning(this, 'OCIA:DWExtractNotebookInfo:EmptyTable', ['Cannot extract informations from ' ...
         'notebook file because the DataWatcher''s table is empty and thus no notebook file can be found.']);
    return;
end

% find all notebook rows' indexes
notebookRows = DWFilterTable(this, 'rowType ~= Notebook');

% if no notebook row can be found in the table, show a warning and abort
if isempty(notebookRows);
     showWarning(this, 'OCIA:DWExtractNotebookInfo:NotebookFileNotFound', ...
        ['Cannot extract informations from notebook file because there was no notebook row' ...
            ' in the DataWatcher''s table and thus no notebook file can be found.']);
    return;
end;

% get each unique animal of the rows and count them
allAnimals = get(this, 'all', 'animal', notebookRows);
if ~iscell(allAnimals); allAnimals = { allAnimals }; end;
allAnimals(cellfun(@isempty, allAnimals)) = { '' };
uniqueAnimals = unique(allAnimals, 'stable');
nUniqueAnimals = numel(uniqueAnimals);

% get the selected animal IDs
selectedAnimalIDs = this.dw.animalIDs(get(this.GUI.handles.dw.filt.animalID, 'Value'));
% if the dash '-' is selected, select all IDs
if numel(selectedAnimalIDs) == 1 && strcmp(selectedAnimalIDs{1}, '-');
    selectedAnimalIDs = uniqueAnimals;
end;

% go through the notebook files animal by animal
for iAnimal = 1 : nUniqueAnimals;
    % get the ID
    animID = uniqueAnimals{iAnimal};
    
    % skip irrelevant animal IDs
    if ~ismember(animID, selectedAnimalIDs); continue; end;

    % get each unique day of the rows and count them
    if ~isempty(animID);
        notebookAnimalRows = DWFilterTable(this, sprintf('animal = %s', animID), notebookRows);
    else
        notebookAnimalRows = notebookRows;
    end;
    allDays = get(this, 'all', 'day', notebookAnimalRows);
    if ~iscell(allDays); allDays = { allDays }; end;
    uniqueDays = unique(allDays, 'stable');
    nUniqueDays = numel(uniqueDays);

    % get the selected day IDs
    selectedDayIDs = this.dw.dayIDs(get(this.GUI.handles.dw.filt.dayID, 'Value'));
    % if the dash '-' is selected, select all IDs
    if numel(selectedDayIDs) == 1 && strcmp(selectedDayIDs{1}, '-');
        selectedDayIDs = uniqueDays;
    end;

    % go through day by day
    for iDay = 1 : nUniqueDays;
        % get the ID
        dayID = uniqueDays{iDay};
    
        % skip irrelevant days
        if ~ismember(dayID, selectedDayIDs); continue; end;
        
        % get the notebook files for that day
        if ~isempty(animID);
            notebookRowsDWForDay = DWFilterTable(this, sprintf('animal = %s AND day = %s', animID, dayID), notebookRows);
        else
            notebookRowsDWForDay = DWFilterTable(this, sprintf('day = %s', dayID), notebookRows);
        end;
        
        % just skip this run if no notebook rows are found
        if isempty(notebookRowsDWForDay);
             showWarning(this, 'OCIA:DWExtractNotebookInfo:NotebookFileNotFoundForSingleDay', ...
                sprintf(['Cannot extract informations from notebook file on the day "%s" for animal "%s" because ', ...
                'there was no notebook row in the DataWatcher''s table for that day.'], dayID, animID));
            continue;
        end;

        % get the number of notebook files and check if it exceeds 2 (which might mean that there are too many of them)
        nDWNBRowForDay = size(notebookRowsDWForDay, 1);
        if nDWNBRowForDay > 2; % more than 2, that's suspicious
            showWarning(this, 'OCIA:DWExtractNotebookInfo:TooManyNotebookRows', ...
                sprintf('A suspiciously big number of notebook rows (%d) have been found for day "%s" for animal "%s", using last one.', ...
                    nDWNBRowForDay, dayID, animID));
            % use the last one
            notebookRowsDWForDay = notebookRowsDWForDay(end, :);
            nDWNBRowForDay = size(notebookRowsDWForDay, 1);
        end;

        % process every notebook file found for the current day
        for iNBRow = 1 : nDWNBRowForDay;

            % call the notebook parsing function
            [~, NBOutput] = OCIAGetCallCustomFile(this, 'parseNotebookFile', ...
                this.dw.notebookParsingFunctionName, 1, { get(this, iNBRow, 'path', notebookRowsDWForDay) }, 1);
            [NBInfoTable, NBInfoTableIDs] = NBOutput{:};
            
            % get the animal ID and asign it to the notebook row
            NBAnimID = get(this, 1, 'animal', NBInfoTable, NBInfoTableIDs);
            if ~isempty(NBAnimID);
                set(this, str2double(get(this, iNBRow, 'rowNum', notebookRowsDWForDay)), 'animal', NBAnimID);
            end;

            % try to find matching rows between DataWatcher's table and notebook informations:
            % get all imaging data rows from the DataWatcher's table
            filterText = sprintf('animal = %s AND day = %s AND rowType ~= Imaging data', animID, dayID);
            filterText = regexprep(filterText, 'animal =  AND ', ''); % remove animal ID filtering if empty
            [imagingRows, imagingRowsIndexes] = DWFilterTable(this, filterText);

            % if no imaging rows are found, show a warning and skip this day
            if isempty(imagingRows);
                showWarning(this, 'OCIA:DWExtractNotebookInfo:NoImagingRows', ...
                    sprintf('No imaging data rows have been found for day %s.', dayID));
                break;
            end;

            % get the rowIDs of these rows
            imagingRowIDs = DWGetRowID(this, 1 : size(imagingRows), imagingRows);
            if ischar(imagingRowIDs); imagingRowIDs = { imagingRowIDs }; end;

            % get the rowIDs of the notebook rows
            NBRowIDs = DWGetRowID(this, 1 : size(NBInfoTable), NBInfoTable, NBInfoTableIDs);

            % loop through all notebook rows
            for iRow = 1 : size(imagingRows, 1);

                % get a row from the notebook file that matches this imaging row's ID
                matchingNBRow = NBInfoTable(strcmp(NBRowIDs, imagingRowIDs{iRow}), :);

                % just skip this run if it was not found in the notebook
                if isempty(matchingNBRow); continue; end;
                
                % check to change the filter settings
                NBCommentRows = DWFilterTable(this, 'runType = comment', NBInfoTable, NBInfoTableIDs);
                NBComments = get(this, 'all', 'comments', NBCommentRows, NBInfoTableIDs);
                if ~iscell(NBComments) && ~isempty(NBComments); NBComments = { NBComments }; end;
                % if red/green filter cube is specified, change general settings
                if ~isempty(NBComments) && any(cellfun(@(cont)~isempty(regexp(cont, '^red/green filter cube', 'once')), NBComments)), ...
                        isfield(this.an, 'img');
                    this.an.img.preProcChan = 2;
                    this.an.img.colVect = [1 2 0];
                    this.an.img.chanVect = 2;
                elseif ~isempty(NBComments) && any(cellfun(@(cont)~isempty(regexp(cont, '^green/blue filter cube', 'once')), NBComments)), ...
                        isfield(this.an, 'img');
                    this.an.img.preProcChan = 1;
                    this.an.img.colVect = [0 1 2];
                    this.an.img.chanVect = [1 2];
                end;

                % if more than one notebook rows matched this run, show a warning and only keep first match
                if size(matchingNBRow, 1) > 1;
                    showWarning(this, 'OCIA:DWExtractNotebookInfo:MultipleMatch', ...
                        sprintf('RowID %s, several notebook-file rows are present! Taking the first one ...', ...
                        imagingRowIDs{iRow}));
                    % only keep the first match
                    matchingNBRow = matchingNBRow(1, :);
                end;


                % copy the relevant informations from the notebook's table to the actual table
                % go through each variable of the notebook's table
                for iVar = 1 : numel(NBInfoTableIDs);
                    % get the variable name and the associated value of the notebook's table
                    NBVarName = NBInfoTableIDs{iVar};
                    NBValue = matchingNBRow{1, strcmp(NBInfoTableIDs, NBVarName)};

                    % if the notebook's variable does not exist in the actual table, continue
                    if ~ismember(NBVarName, this.dw.tableIDs); continue; end;

                    % get the imaging row's value
                    imRowValue = get(this, iRow, NBVarName, imagingRows);

                    % if the notebook's variable is empty, continue
                    if isempty(NBValue); continue; end;

                    % if the value is already set in the imaging row and is not matching, show a warning
                    if ~isempty(imRowValue) && ~strcmp(NBValue, imRowValue);
                        showWarning(this, 'OCIA:DWExtractNotebookInfo:VariableValueOverwrite', ...
                            sprintf(['RowID %s: variable "%s" has already a value: "%s", skipping the ', ...
                            'overwrite with "%s" from the notebook'], imagingRowIDs{iRow}, NBVarName, ...
                            imRowValue, NBValue));
                    % otherwise copy the variable's value
                    else
                        imagingRows = set(this, iRow, NBVarName, NBValue, imagingRows);
                    end;  
                end;
            end;

            % copy back the imaging rows content to the DataWAtcher's table
            this.dw.table(imagingRowsIndexes, :) = imagingRows;
        end;

        DWWaitBar(this, (iDay / nUniqueDays) * 100);

    end;
end;

% fill the wait bar and update the display of the DataWatcher's table
DWWaitBar(this, 100);
DWDisplayTable(this);

showMessage(this, sprintf('Extracted notebook information (%3.1f sec).', toc(extractTic)));

end
