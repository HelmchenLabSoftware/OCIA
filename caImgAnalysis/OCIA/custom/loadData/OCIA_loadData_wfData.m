function OCIA_loadData_wfData(this, iDWRow, loadType)
% OCIA_loadData_wfData - [no description]
%
%       OCIA_loadData_wfData(this, iDWRow, loadType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadTic = tic; % for performance timing purposes
o('#%s: iDWRow: %d, loadType: %s.', mfilename, iDWRow, loadType, 3, this.verb);

isDataLoaded = false;
currRawLoadStatus = getData(this, iDWRow, 'wf', 'loadStatus');

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
    
        [~, ~, ~, refImgDatasetPath, framesDim, ~, ~, ~, ~, attribs] ...
            = OCIA_analysis_widefield_extractFileInfo(this, fullPath);
        
        % get reference image and store as data
        refImg = h5read(fullPath, refImgDatasetPath);
        data = refImg;
        
        % skip the 3rd dimension if it's 1 (display '256x256' and not '256x256x1')
        if framesDim(3) == 1; framesDim = framesDim(1 : 2); end;
        % create and store a dimension tag like : '256x256' or '100x100x3'
        dimTag = regexprep(sprintf(repmat('%dx', 1, numel(framesDim)), framesDim), 'x$', '');
        set(this, iDWRow, 'dim', dimTag);
        
        % update other params
        if isfield(attribs, 'sweepDur');
            set(this, iDWRow, 'stimFreq', sprintf('%.4f', roundn(1 / attribs.sweepDur, -4)));
        end;
        
        % extract the stimulus IDs
        comments = '';
        if isfield(attribs, 'stimIDs') && ~isempty(attribs.stimIDs);
            stimIDs = attribs.stimIDs;
            if isnumeric(stimIDs{1});
                comments = regexprep(sprintf('%d/', cell2mat(stimIDs) ./ 1000), '/$', ' kHz');
            elseif ischar(stimIDs{1});
                comments = regexprep(sprintf('%s/', stimIDs{:}), '/$', '');
            else
                comments = '';
            end;
            
        % find out if its a continuous recording mapping
        elseif isfield(attribs, 'fouBaseFreq') && numel(attribs.fouBaseFreq) > 1 ...
                && all(ismember(attribs.fouBaseFreq, [1, 2, 3])) && numel(unique(attribs.fouBaseFreq)) == 3;
                stimIDs = { 'auditory', 'visual', 'somatosensory' };
                comments = regexprep(sprintf('%s/', stimIDs{:}), '/$', '');
                
        % find out if its a continuous recording mapping with blank
        elseif isfield(attribs, 'fouBaseFreq') && numel(attribs.fouBaseFreq) > 1 ...
                && all(ismember(attribs.fouBaseFreq, [1, 2, 3, 4])) && numel(unique(attribs.fouBaseFreq)) == 4;
                stimIDs = { 'auditory', 'visual', 'somatosensory', 'blank' };
                comments = regexprep(sprintf('%s/', stimIDs{:}), '/$', '');
                
        % find out if its a continuous recording mapping of frequencies
        elseif isfield(attribs, 'fouBaseFreq') && numel(attribs.fouBaseFreq) > 1 ...
                && all(attribs.fouBaseFreq > 500);
                stimIDs = unique(attribs.fouBaseFreq);
                comments = regexprep(sprintf('%d/', stimIDs ./ 1000), '/$', ' kHz');
        end;
        
        % find out if it is a trial-based file
        if isfield(attribs, 'BLDur') && isfield(attribs, 'EVDur') && isfield(attribs, 'triStimDur');
            comments = [comments sprintf(', BL:%.2f, EV:%.2f, stimDur:%.2f', attribs.BLDur, attribs.EVDur, attribs.triStimDur)];
            comments = regexprep(comments, '^, ', '');
        end;
        
        
        % add comments if they contain something
        if ~isempty(comments);
            comments = regexprep(comments, 'somatosensory', 'somato.');
            set(this, iDWRow, 'comments', comments);
        end;
        
        % update display
        DWUpdateColumnsDisplay(this, iDWRow, { 'dim', 'stimFreq', 'comments'}, false);
        
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
    setData(this, iDWRow, 'wf', 'data', data);
    setData(this, iDWRow, 'wf', 'loadStatus', iff(strcmp(currRawLoadStatus, 'full'), 'full', loadType));
    
    showMessage(this, sprintf('Loading data row %s (%03d) done (%3.1f sec).', rowID, iDWRow, toc(loadTic)));
end;


o('#%s: iDWRow: %d, loadType: %s done (%3.1f sec)', mfilename, iDWRow, loadType, toc(loadTic), 3, this.verb);

end
