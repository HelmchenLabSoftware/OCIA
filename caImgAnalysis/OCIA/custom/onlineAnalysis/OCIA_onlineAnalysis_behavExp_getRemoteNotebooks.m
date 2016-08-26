function OCIA_onlineAnalysis_behavExp_getRemoteNotebooks(this, currAnimal, currDay)
% OCIA_onlineAnalysis_behavExp_getRemoteNotebooks - [no description]
%
%       OCIA_onlineAnalysis_behavExp_getRemoteNotebooks(this, currAnimal, currDay)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the path to the local folder where this day should be
dayPath = sprintf('%s%s/%s/', this.path.localData, currAnimal, currDay);

% limit after which a remote notebook is not compared anymore to a local notebook (morning/afternoon session)
NBMoreRecentLimit = 3 * 60 * 60 * 1000;

% get the notebook data from the remote and local folder
remoteNBRows = DWFilterTable(this, sprintf('day = %s AND rowType = Notebook AND loc = remote', currDay));
localNBRows = DWFilterTable(this, sprintf('day = %s AND rowType = Notebook AND loc = local', currDay));
showMessage(this, sprintf('OnlineAnalysis: found %d notebook row(s) ...', size(remoteNBRows, 1)), 'yellow');

% if some remote notebooks found but no local, copy the last remote one
if ~isempty(remoteNBRows) && isempty(localNBRows);
    
    showMessage(this, 'OnlineAnalysis: no local notebooks, taking the last remote one ... ', 'yellow');
    % get the last remote notebook path and timestamp
    remotePath = get(this, size(remoteNBRows, 1), 'path', remoteNBRows);
    timeStamp = regexp(get(this, size(remoteNBRows, 1), 'time', remoteNBRows), '_', 'split');
    % create local path
    localPath = sprintf('%snotebook__%s__%sh_%sm.txt', dayPath, currDay, timeStamp{1}, timeStamp{2});
    
    % file does not exists, copy the last remote notebook locally
    if exist(localPath, 'file') ~= 2;
        showMessage(this, sprintf('Copying "%s" to "%s" ...', remotePath, localPath), 'yellow');
        copyfile(remotePath, localPath);
        
    % file already exists 
    else
%         showMessage(this, sprintf('File "%s" already present. Skipping.', remotePath), 'yellow');
    end;
    
% if notebooks were found both remote and locally
elseif ~isempty(remoteNBRows) && ~isempty(localNBRows);
    
    % get the last remote and local notebook row
    lastRemoteNBRow = remoteNBRows(end, :);
    lastRemoteNBRowTime = dn2unix(datenum(get(this, 1, 'time', lastRemoteNBRow), 'HH_MM_SS'));
    lastLocalNBRow = localNBRows(end, :);
    lastLocalNBRowTime = dn2unix(datenum(get(this, 1, 'time', lastLocalNBRow), 'HH_MM_SS'));
    showMessage(this, sprintf('OnlineAnalysis: both remote (%s) and local (%s) notebooks, comparing them ...', ...
        get(this, 1, 'time', lastRemoteNBRow), get(this, 1, 'time', lastLocalNBRow)), 'yellow');
    
%     % if the remote row is older (but by less than 3 hours) delete the local and copy the remote locally
%     if lastRemoteNBRowTime > lastLocalNBRowTime && lastRemoteNBRowTime - lastLocalNBRowTime > NBMoreRecentLimit;
    % if the remote row is older, delete the local and copy the remote locally
    if lastRemoteNBRowTime > lastLocalNBRowTime;
        showMessage(this, sprintf('OnlineAnalysis: remote notebook is more recent (by %d seconds).', ...
            (lastRemoteNBRowTime - lastLocalNBRowTime) / 1000), 'yellow');
        
        % get the local file's timestamp
        timeStamp = regexp(get(this, 1, 'time', lastLocalNBRow), '_', 'split');
        % create local path
        localPath = sprintf('%snotebook__%s__%sh_%sm.txt', dayPath, currDay, timeStamp{1}, timeStamp{2});
        % delete the local file
        showMessage(this, sprintf('Deleting "%s" ...', localPath), 'yellow');
        delete(localPath);
        
        % get the remote file's path and timestamp
        remotePath = get(this, 1, 'path', lastRemoteNBRow);
        timeStamp = regexp(get(this, 1, 'time', lastRemoteNBRow), '_', 'split');
        % create local path
        localPath = sprintf('%snotebook__%s__%sh_%sm.txt', dayPath, currDay, timeStamp{1}, timeStamp{2});
        
        % file does not exists, copy the remote notebook locally
        if exist(localPath, 'file') ~= 7;
            showMessage(this, sprintf('Copying "%s" to "%s" ...', remotePath, localPath), 'yellow');
            copyfile(remotePath, localPath);

        % file already exists 
        else
%             showMessage(this, sprintf('File "%s" already present. Skipping.', remotePath), 'yellow');
        end;
        
        
    % if the local row is older, do nothing
    elseif lastRemoteNBRowTime <= lastLocalNBRowTime;
        showMessage(this, sprintf('OnlineAnalysis: local notebook is more recent (by %d seconds).', ...
            (lastLocalNBRowTime - lastRemoteNBRowTime) / 1000), 'yellow');
        
%     % if the remote row is older but by more than 3 hours, do nothing
%     elseif lastRemoteNBRowTime > lastLocalNBRowTime && lastRemoteNBRowTime - lastLocalNBRowTime <= NBMoreRecentLimit;
%         showMessage(this, sprintf('OnlineAnalysis: remote notebook is more recent, but by %d seconds.', ...
%             (lastRemoteNBRowTime - lastLocalNBRowTime) / 1000), 'yellow');
        
    end;
end;

end