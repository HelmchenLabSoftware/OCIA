function this = OCIA_trialview_changeFrame(this, varargin)
% OCIA_trialview_changeFrame - Change frame and update GUI accordingly
%
%       OCIA_trialview_changeFrame(this, handle, event)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get params and handles
params = this.tv.params;
tvH = this.GUI.handles.tv;

% get axe names and handles
axeNames = fieldnames(tvH.tc);
axeNames(arrayfun(@(i)isempty(regexp(axeNames{i}, 'Axe$', 'once')), 1 : numel(axeNames))) = [];
axeHandles = arrayfun(@(i) tvH.tc.(axeNames{i}), 1 : numel(axeNames), 'UniformOutput', false);

% function call originated from axe click
targetT = [];
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
        [sourceObj, ~] = varargin{:};
        sourceAxe = get(sourceObj, 'Parent');
        mousePos = get(sourceAxe, 'CurrentPoint');
        targetT = mousePos(1);
        
    end;
    
% function call from timer
elseif ~isempty(varargin) && numel(varargin) == 1 && ischar(varargin{1}) && strcmp(varargin{1}, 'timer');
    
    % update frame number
    this.tv.iFrame = this.tv.iFrame + 1;
    % reset if arrived to the end
    if this.tv.iFrame > params.WFDataSize(3);
        this.tv.iFrame = 1;
    end;
    
% no input argument (not from timer) but autoplay should be turned on and it's not yet
elseif strcmp(params.WFAutoplay, 'on') && strcmp(this.GUI.tv.autoplayTimer.Running, 'off');
    % update period
    set(this.GUI.tv.autoplayTimer, 'Period', 1 / (this.tv.params.WFAutoplaySpeedFactor * this.tv.params.WFFrameRate));
    start(this.GUI.tv.autoplayTimer);
    
% no input argument (not from timer) and autoplay should be turned off and it's not yet
elseif strcmp(params.WFAutoplay, 'off') &&  strcmp(this.GUI.tv.autoplayTimer.Running, 'on');
    stop(this.GUI.tv.autoplayTimer);
    
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
    
end;

% update Y limits
set(tvH.tc.ROIAxe, 'YLim', params.TCYLimROI);
set(tvH.tc.whiskLickAxe(1), 'YLim', params.TCYLimWhisk);
set(tvH.tc.whiskLickAxe(2), 'YLim', params.TCYLimLick);

% update the time bars
for iBar = 1 : numel(tvH.tc.timeBar);
    axeH = axeHandles{iBar}; if numel(axeH) > 1; axeH = axeH(1); end;
    set(tvH.tc.timeBar(iBar), 'XData', [tWF, tWF], 'YData', get(axeH, 'YLim'));
end;

% if only a single row is displayed
if ndims(this.tv.data.wf) < 4;
    % if reference should be shown
    if ~isempty(this.tv.params.showRef) && this.tv.params.showRef && isfield(this.tv.data, 'refImg');
        set(tvH.wf.img, 'CData', this.tv.data.refImg);
        % set display parameters
        set(tvH.wf.axe, 'CLim', this.tv.params.WFCLim);
        colormap(tvH.wf.axe, 'gray');
        figH = gcf;
        if figH ~= this.GUI.figH && (isempty(get(figH, 'Children')) || isempty(get(get(figH, 'Children'), 'Children')));
            close(figH);
        end;
        
    else
        % update the displayed WF frame
        WFFrame = this.tv.data.wf(:, :, iFrame);
        set(tvH.wf.img, 'CData', WFFrame);
        % set display parameters
        set(tvH.wf.axe, 'CLim', this.tv.params.WFCLim);
        colormap(tvH.wf.axe, 'mapgeog');
        figH = gcf;
        if figH ~= this.GUI.figH && (isempty(get(figH, 'Children')) || isempty(get(get(figH, 'Children'), 'Children')));
            close(figH);
        end;
        
    end;

% multiple rows displayed
elseif ndims(this.tv.data.wf) == 4;
    showWarning(this, sprintf('OCIA:%s:MultipleRowsNotImplemented', mfilename()), ...
        'Multiple row display not implemented ...');
    
end;
    
% if a trial number is defined, align current wide-field frame with behavior
if ~isempty(this.tv.iTrial) && isfield(this.tv.data, 'behavMovie');
    
    % figure out current behavior time and frame
    currentTrialTime = tWF + params.WFTimeOffset;
    this.tv.behavFrame = round(currentTrialTime * params.behavFrameRate);
    % apply boundaries
    this.tv.behavFrame = min(max(this.tv.behavFrame, 1), size(this.tv.data.behavMovie, 3));
    behavTime = this.tv.behavStartTime + this.tv.behavFrame / params.behavFrameRate;

    % update the displayed behavior frame
    set(this.GUI.handles.tv.behav.img, 'CData', this.tv.data.behavMovie(:, :, this.tv.behavFrame));
    
    % display time and frame in GUI
    set(tvH.tc.panel, 'Title', sprintf('Time course - T(WF) = %.2f (frame %03d) | T(behav) = %.2f (frame %03d)', ...
        tWF, iFrame, behavTime, this.tv.behavFrame));
    
% no behavior movie information
else
    % display time and frame in GUI
    set(tvH.tc.panel, 'Title', sprintf('Time course - T = %.2f (frame %03d)', tWF, iFrame));
    
end;

end
