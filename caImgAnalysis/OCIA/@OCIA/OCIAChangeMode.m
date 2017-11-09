function OCIAChangeMode(this, handleOrModeName, ~)
% OCIAChangeMode - Changes/switches the mode currently displayed
%
%       OCIAChangeMode(this, modeChangeHandle)
%       OCIAChangeMode(this, newModeName)
%
% Changes the current mode to the one selected in the mode change drop-down menu (if "handleOrModeName" variable 
%   is a handle) or specified by the a string (if "handleOrModeName" variable is a string).
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


% remove zoom upon changing mode
for iMode = 1 : size(this.main.modes, 1);
    % get the two-character name
    mName = this.main.modes{iMode, 2};
    % if there is a zoom tool field in that mode
    if isfield(this.GUI.handles, mName) && isfield(this.GUI.handles.(mName), 'zTool') ...
            && ishandle(this.GUI.handles.(mName).zTool);
        % get the zoom state (activated or not)
        zoomState = get(this.GUI.handles.(mName).zTool, 'Value');
        % if zoom is enabled, disable it
        if zoomState;
            funcHandle = str2func(sprintf('%sActivateZoom', upper(mName)));
            funcHandle(this, 0);
        end;
    end;
end;

% get which mode is currently active
panelNames = fieldnames(this.GUI.handles.panels);
currentMode = panelNames(structfun(@(x)strcmp(get(x, 'Visible'), 'on'), this.GUI.handles.panels));
if ~isempty(currentMode); currentMode = regexprep(currentMode{1}, 'Panel$', ''); end;

if ischar(handleOrModeName); % if change was requested by a string input
    newModeName = handleOrModeName; % current mode
    if strcmp(newModeName, currentMode); return; end; % already in right mode
    o('#OCIAChangeMode(): h: %s, newModeName: %s.', handleOrModeName, 3, newModeName, this.verb);
    % change the OCIAChangeMode pop-up list value to the new mode
    set(this.GUI.handles.changeMode, 'Value', ...
        find(~cellfun(@isempty, strfind(this.main.modes(:, 1), handleOrModeName))));
    
else % if change was requested by the callback
    newModeName = this.main.modes{get(handleOrModeName, 'Value'), 1}; % get the current mode from the handle
    if strcmp(newModeName, currentMode); return; end; % already in right mode
    o('#OCIAChangeMode(): h: %d, value: %d.', handleOrModeName, get(handleOrModeName, 'Value'), 3, this.verb);
    
    
end;

 % if there is a GUI, show only the requested panel
if isGUI(this);
    structfun(@(x)set(x, 'Visible', 'off'), this.GUI.handles.panels); % hide all panels
    set(this.GUI.handles.panels.([newModeName 'Panel']), 'Visible', 'on');
end;

% wait for GUI to update, since we might need to access some Java elements
pause(0.5);

% perform actions that should be done upon activation of new modes
toShowMessage = '';
switch newModeName;
    
    case 'DataWatcher';
        
        % initialize the preview image's imshow handle
        if isempty(this.GUI.handles.dw.prevIm);
            % if there is a GUI, initialize the real imshow handle
            if isGUI(this);
                this.GUI.handles.dw.prevIm = imshow(zeros(100), 'Parent', this.GUI.handles.dw.prevImAx);
            end;
        end;
        
        % if no watch folder yet, set a new watch folder path
        if isempty(this.dw.watchFolder);
            
            % fill-in the lists
            dataConfig = this.main.dataConfig;
            nConfs = size(dataConfig, 1);
            set(this.GUI.handles.dw.SLROptDataList, 'String', dataConfig.label);

            % fill-in the lists
            nOpts = 0;
            if isfield(this.an, 'procOptions');
                procOptions = this.an.procOptions;
                nOpts = size(procOptions, 1);
                set(this.GUI.handles.dw.procOptsList, 'String', procOptions.label, ...
                    'Value', find(procOptions.defaultOn));
            end;
            
            % if there is a GUI, add some GUI interaction callbacks
            if isGUI(this);
                
                % get the java component of the the DataWatcher's table and enable multiple row selection
                try
                    jTable = getJTable(this, 'DWTable');
                catch e; %#ok<NASGU>
                    jTable = getJTable(this, 'DWTable');
                end;
                jTable.setNonContiguousCellSelection(false);
                % add a callback for the mouse click on the rows
                set(handle(jTable, 'CallbackProperties'), 'MouseReleasedCallback', @(h, e)(DWTableClick(this, h, e)));
                % add a tooltip to the table's header row
                toolTipTxt = '<html><font size=-1><ul>';
                colLabels = this.GUI.dw.tableDisplay.label; % get the column labels
                colDescrs = this.GUI.dw.tableDisplay.description; % get the column descriptions
                for iCol = 1 : numel(colLabels);
                    toolTipTxt = sprintf('%s<li><b>%s</b>: %s</li>', toolTipTxt, colLabels{iCol}, colDescrs{iCol});
                end;
                jTable.getTableHeader().setToolTipText(toolTipTxt);

                % add right click event for watch type checkboxes
                for iType = 1 : size(this.dw.watchTypes, 1);
                    % only process visible elements
                    if this.dw.watchTypes{iType, 'visible'}; %#ok<BDSCA>
                        jCheckBox = findjobj(this.GUI.handles.dw.watchTypes.(this.dw.watchTypes.id{iType}));
                        set(jCheckBox, 'MouseClickedCallback', @(h, e)DWChangeWatchType(this, h, e));
                    end;
                end;
                
                jAllNone = findjobj(this.GUI.handles.dw.watchTypesAllNone);
                set(jAllNone, 'MouseClickedCallback', @(h, e)DWChangeWatchType(this, h, e));
                
                jScrollPane = java(findjobj(this.GUI.handles.dw.SLROptDataList));
                jListbox = jScrollPane.getViewport().getView();
                jListbox.setLayoutOrientation(jListbox.VERTICAL_WRAP);
                set(jScrollPane, 'VerticalScrollBarPolicy', jScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
                set(jScrollPane, 'HorizontalScrollBarPolicy', jScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);                
                jListbox.setVisibleRowCount(nConfs);
                
                jScrollPane = java(findjobj(this.GUI.handles.dw.procOptsList));
                jListbox = jScrollPane.getViewport().getView();
                jListbox.setLayoutOrientation(jListbox.VERTICAL_WRAP);
                set(jScrollPane, 'VerticalScrollBarPolicy', jScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
                set(jScrollPane, 'HorizontalScrollBarPolicy', jScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);                
                jListbox.setVisibleRowCount(nOpts);
                
            end;
            
            % update the watch folder path
            DWUpdateWatchFolderPath(this);
            toShowMessage = sprintf('New watch folder path: "%s".', this.dw.watchFolder);
        end;
        
    case 'ROIDrawer';
        
        % if ROIDrawer was not activated before, initialize the image axes
        if isempty(this.GUI.handles.rd.img);
            
            this.GUI.rd.img = zeros(this.GUI.rd.defaultImDim, this.GUI.rd.defaultImDim, 3);
            
            % if there is a GUI, initialize the real imshow handle and add a callback for the frame setter
            if isGUI(this);
                
                this.GUI.handles.rd.img = imshow(this.GUI.rd.img, 'Parent', this.GUI.handles.rd.axe);
                
                % set tags and callbacks
                set(this.GUI.handles.rd.img, 'Tag', 'RDImg', 'ButtonDownFcn', @(h, e)RDDrawNewROI(this, h, e));
                set(this.GUI.handles.rd.axe, 'Tag', 'RDAxe');
                
                jObj = findjobj(this.GUI.handles.rd.frameSetter);
                set(jObj, 'AdjustmentValueChangedCallback', ...
                    @(~, ~)RDChangeFrame(this, this.GUI.handles.rd.frameSetter));
                
                % make setter horizontal
                setterNames = {'refROISetBSetter', 'refROISetASetter', 'colorChannels'};
                for iName = 1 : numel(setterNames);
                    jScrollPane = java(findjobj(this.GUI.handles.rd.(setterNames{iName})));
                    set(jScrollPane, 'VerticalScrollBarPolicy', jScrollPane.VERTICAL_SCROLLBAR_NEVER);
                    set(jScrollPane, 'HorizontalScrollBarPolicy', jScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
                    jListbox = jScrollPane.getViewport().getView();
                    set(jListbox, 'LayoutOrientation', 1, 'VisibleRowCount', 1);
                end;
                
            end;
        end;
        
    case 'Analyser';
        
        %% Create the plot types list with icons
        nAnalysisTypes = size(this.an.analysisTypes, 1);
        % Modify the listbox layout to display square icon cells
        jScrollPane = java(findjobj(this.GUI.handles.an.plotList));
        jListbox = jScrollPane.getViewport().getView();
        jListbox.setLayoutOrientation(jListbox.HORIZONTAL_WRAP);
%         jListbox.setVisibleRowCount(round(nAnalysisTypes / 2));
        jListbox.setVisibleRowCount(2); % for screenshot
%         jListbox.setFixedCellWidth(64 + 10);
%         jListbox.setFixedCellHeight(64 + 10);
        jListbox.setFixedCellWidth(50 + 10);
        jListbox.setFixedCellHeight(50 + 10);
        jListbox.repaint();  % refresh the display

        % create the HTML strings for icon-based list elements
        HTMLCellString = cell(nAnalysisTypes, 1);
        % go through each plot type
        for iType = 1 : nAnalysisTypes;
            % get the plot type's name
            name = this.an.analysisTypes.id{iType};
            label = this.an.analysisTypes.label{iType};
            % get the icon for this plot type
            iconPath = regexprep(which('OCIA'), '@OCIA.OCIA\.m', sprintf('icons/plotIcons/%s.png', name));
            % if the icon exists, use it as element
            if exist(iconPath, 'file');
                HTMLCellString{iType} = sprintf('<html><img src="file:/%s"/>', iconPath);
                
            % otherwise just use the plot type's name as element
            else 
%                 % split word in several dash-separated words right before capital letters
%                 name = regexprep(name, '([A-Z_])', ' $1');
                HTMLCellString{iType} = sprintf('<html><font style="font-size:12"><b>%s', label);
                
            end;
        end;
        % add the HTML strings as string elements
        set(this.GUI.handles.an.plotList, 'String', HTMLCellString);
        
    case 'Behavior';
        
        % if behavior mode was not already activated before, initiate it
        if isempty(this.be.room);
            
            BEActivate(this);
            
%             jObj = findjobj(this.GUI.handles.be.ETL);
%             set(jObj, 'AdjustmentValueChangedCallback', @(~, ~)BEETL(this, this.GUI.handles.be.ETL));
            
            jObj = findjobj(this.GUI.handles.be.piezoBL);
            set(jObj, 'AdjustmentValueChangedCallback', @(~, ~)BEPiezoBL(this, this.GUI.handles.be.piezoBL));
            
        end;
        
    case 'JointTracker';

    % if ROIDrawer was not activated before, initialize the image axes
    if isempty(this.GUI.handles.jt.img);

        this.GUI.jt.img = zeros(1, 1);
        % if there is a GUI, initialize the real imshow handle
        if isGUI(this);
            
            this.GUI.handles.jt.img = imshow(this.GUI.jt.img, 'DisplayRange', [0 1], 'Parent', this.GUI.handles.jt.axe);
            this.GUI.handles.jt.validImg = imagesc(this.GUI.jt.jointValidity, 'Parent', this.GUI.handles.jt.joinValAxe);
            set(this.GUI.handles.jt.joinValAxe, 'XTick', [], 'YTick', [], 'XColor', 'white', 'YColor', 'white');
            cMap = flipud(redgreencmap(100000));
            cMap(1, :) = [0.8, 0.8, 0.8];
            colormap(this.GUI.handles.jt.joinValAxe, cMap);
            if gcf ~= this.GUI.figH; close(gcf); end;
            set(this.GUI.handles.jt.joinValAxe, 'CLim', [0, 1], 'XLim', [0.5 this.jt.nFrames + 0.5], ...
                'YLim', [0.5 this.jt.nJoints + 0.5]);
            for iJoint = 1 : this.jt.nJoints - 1;
                line([0 this.jt.nFrames], [iJoint, iJoint] + 0.5, 'Parent', this.GUI.handles.jt.joinValAxe, ...
                    'LineWidth', 1, 'Color', 'black', 'LineStyle', ':');
            end;
            this.GUI.handles.jt.validityFrameIndicator = line([1 1], [0.55, this.jt.nJoints + 0.5], ...
                'Parent', this.GUI.handles.jt.joinValAxe, 'LineWidth', 1, 'Color', 'black', 'LineStyle', '--');
            
            %%
            % set tags
            set(this.GUI.handles.jt.img, 'Tag', 'JTImg');
            set(this.GUI.handles.jt.axe, 'Tag', 'JTAxe');
            set(this.GUI.handles.jt.validImg, 'Tag', 'JTValid');
            set(this.GUI.handles.jt.joinValAxe, 'Tag', 'JTValidAxe');

            % add a callback for the frame setter
            jObj = findjobj(this.GUI.handles.jt.frameSetter);
            set(jObj, 'AdjustmentValueChangedCallback', @(h, e)JTChangeFrame(this, this.GUI.handles.jt.frameSetter, e));
            set(jObj, 'MouseWheelMovedCallback', @(h, e)JTChangeFrame(this, this.GUI.handles.jt.frameSetter, e));
            
            % make setter horizontal
            setterNames = {'jointSelSetter', 'jointTypeSelSetter', 'jointSelDispSetter', 'jointTypeSelDispSetter'};
            for iName = 1 : numel(setterNames);
                jScrollPane = java(findjobj(this.GUI.handles.jt.(setterNames{iName})));
                set(jScrollPane, 'VerticalScrollBarPolicy', jScrollPane.VERTICAL_SCROLLBAR_NEVER);
                set(jScrollPane, 'HorizontalScrollBarPolicy', jScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
                jListbox = jScrollPane.getViewport().getView();
                set(jListbox, 'LayoutOrientation', 1, 'VisibleRowCount', 1);
            end;
            
        end;
    end;
    
    case 'Intrinsic';
        
        % if ROIDrawer was not activated before, initialize the image axes
        if isempty(this.GUI.handles.in.prevImg);
            
            warning('off', 'imaq:getdata:infFramesPerTrigger');
            
            % if there is a GUI, initialize the real imshow handle and add a callback for the frame setter
            if isGUI(this);
                
                % reset imaq if not running
                if isempty(this.in.camH) || ~this.in.connected;
                    imaqreset();
                end;
        
                % get the available camera formats
                try
                    camStructure = imaqhwinfo(this.in.adaptorName, this.in.deviceID);
                    this.in.availableCamFormats = camStructure.SupportedFormats;
                    set(this.GUI.handles.in.camFormat, 'String', this.in.availableCamFormats, ...
                        'Value', find(strcmp(this.in.common.camFormat, this.in.availableCamFormats)));
                catch err; %#ok<NASGU>
                    % silently do nothing because reasons
                    showWarning(this, 'OCIA:OCIAChangeMode:Intrinsic:CamFormatsNotFound', ...
                        'Could not find camera formats.');
                end;
                
                % create the image handle
                params = { 0.5 * ones(this.GUI.in.imDim(2), this.GUI.in.imDim(1), 3), 'Parent' };
                this.GUI.handles.in.prevImg = imagesc(params{:}, this.GUI.handles.in.prevAxe);
                if isempty(this.in.data.refImg);
                    this.GUI.handles.in.refImg = imagesc(params{:}, this.GUI.handles.in.refAxe);
                else
                    this.GUI.handles.in.refImg = imagesc(linScale(repmat(this.in.data.refImg, [1 1 3])), ...
                        'Parent', this.GUI.handles.in.refAxe);
                end;
                this.GUI.handles.in.expLeftImg = imagesc(params{:}, this.GUI.handles.in.expAxeLeft);
                this.GUI.handles.in.expRightImg = imagesc(params{:}, this.GUI.handles.in.expAxeRight);
                
                % set tags back
                set(this.GUI.handles.in.prevImg, 'Tag', 'INPrevImg');
                set(this.GUI.handles.in.refImg, 'Tag', 'INRefImg');
                set(this.GUI.handles.in.expLeftImg, 'Tag', 'INExpLeftImg');
                set(this.GUI.handles.in.expRightImg, 'Tag', 'INExpRightImg');
                set(this.GUI.handles.in.prevAxe, 'Tag', 'INPrevAxe', 'XTick', [], 'YTick', []);
                set(this.GUI.handles.in.refAxe, 'Tag', 'INRefAxe', 'XTick', [], 'YTick', []);
                set(this.GUI.handles.in.expAxeLeft, 'Tag', 'INExpAxeLeft', 'XTick', [], 'YTick', []);
                hColBar = colorbar('SouthOutside', 'peer', this.GUI.handles.in.expAxeLeft);
                set(get(hColBar, 'XLabel'), 'String', 'Reflectance [%]', 'FontSize', this.GUI.pos(4) / 100);
                set(hColBar, 'FontSize', this.GUI.pos(4) / 140)
                set(this.GUI.handles.in.expAxeRight, 'Tag', 'INExpAxeRight', 'XTick', [], 'YTick', []);
                hColBar = colorbar('SouthOutside', 'peer', this.GUI.handles.in.expAxeRight);
                set(get(hColBar, 'XLabel'), 'String', 'Reflectance [%]', 'FontSize', this.GUI.pos(4) / 100);
                set(hColBar, 'FontSize', this.GUI.pos(4) / 140)
                hFakeFig = figure(); colormap(this.GUI.figH, 'gray'); close(hFakeFig);
                
                % set the axis to equal aspect ratio if required
                if this.GUI.in.axisEqual;
                    axis(this.GUI.handles.in.prevAxe, 'equal');
                    axis(this.GUI.handles.in.refAxe, 'equal');
                    axis(this.GUI.handles.in.expAxeLeft, 'equal');
                    axis(this.GUI.handles.in.expAxeRight, 'equal');
                end;
                
                % link axes
                linkaxes([this.GUI.handles.in.prevAxe, this.GUI.handles.in.refAxe, this.GUI.handles.in.expAxeLeft, ...
                    this.GUI.handles.in.expAxeRight], 'xy');
                
                % update the pre-set
                INChangePreSetConfig(this);
                
            end;
        end;
        
    case 'TrialView';
        
        % if java elements have not yet been initialized
        if ~this.GUI.tv.javaInitialized;
            
            showMessage(this, '#OCIAChangeMode not finished for TrialView', 'blue');
            
            set(this.GUI.handles.tv.wf.axe, 'Tag', 'wf');
            set(this.GUI.handles.tv.behav.axe, 'Tag', 'behav');
            
            % set flag so that initialization only happens once
            this.GUI.tv.javaInitialized = true;
        end;
        
    %{
    case 'Discriminator';
        
        toShowMessage = sprintf('DISCRIMINATOR activated.');

        % if the camera has not been initialized yet
        if isempty(this.GUI.di.camHandle);            
            
            % show image in camera and activity axes
            imagesc(zeros(576, 720, 3), 'Parent', this.GUI.handles.di.camAxe);
            axis(this.GUI.handles.di.camAxe, 'equal');
            imagesc(zeros(128, 128, 3), 'Parent', this.GUI.handles.di.actiAxe);
            axis(this.GUI.handles.di.actiAxe, 'equal');

            % init camera
            o('#%s(): Launching camera ... ', mfilename, 1, this.verb);
            % remove warning and create videoinput object
            warning('off', 'imaq:peekdata:tooManyFramesRequested');
            warning('off', 'MATLAB:JavaEDTAutoDelegation');
            this.GUI.di.camHandle = videoinput('winvideo', 1, 'YUY2_720x576');
            this.GUI.di.camHandle.FramesPerTrigger = Inf;
            this.GUI.di.camHandle.FrameGrabInterval = 1;
            
            % start recording
            DIStartStopCamera(this, 'start');

        end;
        
        % if the update timer has not been initialized yet
        if isempty(this.GUI.di.updateTimer);
            
            % init timer
            o('#%s(): Launching timer ... ', mfilename, 1, this.verb);
            this.GUI.di.updateTimer = timer('TimerFcn', @(h, e)DIUpdateGUI(this, h, e), ...
                'ExecutionMode', 'fixedRate', 'Period', this.GUI.di.updateRate, ...
                'StopFcn', @(~, ~)o('!! DiscriminatorGUIUpdateTimer stopped.', 1, this.verb), ...
                'ErrorFcn', @(~, ~)o('!! DiscriminatorGUIUpdateTimer stopped with error.', 1, this.verb));
            start(this.GUI.di.updateTimer);
            
        end;
        
        if isempty(this.GUI.di.actiMovies);
            actiMovieMat = load([this.path.discrDataSave, 'activity_01.mat']);
            this.GUI.di.actiMovies{end + 1} = actiMovieMat.concatMovie;
            actiMovieMat = load([this.path.discrDataSave, 'activity_02.mat']);
            this.GUI.di.actiMovies{end + 1} = actiMovieMat.concatMovie;
        end;
        %}
end;

showMessage(this, sprintf('Changed to %s mode. %s', newModeName, toShowMessage));
pause(0.2); % required to let the GUI update itself

end
