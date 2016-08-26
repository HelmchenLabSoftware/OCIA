function OCIA_annotateTable_wenrui(this)
% OCIA_annotateTable_wenrui - [no description]
%
%       OCIA_annotateTable_wenrui(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% extract the depth from the spot IDs
depths = regexprep(this.dw.spotIDs, '^Spot\d+_(\d+)$', '$1');

% get the list of spot for each row
spots = get(this, 'all', 'spot');
if ~iscell(spots); spots = { spots }; end;
% remove empty spot labels
spots(cellfun(@isempty, spots)) = { '' };
% extract which spot it corresponds to
[~, spotIndexes] = ismember(spots, this.dw.spotIDs);
% if no spot ID was found, use the '-' that is in the first position in the 'depths' cell-array
spotIndexes(spotIndexes == 0) = 1;
% set the corresponding depth
set(this, 'all', 'depth', depths(spotIndexes));

% match ROISets to imaging data
DWMatchROISetsToData(this);

% match whisker data to imaging data
matchWhiskerDataToImagingData(this);

% show the table
DWDisplayTable(this);

end

function matchWhiskerDataToImagingData(this)
% sub-function to load the whisker data and match it to the imaging rows

% get imaging rows
imagingRows = DWFilterTable(this, 'rowType = Imaging data');
% abort if no imaging rows
if isempty(imagingRows); return; end;

% show message and update wait bar
showMessage(this, sprintf('Extracting whisker data for %02d imaging row(s) ...', size(imagingRows, 1)), 'yellow');
DWWaitBar(this, 0);

% go through each row
for iRow = 1 : size(imagingRows, 1);
    
    % get the DataWatcher's table index for this row
    iDWRow = str2double(get(this, 1, 'rowNum', imagingRows(iRow, :)));
    % get the experiment number
    expNum = str2double(get(this, iDWRow, 'expNum'));
    % show a warning and skip if a row has an invalid experiment number
    if isempty(expNum) || isnan(expNum);
        showWarning(this, 'OCIA:OCIA_annotateTable_wenrui:WhiskerDataUnknownExpNum', ...
            sprintf('Row %s (%02d) has an invalid experiment number: %s. Skipping it.', ...
            DWGetRowID(this, iDWRow), iDWRow, expNum));
        continue;
    end;
    % find the whisker data folder's path
    whiskerDataFolderRow = DWFilterTable(this, sprintf('rowType = Whisker data AND day = %s', get(this, iDWRow, 'day')));
    whiskerDataFolderPath = get(this, 1, 'path', whiskerDataFolderRow);
    
    % get the path to the correct file using the experiment number
    whiskerDataPath = sprintf('%s/Experiment_%d_Whisker_Tracking.mat', whiskerDataFolderPath, expNum);
    % show a warning and skip if file cannot be found
    if ~exist(whiskerDataPath, 'file');
        showWarning(this, 'OCIA:OCIA_annotateTable_wenrui:FileNotFound', ...
            sprintf('Whisker data for row %s (%02d) could not be found at "%s". Skipping it.', ...
            DWGetRowID(this, iDWRow), iDWRow, whiskerDataPath));
        continue;
    end;
        
    % load the whisker data
    whiskDataMat = load(whiskerDataPath);
    if isfield(whiskDataMat, 'MovieInfo');
        % store the whisker angle data and its frame rate
        dataStruct = struct('angle', whiskDataMat.MovieInfo.AvgWhiskerAngle, ...
            'frameRate', whiskDataMat.MovieInfo.FramesPerSecond);
    elseif isfield(whiskDataMat, 'whiskingAll');
        % store the whisker angle data and its frame rate (hard-coded)
        dataStruct = struct('angle', whiskDataMat.whiskingAll', 'frameRate', 200);
    % unknown way of load data: show a warning and skip
    else
        showWarning(this, 'OCIA:OCIA_annotateTable_wenrui:UnknownContent', ...
            sprintf('Whisker data for row %s (%02d) was found at "%s" but content is unknown. Skipping it.', ...
            DWGetRowID(this, iDWRow), iDWRow, whiskerDataPath));
        continue;
    end;
    
    % load the data and set the load status to full
    setData(this, iDWRow, 'whisk', 'data', dataStruct);
    setData(this, iDWRow, 'whisk', 'loadStatus', 'full');
    
    % update wait bar
    DWWaitBar(this, 100 * iRow / size(imagingRows, 1));
    
end;

% show message and update wait bar
showMessage(this, sprintf('Extracting whisker data for %02d imaging row(s) done.', size(imagingRows, 1)));
DWWaitBar(this, 100);

end
