function OCIA_onlineAnalysis_behavExp_getRemoteImgDataToSpots(this, currAnimal, currDay)
% OCIA_onlineAnalysis_behavExp_getRemoteImgDataToSpots - [no description]
%
%       OCIA_onlineAnalysis_behavExp_getRemoteImgDataToSpots(this, currAnimal, currDay)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the imaging data from the remote folder
newImagingRows = DWFilterTable(this, sprintf('day = %s AND rowType = Imaging data AND loc = remote', currDay));

% get the spot IDs
spotIDs = get(this, 'all', 'spot', newImagingRows);
if ~isempty(spotIDs) && ~iscell(spotIDs); spotIDs = { spotIDs }; end;

% if no spot IDs or no imaging rows, do not copy anything
if isempty(spotIDs) || isempty(newImagingRows); return; end;
    
% get the unique spot IDs
spotIDs(cellfun(@isempty, spotIDs)) = [];
spotIDs = unique(spotIDs);

% go through each spot
for iSpot = 1 : numel(spotIDs);

    % get and create the local spot path
    spotID = spotIDs{iSpot};
    spotPath = sprintf('%s%s/%s/%s/', this.path.localData, currAnimal, currDay, spotID);
    if exist(spotPath, 'dir') ~= 7; mkdir(spotPath); end;

    % get the imaging rows for that spot
    spotRows = DWFilterTable(this, sprintf('spot = %s', spotID), newImagingRows);
    showMessage(this, sprintf('OnlineAnalysis: found %d row(s) to move locally for %s ...', size(spotRows, 1), ...
        spotID), 'yellow');

    % go through each file and copy it locally
    for iRow = 1 : size(spotRows, 1);
        % get remote path and timestamp
        remotePath = get(this, iRow, 'path', spotRows);        
        timeStamp = get(this, iRow, 'time', spotRows);
        % create local path
        localPath = sprintf('%s%s/%s/%s/%s__%sh', this.path.localData, currAnimal, currDay, spotID, currDay, ...
            timeStamp);

        % data folder does not exists, copy it locally
        if exist(localPath, 'dir') ~= 7;
            showMessage(this, sprintf('Copying "%s" to "%s" ...', remotePath, localPath), 'yellow');
            copyfile(remotePath, localPath);

        % data folder already exists 
        else
%             showMessage(this, sprintf('Folder "%s" already present. Skipping.', remotePath), 'yellow');
        end;
    end;
end;

end