%% #OCIA_dataWatcherProcess_trackMovies
function OCIA_dataWatcherProcess_trackMovies(this, ~, ~)

%% initialize movie
% get the path of the selected movie
moviePath = DWGetFullPath(this, this.dw.selectedTableRows(1));
if regexp(moviePath, '\.avi$');
    
    % get VideoReader object for the selected movie
    vrHand = VideoReader(moviePath);
    % get movie dimensions   
    nFrames = vrHand.NumberOfFrames;
    this.jt.nFrames = nFrames; % store the number of frames
    H = vrHand.Height;
    W = vrHand.Width;

    %% load the movie
    loadTic = tic; % for performance timing purposes
    showMessage(this, 'Loading movie ...', 'yellow');
    % pre-allocate movie
    oriFrames = zeros(H, W, nFrames);
    % load movie frame by frame
    DWWaitBar(this, 0);
    for iFrame = 1 : nFrames;
        oriFrames(:, :, iFrame) = nanmean(double(read(vrHand, iFrame)), 3);
        DWWaitBar(this, 100 * (iFrame / nFrames));
    end
    % back up the frames
    this.jt.oriFrames = oriFrames;
    this.jt.frames = oriFrames;
    showMessage(this, sprintf('Loading movie done (%3.1f sec).', toc(loadTic)));
    
elseif regexp(moviePath, '\.tif$');
    
    loadTic = tic; % for performance timing purposes
    showMessage(this, 'Loading movie ...', 'yellow');
    
    % read the movie
    tiffStruct = tiffread2(moviePath, 1, 10000, @(progressFrac)DWWaitBar(this, progressFrac * 100));
    
    % get movie dimensions   
    W = tiffStruct.width;
    H = tiffStruct.height;
    % get the number of frames and store it
    nFrames = size(tiffStruct, 2);
    this.jt.nFrames = nFrames;
    
    % pre-allocate movie and unwrap it frame by frame
    this.jt.oriFrames = zeros(H, W, nFrames);
    for iFrame = 1 : nFrames;
        this.jt.oriFrames(:, :, iFrame) = double(tiffStruct(iFrame).data);
    end
    
    % back up the frames
    this.jt.frames = this.jt.oriFrames;
    showMessage(this, sprintf('Loading movie done (%3.1f sec).', toc(loadTic)));
    
end;

%% set JointTracker settings
this.jt.nJoints = size(this.jt.jointConfig, 1);
this.jt.joints = zeros(this.jt.nJoints, nFrames, 2, this.jt.nJointTypes);
this.GUI.jt.forcedJoints = false(this.jt.nJoints, nFrames, this.jt.nJointTypes);
this.GUI.jt.boundBoxPos = zeros(this.jt.nJoints, this.jt.nFrames, this.jt.nJointTypes, 4);
this.GUI.jt.jointROIHandles = cell(this.jt.nJoints, 1);
this.jt.jointROIMasks = cell(this.jt.nJoints, 1);

%% initialize GUI
% change mode
OCIAChangeMode(this, 'JointTracker');

% replace the image by a dummy one by one dark pixel
this.GUI.jt.img = zeros(1, 1);
set(this.GUI.handles.jt.img, 'CData', linScale(this.GUI.jt.img));
set(this.GUI.handles.jt.axe, 'XLim', [0.5 1.5], 'YLim', [0.5 1.5]);

% adjust the display options setter
set(this.GUI.handles.jt.viewOpts.boundBoxes, 'Value', 0);
set(this.GUI.handles.jt.viewOpts.debugPlots, 'Value', 0);
set(this.GUI.handles.jt.viewOpts.preProc, 'Value', 0);

% adjust the joint and joint type setters
set(this.GUI.handles.jt.jointSelSetter, 'Value', 1);
this.GUI.jt.iJoint = 1;
set(this.GUI.handles.jt.jointTypeSelSetter, 'Value', 1);
this.GUI.jt.iJointType = 1;

% adjust the frame setter
this.GUI.jt.iFrame = 1;
set(this.GUI.handles.jt.frameSetter, 'Enable', 'on', 'Min', 1, 'Max', nFrames, 'Value', 1, ...
    'SliderStep', [1 / nFrames 3 / nFrames]);
% update the frame label
set(this.GUI.handles.jt.frameLabel, 'String', sprintf('Frame %03d', 1));

% update the GUI
JTUpdateGUI(this, 'all');

% set the focus to the frame setter
uicontrol(this.GUI.handles.jt.frameSetter);

end
