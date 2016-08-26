function OCIA_onlineAnalysis_behavExp_getRemoteNoSpotImgData(this, currAnimal, currDay)
% OCIA_onlineAnalysis_behavExp_getRemoteNoSpotImgData - [no description]
%
%       OCIA_onlineAnalysis_behavExp_getRemoteNoSpotImgData(this, currAnimal, currDay)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
% get the imaging data from the remote folder
newImagingRows = DWFilterTable(this, sprintf('day = %s AND rowType = Imaging data AND loc = remote', currDay));

% get the imaging rows for that spot
noSpotRows = DWFilterTable(this, 'spot !~= \w+', newImagingRows);
showMessage(this, sprintf('OnlineAnalysis: found %d row(s) to move locally (no spot) ...', size(noSpotRows, 1)), ...
    'yellow');

% go through each file and copy it locally
for iRow = 1 : size(noSpotRows, 1);
    
    % if row has a comment, just copy it since it is not a trial
    commentForRow = get(this, iRow, 'comments', noSpotRows);
    runTypeForRow = get(this, iRow, 'runType', noSpotRows);
    if ~isempty(commentForRow) || strcmp(runTypeForRow, 'surface');
        
        % get remote path and timestamp
        remotePath = get(this, iRow, 'path', noSpotRows);
        timeStamp = get(this, iRow, 'time', noSpotRows);
        % create local path
        localPath = sprintf('%s%s/%s/%s__%sh', this.path.localData, currAnimal, currDay, currDay, timeStamp);

        % data folder does not exists, copy it locally
        if exist(localPath, 'dir') ~= 7;
            showMessage(this, sprintf('Moving "%s" to "%s" ...', remotePath, localPath), 'yellow');
            copyfile(remotePath, localPath);

        % data folder already exists 
        else
    %         showMessage(this, sprintf('Folder "%s" already present. Skipping.', remotePath), 'yellow');
        end;
        
    end;
end;

end