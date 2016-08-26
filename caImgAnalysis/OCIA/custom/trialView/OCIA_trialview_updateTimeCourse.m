function this = OCIA_trialview_updateTimeCourse(this, varargin)
% OCIA_trialview_updateTimeCourse - Update the ROI time course
%
%       OCIA_trialview_updateTimeCourse(this, targetROI)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get params and handles
params = this.tv.params;
tvH = this.GUI.handles.tv;

% get time vector
t.wf = ((1 : size(this.tv.data.wf, 3)) / params.WFFrameRate) - params.WFTimeOffset + this.tv.trigDelay;
if isfield(this.tv.data, 'behavMovie');
    t.behav = ((1 : size(this.tv.data.behavMovie, 3)) / params.behavFrameRate) - params.WFTimeOffset;
end;
% go through each ROI
ROIHandles = this.tv.ROI.ROIHandles;
nROIs = numel(ROIHandles);
for iROI = 1 : nROIs;
    
    % if targeted update is required for a single ROI, only update that one
    if ~isempty(varargin) && isnumeric(varargin{1}) && numel(varargin{1}) == 1;
        % get target ROI index
        iTargetROI = find(this.tv.ROI.ROIIDs == varargin{1});
        if isempty(iTargetROI) || iROI ~= iTargetROI(1);
            continue;
        end;
    end;
    
    % extract time course for current ROI
    this.tv.ROI.ROIMasks{iROI} = this.tv.ROI.ROIHandles{iROI}.createMask();
    ROIMask = this.tv.ROI.ROIMasks{iROI};
    % for wide-field data, just extract the time course
    if strcmp(this.tv.ROI.axeH{iROI}, 'wf');
        this.tv.ROI.ROITimeCourses{iROI} = nanmean(GetRoiTimeseries(this.tv.data.wf, ROIMask), 1);
        
    elseif isfield(this.tv.data, 'behavMovie') && strcmp(this.tv.ROI.axeH{iROI}, 'behav');
        
        percBoundBox = -1;
        showMessage(this, sprintf('TrialView: getting frame-to-frame correlation for ROI "%s" ...', ...
            this.tv.ROI.ROINames{iROI}));
        this.tv.ROI.ROITimeCourses{iROI} = 1 - getFrameToFrameCorrROI({'', ROIMask}, percBoundBox, ...
            this.tv.data.behavMovie, false);
        this.tv.ROI.ROITimeCourses{iROI} = [NaN, this.tv.ROI.ROITimeCourses{iROI}];
        
        this.tv.ROI.ROITimeCourses{iROI} = this.tv.ROI.ROITimeCourses{iROI} + params.TCYLimROI(1);
        
%         this.tv.ROI.ROITimeCourses{iROI} = nanmean(GetRoiTimeseries(this.tv.data.behavMovie, ROIMask), 1);
%         this.tv.ROI.ROITimeCourses{iROI} = linScale(this.tv.ROI.ROITimeCourses{iROI}, params.TCYLimROI);

    end;
    
    % try to find display options for this ROI
    ROIDisplayIndex = find(strcmp(this.tv.ROI.ROINames{iROI}, params.ROIDisplayConfigs(:, 1)));
    % no match found, use default with random color
    if isempty(ROIDisplayIndex);
        ROIColor = lines(100);
        ROIColor = ROIColor(iROI, :);
        ROILineStyle = iff(~isempty(regexp(this.tv.ROI.ROINames{iROI}, 'Behav', 'once')), ':', '-');
      
    % use pre-set color and line style for this ROI
    else
        ROIColor = str2double(regexp(params.ROIDisplayConfigs{ROIDisplayIndex, 2}, ',', 'split'));
        ROILineStyle = params.ROIDisplayConfigs{ROIDisplayIndex, 3};
        
    end;
    
    % update the ROIHandle's color
    this.tv.ROI.ROIHandles{iROI}.setColor(ROIColor);
    % restore the checked state
    ROIHandleChildren = get(this.tv.ROI.ROIHandles{iROI}, 'Children');
    hContextMenu = get(ROIHandleChildren(1), 'UIContextMenu');
    contextMenuItems = get(hContextMenu, 'Children');
    assignRegionItemChildren = get(contextMenuItems(2), 'Children');
    % modify the checked state to assign ROI from list
    for iROIMenu = 1 : numel(assignRegionItemChildren);
        set(assignRegionItemChildren(iROIMenu), 'Checked', ...
            iff(strcmp(get(assignRegionItemChildren(iROIMenu), 'Label'), this.tv.ROI.ROINames{iROI}), 'on', 'off'));
    end;
    
    % plot time course if it does not exist yet
    if numel(tvH.tc.ROITimeCourses) < iROI;
        hold(tvH.tc.ROIAxe, 'on');
        tvH.tc.ROITimeCourses{iROI} = plot(tvH.tc.ROIAxe, t.(this.tv.ROI.axeH{iROI}), this.tv.ROI.ROITimeCourses{iROI}, ...
            'LineStyle', ROILineStyle, 'Color', ROIColor, 'LineWidth', 2);
        hold(tvH.tc.ROIAxe, 'off');
        
    % otherwise just update the Y data and plotting parameters
    else
        set(tvH.tc.ROITimeCourses{iROI}, 'YData', this.tv.ROI.ROITimeCourses{iROI}, 'XData', t.(this.tv.ROI.axeH{iROI}), ...
            'LineStyle', ROILineStyle, 'Color', ROIColor, 'LineWidth', 2);
        
    end;
    
end;

% if some ROI time course is displayed, add a legend
if nROIs > 0;
    % turn cell-array of line handles into a "Line array"
    lineHandles = tvH.tc.ROITimeCourses{1};
    for iROI = 2 : nROIs; lineHandles(end + 1) = tvH.tc.ROITimeCourses{iROI}; end; %#ok<AGROW>
    hLeg = legend(tvH.tc.ROIAxe, lineHandles, this.tv.ROI.ROINames, 'Location', 'NorthEast', ...
        'FontSize', this.GUI.pos(3) / 180);
    % reposition legend
    legPos = get(hLeg, 'Position');
    set(hLeg, 'Position', [legPos(1) * 1.05, legPos(2), legPos(3), legPos(4)]);
end;

% restore handles
this.GUI.handles.tv = tvH;
% restore params and then restore & enable GUI
this.tv.params = params;

% update frame and time course axis
OCIA_trialview_changeFrame(this);

end
