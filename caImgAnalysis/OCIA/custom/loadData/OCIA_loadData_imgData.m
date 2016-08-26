function OCIA_loadData_imgData(this, iDWRow, loadType)
% OCIA_loadData_imgData - [no description]
%
%       OCIA_loadData_imgData(this, iDWRow, loadType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadTic = tic; % for performance timing purposes
o('#%s: iDWRow: %d, loadType: %s.', mfilename, iDWRow, loadType, 3, this.verb);

isDataLoaded = false;
currRawLoadStatus = getData(this, iDWRow, 'rawImg', 'loadStatus');

% get the row's ID
rowID = DWGetRowID(this, iDWRow);

% process the row depending on the requested loading type
switch loadType;
    % partial load (only for preview)
    case 'partial';
        % load the first "couple" of frames
        nMaxFrameLoad = this.dw.previewNMaxFrameToLoad;
        % check whether data is loaded
        isDataLoaded = ~isempty(currRawLoadStatus) && any(strcmp(currRawLoadStatus, {'partial', 'full'}));
        
    % fully load
    case 'full';
        % set to -1, which means to load all frames
        nMaxFrameLoad = -1;
        % check whether data is loaded
        isDataLoaded = ~isempty(currRawLoadStatus) && strcmp(currRawLoadStatus, 'full');
end;

% if not all frames should be loaded (not -1), pre-compensate the number of frames to load for skipped frames
if nMaxFrameLoad ~= -1;
    nMaxFrameLoad = nMaxFrameLoad + this.an.skipFrame.nFramesBegin + this.an.skipFrame.nFramesEnd;
end;

% if it is not already done, load the data and store it
if ~isDataLoaded;

    showMessage(this, sprintf('Loading data for %s (%03d) ("%s") ...', rowID, iDWRow, loadType), 'yellow');
    pause(0.0001);

    % extract the path of the current row
    dataFolderPath = get(this, iDWRow, 'path');

    try
    
        % load the data
        data = loadData(dataFolderPath, 'nMaxFrameLoad', nMaxFrameLoad, 'imgXYDim', this.an.img.defaultImDim, ...
            'skipMeta', true, 'zeroToNaN', this.an.loadImageSetValueToNaNWhenZero);
        
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
    setData(this, iDWRow, 'rawImg', 'data', data);
    setData(this, iDWRow, 'rawImg', 'loadStatus', iff(strcmp(currRawLoadStatus, 'full'), 'full', loadType));
    
    % make sure that processed images are also loaded if raw data is loaded
    setData(this, iDWRow, 'procImg', 'data', data);
    setData(this, iDWRow, 'procImg', 'loadStatus', 'partial');
    setData(this, iDWRow, 'procImg', 'procState', '');

    showMessage(this, sprintf('Loading data row %s (%03d) done (%3.1f sec).', rowID, iDWRow, toc(loadTic)));
end;

% make sure that processed images are also loaded if raw data is loaded
currProcLoadStatus = getData(this, iDWRow, 'procImg', 'loadStatus');
if isempty(currProcLoadStatus);
    setData(this, iDWRow, 'procImg', 'data', getData(this, iDWRow, 'rawImg', 'data'));
    setData(this, iDWRow, 'procImg', 'loadStatus', 'partial');
    setData(this, iDWRow, 'procImg', 'procState', '');
end;


o('#%s: iDWRow: %d, loadType: %s done (%3.1f sec)', mfilename, iDWRow, loadType, toc(loadTic), 3, this.verb);

end
