function DWLoadDataFromMat(this, loadPath)
% DWLoadDataFromMat - [no description]
%
%       DWLoadDataFromMat(this, loadPath)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
    showMessage(this, sprintf('Loading data from "%s" ...', loadPath), 'yellow');
    loadTic = tic; % for performance timing purposes
    
    % load the data
    dataMat = load(loadPath);
    this.data = dataMat.data;
    
    % display message
    showMessage(this, sprintf('Loading data from "%s" done (%.3f sec).', loadPath, toc(loadTic)));
    
end
