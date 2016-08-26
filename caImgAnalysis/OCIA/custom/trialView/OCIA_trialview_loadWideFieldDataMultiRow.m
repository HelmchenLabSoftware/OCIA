function this = OCIA_trialview_loadWideFieldDataMultiRow(this, ~, ~)
% OCIA_trialview_loadWideFieldDataMultiRow - Load multiple widefield data files for simultaneous display
%
%       OCIA_trialview_loadWideFieldDataMultiRow(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% check for number of rows selected: less than two rows selected
nFiles = numel(this.tv.params.fileList);
if numel(this.tv.params.fileList) < 2;
    % thrown warning and abort
    showWarning(this, sprintf('OCIA:%s:NoEnoughRowsSelected', mfilename()), ...
        sprintf('No enough rows (%d) selected ! Aborting.', nFiles));
    return;
end;

% disable GUI and get params and handles
OCIAToggleGUIEnableState(this, 'TrialView', 'off');
params = this.tv.params;
tvH = this.GUI.handles.tv;

% clear param path for concatenation
params.WFFilePath = '';

% clean up previous data
this.tv.data.wf = [];

% load all rows
for iFile = 1 : nFiles;

    % get selected file name
    selFileName = params.fileList{iFile};
    currentFilePath = [params.WFDataPath, selFileName];
    params.WFFilePath = [params.WFFilePath, currentFilePath, ';'];
    showMessage(this, sprintf('TrialView: loading "%s" ...', selFileName), 'yellow');
    pause(0.05);

    % load the data
    wfMat = load(currentFilePath);
    % figure out the variable name
    varName = fieldnames(wfMat);
    varNameOri = varName;
    varName(arrayfun(@(i)isempty(regexp(varName{i}, '^tr|tr_ave|cond', 'once')), 1 : numel(varName))) = [];
    % no variable name left after filtering
    if isempty(varName);
        showWarning(this, sprintf('OCIA:%s:NoMatchingVariableName', mfilename()), ...
            sprintf('Could not find WF data variable name for file "%s", field name(s) available: "%s". Aborting.', ...
            regexprep(sprintf('%s, ', varNameOri{:}), ', $', '')));
        currentFilePath = '';

    % too many variable names after filtering
    elseif iscell(varName) && numel(varName) > 1;
        showWarning(this, sprintf('OCIA:%s:TooManyVariableNames', mfilename()), ...
            'Too many WF data variable name for file "%s": "%s". Using first one ("%s")', ...
            regexprep(sprintf('%s, ', varNameOri{:}), ', $', ''));
        currentFilePath = '';

    % make sure variable name is a cell
    elseif ~iscell(varName);
        varName = { varName };

    end;
    
    % if we have a valid data path
    if ~isempty(currentFilePath);
        
        % extract data
        wfDataForFile = wfMat.(varName{1}) - 1;
        if all(params.WFSmoothDim > 0) && any(params.WFSmoothDim > 1);
            showMessage(this, sprintf('TrialView: smoothing "%s" ...', selFileName)); pause(0.01);
            wfDataForFile = smoothn(wfDataForFile, params.WFSmoothDim, 'Gauss');
        end;

        % extract size of the behavior movie
        params.WFDataSize = [size(wfDataForFile), nFiles];
        nFrames = params.WFDataSize(3);
        
        % initialize data store
        if isempty(this.tv.data.wf);
            this.tv.data.wf = nan(params.WFDataSize);
        end;
        
        % store data
        this.tv.data.wf(:, :, :, iFile) = wfDataForFile;
        
    end;
end;

% display a new title in GUI
set(tvH.wf.panel, 'Title', sprintf('Wide-field - %d files', nFiles));

% remove trailing ";"
params.WFFilePath = regexprep(params.WFFilePath, ';$', '');

% if we have some data
if ~isempty(params.WFFilePath) && ~isempty(this.tv.data.wf);

    % calculate the display shape
    M = ceil(sqrt(nFiles)); N = M; if M * (N - 1) >= nFiles; N = N - 1; end;
    
    % create a big frame that has all the files' first frame in it
    iFrame = 1;
    bigFrame = nan(N * params.WFDataSize(1), M * params.WFDataSize(2));
    
    MAYBE CHANGE THIS TO ALREADY 4 BIG FRAMES PREPROCESS AND THEN ONLY DISPLAY IT
    
    % go through each file and place them
    iFile = 1;
    for iX = 1 : M;
        for iY = 1 : N;
            % get frame and place it
            yStart = (iY - 1) * params.WFDataSize(1) + 1;
            yEnd = iY * params.WFDataSize(1);
            xStart = (iX - 1) * params.WFDataSize(2) + 1;
            xEnd = iX * params.WFDataSize(2);
            bigFrame(yStart : yEnd, xStart : xEnd) = this.tv.data.wf(:, :, iFrame, iFile);
            % update file number
            iFile = iFile + 1;
            % abort if all files were placed
            if iFile > nFiles; break; end;
        end;
        % abort if all files were placed
        if iFile > nFiles; break; end;
    end;
    
    set(tvH.wf.img, 'CData', bigFrame);
    set(tvH.wf.axe, 'XLim', [0.5, size(bigFrame, 2) - 0.5], 'YLim', [0.5, size(bigFrame, 1) - 0.5]);
    % change colormap to gray
    colormap(tvH.wf.axe, 'mapgeog'); figH = gcf; if figH ~= this.GUI.figH; close(figH); end;

    %% update display of ROI axe
    % display the time-series axis
    xLims = [0, nFrames] / params.WFFrameRate + [-0.25, 0.25] - round(params.WFTimeOffset);
    xTicks = (xLims(1) : xLims(2)) + 0.25;
    set(tvH.tc.whiskLickAxe, 'XLim', xLims, 'XTick', xTicks);
    set(tvH.tc.ROIAxe, 'YTick', [], 'YTickMode', 'auto', 'YTickLabelMode', 'auto');
    
    % get axe names and handles
    axeNames = fieldnames(tvH.tc);
    axeNames(arrayfun(@(i)isempty(regexp(axeNames{i}, 'Axe$', 'once')), 1 : numel(axeNames))) = [];
    axeHandles = arrayfun(@(i) tvH.tc.(axeNames{i}), 1 : numel(axeNames), 'UniformOutput', false);
    
    % delete previous timeline infos
    for iElem = 1 : numel(tvH.tc.timeLineInfoElems);
        try delete(tvH.tc.timeLineInfoElems{iElem}); catch; end;
    end;
    tvH.tc.timeLineInfoElems = {};
    
    % annotate the time axis with the trial timeline infos
    for iConfig = 1 : size(this.tv.params.TCTimeLineConfig);
        timeLineConfig = this.tv.params.TCTimeLineConfig(iConfig, :);
        [markerName, markerStart, markerStop, markerColor, markerType] = timeLineConfig{:};
        % transform parameters
        markerColor = str2double(regexp(markerColor, ',', 'split'));
        if ischar(markerStart); markerStart = eval(markerStart); end;
        if ischar(markerStop); markerStop = eval(markerStop); end;
        
        % mark duration as box
        if strcmp(markerType, 'box');
            
            % draw a rectangle on each axe
            for iAxe = 1 : numel(axeHandles);
                axeH = axeHandles{iAxe}; if numel(axeH) > 1; axeH = axeH(1); end;
                hold(axeH, 'on');                
                xData = [markerStart, markerStop, markerStop, markerStart];
                yData = [-10000, -10000, 10000, 10000];
                tvH.tc.timeLineInfoElems{end + 1} = patch('XData', xData, 'YData', yData, 'Parent', axeH, ...
                    'FaceColor', markerColor, 'EdgeColor', 'none', 'FaceAlpha', 0.1, ...
                    'ButtonDownFcn', @(h, e) OCIA_trialview_changeFrame(this, h, e));                
                hold(axeH, 'off');
            end;
            
            % add label
            yLims = get(tvH.tc.whiskLickAxe(1), 'YLim');
            tvH.tc.timeLineInfoElems{end + 1} = text(markerStart + 0.4 * (markerStop - markerStart), ...
                yLims(1) + 0.1 * diff(yLims), markerName, 'FontSize', 10, 'VerticalAlignment', 'bottom', ...
                'HorizontalAlignment', 'left', 'Parent', tvH.tc.whiskLickAxe(1), ...
                'ButtonDownFcn', @(h, e) OCIA_trialview_changeFrame(this, h, e));
            
        % single line marker
        else
            
            % draw a line marker on each axe
            for iAxe = 1 : numel(axeHandles);
                axeH = axeHandles{iAxe}; if numel(axeH) > 1; axeH = axeH(1); end;
                hold(axeH, 'on');
                tvH.tc.timeLineInfoElems{end + 1} = plot(axeH, [markerStart, markerStart], ...
                    [-10000, 10000], 'Color', markerColor, 'LineStyle', markerType, ...
                    'ButtonDownFcn', @(h, e) OCIA_trialview_changeFrame(this, h, e));
                hold(axeH, 'off');
            end;
            
            % add label
            yLims = get(tvH.tc.whiskLickAxe(1), 'YLim');
            tvH.tc.timeLineInfoElems{end + 1} = text(markerStart, yLims(1) + 0.1 * diff(yLims), markerName, ...
                'FontSize', 10, 'VerticalAlignment', 'top', ...
                'HorizontalAlignment', 'left', 'rotation', 90, 'Parent', tvH.tc.whiskLickAxe(1), ...
                'ButtonDownFcn', @(h, e) OCIA_trialview_changeFrame(this, h, e));
            
        end;
    end; 
    
end; % valid WFFilePath

%% restore GUI
% restore handles
this.GUI.handles.tv = tvH;
% restore params and then restore & enable GUI
this.tv.params = params;

% create config parameter panel
OCIACreateParamPanelControls(this, 'tv');

% if they are still valid, store the enable/disable state of the navigating buttons
if isfield(this.GUI.handles.tv, 'prevParams') && ishandle(this.GUI.handles.tv.prevParams);
    prevEnableState = get(this.GUI.handles.tv.prevParams, 'Enable');
    nextEnableState = get(this.GUI.handles.tv.nextParams, 'Enable');
end;
% enable the TrialView panel's GUI
OCIAToggleGUIEnableState(this, 'TrialView', 1);
% if they are still valid, set back the enable/disable state of the navigating buttons
if isfield(this.GUI.handles.tv, 'prevParams') && ishandle(this.GUI.handles.tv.prevParams);
    set(this.GUI.handles.tv.prevParams, 'Enable', prevEnableState);
    set(this.GUI.handles.tv.nextParams, 'Enable', nextEnableState);
end;

%% update GUI
% if we have a valid data path
if ~isempty(params.WFFilePath);
    showMessage(this, sprintf('TrialView: loaded "%s"', selFileName));
    
    % set frame back to 1 and update GUI
    this.tv.iFrame = 1;
    OCIA_trialview_changeFrame(this);
    
    % update time course
    OCIA_trialview_updateTimeCourse(this);
        
    % update GUI
    OCIA_trialview_addMovePoint(this, 'updateGUI');

end;

end
