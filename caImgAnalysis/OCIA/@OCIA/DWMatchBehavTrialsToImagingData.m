function DWMatchBehavTrialsToImagingData(this)
% DWMatchBehavTrialsToImagingData - [no description]
%
%       DWMatchBehavTrialsToImagingData(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
% match the behavior trials and the data files

% update the wait bar
DWWaitBar(this, 0);
    
% get the behavior rows with no animal ID and figure it out from the data structure
behavRows = DWFilterTable(this, 'animal !~= \w+ AND rowType = Behavior data');
for iBehavRow = 1 : size(behavRows, 1);
    % get the DataWatcher table's row index for this row
    iDWRow = str2double(get(this, iBehavRow, 'rowNum', behavRows));
    % load the row
    DWLoadRow(this, iDWRow, 'full');
    % get the behavior data
    behavData = getData(this, iDWRow, 'behav', 'data');
    % set the new animal ID
    set(this, iDWRow, 'animal', regexprep(['mou_bl_', behavData.animalID], 'mou_bl_mou_bl', 'mou_bl'));
end;

% get the list of all animals
uniqueAnimals = get(this, 'animal');
if ~iscell(uniqueAnimals) && ischar(uniqueAnimals) && ~isempty(uniqueAnimals); uniqueAnimals = { uniqueAnimals }; end;
uniqueAnimals(cellfun(@isempty, uniqueAnimals)) = { '' };
uniqueAnimals = unique(uniqueAnimals);

% get the list of all days
uniqueDays = get(this, 'day');
if ~iscell(uniqueDays) && ischar(uniqueDays) && ~isempty(uniqueDays); uniqueDays = { uniqueDays }; end;
uniqueDays(cellfun(@isempty, uniqueDays)) = [];
uniqueDays = unique(uniqueDays);

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
allSessionInfos = cell(1000, 6);

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

        % empty spot filters
        spotID = '';
        spotFilter = '';

        % create animal filter
        if isempty(animalID);
            animalFilter = 'animal !~= \w AND ';
        else
            animalFilter = sprintf('animal = %s AND ', animalID);
        end;

        % use different filters for different locations
        locFilter = {
            '', '';
        };
        if ismember('loc', this.dw.tableIDs);
            locFilter = {
                '',         ' AND loc !~= \w+'; 
                'local',    ' AND loc = local';
                'remote',   ' AND loc = remote';
            }; 
        end;
        
        % go through each location filter
        for iLocFilter = 1 : size(locFilter, 1);
            
            % get the imaging rows indexes
            imagingRows = DWFilterTable(this, ...
                sprintf('%s%sday = %s AND rowType = Imaging data AND runType !~= \\w+%s', ...
                animalFilter, spotFilter, dayID, locFilter{iLocFilter, 2}));
            imagingRowIndexes = str2double(get(this, 'all', 'rowNum', imagingRows));

            % if no imaging data, skip
            if isempty(imagingRowIndexes) || any(isnan(imagingRowIndexes));
                continue;
            % if only one row found, label it as session 1
            elseif numel(imagingRowIndexes) == 1;
                sessIDs = 1;            
            % if several rows, cluster them by session using time
            else
                sessIDs = clusterRowsBySession(this, imagingRowIndexes);
            end;

            % go through session by session
            for iSess = 1 : size(unique(sessIDs), 1);
                % get the indexes of this session
                sessRowIndexes = imagingRowIndexes(sessIDs == iSess);
                % store the data to process
                allSessionInfos(end + 1, :) = { animalID, dayID, spotID, iSess, sessRowIndexes, ...
                    locFilter{iLocFilter, 2} }; %#ok<AGROW>
            end;
            
        end; % end of location filter
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

% % remove raw behavior data for the current session
% behavRows = DWFilterTable(this, 'rowType = Behavior data');
% DWFlushData(this, str2double(get(this, 'all', 'rowNum', behavRows)), false, 'behav');

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
