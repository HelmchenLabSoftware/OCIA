%% #DIUpdateGUI
function DIUpdateGUI(this, ~, ~)

o('#%s() ...', mfilename, 3, this.verb);

try % capture display errors


%% camera plot
try
    currFrame = peekdata(this.GUI.di.camHandle, 1);
    flushdata(this.GUI.di.camHandle);
    currFrame(:, :, 2) = currFrame(:, :, 1);
    currFrame(:, :, 3) = currFrame(:, :, 1);
%     imagesc(currFrame, 'Parent', this.GUI.handles.di.camAxe);
    cameAxeChild = get(this.GUI.handles.di.camAxe, 'Child');
    if isempty(cameAxeChild);
        cameAxeChild = imagesc(zeros(576, 720, 3), 'Parent', this.GUI.handles.di.camAxe);
        axis(this.GUI.handles.di.camAxe, 'equal');
    end;
    set(cameAxeChild, 'CData', currFrame);
catch
    imagesc(zeros(576, 720, 3), 'Parent', this.GUI.handles.di.camAxe);
end;


%% activity plot
actiW = 180; actiH = 180;

if this.GUI.di.activityRunning && ~isempty(this.GUI.di.actiMovies);    
    % get the current frame
    activityFrame = this.GUI.di.actiMovies{this.GUI.di.actiMovieIndex}(:, :, :, this.GUI.di.actiMovieFrame);
    
    % update the frame
    this.GUI.di.actiMovieFrame = this.GUI.di.actiMovieFrame + 3;
    
    if this.GUI.di.actiMovieFrame > size(this.GUI.di.actiMovies{1}, 4); this.GUI.di.actiMovieFrame = 1; end;
else
    activityFrame = zeros(actiH, actiW, 3);
end;


% plot the frame
actiAxeChild = get(this.GUI.handles.di.actiAxe, 'Child');
if isempty(actiAxeChild);
    actiAxeChild = imagesc(activityFrame, 'Parent', this.GUI.handles.di.actiAxe);
    axis(this.GUI.handles.di.actiAxe, 'equal');
end;
set(actiAxeChild, 'CData', activityFrame);

% calculate zoom factors
actiWZoom = actiW / this.GUI.di.zoomLevel; actiHZoom = actiH / this.GUI.di.zoomLevel;
actiMargX = (actiW - actiWZoom) / 2; actiMargY = (actiH - actiHZoom) / 2;
xLims = [0, actiW - actiMargX]; yLims = [0, actiH - actiMargY];
set(this.GUI.handles.di.actiAxe, 'XLim', xLims, 'YLim', yLims);

%% reponse axe
% create the response rate rectangle
delete(get(this.GUI.handles.di.respRateAxe, 'Child'));
hold(this.GUI.handles.di.respRateAxe, 'on');
rectangle('Parent', this.GUI.handles.di.respRateAxe, 'FaceColor', 'blue', 'EdgeColor', 'black', 'Position', [0 0 min(abs(this.di.nResps + 0.1), 10) 1]);
% add the threshold
plot(this.GUI.handles.di.respRateAxe, ones(2, 1) * this.di.respRateThresh, [0 1], 'Color', 'red', 'LineWidth', 8);
hold(this.GUI.handles.di.respRateAxe, 'off');
set(this.GUI.handles.di.respRateAxe, 'XLim', [0, 10], 'YLim', [0 1], 'XTick', [], 'YTick', []);

% apply the decay
this.di.nResps = min(max((this.di.nResps - this.di.nRespsDecay) * 0.99, 0), 10 + 0.5);

%% time axe
% create the time rectangle
if this.di.waitingForResp;
    
    delete(get(this.GUI.handles.di.respTimeAxe, 'Child'));
    hold(this.GUI.handles.di.respTimeAxe, 'on');
    remTime = min(max(this.di.waitingTime - (nowUNIX - this.di.waitingStartTime), 0) + 0.001, this.di.waitingTime);
    rectangle('Parent', this.GUI.handles.di.respTimeAxe, 'FaceColor', 'green', 'EdgeColor', 'black', 'Position', [0 0 remTime 1]);
    hold(this.GUI.handles.di.respTimeAxe, 'off');
    set(this.GUI.handles.di.respTimeAxe, 'XLim', [0, this.di.waitingTime], 'YLim', [0 1], 'XTick', [], 'YTick', []);

    set(this.GUI.handles.di.panels.time, 'Title', sprintf('Response time - %.1f sec', remTime / 1000));

end;


% check if a response was given
if this.di.waitingForResp && this.di.nResps > this.di.respRateThresh;
    this.di.resp = true;
    this.di.waitingForResp = false;
    stimNum = this.di.stimMatrix(this.di.iTrial, this.di.iStimMat);
    isTarget = stimNum == this.di.targetStim;
    showMessage(this, sprintf('RESPONSE !! Trial %d: stimulus %d, target: %d, correct: %d...', this.di.iTrial, stimNum, isTarget, isTarget), 'yellow');
end;

if this.di.lockMouse;
    r = java.awt.Robot();
    lockCoords = this.GUI.pos(1:2) + this.GUI.pos(3:4) - [2 2];
    r.mouseMove(lockCoords(1), lockCoords(2));   
end;


catch err;
    errStack = getStackText(err);
    showWarning(this, 'OCIA:DIUpdateGUI', sprintf('Problem in the discriminator GUI update function: "%s".', err.message));
    o(errStack, 0, 0);
end
