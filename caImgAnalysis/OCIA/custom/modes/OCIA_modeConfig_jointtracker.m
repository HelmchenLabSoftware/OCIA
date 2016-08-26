function this = OCIA_modeConfig_jointtracker(this)
% adds the join tracker mode to the OCIA

%% - properties: Joint Tracker
this.jt = struct();
% original frames of the movie
this.jt.oriFrames = [];
% average of all the orginal frames of the movie
this.jt.avgOriFrame = [];
% sliding window average of all the orginal frames of the movie
this.jt.slidingAvgOriFrames = [];
% size of the sliding window average
this.jt.slidingAvgWindowPercentage = 0.3;
% current (eventually modified) frames of the movie
this.jt.frames = [];
% number of frames of the movie
this.jt.nFrames = 0;

% number of joints to track
this.jt.nJoints = 0;
% joints as a cell-array with one row per joint and 8 columns: 
%   { 1: name, 2: is virtual, 3: window size, 4: distance to previous and next joint, 5: which virtual joint should
%       be used (left or right), 6: find joint method, 7: and pre-processing settings, 8: joint size }
this.jt.jointConfig = cell(0, 8);
% cell array of joint types with 3 columns: { id, name }
this.jt.jointTypes = { 'a', 'auto'; 'm', 'manual'; };
% number of joint typesk
this.jt.nJointTypes = size(this.jt.jointTypes, 1);
% joint coordinates as a matrix of nJoints x nFrames x nCoords (= 2 for x and y) x nJointTypes (see this.jt.jointTypes)
this.jt.joints = zeros(this.jt.nJoints, this.jt.nFrames, 2, this.jt.nJointTypes);
% cell-array of mask defining the possible positions of each ROI
this.jt.jointROIMasks = cell(this.jt.nJoints, 1);

%% -- properties: Joint Tracker: joint finding parameters
% whether to skip or not the pre-processing
this.jt.skipPreProc = false;
% order in which joints should be processed
this.jt.jointProcessOrder = [];
% structure of cell-arrays defining different types of correction/processing that should be applied to find the joints
% ( see the JTFindJoint method for a description of each correction, current choice is:
%   invert, linScale, flatField, median, imadjustAuto, imadjustPrctile, convolFilter, threshMinPrctle, 
%   threshMinPeakPrctle, threshMaxPrctle, showPoints_***, ... )
this.jt.findJointPreProc = struct();

% cross-correlation
this.jt.findJointPreProc.xcorr_gauss = struct();
this.jt.findJointPreProc.xcorr_gauss.smallMoveJoint = { ...
    'original',             [],                                 0;
    'invert',               [],                                 1;
    'flatField',            2,                                  1;
    'medianJS',             [2, 2],                             1;
};
this.jt.findJointPreProc.xcorr_gauss.bigMoveWristJoint = this.jt.findJointPreProc.xcorr_gauss.smallMoveJoint;
this.jt.findJointPreProc.xcorr_gauss.bigMoveJoint = this.jt.findJointPreProc.xcorr_gauss.smallMoveJoint;
this.jt.findJointPreProc.xcorr_ref = this.jt.findJointPreProc.xcorr_gauss;
this.jt.findJointPreProc.xcorr_comb = this.jt.findJointPreProc.xcorr_gauss;

% for debug: when evaluating this cell while the software is already opened, executes the process function
if isfield(this.GUI, 'jt'); % check if the software is initialized
    JTProcess(this, 'single');
end;

%% -- properties: GUI: Joint Tracker
this.GUI.jt = struct();
% currently displayed image
this.GUI.jt.img = [];
% currently displayed frame number
this.GUI.jt.iFrame = 0;
% defines which joint type is currently selected (for tracking/moving/etc.)
this.GUI.jt.iJointType = [];
% defines which joint is currently selected (for tracking/moving/etc.)
this.GUI.jt.iJoint = [];
% defines the forced-placed joints which should not be re-updated (virtual joints, auto-joints, etc.), as a matrix 
%   of nJoints x nFrames x nJointTypes (see this.jt.jointTypes)
this.GUI.jt.forcedJoints = zeros(this.jt.nJoints, this.jt.nFrames, this.jt.nJointTypes);
% positions of the used bounding boxes
this.GUI.jt.boundBoxPos = zeros(this.jt.nJoints, this.jt.nFrames, this.jt.nJointTypes, 4);
% handles for the joints' ROIs
this.GUI.jt.jointROIHandles = cell(this.jt.nJoints, 1);
% handles for the movie croping
this.GUI.jt.cropROIHandle = [];

% defines whether to ask for a confirmation before reseting all joints
this.GUI.jt.askResetConfirm = true;
% handle of the imroi object defining the mask where the pre-processing of the frames should be applied
this.GUI.jt.imPreProcROI = [];
% mask where the pre-processing of the frames should be applied
this.GUI.jt.imPreProcROIMask = [];
% defines whether the user is currently selecting a Region Of Interest, in which case other click events are invalid
this.GUI.jt.selectingROI = false;

% types of GUI view options
this.GUI.jt.viewOpts = {
    'joints',       'Joints',           'Show the joints (circles)';
    'jointLines',   'Joint lines',      'Show the joints lines (skeleton)';
    'preProc',      'Pre-processed',    'Show the pre-processed frames (or the originals if not checked)';
    'ROIs',         'ROI masks',        'Show the mask restricting the joints'' position';
    'boundBoxes',   'Bounding boxes',   'Show the bounding boxes for the joint finding';
    'debugPlots',   'Debug plots',      'Show the debug plots (all sorts of plots showing what is going on)';
};

% frame index at the begining of the joint track
this.GUI.jt.startFrame = [];
% time at the begining of the joint track
this.GUI.jt.startTime = [];
% target frame index until where the track should go on
this.GUI.jt.endFrame = [];
% joint index where a click down was done for a joint placing event (not all joints placed)
this.GUI.jt.placeJointIndex = [];
% joint index where a click down was done for a joint moving event (all joints already placed)
this.GUI.jt.moveJointIndex = [];
% maximum distance allowed for selecting a joint
this.GUI.jt.jointMoveMaxDist = 60;
% minimum distance allowed for placing a new joint if a closer joint exists
this.GUI.jt.jointMoveMinDist = 25;

%% --- properties: GUI: Joint Tracker: display settings
% display settings for the different joint types with 14 columns:
%   { real and virtual joints: [size, edge color, face color, curvature], line: width, color, style, 
%       bounding box: line width, color, lineStyle }
this.GUI.jt.disp = { ...
    5, [0 0 0], [0 1 0], [1, 1], 5, [0 0 0], [1 0 0], [1, 1], 0.5, [0 1 0], '-', 0.5, [0 1 0], '--'; % xref_ref
    5, [0 0 0], [1 1 0], [1, 1], 5, [0 0 0], [0.8 0.2 1], [1, 1], 0.5, [1 0 1], '-', 0.5, [1 1 0], '--'; % manual
%     3, [0 0 0], [1 0 1], [1, 1], 3, [0 0 0], [0 1 1], [1, 1], 0.5, [0 0 1], '-', 0.5, [1 0 1], '--'; % maxima
%     3, [0 0 0], [1 1 0], [1, 1], 3, [0 0 0], [0.8 0.2 1], [1, 1], 0.5, [1 0 1], '-', 0.5, [1 1 0], '--'; % xref_ref
};

% defines which colormap is applied to the debug plots in the joint finding pre-processing step
this.GUI.jt.preProcDebugColormap = 'gray';

end
