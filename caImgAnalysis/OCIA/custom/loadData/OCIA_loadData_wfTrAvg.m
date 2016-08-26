function OCIA_loadData_wfTrAvg(this, iDWRow, ~)
% OCIA_loadData_wfTrAvg - [no description]
%
%       OCIA_loadData_wfTrAvg(this, iDWRow, loadType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% overriding: only fully load possible
loadType = 'full';

loadTic = tic; % for performance timing purposes
o('#%s: iDWRow: %d, loadType: %s.', mfilename, iDWRow, loadType, 3, this.verb);

isDataLoaded = false;
currRawLoadStatus = getData(this, iDWRow, 'wfTrAvg', 'loadStatus');


% get the row's ID
rowID = DWGetRowID(this, iDWRow);

% process the row depending on the requested loading type
switch loadType;
    % partial load (only for preview)
    case 'partial';
        % check whether data is loaded
        isDataLoaded = ~isempty(currRawLoadStatus) && any(strcmp(currRawLoadStatus, {'partial', 'full'}));
        
    % fully load
    case 'full';
        % check whether data is loaded
        isDataLoaded = ~isempty(currRawLoadStatus) && strcmp(currRawLoadStatus, 'full');
end;

% if it is not already done, load the data and store it
if ~isDataLoaded;

    showMessage(this, sprintf('Loading data for %s (%03d) ("%s") ...', rowID, iDWRow, loadType), 'yellow');
    pause(0.0001);

    % extract the path of the current row
    fullPath = get(this, iDWRow, 'path');

    try
        % get reference image and store as data
        dataMat = load(fullPath);
        data = dataMat.tr_ave;
        framesDim = size(data);
        
        % skip the 3rd dimension if it's 1 (display '256x256' and not '256x256x1')
        if numel(framesDim) >= 3 && framesDim(3) == 1; framesDim = framesDim(1 : 2); end;
        % create and store a dimension tag like : '256x256' or '100x100x3'
        dimTag = regexprep(sprintf(repmat('%dx', 1, numel(framesDim)), framesDim), 'x$', '');
        
        if isfield(dataMat, 'N');
            N = dataMat.N;
            dimTag = sprintf('%s (N=%02d)', dimTag, N);
        end;
        set(this, iDWRow, 'dim', dimTag);
        
        % update display
        DWUpdateColumnsDisplay(this, iDWRow, { 'dim' }, false);
        
    % catch loading failures
    catch err;
        showWarning(this, sprintf('%s:LoadingFailed', mfilename), ...
            sprintf('Loading data for %s (%03d) failed ("%s"): %s', rowID, iDWRow, err.identifier, err.message));
        return;
    end;
    
    % if there are less frames loaded then required, it means data is fully loaded
    if ~isempty(data) && iscell(data) && size(data{1}, 3) < nMaxFrameLoad;
        currRawLoadStatus = 'full';
    end;

    % store the data
    setData(this, iDWRow, 'wfTrAvg', 'data', data);
    setData(this, iDWRow, 'wfTrAvg', 'loadStatus', iff(strcmp(currRawLoadStatus, 'full'), 'full', loadType));
    
    showMessage(this, sprintf('Loading data row %s (%03d) done (%3.1f sec).', rowID, iDWRow, toc(loadTic)));
end;


o('#%s: iDWRow: %d, loadType: %s done (%3.1f sec)', mfilename, iDWRow, loadType, toc(loadTic), 3, this.verb);

end
