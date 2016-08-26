function BEUpdateGUI(this, ~, ~)
% BEUpdateGUI - [no description]
%
%       BEUpdateGUI(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

tic;
% o('#%s: ...', mfilename(), 1, this.verb);

% capture display errors
try
    
G = this.GUI.be;
H = this.GUI.handles.be;
B = this.be;

% % update mean
% if ~isempty(this.be.procAnInData) && isfield(this.be.procAnInData, 'piezo');
%     this.be.params.piezoBLMed = nanmean(this.be.procAnInData.piezo);
%     set(H.piezoBLMedLab, 'String', sprintf('Med = %0.8f', this.be.params.piezoBLMed));
% end;

%% update experiment table
% if there is an experiment table, update data
if ishandle(H.expTable);

    % if experiment is running, get trial info for previous/current/next trials
    if B.isRunning;

        % get trial infos
        stateData(:, 1) = BEGetTrialInfo(this, B.iTrial - 1);
        stateData(:, 2) = BEGetTrialInfo(this, B.iTrial);
        stateData(:, 3) = BEGetTrialInfo(this, B.iTrial + 1);

    % experiment is not running
    else

        % if there is a config loaded, show the first trial's data
        if isfield(B, 'configLoaded') && B.configLoaded && B.iTrial == 0;
            stateData(:, 3) = BEGetTrialInfo(this, 1);

        % otherwise show nothing
        else
            stateData(:, 3) = BEGetTrialInfo(this, 0);
        end;

    end;

    % store data
    set(H.expTable, 'Data', stateData);

end;
    

%% update monitoring plot
if ~isfield(B, 'hw') || ~isfield(B.hw, 'connected') || ~B.hw.connected;
    % nothing to update, abort
    return;
end;

yLims = G.monPlotLimits;
xLims = [-0.2 B.hw.maxRecDur + 0.2];
axeH = H.monAxes;
    
handles = [];

% handle exist and is valid
if ishandle(axeH);
    axeChilds = get(axeH, 'Children');
%     hLeg = legend(axeH);
    
    % delete previous elements
    delete(axeChilds);
    
% no handle, no update
else
    return;
    
end;

% set axis limits
xlim(axeH, xLims);
ylim(axeH, yLims);

% no data, no update
if ~isfield(B, 'anInData');
    return;
end;


%% time windows
iTrial = B.iTrial;
if ~isempty(B.config) && (isempty(iTrial) || iTrial < 0 || iTrial > B.config.training.nTrials);
    iTrial = 0;
end;

% if we have a trial
if iTrial;
    
    timesWindowsToShow = {
...     label           tStart          tEnd/dur        tStartOrDur?    yPos    height  color
        'respWindow',   'respMin',      'respMax',      1,              0.02,   0.04,   'red';
        'rewColl',      'rewCollStart', 'rewCollEnd',   1,              0.06,   0.08,   'blue';
%         'sound',        'sound',        'soundDur',     0,              0.02,   0.04,   'green';
%         'light',        'lightCueOn',   'lightCueOff',  1,              0.08,   0.12,   'yellow';
%         'light',        'spoutIn',      'spoutOut',     1,              0.08,   0.12,   'magenta';
    };
    
    for iWindow = 1 : size(timesWindowsToShow, 1);
        [label, tStart, tEndOrDur, isTEndOrDur, yPosOffset, hOffset, col] = timesWindowsToShow{iWindow, :};
        if ~isfield(B.times, tStart); continue; end;
        x = B.times.(tStart)(iTrial);
        if isnan(x); continue; end;
        w = B.times.(tEndOrDur)(iTrial) - iff(isTEndOrDur, x, 0);
        y = yLims(1) + yPosOffset;
        h = yLims(2) - y - hOffset;
        if w <= 0; continue; end;
        rectangle('Parent', H.monAxes, 'Position', [x y w h], 'FaceColor', 'none', ...
            'EdgeColor', col, 'LineWidth', 2);
        text(x + 0.5 * w, y + (0.92 + mod(iWindow - 1, 3) * 0.05) * h , label, 'HorizontalAlignment', 'center', ...
            'Parent', axeH, 'FontSize', 6, 'Color', col);
    end;
end;

%% analog input data
hold(axeH, 'on');
nAnIn = numel(B.hw.analogIns);

tDiff = 0;
% if we have a trial
if iTrial && ~isnan(B.times.start(iTrial)) && ~isnan(B.times.init(iTrial));    
    tDiff = B.times.start(iTrial) - B.times.init(iTrial);
    xLims = [-0.2 - tDiff B.hw.maxRecDur + 0.2];
end;

for iAnIn = 1 : nAnIn;
    anInName = B.hw.analogIns{iAnIn};
    if isfield(B.procAnInData, anInName);
        procAnInData = B.procAnInData.(anInName);
        % get the number of samples and check if there are any samples to plot
        B.nSamples = size(procAnInData, 1);
%         o('#%s: nSamples: %d ~= %.3f sec', mfilename(), B.nSamples, B.nSamples / B.hw.anInSampRate, 2, this.verb);
        if B.nSamples;
            % plot the data
            t = (0 : (numel(procAnInData) - 1)) / B.hw.anInSampRate;
            handles(end + 1) = plot(axeH, t - tDiff, procAnInData * G.anInMagnifs(iAnIn) + G.anInOffset(iAnIn), ...
                G.anInColors{iAnIn}); %#ok<AGROW>

        end;
    end;
end;

%% piezo threshold
if isfield(B.params, 'piezoThresh');
    iPiezo = find(strcmp(B.hw.analogIns, 'piezo'));
    if ~isempty(iPiezo);
        thresh = repmat(B.params.piezoThresh, 1, 2) * G.anInMagnifs(iPiezo) + G.anInOffset(iPiezo);
        plot(axeH, xLims, thresh, [G.anInColors{iPiezo}, ':']);
    end;
end;

%% time marker lines
% if we have a trial
if iTrial;
    
    timesToShow = struct('vidStartTCPTrig', 'g:', 'imgStart', 'b--', 'trialStartCue', 'm:', 'lightCueOn', 'm:', ...
        'startDelay', 'k:', ... 'sound', 'g:', 'respWaitRealStart', 'k:', 'lightIn', 'm:', 'lightOut', 'm:', 
        'rewTime', 'b--', 'respTime', 'r:', ... % 'spoutIn', 'm--', 'spoutOut', 'm--', 
        'imgStopObs', 'b--', ... 'lightCueOff', 'm:', 
        'endPunish', 'k--', 'end', 'k-', 'vidEndTCPTrig', 'g:');
    
    if isfield(this.GUI.handles.be, 'vidRecEnableOn') && ~get(H.vidRecEnableOn, 'Value');
        timesToShow = rmfield(timesToShow, { 'vidStartTCPTrig', 'vidEndTCPTrig' });
    end;
    
    tNames = fieldnames(timesToShow);
    
    for iTime = 1 : numel(tNames);
        tName = tNames{iTime};
        col = timesToShow.(tName);
        if regexp(tName, '__plus__');
            nameParts = regexp(tName, '__plus__', 'split');
            tName = nameParts{1};
            t = 0;
            for iPart = 1 : numel(nameParts);
                if isfield(B.times, nameParts{iPart});
                    t = t + B.times.(nameParts{iPart})(iTrial);
                end;
            end;
            if t == 0;
                t = NaN;
            end;
        else
            if isfield(B.times, tName);
                t = B.times.(tName)(iTrial);
            else
                t = NaN;
            end;
        end;
        o('%s: %.3f', tName, t, 4, this.verb);
        if isnan(t) || ~t; continue; end;
        plot(axeH, repmat(t, 2, 1), yLims, col);
        text(t, yLims(2) * (1.05 + 0.065 * mod(iTime - 1, 4)), tName, 'Parent', axeH, 'FontSize', 6, ...
            'HorizontalAlignment', 'center', 'Color', col(1));
    end;
    
%     plot(axeH, zeros(2, 1) - tDiff, yLims, 'k-');
%     text(-tDiff, yLims(2) * (1.05 + 0.065 * 0), 'init', 'Parent', axeH, 'FontSize', 6, ...
%         'HorizontalAlignment', 'center', 'Color', 'k');
    
%     plot(axeH, zeros(2, 1), yLims, 'k-');
%     text(0, yLims(2) * (1.05 + 0.065 * 2), 'start', 'Parent', axeH, 'FontSize', 6, ...
%         'HorizontalAlignment', 'center', 'Color', 'k');
    
end;

% adjust axe limits
xlim(axeH, xLims);
ylim(axeH, yLims);


catch err;
    errStack = getStackText(err);
    showWarning(this, 'OCIA:BEUpdateGUI:UnknownError', ...
        sprintf('Problem in the behavior GUI update function: "%s".', err.message));
    o(errStack, 0, 0);
end

% update the update time
this.GUI.be.GUILastUpdateTime = nowUNIXSec();

o('#%s: plot time: %03.0f msec', mfilename(), round(toc * 1000), 5, this.verb);
