function this = OCIA_trialview_loadWideFieldData(this, ~, ~)
% OCIA_trialview_loadWideFieldData - Load a widefield data file
%
%       OCIA_trialview_loadWideFieldData(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% check for number of rows selected: more than one row selected
nFiles = numel(this.tv.params.fileList);
if nFiles > 1;
%     showMessage(this, sprintf('TrialView: %d rows selected, switching to multi-row view ...', nFiles));
%     OCIA_trialview_loadWideFieldDataMultiRow(this);
    
    showWarning(this, sprintf('OCIA:%s:MultipleRowsSelected', mfilename()), 'Multiple rows selected ! Aborting.');
    return;

% check for number of rows selected: no rows selected
elseif nFiles < 1;
    % thrown warning and abort
    showWarning(this, sprintf('OCIA:%s:NoRowSelected', mfilename()), 'No rows selected ! Aborting.');
    return;
end;

% disable GUI and get params and handles
OCIAToggleGUIEnableState(this, 'TrialView', 'off');
params = this.tv.params;
tvH = this.GUI.handles.tv;

% get selected file name
selFileName = params.fileList{1};
params.WFFilePath = [params.WFDataPath, selFileName];
showMessage(this, sprintf('TrialView: loading "%s" ...', selFileName), 'yellow');
pause(0.05);

% load the data
wfMat = load(params.WFFilePath);
% figure out the variable name
varName = fieldnames(wfMat);
varNameOri = varName;
varName(arrayfun(@(i)isempty(regexp(varName{i}, '^tr|tr_ave|cond|CR|hit', 'once')), 1 : numel(varName))) = [];
% no variable name left after filtering
if isempty(varName);
    showWarning(this, sprintf('OCIA:%s:NoMatchingVariableName', mfilename()), ...
        sprintf('Could not find WF data variable name for file "%s", field name(s) available: "%s". Aborting.', ...
        regexprep(sprintf('%s, ', varNameOri{:}), ', $', '')));
    params.WFFilePath = '';
    
% too many variable names after filtering
elseif iscell(varName) && numel(varName) > 1;
    showWarning(this, sprintf('OCIA:%s:TooManyVariableNames', mfilename()), ...
        'Too many WF data variable name for file "%s": "%s". Using first one ("%s")', ...
        regexprep(sprintf('%s, ', varNameOri{:}), ', $', ''));
    params.WFFilePath = '';
    
% make sure variable name is a cell
elseif ~iscell(varName);
    varName = { varName };
    
end;

% if we have a valid data path
if ~isempty(params.WFFilePath);

    % extract data
    this.tv.data.wf = wfMat.(varName{1}) - 1;
    if all(params.WFSmoothDim > 0) && any(params.WFSmoothDim > 1);
        showMessage(this, sprintf('TrialView: smoothing "%s" ...', selFileName)); pause(0.01);
        this.tv.data.wf = smoothn(this.tv.data.wf, params.WFSmoothDim, 'Gauss');
    end;
    
    % display row name in GUI
    set(tvH.wf.panel, 'Title', sprintf('Wide-field - "%s"', selFileName));

    % extract size of the behavior movie
    params.WFDataSize = size(this.tv.data.wf);
    nFrames = params.WFDataSize(3);

    % get first frame and display it
    iFrame = 1;
    frame = this.tv.data.wf(:, :, iFrame);
    set(tvH.wf.img, 'CData', frame);
    set(tvH.wf.axe, 'XLim', [0.5, params.WFDataSize(1) - 0.5], ...
        'YLim', [0.5, params.WFDataSize(2) - 0.5]);
    % change colormap to mapgeog
    colormap(tvH.wf.axe, 'mapgeog');
    figH = gcf;
    if figH ~= this.GUI.figH && (isempty(get(figH, 'Children')) || isempty(get(get(figH, 'Children'), 'Children')));
        close(figH);
    end;

    %% figure out trial number
    % extract trial number from path
    trialHits = regexp(params.WFFilePath, '(?<stimOrCond>stim|cond)_?(?<cond>\w+)?_trial(?<iTrial>\d+)\.mat$', 'names');
    % no trial number found
    if isempty(trialHits);
        showWarning(this, sprintf('OCIA:%s:UnknownTrialNumber', mfilename()), sprintf( ...
            'Could not figure out the trial number for "%s". Alignment with behavior movie will not be possible.', ...
            selFileName));
            this.tv.iTrial = [];
            
    % trial number found
    else
        
        % trials are already sorted according to condition
        if strcmp(trialHits.stimOrCond, 'cond');            
            % trial number is not the real trial number but the sorted trial number for this condition
            iCondTrial = str2double(trialHits.iTrial);
            % extract condition
            condition = trialHits.cond;
            % find 'trials_ind.mat' file
            trialIndsPath = [this.tv.params.WFDataPath, 'trials_ind.mat'];
            
            % if the 'trials_ind.mat' file exists
            if exist(trialIndsPath, 'file');
                % load file and figure out field name to use depending on condition
                trialIndicesMat = load(trialIndsPath);
                fieldName = ['tr_', condition];
                % if the requested field exists
                if isfield(trialIndicesMat, fieldName);
                    % find out the real trial number
                    trialIndicesForCond = trialIndicesMat.(fieldName);
                    this.tv.iTrial = trialIndicesForCond(iCondTrial);
                    
                    % display informations in GUI
                    set(tvH.wf.panel, 'Title', sprintf('Wide-field - "%s" - Trial %03d', selFileName, this.tv.iTrial));
                    
                % requested field for condition does not exist
                else
                    showWarning(this, sprintf('OCIA:%s:FieldNameForConditionNotFound', mfilename()), sprintf( ...
                        ['Cannot find fieldname "%s" for "%s" (condition "%s"). ', ...
                        'Alignment with behavior movie will not be possible.'], fieldName, selFileName, condition));
                    this.tv.iTrial = [];
                    
                end;
                
            % the 'trials_ind.mat' file cannot be found
            else
                
                % if there is a behavior vector for response type
                if isfield(this.tv.data, 'behav') && isfield(this.tv.data.behav, 'respTypes');
                    condRespType = iff(strcmp(condition, 'hit'), 1, iff(strcmp(condition, 'CR'), 2, NaN));
                    if ~isnan(condRespType);
                        trialIndicesForCond = find(this.tv.data.behav.respTypes == condRespType);
                        this.tv.iTrial = trialIndicesForCond(iCondTrial);
                    
                        % display informations in GUI
                        set(tvH.wf.panel, 'Title', sprintf('Wide-field - "%s" - Trial %03d', selFileName, this.tv.iTrial));
                        
                    else
                        showWarning(this, sprintf('OCIA:%s:BadRespType', mfilename()), sprintf( ...
                            ['Bad response type (condition "%s", file "%s"). ', ...
                            'Alignment with behavior movie will not be possible.'], trialIndsPath, condition, selFileName));
                        this.tv.iTrial = [];
                    end;
                    
                else
                    showWarning(this, sprintf('OCIA:%s:TrialIndsFileNotFound', mfilename()), sprintf( ...
                        ['Cannot find "trials_ind.mat" file at "%s" (condition "%s", file "%s"). ', ...
                        'Alignment with behavior movie will not be possible.'], trialIndsPath, condition, selFileName));
                    this.tv.iTrial = [];
                end;
                
            end;
        
        % trials are unsorted
        elseif strcmp(trialHits.stimOrCond, 'stim');
            % trial number is actually the real trial number
            this.tv.iTrial = str2double(trialHits.iTrial);
    
            % display informations in GUI
            set(tvH.wf.panel, 'Title', sprintf('Wide-field - "%s" - Trial %03d', selFileName, this.tv.iTrial));
            
        end;
    
        % adjust time offsets
        if isfield(this.tv.data, 'behav') && isfield(this.tv.data.behav, 'times');
%             params.WFTimeOffset = this.tv.data.behav.times.sound(this.tv.iTrial);
            behavConfig = this.tv.data.behav.config;
            params.behavDelay = behavConfig.training.minRespTime - behavConfig.tone.stimDur;
        end;
        
    end;

    %% update display of ROI axe
    % display the time-series axis
    xLims = [0, nFrames] / params.WFFrameRate + [-0.25, 0.25] - round(params.WFTimeOffset);
    xTicks = (xLims(1) : xLims(2)) + 0.25;
    set(tvH.tc.whiskLickAxe, 'XLim', xLims, 'XTick', xTicks);
    set(tvH.tc.ROIAxe, 'YTick', [], 'YTickMode', 'auto', 'YTickLabelMode', 'auto');
    
    % get axe names and handles
    axeNames = fieldnames(tvH.tc);
    axeNames(arrayfun(@(i)isempty(regexp(axeNames{i}, 'Axe$', 'once')), 1 : numel(axeNames))) = [];
    axeHandles = arrayfun(@(i) tvH.tc.(axeNames{i}), 1 : numel(axeNames), 'UniformOutput', false);
    
    % delete previous timeline infos
    for iElem = 1 : numel(tvH.tc.timeLineInfoElems);
        try delete(tvH.tc.timeLineInfoElems{iElem}); catch; end;
    end;
    tvH.tc.timeLineInfoElems = {};
    
    % annotate the time axis with the trial timeline infos
    for iConfig = 1 : size(this.tv.params.TCTimeLineConfig);
        timeLineConfig = this.tv.params.TCTimeLineConfig(iConfig, :);
        [markerName, markerStart, markerStop, markerColor, markerType] = timeLineConfig{:};
        % transform parameters
        markerColor = str2double(regexp(markerColor, ',', 'split'));
        % evaluate marker times if they are commands
        if ischar(markerStart); try markerStart = eval(markerStart); catch, continue; end; end;
        if ischar(markerStop); try markerStop = eval(markerStop); catch, continue; end; end;
        
        % mark duration as box
        if strcmp(markerType, 'box');
            
            % draw a rectangle on each axe
            for iAxe = 1 : numel(axeHandles);
                axeH = axeHandles{iAxe}; if numel(axeH) > 1; axeH = axeH(1); end;
                hold(axeH, 'on');                
                xData = [markerStart, markerStop, markerStop, markerStart];
                yData = [-10000, -10000, 10000, 10000];
                tvH.tc.timeLineInfoElems{end + 1} = patch('XData', xData, 'YData', yData, 'Parent', axeH, ...
                    'FaceColor', markerColor, 'EdgeColor', 'none', 'FaceAlpha', 0.1, ...
                    'ButtonDownFcn', @(h, e) OCIA_trialview_changeFrame(this, h, e));                
                hold(axeH, 'off');
            end;
            
            % add label
            yLims = get(tvH.tc.whiskLickAxe(1), 'YLim');
            tvH.tc.timeLineInfoElems{end + 1} = text(markerStart + 0.4 * (markerStop - markerStart), ...
                yLims(1) + 0.1 * diff(yLims), markerName, 'FontSize', 10, 'VerticalAlignment', 'bottom', ...
                'HorizontalAlignment', 'left', 'Parent', tvH.tc.whiskLickAxe(1), ...
                'ButtonDownFcn', @(h, e) OCIA_trialview_changeFrame(this, h, e));
            
        % single line marker
        else
            
            % draw a line marker on each axe
            for iAxe = 1 : numel(axeHandles);
                axeH = axeHandles{iAxe}; if numel(axeH) > 1; axeH = axeH(1); end;
                hold(axeH, 'on');
                tvH.tc.timeLineInfoElems{end + 1} = plot(axeH, [markerStart, markerStart], ...
                    [-10000, 10000], 'Color', markerColor, 'LineStyle', markerType, ...
                    'ButtonDownFcn', @(h, e) OCIA_trialview_changeFrame(this, h, e));
                hold(axeH, 'off');
            end;
            
            % add label
            yLims = get(tvH.tc.whiskLickAxe(1), 'YLim');
            tvH.tc.timeLineInfoElems{end + 1} = text(markerStart, yLims(1) + 0.1 * diff(yLims), markerName, ...
                'FontSize', 10, 'VerticalAlignment', 'top', ...
                'HorizontalAlignment', 'left', 'rotation', 90, 'Parent', tvH.tc.whiskLickAxe(1), ...
                'ButtonDownFcn', @(h, e) OCIA_trialview_changeFrame(this, h, e));
            
        end;
    end;
    
    %% process trial-related informations
    % if a trial number is assigned for this file
    if ~isempty(this.tv.iTrial);
    
        % if move vectors/points does not exist yet for current trial
        if numel(this.tv.data.movePoints) < this.tv.iTrial;
            % init the move points storage and the move vector
            this.tv.data.movePoints{this.tv.iTrial} = [];
            this.tv.data.moveVects{this.tv.iTrial} = zeros(params.WFDataSize(3), 1);
        end;
        
        %% extract analog inputs (Balazs)
        lickData = [];
        tLickData = [];
        trigData = [];
        tTrigData = [];
        micrData = [];
        tMicrData = [];
        
        if isfield(this.tv.data, 'behav') && isfield(this.tv.data.behav, 'record');
            
            % extract analog inputs and sampling rate
            micrData = this.tv.data.behav.record.micr{this.tv.iTrial};
            trigData = this.tv.data.behav.record.trig{this.tv.iTrial};
            lickData = this.tv.data.behav.record.piezo{this.tv.iTrial};
            anInSampRate = this.tv.data.behav.anInSampRate;
            
            % flatten lick data
            lickData(lickData <= this.tv.data.behav.params.piezoThresh) = 0;
            
            % get sound time
            micrForTrial = linScale(abs(micrData'));
            soundYThresh = 0.09;
            upSamples = [0 find(micrForTrial > soundYThresh)];
            minSample = 3 * anInSampRate;
            soundStartInds = upSamples(find(upSamples >= minSample, 1));
            if isempty(soundStartInds);
                showWarning(this, sprintf('OCIA:%s:SoundStartNotFound', mfilename()), ...
                    'Cannot find sound start from analog input. Alignment with behavior movie will not be possible.');
                tSoundAI = 0;
            else
                tSoundAI = soundStartInds(1) / anInSampRate;
            end;
            
            % get trigger time
            normThresh = 0.05; % take the first frames for normalization threshold
            trigData(abs(trigData) < normThresh) = 0; % normalize to remove the noise of parts when there is no trigger
%             trigTop = find(abs(trigData(1 : round(numel(trigData) * 0.5))) > 0); % find all the peaks

%             % get the trigger delay
%             if isempty(trigTop);
%                 showWarning(this, sprintf('OCIA:%s:TriggerStartNotFound', mfilename()), ...
%                     'Cannot find trigger start from analog input. Alignment with behavior movie will not be possible.');
                this.tv.trigDelay = 0;
%             else
%                 this.tv.trigDelay = - (tSoundAI - (trigTop(1) / anInSampRate)) + params.WFTimeOffset;
%             end;
            
            % align everything to the sound from the AI
            tTrigData = (1 : numel(trigData)) / anInSampRate - tSoundAI;
            tMicrData = (1 : numel(micrData)) / anInSampRate - tSoundAI;
            tLickData = (1 : numel(lickData)) / anInSampRate - tSoundAI;
            
            % make data displayable
            micrData = linScale(sgolayfilt(abs(micrData), 1, 3), params.TCYLimLick .* [1 0.9]);
            trigData = linScale(abs(trigData), params.TCYLimLick .* [1 0.9]);
            
            % debug plot
            debugPlot = false;
%             debugPlot = true;
            if debugPlot;
                timeOffsetTS = - this.tv.data.behav.times.sound(this.tv.iTrial); %#ok<UNRCH>
                tLightCue = this.tv.data.behav.times.trialStartCue(this.tv.iTrial) + timeOffsetTS;
                tImgStartCue = this.tv.data.behav.times.imgStart(this.tv.iTrial) + timeOffsetTS;
                tRespMin = this.tv.data.behav.times.respMin(this.tv.iTrial) + timeOffsetTS;
                tRespTime = this.tv.data.behav.times.respTime(this.tv.iTrial) + timeOffsetTS;
                tRewTime = this.tv.data.behav.times.rewTime(this.tv.iTrial) + timeOffsetTS;
            
                figure('NumberTitle', 'off', 'Name', sprintf('Analog inputs for trial %03d', this.tv.iTrial), ...
                    'Position', [100 100 1700 990]);
                hold on;
                plot(tTrigData, trigData, 'b');
                plot(tLickData, lickData * 10, 'r');
                plot(tMicrData, micrData * 2, 'g');
                plot([tLightCue, tLightCue], [-1 1], 'green', 'LineStyle', ':', 'LineWidth', 2);
                plot([tImgStartCue, tImgStartCue], [-1 1], 'blue', 'LineStyle', ':', 'LineWidth', 2);
                plot([tRespMin, tRespMin], [-1 1], 'red', 'LineStyle', ':', 'LineWidth', 2);
                plot([tRespTime, tRespTime], [-1 1], 'magenta', 'LineStyle', ':', 'LineWidth', 2);
                plot([tRewTime, tRewTime], [-1 1], 'cyan', 'LineStyle', ':', 'LineWidth', 2);
                hold off;
                ylim([-1 1]);
                legend('trig', 'lick', 'micr', 'lightCue', 'imgStartCue', 'respMin', 'respTime', 'rewTime');
                
            end;
            
        end;
    
        %% extract relevant licking data
        % lick data stored in behavior data
        if isfield(this.tv.data, 'lick');
            
            % figure out if current condition is go or nogo
            trialType = lower(regexprep(this.tv.data.behav(this.tv.iTrial).decision, ' ', ''));
            
            % extract lick data
            lickData = this.tv.data.lick.(['licks_', trialType])(:, iCondTrial);
            lickData = abs(lickData - min(lickData));
            tLickData = this.tv.data.lick.x;

        end;

        % update lick trace
        set(tvH.tc.lickTrace, 'Color', 'red', 'XData', tLickData, 'YData', lickData);
        set(tvH.tc.micrTrace, 'Color', 'green', 'XData', tMicrData, 'YData', micrData);
        set(tvH.tc.trigTrace, 'Color', 'blue', 'XData', tTrigData, 'YData', trigData);
        set(tvH.tc.whiskLickAxe, 'YTick', [], 'YTickMode', 'auto', 'YTickLabelMode', 'auto');
        
        %% extract relevant whisking data
        whiskData = [];
        tWhiskData = [];
        
        % whisk data stored in data as envelope
        if isfield(this.tv.data, 'whisk') && isfield(this.tv.data.whisk, 'whisk_env');
            % extract whisk data
            whiskData = this.tv.data.whisk.whisk_env(:, this.tv.iTrial);
            whiskData = abs(whiskData - min(whiskData));
            tWhiskData = this.tv.data.whisk.x_env;
            
        % whisk data stored in data as raw
        elseif isfield(this.tv.data, 'whisk') && isfield(this.tv.data.whisk, 'whiskAngle');
            % extract whisk data
            whiskData = this.tv.data.whisk.whiskAngle(:, this.tv.iTrial);
            whiskData = abs(whiskData - min(whiskData));
            tWhiskData = (1 : numel(whiskData)) / 200 - params.WFTimeOffset;

        end;

        % update whisk trace
        set(tvH.tc.whiskTrace, 'Color', 'black', 'XData', tWhiskData, 'YData', whiskData);    
    
        %% extract relevant behavior movie part
        if ~isempty(this.tv.trialZeroTimes);
            % figure out current behavior time for first and last frame of wide-field
            currentTrialZeroTime = this.tv.trialZeroTimes(this.tv.iTrial);
            WFStartTime = 1 / params.WFFrameRate;
            WFEndTime = params.WFDataSize(3) / params.WFFrameRate;
            behaviorStartTime = currentTrialZeroTime + WFStartTime - params.WFTimeOffset + params.behavTimeOffset;
            behaviorEndTime = currentTrialZeroTime + WFEndTime - params.WFTimeOffset + params.behavTimeOffset;
            % apply boundaries
            behaviorStartTime = min(max(behaviorStartTime, 1 / params.behavFrameRate), this.tv.VRHBehav.Duration);
            behaviorEndTime = min(max(behaviorEndTime, 1 / params.behavFrameRate), this.tv.VRHBehav.Duration);
            % calculate approximate number of frames
            nFrames = ceil(ceil(behaviorEndTime - behaviorStartTime) * params.behavFrameRate);

            showMessage(this, sprintf('TrialView: extracting behavior movie associated with "%s" ...', selFileName), 'yellow');
            pause(0.01);

            % create a larger storage than needed
            this.tv.data.behavMovie = nan(params.behavMovieSize(2), params.behavMovieSize(1), nFrames);
            % adjust time for frame rate difference
            realTime = behaviorStartTime * (this.tv.VRHBehav.FrameRate / params.behavFrameRate);
            showMessage(this, sprintf('TrialView: stim time: %.2f, real stim time: %.2f ...', ...
                behaviorStartTime + params.WFTimeOffset, realTime + params.WFTimeOffset), 'yellow');
            this.tv.VRHBehav.CurrentTime = realTime;
            loadText = sprintf('Loaded frame %03d / %03d', 0, nFrames);
            fprintf('TrialView: %s\n', loadText);
            tvH.behav.loadText = text(params.behavMovieSize(1) * 0.5, params.behavMovieSize(2) * 0.5, loadText, ...
                'BackgroundColor', 'white', 'FontSize', this.GUI.pos(3) / 50, 'HorizontalAlignment', 'center', ...
                'VerticalAlignment', 'middle', 'Parent', tvH.behav.axe);
            pause(0.01);
            for iFrame = 1 : nFrames;
                this.tv.data.behavMovie(:, :, iFrame) = nanmean(this.tv.VRHBehav.readFrame(), 3);
                for iRound = 1 : params.behavPseudoFlatFieldRounds;
                    this.tv.data.behavMovie(:, :, iFrame) = PseudoFlatfieldCorrect(this.tv.data.behavMovie(:, :, iFrame));
                end;
                loadText = sprintf('Loaded frame %03d / %03d', iFrame, nFrames);
                fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\bTrialView: %s\n', loadText);
                if mod(iFrame, 10) == 0;
                    set(tvH.behav.loadText, 'String', loadText);
                    pause(0.01);
                end;
            end;
            delete(tvH.behav.loadText);

            % set current frame to the first from behavior
            this.tv.behavFrame = 1;
            this.tv.behavStartTime = behaviorStartTime;
        end;
    end; % end of trial check
    
end; % valid WFFilePath

%% restore GUI
% restore handles
this.GUI.handles.tv = tvH;
% restore params and then restore & enable GUI
this.tv.params = params;

%% update GUI
% if we have a valid data path
if ~isempty(params.WFFilePath);
    showMessage(this, sprintf('TrialView: loaded "%s"', selFileName));
    
    % set frame back to 1 and update GUI
    this.tv.iFrame = 1;
    OCIA_trialview_changeFrame(this);
    
    % update time course
    OCIA_trialview_updateTimeCourse(this);
        
    % update GUI
    OCIA_trialview_addMovePoint(this, 'updateGUI');

end;

% create config parameter panel
OCIACreateParamPanelControls(this, 'tv');

% if they are still valid, store the enable/disable state of the navigating buttons
if isfield(this.GUI.handles.tv, 'prevParams') && ishandle(this.GUI.handles.tv.prevParams);
    prevEnableState = get(this.GUI.handles.tv.prevParams, 'Enable');
    nextEnableState = get(this.GUI.handles.tv.nextParams, 'Enable');
end;

% enable the TrialView panel's GUI
OCIAToggleGUIEnableState(this, 'TrialView', 1);
% if they are still valid, set back the enable/disable state of the navigating buttons
if isfield(this.GUI.handles.tv, 'prevParams') && ishandle(this.GUI.handles.tv.prevParams);
    set(this.GUI.handles.tv.prevParams, 'Enable', prevEnableState);
    set(this.GUI.handles.tv.nextParams, 'Enable', nextEnableState);
end;


end
