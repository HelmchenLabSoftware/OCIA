function JTChangeJointOrJointType(this, h, ~)
% JTChangeJointOrJointType - [no description]
%
%       JTChangeJointOrJointType(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% check if h is a handle
isHHandle = ~isempty(h) && ishandle(h);

if isHHandle && h == this.GUI.handles.jt.jointSelSetter;
    
    this.GUI.jt.iJoint = get(this.GUI.handles.jt.jointSelSetter, 'Value');
    if isempty(this.GUI.jt.iJoint);
        showMessage(this, 'No joint selected');
    else
        jointText = regexprep(cell2mat(arrayfun(@(iJoint) sprintf('%s (%d), ', this.jt.jointConfig{iJoint, 1}, iJoint), ...
            this.GUI.jt.iJoint, 'UniformOutput', false)), ', $', '');
        showMessage(this, sprintf('Selected %s.', jointText));
    end;
    
    % if a single joint was selected, place or move that one upon next click
    if numel(this.GUI.jt.iJoint) == 1;
        this.GUI.jt.placeJointIndex = this.GUI.jt.iJoint;
    end;
    
elseif isHHandle && h == this.GUI.handles.jt.jointTypeSelSetter;
    
    this.GUI.jt.iJointType = get(this.GUI.handles.jt.jointTypeSelSetter, 'Value');
    if isempty(this.GUI.jt.iJointType);
        showMessage(this, 'No joint type selected');
    else
        jointTypeText = regexprep(cell2mat(arrayfun(@(iJointType) sprintf('%s (%d), ', this.jt.jointTypes{iJointType, 2}, iJointType), ...
        this.GUI.jt.iJointType, 'UniformOutput', false)), ', $', '');
        showMessage(this, sprintf('Selected to %s.', jointTypeText));
    end;
    
% update display
elseif isHHandle && any(h == [this.GUI.handles.jt.jointSelDispSetter, this.GUI.handles.jt.jointTypeSelDispSetter]);
    
    JTUpdateGUI(this);
    
end;

% set the focus to the frame setter if the call was from a GUI element
if isHHandle; uicontrol(this.GUI.handles.jt.frameSetter); end;

end
