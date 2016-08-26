function OCIA_onlineAnalysis_behavExp_getRemoteBehavData(this, currAnimal, currDay)
% OCIA_onlineAnalysis_behavExp_getRemoteBehavData - [no description]
%
%       OCIA_onlineAnalysis_behavExp_getRemoteBehavData(this, currAnimal, currDay)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
% get the behavior data from the remote folder
behavRows = DWFilterTable(this, sprintf('day = %s AND rowType = Behavior data AND loc = remote', currDay));
showMessage(this, sprintf('OnlineAnalysis: found %d behavior data row(s) to move locally ...', size(behavRows, 1)), ...
    'yellow');

% get and create local behavior path
behavPath = sprintf('%s%s/%s/behav/', this.path.localData, currAnimal, currDay);
if exist(behavPath, 'dir') ~= 7; mkdir(behavPath); end;
% go through each file and copy it locally
for iRow = 1 : size(behavRows, 1);
    
    % get remote path and timestamp
    remotePath = get(this, iRow, 'path', behavRows);
    timeStamp = get(this, iRow, 'time', behavRows);
    
    % create local path
    localPath = sprintf('%sBehavior_%s__%s.mat', behavPath, currDay, timeStamp);
     
    % data folder does not exists, copy it locally
    if exist(localPath, 'file') ~= 2;
        showMessage(this, sprintf('Copying "%s" to "%s" ...', remotePath, localPath), 'yellow');
        copyfile(remotePath, localPath);
        
    % data folder already exists 
    else
%         showMessage(this, sprintf('Folder "%s" already present. Skipping.', remotePath), 'yellow');
    end
    
    % change animal ID in case it's testing
    if strcmp('testing', get(this, iRow, 'animal', behavRows));
        behavRows = set(this, iRow, 'animal', 'mou_bl_000000_01', behavRows);
        set(this, str2double(get(this, iRow, 'rowNum', behavRows)), 'animal', 'mou_bl_000000_01');
    end;
end;

end