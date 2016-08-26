function this = OCIA_trialview_deleteROI(this, ROIID)
% OCIA_trialview_deleteROI - Delete an ROI
%
%       OCIA_trialview_deleteROI(this, ROIID)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% init
% disable GUI and get params and handles
OCIAToggleGUIEnableState(this, 'TrialView', 'off');
params = this.tv.params;
tvH = this.GUI.handles.tv;

%% delete ROI
% get current ROI index
iROI = find(this.tv.ROI.ROIIDs == ROIID);

% no ROI found
if numel(iROI) < 1;
    showMessage(this, sprintf('TrialView: cannot find ROI with ID "%s", aborting.', ROIID), 'red');
    return;
    
% more than one ROI with same ROI ID    
elseif numel(iROI) > 1;
    % change first ROIID and delete it
    this.tv.ROI.ROIIDs{iROI(1)} = this.tv.ROI.ROIIDs{iROI(1)} + 1;
    OCIA_trialview_deleteROI(this, this.tv.ROI.ROIIDs{iROI(1)});
    
    % delete rest of ROIs
    OCIA_trialview_deleteROI(this, ROIID(2 : end));
    
else

    % get name
    ROIName = this.tv.ROI.ROINames{iROI};
    showMessage(this, sprintf('TrialView: deleting ROI "%s" ...', ROIName), 'yellow');

    % store handle and mask
    delete(this.tv.ROI.ROIHandles{iROI});
    this.tv.ROI.ROIIDs(iROI) = [];
    this.tv.ROI.ROIHandles(iROI) = [];
    this.tv.ROI.ROIMasks(iROI) = [];
    this.tv.ROI.ROINames(iROI) = [];
    this.tv.ROI.axeH(iROI) = [];
    delete(tvH.tc.ROITimeCourses{iROI});
    tvH.tc.ROITimeCourses(iROI) = [];
    this.tv.ROI.ROITimeCourses(iROI) = [];

    % restore handles
    this.GUI.handles.tv = tvH;
    % restore params
    this.tv.params = params;

    %% update time course
    % update only the legend
    OCIA_trialview_updateTimeCourse(this, -1);

    % flag as not drawing anymore
    showMessage(this, sprintf('TrialView: deleting ROI "%s": done!', ROIName));
    
end;

%% finalize
% restore & enable GUI
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
