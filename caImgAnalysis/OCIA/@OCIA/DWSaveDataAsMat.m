function DWSaveDataAsMat(this, savePath)
% DWSaveDataAsMat - [no description]
%
%       DWSaveDataAsMat(this, savePath)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
    showMessage(this, sprintf('Saving data to "%s" ...', savePath), 'yellow');
    saveDataTic = tic; % for performance timing purposes
    
    % make a copy of the data before flushing it
    dataBackup = this.data;
    
    % flush everything that is not to be saved as mat
    DWFlushData(this, 'all', true, this.dw.dataAsHDF5{:});
    
    % save the data
    data = this.data; %#ok<NASGU>
    save(savePath, 'data');
    
    % restore the data from the backup
    this.data = dataBackup;
    
    % get information about the saved file
    saveFile = dir(savePath);
    showMessage(this, sprintf('Saving data to "%s" done (%.3f sec, %.3f MB).', savePath, ...
        toc(saveDataTic), saveFile.bytes / (2^10 * 2^10)));
end
