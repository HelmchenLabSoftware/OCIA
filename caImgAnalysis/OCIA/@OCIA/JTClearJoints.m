function JTClearJoints(this, varargin)
% JTClearJoints - [no description]
%
%       JTClearJoints(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
% Usage: JTClearJoints(this, varargin), where varargin is optionally: clearData, frameRange, h

if nargin > 1 && ~isempty(varargin{1});  clearData = varargin{1};
else            clearData = false;
end;
if ischar(clearData) && strcmp(clearData, 'current');
    clearData = zeros(this.jt.nJoints, this.jt.nJointTypes);
    clearData(this.GUI.jt.iJoint, this.GUI.jt.iJointType) = 1;
end;
if nargin > 2 && ~isempty(varargin{2});  frameRange = varargin{2};
else            frameRange = this.GUI.jt.iFrame;
end;

if nargin > 3 && ~isempty(varargin{3});  h = varargin{3};
else            h = [];
end;

% clear joint placing/moving indexes
this.GUI.jt.placeJointIndex = [];
this.GUI.jt.moveJointIndex = [];

% if clearing the actual coordinates is required, remove the stored coordinates for this frame
if any(clearData(:));
    
    % if clearData is just a single value, apply to all
    if numel(clearData) == 1;
        clearData = zeros(this.jt.nJoints, this.jt.nJointTypes) + clearData;
    % if clearData is just a vector of joints, apply to all joint types
    elseif numel(clearData) == this.jt.nJoints;
        clearData = repmat(clearData, 1, this.jt.nJointTypes);
    % if clearData is just a vector of joint types, apply to all joints
    elseif numel(clearData) == this.jt.nJointTypes;
        clearData = repmat(clearData, this.jt.nJoints, 1);
    end;
    
    % delete the required joints on the selected frames
    for iJointType = 1 : this.jt.nJointTypes;
        this.jt.joints(logical(clearData(:, iJointType)), frameRange, :, iJointType) = 0;
        this.GUI.jt.forcedJoints(logical(clearData(:, iJointType)), frameRange, iJointType) = false;
    end;
end;

% update the GUI
JTUpdateGUI(this, 'joints');

% set the focus to the frame setter if the call was from a GUI element
if ~isempty(h) && all(ishandle(h)) && all(h > 0);
    uicontrol(this.GUI.handles.jt.frameSetter);
end;

end
