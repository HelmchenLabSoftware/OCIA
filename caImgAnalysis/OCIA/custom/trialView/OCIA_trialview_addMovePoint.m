function this = OCIA_trialview_addMovePoint(this, varargin)
% OCIA_trialview_addMovePoint - Add a movement point
%
%       OCIA_trialview_addMovePoint(this)
%       OCIA_trialview_addMovePoint(this, 'updateGUI')
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get params and handles
params = this.tv.params;
tvH = this.GUI.handles.tv;

% reset elements in GUI
for iElem = 1 : numel(tvH.tc.moveVectElems);
    delete(tvH.tc.moveVectElems{iElem});
end;
tvH.tc.moveVectElems = {};

% if there is a no current trial number, abort
if isempty(this.tv.iTrial);
    showWarning(this, sprintf('OCIA:%s:NoCurrentTrial', mfilename()), ...
        'Could not place move vector label since there is no current trial number.');
    return;
end;

% target time point of clicking
targetT = []; 
% whether no point should be added but the only the GUI updated with current data points
onlyUpdateGUI = false;

% function call originated from axe click
if ~isempty(varargin) && numel(varargin) == 2;
    
    if (isa(varargin{1}, 'matlab.graphics.axis.Axes') || isa(varargin{1}, 'matlab.graphics.chart.primitive.Line') ...
                    || isa(varargin{1}, 'matlab.graphics.primitive.Patch') ...
                    || isa(varargin{1}, 'matlab.graphics.primitive.Text')) && isa(varargin{2}, 'matlab.graphics.eventdata.Hit');
        [~, event] = varargin{:};
        targetT = event.IntersectionPoint(1);

    % function call originated from axe drag (via figure "mouseMoved" event)
    elseif isa(varargin{1}, 'matlab.graphics.axis.Axes') ...
             && isa(varargin{2}, 'matlab.ui.eventdata.WindowMouseData');
        [sourceAxe, ~] = varargin{:};
        mousePos = get(sourceAxe, 'CurrentPoint');
        targetT = mousePos(1);

    % function call originated from line drag (via figure "mouseMoved" event)
    elseif (isa(varargin{1}, 'matlab.graphics.chart.primitive.Line') ...
                    || isa(varargin{1}, 'matlab.graphics.primitive.Patch') ...
                    || isa(varargin{1}, 'matlab.graphics.primitive.Text')) ...
             && isa(varargin{2}, 'matlab.ui.eventdata.WindowMouseData');
        [sourceLine, ~] = varargin{:};
        sourceAxe = get(sourceLine, 'Parent');
        mousePos = get(sourceAxe, 'CurrentPoint');
        targetT = mousePos(1);
    end;
    
% if a GUI update is requested
elseif numel(varargin) == 1 && ischar(varargin{1}) && strcmp(varargin{1}, 'updateGUI');
    onlyUpdateGUI = true;
    
end; % end of varargin check
 
% function call with a defined time point to move to
if ~isempty(targetT);
    % get boundaries
    minTValue = -params.WFTimeOffset + 1 / params.WFFrameRate;
    maxTValue = (params.WFDataSize(3) / params.WFFrameRate) - params.WFTimeOffset;
    % get clicked time point with boundaries
    tWF = min(max(targetT, minTValue), maxTValue);
    % figure out corresponding frame
    iFrame = round((tWF + params.WFTimeOffset - this.tv.trigDelay) * params.WFFrameRate);
    % aplly boundaries and store
    iFrame = min(max(round(iFrame), 1), params.WFDataSize(3));
    this.tv.iFrame = iFrame;
    
% function call without input arguments, use time based on the "iFrame" property
else
        
    % get current frame
    iFrame = min(max(round(this.tv.iFrame), 1), params.WFDataSize(3));
    % get corresponding time
    tWF = (iFrame / params.WFFrameRate) - params.WFTimeOffset + this.tv.trigDelay;
    iFrame = round((tWF + params.WFTimeOffset) * params.WFFrameRate);
    
end;

% if it's not only a GUI update that is requested
if ~onlyUpdateGUI;
    showMessage(this, sprintf('TrialView: movement at %.2f (frame %03d).', tWF, iFrame));

    % store move point
    this.tv.data.movePoints{this.tv.iTrial}(end + 1) = iFrame;
    % if we have a pair of points, insert in move vector
    nPoints = numel(this.tv.data.movePoints{this.tv.iTrial});
    if mod(nPoints, 2) == 0;
        % label move vector within selected last two points
        lastPoints = this.tv.data.movePoints{this.tv.iTrial}(end - 1 : end);
        lastTimes = (lastPoints / params.WFFrameRate) - params.WFTimeOffset - this.tv.trigDelay;
        this.tv.data.moveVects{this.tv.iTrial}(lastPoints(1) : lastPoints(2)) = 1;

        showMessage(this, sprintf('TrialView: movement labeled from %.2f to %.2f (frame %03d to %03d).', ...
            lastTimes, lastPoints));
    end;
end;

%% update GUI
% get axe names and handles
axeNames = fieldnames(tvH.tc);
axeNames(arrayfun(@(i)isempty(regexp(axeNames{i}, 'Axe$', 'once')), 1 : numel(axeNames))) = [];
axeHandles = arrayfun(@(i) tvH.tc.(axeNames{i}), 1 : numel(axeNames), 'UniformOutput', false);

% get points
movePoints = this.tv.data.movePoints{this.tv.iTrial};
% if there is something to plot (more than just one point)
if numel(movePoints) > 1;
    % if there is a not yet completed move period (first point present but last not yet labeled), remove last point
    if mod(numel(movePoints), 2) ~= 0; movePoints(end) = []; end;
    moveTimes = (movePoints / params.WFFrameRate) - params.WFTimeOffset; 
    for iMoveTime = 1 : 2 : numel(moveTimes);
        % draw a rectangle on each axe
        for iAxe = 1 : numel(axeHandles);
            axeH = axeHandles{iAxe}; if numel(axeH) > 1; axeH = axeH(1); end;
            hold(axeH, 'on');
            xData = [moveTimes(iMoveTime) moveTimes(iMoveTime + 1) moveTimes(iMoveTime + 1) moveTimes(iMoveTime)];
            yData = [-10000, -10000, 10000, 10000];
            tvH.tc.moveVectElems{end + 1} = patch('XData', xData, 'YData', yData, 'Parent', axeH, ...
                'FaceColor', [0 0 0], 'EdgeColor', 'none', 'FaceAlpha', 0.2);
            hold(axeH, 'off');
        end;
    end;
end;

% restore handles
this.GUI.handles.tv = tvH;

end
