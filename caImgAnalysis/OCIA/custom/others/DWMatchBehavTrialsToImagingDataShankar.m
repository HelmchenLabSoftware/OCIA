function DWMatchBehavTrialsToImagingDataShankar(this)
% DWMatchBehavTrialsToImagingDataShankar - [no description]
%
%       DWMatchBehavTrialsToImagingDataShankar(this)
%
% Match the behavior trials and the data files.

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% update the wait bar
DWWaitBar(this, 0);

% get the list of all animals
uniqueAnimals = get(this, 'animal');
uniqueAnimals(cellfun(@isempty, uniqueAnimals)) = [];
uniqueAnimals = unique(uniqueAnimals);

% get the list of all days
uniqueDays = get(this, 'day');
uniqueDays(cellfun(@isempty, uniqueDays)) = [];
uniqueDays = unique(uniqueDays);
    
% get the list of all spots
uniqueSpots = get(this, 'spot');
uniqueSpots(cellfun(@isempty, uniqueSpots)) = [];
uniqueSpots = unique(uniqueSpots);

% get the selected animal IDs
selectedAnimalIDs = this.dw.animalIDs(get(this.GUI.handles.dw.filt.animalID, 'Value'));
% if the dash '-' is selected, select all IDs
if numel(selectedAnimalIDs) == 1 && strcmp(selectedAnimalIDs{1}, '-');
    selectedAnimalIDs = uniqueAnimals;
end;

% get the selected day IDs
selectedDayIDs = this.dw.dayIDs(get(this.GUI.handles.dw.filt.dayID, 'Value'));
% if the dash '-' is selected, select all IDs
if numel(selectedDayIDs) == 1 && strcmp(selectedDayIDs{1}, '-');
    selectedDayIDs = uniqueDays;
end;

% cell array storing all the informations to process each session
allSessionInfos = cell(1000, 5);

commentRows = DWFilterTable(this, sprintf('rowType = Imaging data AND runType = comment'));
if ~isempty(commentRows);
    commentRowIndexes = str2double(get(this, 'all', 'rowNum', commentRows));
    set(this, commentRowIndexes, 'runType', '');
end;

% first get all the information for each sessions to process
% go through each animal
for iAnim = 1 : numel(uniqueAnimals);    
    animalID = uniqueAnimals{iAnim}; % get the current animal

    % skip irrelevant animal IDs
    if ~ismember(animalID, selectedAnimalIDs); continue; end;
    
    % go through each day
    for iDay = 1 : numel(uniqueDays);    
        dayID = uniqueDays{iDay}; % get the current day

        % skip irrelevant days
        if ~ismember(dayID, selectedDayIDs); continue; end;
    
        % go through spot by spot
        for iSpot = 1 : numel(uniqueSpots);
            spotID = uniqueSpots{iSpot}; % get the current spot

            % get the imaging rows indexes for this day and this spot
            imagingRows = DWFilterTable(this, ...
                sprintf('animal = %s AND day = %s AND spot = %s AND rowType = Imaging data AND runType !~= \\w+', ...
                animalID, dayID, spotID));
            imagingRowIndexes = str2double(get(this, 'all', 'rowNum', imagingRows));

            % if no imaging data, skip
            if isempty(imagingRowIndexes) || any(isnan(imagingRowIndexes));
                continue;
            end;
            
            % find behavior row
            behavRow = DWFilterTable(this, ...
                sprintf('animal = %s AND day = %s AND spot = %s AND rowType = Behavior data', ...
                animalID, dayID, spotID));
            
            % if no behavior row, continue
            if isempty(behavRow); 
                continue;
            end;
            
            % get the DW's table row index
            iDWRowBehav = str2double(get(this, 1, 'rowNum', behavRow));
            
            % get behavior data
            DWLoadRow(this, iDWRowBehav, 'full');
            behavData = getData(this, iDWRowBehav, 'behavtext', 'data');
            
            % check consistency
            if numel(behavData) ~= numel(imagingRowIndexes);    
                showWarning(this, 'OCIA:DWMatchBehavTrialsToImagingDataShankar:NotEnoughBehavRows', ...
                    'Not enough behavior rows !');
                continue;
            end;

            % match behavior data with imaging rows
            for iRow = 1 : numel(imagingRowIndexes);
                % annotate in table
                stimID = behavData(iRow).stimulus;
                set(this, imagingRowIndexes(iRow), 'runType', regexprep(stimID, 'Texture \d+ ', '')); 
                set(this, imagingRowIndexes(iRow), 'comments', behavData(iRow).decision);  
                set(this, imagingRowIndexes(iRow), 'runNum', sprintf('%03d', iRow));
                % store the structure and mark it as loaded
                setData(this, imagingRowIndexes(iRow), 'behavExtr', 'data', behavData(iRow));
                setData(this, imagingRowIndexes(iRow), 'behavExtr', 'loadStatus', 'full');
            end;
            
        end; % end of spot loop
    end; % end of day loop
end; % end of animal loop

% remove empty lines
allSessionInfos(cellfun(@isempty, allSessionInfos(:, 1)), :) = [];
nTotSessions = size(allSessionInfos, 1);

% match all sessions
for iTotSess = 1 : nTotSessions;
    
    % match the behavior trials using the stored informations
    DWMatchBehavTrialsToImagingDataForSession(this, allSessionInfos{iTotSess, :});
    
    % update the wait bar
    DWWaitBar(this, 99 * (iTotSess / nTotSessions));
    
end;
    
% remove raw behavior data for the current session
behavRows = DWFilterTable(this, 'rowType = Behavior data');
DWFlushData(this, str2double(get(this, 'all', 'rowNum', behavRows)), false, 'behav');

% final update of the wait bar
DWWaitBar(this, 100);

end

%% - #clusterRowsBySession
function sessIDs = clusterRowsBySession(this, rowNums)

% do not process if not at least 2 rows
if numel(rowNums) < 2;
    sessIDs = repmat('1', numel(rowNums), 1);
    return;
end;
    
% separate rows into morning and afternoon sessions
nUnknRows = size(rowNums, 1);
dateNums = zeros(nUnknRows, 1);
for iUnknRow = 1 : nUnknRows;
    dateAndTime = get(this, rowNums(iUnknRow), { 'day', 'time' });
    dateNums(iUnknRow) = datenum(sprintf('%s__%s', dateAndTime{:}), 'yyyy_mm_dd__HH_MM_SS');
end;
sessIDs = clusterdata(dateNums, 'maxclust', 2);
nearbySessDiffInHours = (dn2unix(dateNums(find(sessIDs == sessIDs(end), 1, 'first'))) ...
    - dn2unix(dateNums(find(sessIDs == sessIDs(1), 1, 'last')))) / 1000 / 60 / 60;
% if sessions are too close, it means that it was a single session with a missing trial/interruption
if nearbySessDiffInHours < 3; % minimum 3 hours between sessions
    sessIDs = clusterdata(dateNums, 'maxclust', 1);
end;

end
