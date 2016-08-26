%% - #DWMatchROISetsToData
function DWMatchROISetsToData(this)

% update the wait bar
DWWaitBar(this, 0);

% get the list of all animals
uniqueAnimals = get(this, 'animal');
if ~isempty(uniqueAnimals) && ~iscell(uniqueAnimals); uniqueAnimals = { uniqueAnimals }; end;
if isempty(uniqueAnimals); uniqueAnimals = { '' }; end;
uniqueAnimals(cellfun(@isempty, uniqueAnimals)) = [];
uniqueAnimals = unique(uniqueAnimals);
nAnim = numel(uniqueAnimals);

% get the list of all days
uniqueDays = get(this, 'day');
if ~isempty(uniqueDays) && ~iscell(uniqueDays); uniqueDays = { uniqueDays }; end;
if isempty(uniqueDays); return; end;
uniqueDays(cellfun(@isempty, uniqueDays)) = [];
uniqueDays = unique(uniqueDays);
nDays = numel(uniqueDays);

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

% go through each animal
for iAnim = 1 : nAnim;    
    animalID = uniqueAnimals{iAnim}; % get the current animal

    % skip irrelevant animal IDs
    if ~ismember(animalID, selectedAnimalIDs);
        % update wait bar
        DWWaitBar(this, 100 * (iAnim / nAnim));
        continue;
    end;
    
    % go through each day
    for iDay = 1 : nDays;    
        dayID = uniqueDays{iDay}; % get the current day

        % skip irrelevant days
        if ~ismember(dayID, selectedDayIDs);
            % update wait bar
            DWWaitBar(this, 100 * ((iDay / (nDays * nAnim)) + (iAnim - 1) / nAnim));
            continue;
        end;
        
        % get the ROISet rows
        ROISetRows = DWFilterTable(this, sprintf('animal = %s AND day = %s AND rowType = ROISet', animalID, dayID));
        nROISets = size(ROISetRows, 1); % count them
        % if no ROISets have been found, try without animal ID filtering
        if nROISets == 0;
            ROISetRows = DWFilterTable(this, sprintf('animal !~= \\w+ AND day = %s AND rowType = ROISet', dayID));
            nROISets = size(ROISetRows, 1); % count them
        end;
        % get the imaging rows
        imTypeFilter = iff(ismember(this.dw.tableIDs, 'imType'), ' AND imType = movie', '');
        imagingRows = DWFilterTable(this, sprintf('animal = %s AND day = %s AND rowType = Imaging data%s', ...
            animalID, dayID, imTypeFilter));
        nImagingRows = size(imagingRows, 1); % count them

        % go through each ROISet
        for iROISet = 1 : nROISets;  

            % get the DataWatcher table's row index for this ROISet row
            iDWRowROISet = str2double(get(this, iROISet, 'rowNum', ROISetRows));
            % get the ROISet's row ID
            ROISetRowID = DWGetRowID(this, iDWRowROISet);
            % make sure the ROISet is loaded
            DWLoadRow(this, iDWRowROISet, 'full');
            % extract the data
            ROISetData = getData(this, iDWRowROISet, 'ROISets', 'data');
            % abort if the data cannot be found
            if isempty(ROISetData);
                showWarning(this, 'OCIA:DWMatchROISetsToData:ROISetDataNotFound', ...
                    sprintf('Could not find ROISet data for %s (row %03d). Skipping it.', ROISetRowID, iDWRowROISet));                
                % update wait bar
                DWWaitBar(this, 100 * ((iROISet / (nROISets * nDays * nAnim)) + ((iDay - 1) / (nDays * nAnim)) + (iAnim - 1) / nAnim));
                continue;
            end;
            % get the ROISet's "runsValidity", which tells which trials/runs are valid for this ROISet
            runsValidity = ROISetData.runsValidity;
            if ~iscell(runsValidity) && ~isempty(runsValidity); runsValidity = { runsValidity }; end;
            % if the runsValidity are in the old format 'YYYY_MM_DD__hh_mm_ss', convert them to the new 'YYYYMMDD_hhmmss' format
            if ~isempty(runsValidity) && ~isempty(regexp(runsValidity{1}, '\d{4}_\d{2}_\d{2}__\d{2}_\d{2}_\d{2}', 'once'));
                runsValidity = cellfun(@(id)id([1 : 4, 6 : 7, 9 : 10, 12 : 14, 16 : 17, 19 : 20]), runsValidity, ...
                    'UniformOutput', false);
            end;

            % if no imaging rows, try to figure out the spot identity of this ROISet
            if nImagingRows <= 0;

                % get the ROISet's path
                ROISetPath = get(this, iDWRowROISet, 'path');
                % go through each possible spot
                for iSpot = 1 : 10;
                    % get the spot folder's path
                    spotPath = regexprep(regexprep(ROISetPath, '/[^/]+$', '/'), 'ROISets', sprintf('spot%02d', iSpot));

                    % go through each possible row
                    for iRun = 1 : numel(runsValidity);
                        % get the spot folder's path
                        dataPath = sprintf('%s%s_%s_%s__%s_%s_%sh/', spotPath, runsValidity{iRun}(1:4), runsValidity{iRun}(5:6), ...
                            runsValidity{iRun}(7:8), runsValidity{iRun}(10:11), runsValidity{iRun}(12:13), runsValidity{iRun}(14:15));

                        % check if the data exists
                        if exist(dataPath, 'dir');
                            set(this, iDWRowROISet, 'spot', sprintf('spot%02d', iSpot));    
                            break;
                        end;
                    end;

                    % if spot was found, interrupt search
                    if ~isempty(get(this, iDWRowROISet, 'spot')); break; 
                    end;
                end;
                continue;
            end;

            % go through each imaging row
            for iImagingRow = 1 : nImagingRows;

                % get the DataWatcher table's row index for this imaging row
                iDWRowImaging = str2double(get(this, iImagingRow, 'rowNum', imagingRows));
                % get the row ID for the current imaging row
                imagingRowID = DWGetRowID(this, iDWRowImaging);

                % if there is a match compare the runs validity of the ROISet with this row's ID
                if any(strcmp(runsValidity, imagingRowID));            
                    % label the current imaging row as belonging to the current ROISet
                    set(this, iDWRowImaging, 'ROISet', ROISetRowID);
                    % if the ROISet does not have a spot ID specified, add the one from the imaging row
                    if isempty(get(this, iDWRowROISet, 'spot'));
                        set(this, iDWRowROISet, 'spot', get(this, iDWRowImaging, 'spot'));              
                    end;
                    % if there is a GUI and the ROISet's reference image is from the current imaging row
                    if isGUI(this) && strcmp(imagingRowID, ROISetRowID);
                        set(this, iDWRowImaging, 'ROISet', sprintf('<html><font color="blue">%s</font>', ROISetRowID));
                    end;
                end;
            end;

            % update wait bar
            DWWaitBar(this, 100 * ((iROISet / (nROISets * nDays * nAnim)) + ((iDay - 1) / (nDays * nAnim)) + (iAnim - 1) / nAnim));

        end;        
    end;    
end;

end
