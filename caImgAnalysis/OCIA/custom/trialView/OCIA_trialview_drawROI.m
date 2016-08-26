function this = OCIA_trialview_drawROI(this, varargin)
% OCIA_trialview_drawROI - Draw an ROI
%
%       OCIA_trialview_drawROI(this)
%       OCIA_trialview_drawROI(this, ROIInfos)
%       OCIA_trialview_drawROI(this, axeH)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% init
% disable GUI and get params and handles
OCIAToggleGUIEnableState(this, 'TrialView', 'off');
params = this.tv.params;
tvH = this.GUI.handles.tv;
axeH = tvH.wf.axe;

%% draw ROI

% ROI infos provided for automated creation without drawing
if numel(varargin) == 1 && iscell(varargin{1});
    
    showMessage(this, 'TrialView: loading WF ROI: drawing ...', 'yellow');
    % get ROI informations
    [ROIID, ROIName, ROIMask, axeHName] = varargin{1}{:};
    axeH = tvH.(axeHName).axe;
    % create coordinates from mask
    ROICoords = mask2poly(ROIMask, 'Inner', 'MINDIST');
    % create ROI as polygon
    ROIHandle = imfreehand(axeH, ROICoords);
    
 
% ROI must be drawn
else
    
    % axe handle is on behavior movie
    if numel(varargin) == 1 && ishandle(varargin{1}) && varargin{1} == tvH.behav.axe;
        axeH = tvH.behav.axe;
        % generate name
        ROIName = sprintf('BehavROI%02d', numel(this.tv.ROI.ROIIDs));
        showMessage(this, 'TrialView: creating behav ROI: drawing ...', 'yellow');
        
    else
        axeH = tvH.wf.axe;
        % generate name
        ROIName = sprintf('ROI%02d', numel(this.tv.ROI.ROIIDs));
        showMessage(this, 'TrialView: creating WF ROI: drawing ...', 'yellow');
        
    end;
    
    % flag as currently drawing
    this.GUI.tv.mouseDownOnWFImg = true;
    % draw the ROI
    ROIHandle = imfreehand(axeH);
    
    if ~isempty(ROIHandle);

        % generate ROIID
        ROIID = rand() * 10000000;
        while any(ROIID == this.tv.ROI.ROIIDs);
            ROIID = rand() * 10000000;
        end;
        % generate mask
        ROIMask = ROIHandle.createMask();
        
    end;
end;

% if an ROI was actually drawn
if ~isempty(ROIHandle);
    
    % add ROI ID
    this.tv.ROI.ROIIDs(end + 1) = ROIID;

    % add a ROI movement callback
    ROIHandle.addNewPositionCallback(@(h) OCIA_trialview_updateTimeCourse(this, ROIID));

    % get context menu of ROI
    ROIHandleChildren = get(ROIHandle, 'Children');
    hContextMenu = get(ROIHandleChildren(1), 'UIContextMenu');
    % get context menu items
    contextMenuItems = get(hContextMenu, 'Children');
    % remove last item
    delete(contextMenuItems(3));
    % modify the delete item to use customize callback
    set(contextMenuItems(1), 'Callback', @(h, e) OCIA_trialview_deleteROI(this, ROIID));
    % modify the set color item to assign ROI from list
    possibleROINames = params.ROIDisplayConfigs(:, 1);
    set(contextMenuItems(2), 'Label', 'Assign region');
    assignRegionItemChildren = get(contextMenuItems(2), 'Children');
    delete(assignRegionItemChildren);
    for iROIMenu = 1 : numel(possibleROINames);
        uimenu(contextMenuItems(2), 'Label', possibleROINames{iROIMenu}, ...
            'Callback', @(h, e) OCIA_trialview_renameROI(this, iROIMenu, ROIID));
    end;

    % store informations
    this.tv.ROI.ROIHandles{end + 1} = ROIHandle;
    this.tv.ROI.ROIMasks{end + 1} = ROIMask;
    this.tv.ROI.ROINames{end + 1} = ROIName;
    this.tv.ROI.axeH{end + 1} = get(axeH, 'Tag');

    %% update time course
    showMessage(this, sprintf('TrialView: creating ROI "%s": updating time course ...', ROIName), 'yellow');
    % update the time course by adding an ROI time course
    OCIA_trialview_updateTimeCourse(this, ROIID);

    % flag as not drawing anymore
    this.GUI.tv.mouseDownOnWFImg = false;
    showMessage(this, sprintf('TrialView: creating ROI "%s": done!', ROIName));

% ROI drawing aborted
else
    % flag as not drawing anymore
    this.GUI.tv.mouseDownOnWFImg = false;
    showMessage(this, 'TrialView: creating ROI aborted.', 'red');

end;

%% finalize
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

end
