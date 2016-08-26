function this = OCIA_trialview_renameROI(this, iNewROIName, ROIID)
% OCIA_trialview_renameROI - Rename an ROI
%
%       OCIA_trialview_renameROI(this, iNewROIName, ROIID)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% init
% disable GUI and get params and handles
OCIAToggleGUIEnableState(this, 'TrialView', 'off');
params = this.tv.params;
tvH = this.GUI.handles.tv;

%% rename ROI
% get current ROI index
iROI = find(this.tv.ROI.ROIIDs == ROIID);
% get old name
oldROIName = this.tv.ROI.ROINames{iROI};
showMessage(this, sprintf('TrialView: renaming ROI "%s" ...', oldROIName), 'yellow');
% rename ROI
newROIName = params.ROIDisplayConfigs{iNewROIName, 1};
this.tv.ROI.ROINames{iROI} = newROIName;

% get the assign region context menu
ROIHandleChildren = get(this.tv.ROI.ROIHandles{iROI}, 'Children');
hContextMenu = get(ROIHandleChildren(1), 'UIContextMenu');
contextMenuItems = get(hContextMenu, 'Children');
assignRegionItemChildren = get(contextMenuItems(2), 'Children');

% modify the checked state to assign ROI from list
for iROIMenu = 1 : numel(assignRegionItemChildren);
    set(assignRegionItemChildren(iROIMenu), 'Checked', ...
        iff(strcmp(get(assignRegionItemChildren(iROIMenu), 'Label'), newROIName), 'on', 'off'));
end;

% restore handles
this.GUI.handles.tv = tvH;
% restore params and then restore & enable GUI
this.tv.params = params;

%% update time course
showMessage(this, sprintf('TrialView: renaming ROI "%s/%s": updating time course ...', oldROIName, newROIName), 'yellow');
OCIA_trialview_updateTimeCourse(this, ROIID);

%% finalize
showMessage(this, sprintf('TrialView: renaming ROI "%s/%s": done!', oldROIName, newROIName));

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
