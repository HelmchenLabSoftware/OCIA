%% #OCIA_dataWatcherProcess_trackMovies
function OCIA_dataWatcherProcess_trackMovies(this, ~, ~)

% change mode
OCIAChangeMode(this, 'DataWatcher');

%% initialize movie
% get the path of the selected movie
moviePath = this.path.moviePath;
moviePathCropped = regexprep(moviePath, '\.avi', '_cropped.avi');

if regexp(moviePath, '\.avi$');
    
    % get VideoReader object for the selected movie
    vrHand = VideoReader(moviePath);
    % get movie dimensions   
    nFrames = round(vrHand.Duration * vrHand.FrameRate);
    this.jt.frameRate = vrHand.FrameRate;
    this.jt.nFrames = nFrames; % store the number of frames
    showMessage(this, sprintf('Video has %d frames ...', nFrames), 'yellow');
    H = vrHand.Height;
    W = vrHand.Width;
%     H = round(vrHand.Height * 0.1);
%     W = round(vrHand.Width * 0.1);

    %% crop movie
    % if cropping is requested
    if this.jt.doCroppingStep;
        % if no cropping rectangle is not defined yet
        if isempty(this.jt.cropRect);
            
            % load a frame
            frame = nanmean(double(readFrame(vrHand)), 3);
            % reset time so vrHand is back at the begininning of the movie
            vrHand.CurrentTime = 0;
            % display frame
            figH = figure('NumberTitle', 'off', 'Name', 'Crop movie - [X, Y, W, H]', ...
                'MenuBar', 'none', 'ToolBar', 'none', 'Units', 'Normalized');
            imH = imagesc(frame);
            colormap(gray);
            % select an area
            imRectH = imrect(get(imH, 'Parent'));
            set(figH, 'Name', sprintf('Crop movie - [%d, %d, %d, %d]', round(imRectH.getPosition())));
            fprintf('Cropping rectangle: [%d, %d, %d, %d]\n', round(imRectH.getPosition()));
            imRectH.addNewPositionCallback(@(pos) {
                set(figH, 'Name', sprintf('Crop movie -  [%d, %d, %d, %d]', round(pos)));
                fprintf('Cropping rectangle: [%d, %d, %d, %d]\n', round(imRectH.getPosition()));
            });
        
            return;
        
        % if a cropping rectangle is defined but cropped movie alread exists, print warning and go on
        elseif exist(moviePathCropped, 'file');
            showWarning(this, 'OCIA:JTTrackMovies:CroppedMovieAlreadyExists', ...
                sprintf('Cropped movie already exists at "%s". Skipping cropping...', moviePathCropped));
            % switch to cropped file
            this.path.moviePath = moviePathCropped;
            this.jt.doCroppingStep = 0;
            OCIA_dataWatcherProcess_trackMovies(this);
            return;
        
        % if a cropping rectangle is defined and file does not exist yet, crop movie
        else
            showMessage(this, 'Cropping movie ...', 'yellow');
            % get VideoWriter object to write cropped movie
            vwHand = VideoWriter(moviePathCropped, 'Uncompressed AVI');
            vwHand.FrameRate = this.jt.frameRate;
            open(vwHand);
            % crop movie
            for iFrame = 1 : nFrames;
                % skip unwanted frames and switch directly to the required time
                if ~isempty(this.jt.timeCrop) && iFrame < this.jt.timeCrop(1);
                    continue;
                end;
                % switch directly to the required time
                if ~isempty(this.jt.timeCrop) && iFrame == this.jt.timeCrop(1);
                    vrHand.CurrentTime = iFrame / this.jt.frameRate;
                end;
                % skip unwanted frames
                if ~isempty(this.jt.timeCrop) && iFrame > this.jt.timeCrop(2);
                    break;
                end;
                frame = readFrame(vrHand);
                writeVideo(vwHand, imcrop(frame, this.jt.cropRect));
                if ~isempty(this.jt.timeCrop);
                    DWWaitBar(this, 100 * ((iFrame - this.jt.timeCrop(1)) / diff(this.jt.timeCrop)));
                else
                    DWWaitBar(this, 100 * (iFrame / nFrames));
                end;
            end
            close(vwHand);
            % switch to cropped file
            this.path.moviePath = moviePathCropped;
            this.jt.doCroppingStep = 0;
            OCIA_dataWatcherProcess_trackMovies(this);
            return;
        end;        
    end;

    %% load the movie
    loadTic = tic; % for performance timing purposes
    showMessage(this, 'Loading movie (avi)...', 'yellow');
    % pre-allocate movie
    oriFrames = zeros(H, W, nFrames);
    % load movie frame by frame
    DWWaitBar(this, 0);
    pause(0.001); % required to let the GUI update itself
    for iFrame = 1 : nFrames;
        frame = nanmean(double(readFrame(vrHand)), 3);
        o('Loaded frame %d', iFrame, 0, this.verb);
        oriFrames(:, :, iFrame) = imcrop(frame, [0, 0, W, H]);
        DWWaitBar(this, 100 * (iFrame / nFrames));
        pause(0.001); % required to let the GUI update itself
    end
    % back up the frames
    this.jt.oriFrames = oriFrames;
    this.jt.frames = oriFrames;
    showMessage(this, sprintf('Loading movie done (%3.1f sec).', toc(loadTic)));
    
elseif regexp(moviePath, '\.tif$');
    
    loadTic = tic; % for performance timing purposes
    showMessage(this, 'Loading movie (tiff)...', 'yellow');
    
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
this.GUI.jt.jointValidity = nan(this.jt.nJoints, this.jt.nFrames);
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
set(this.GUI.handles.jt.viewOpts.ROIs, 'Value', 0);
set(this.GUI.handles.jt.viewOpts.jointDist, 'Value', 0);
set(this.GUI.handles.jt.viewOpts.validPlots, 'Value', 0);
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
currTimeTotSec = 1 / this.jt.frameRate;
currTimeMin = floor(currTimeTotSec / 60);
currTimeSec = floor(currTimeTotSec - currTimeMin * 60);
currTimeMSec = floor((currTimeTotSec - currTimeMin * 60 - currTimeSec) * 1000);
set(this.GUI.handles.jt.frameLabel, 'String', sprintf('F  %03d\nT  %02d:%02d.%03d\nM 0000 0000', ...
    1, currTimeMin, currTimeSec, currTimeMSec));

% update the GUI
JTUpdateGUI(this, 'all');

% set the focus to the frame setter
uicontrol(this.GUI.handles.jt.frameSetter);

end
