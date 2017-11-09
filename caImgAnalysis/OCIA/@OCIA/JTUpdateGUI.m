function JTUpdateGUI(this, varargin)
% JTUpdateGUI - [no description]
%
%       JTUpdateGUI(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
  
% get input argument
if numel(varargin) > 0; h = varargin{1};
else h = [];
end;

updateTic = tic; % for performance timing purposes
o('#JTUpdateGUI: h: %.5f', h, 4, this.verb);

% get the view option handles
viewOpts = this.GUI.handles.jt.viewOpts;

% update the joints if there is no handle or for some specific handles or for the 'joints' string
updateJoints = false;
if isempty(h) || (~ischar(h) ...
        && any(h == [viewOpts.joints, viewOpts.jointLines, viewOpts.boundBoxes, viewOpts.jointDist])) ...
        || (ischar(h) && (strcmpi(h, 'all') || strcmpi(h, 'joints')));
    updateJoints = true;
end;

% check whether the image should be updated or not
updateImage = false;
if (~ischar(h) && any(h == [viewOpts.preProc])) || (ischar(h) && (strcmpi(h, 'all') || strcmpi(h, 'image')));
    updateImage = true;
end;

% check whether the ROI masks should be updated or not
updateROIs = false;
if (~ischar(h) && any(h == [viewOpts.ROIs])) || (ischar(h) && (strcmpi(h, 'all') || strcmpi(h, 'rois')));
    updateROIs = true;
end;

% update the joints' display
if updateJoints;
    
    o('#JTUpdateGUI: h: %.5f, updating joints ... ', h, 4, this.verb);

    % get the handles of the GUI elements on the axe
    childHands = get(this.GUI.handles.jt.axe, 'Children'); % get the handles of the child elements of the main axe
    childTags = get(childHands, 'Tag'); % get their tags
    if ischar(childTags); childTags = {childTags}; end; % make sure we have a cell-array    
        
    % check if the joint coordinates storage is not empty
    if ~isempty(this.jt.joints);

        % get the joint coordinates
        jointCoords = squeeze(this.jt.joints(:, this.GUI.jt.iFrame, :, :));
        
        % loop through each joint type
        for iJointType = 1 : this.jt.nJointTypes;
            
            % loop through each joint
            for iJoint = 1 : this.jt.nJoints;
                
                % first delete the GUI element
                jointHandleName = sprintf('JTJoint_%s_%02d', this.jt.jointTypes{iJointType, 1}, iJoint);
                jointLineHandleName = sprintf('JTJointLine_%s_%02d', this.jt.jointTypes{iJointType, 1}, iJoint);
                jointBBoxHandleName = sprintf('JTBBox_%s_%02d', this.jt.jointTypes{iJointType, 1}, iJoint);
                jointDistHandleName = sprintf('JTDist_%s_%02d', this.jt.jointTypes{iJointType, 1}, iJoint);
                regexpTxt = sprintf('^(%s|%s|%s|%s)$', jointHandleName, jointLineHandleName, jointBBoxHandleName, ...
                    jointDistHandleName);
                
                % delete the elements of the list
                try         delete(childHands(~cellfun(@isempty, regexp(regexpTxt, childTags))));
                catch e;    o('#JTUpdateGUI(): error while deleting handles: %s (%s).', e.message, e.identifier, 2, this.verb);
                end;
                
                % if there are some coordinates for it and the display is required, place the joint's GUI elements, 
                %   also depending on whether they are selected for display or not
                if any(jointCoords(iJoint, :, iJointType)) ...
                        && any(iJoint == get(this.GUI.handles.jt.jointSelDispSetter, 'Value')) ...
                        && any(iJointType == get(this.GUI.handles.jt.jointTypeSelDispSetter, 'Value'));
                    JTPlaceJoint(this, iJoint, iJointType, jointCoords(iJoint, :, iJointType));
                end;
            end;
        end;
        
        % update joint validity picture:
        set(this.GUI.handles.jt.validImg, 'CData', this.GUI.jt.jointValidity);
        delete(get(this.GUI.handles.jt.joinValDispAxe, 'Children'));
        set(this.GUI.handles.jt.joinValDispAxe, 'XLim', [0 10], 'YLim', [0.5 this.jt.nJoints + 0.5]);
        for iJoint = 1 : this.jt.nJoints;
            text(1, this.jt.nJoints - iJoint + 1, sprintf('J%d: %.3f', iJoint, this.GUI.jt.jointValidity(iJoint, this.GUI.jt.iFrame)), ...
                'Parent', this.GUI.handles.jt.joinValDispAxe, 'FontSize', 16);
        end;
        
    end;
end;

% update the image
if updateImage;
    
    o('#JTUpdateGUI: h: %.5f, updating image ... ', h, 4, this.verb);
    
    % get the image to display
    img = linScale(squeeze(this.jt.frames(:, :, this.GUI.jt.iFrame)));
    this.GUI.jt.img = img; % store always the pre-processed image
    
    % if not the pre-processed images should be shown, used the original ones
    if ~get(viewOpts.preProc, 'Value');
        img = linScale(squeeze(this.jt.oriFrames(:, :, this.GUI.jt.iFrame)));
    end;
    
    % display the image, keeping the zoom settings
    xLims = get(this.GUI.handles.jt.axe, 'XLim'); yLims = get(this.GUI.handles.jt.axe, 'YLim');
    % in case the previous image was the 1x1 pixel of start, re-adjust the image scale
    if all(xLims == [0.5 1.5]) && all(yLims == [0.5 1.5]);
        xLims = [0 size(img, 2)]; yLims = [0 size(img, 1)];
    end;
    set(this.GUI.handles.jt.img, 'CData', img);
    set(this.GUI.handles.jt.axe, 'XLim', xLims, 'YLim', yLims);
end;

% update the ROIs, also when the joints are to be updated
if updateROIs || updateJoints;
    
    o('#JTUpdateGUI: h: %.5f, updating ROIs ... ', h, 4, this.verb);
    
    % loop through each joint
    for iJoint = 1 : this.jt.nJoints;
        ROIHandle = this.GUI.jt.jointROIHandles{iJoint};
        if ~isempty(ROIHandle) && isa(ROIHandle, 'impoly') && ROIHandle.isvalid();
            if get(this.GUI.handles.jt.viewOpts.ROIs, 'Value') && any(iJoint == get(this.GUI.handles.jt.jointSelDispSetter, 'Value'));
                set(this.GUI.jt.jointROIHandles{iJoint}, 'Visible', 'on');
            else
                set(this.GUI.jt.jointROIHandles{iJoint}, 'Visible', 'off');
            end;
        end;
    end;
end;


% set the focus to the frame setter if the call was from a GUI element
if ~isempty(h) && ~ischar(h) && ishandle(h);
    uicontrol(this.GUI.handles.jt.frameSetter);
end;

o('#JTUpdateGUI: h: %.5f done (%.1f sec)', h, toc(updateTic), 3, this.verb);

end
