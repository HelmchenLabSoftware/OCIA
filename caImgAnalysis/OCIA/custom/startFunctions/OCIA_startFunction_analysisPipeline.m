function OCIA_startFunction_analysisPipeline(this)
% OCIA_startFunction_analysisPipeline - [no description]
%
%       OCIA_startFunction_analysisPipeline(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% load data and swtich to analyser mode
% OCIA_startFunction_loadDataAndOpenAnalyser(this);
OCIA_startFunction_loadDataAndOpenAnalyserFromGUI(this);

%% start analysis pipeline    
% remove PNG saving warning
warning('off', 'MATLAB:LargeImage');

% get the DataWatcher's and the Analyser's GUI handle
dwh = this.GUI.handles.dw;
anh = this.GUI.handles.an;

% shorten the name
plotAndSave = @OCIA_analysis_updatePlotAndSave;
setIfExists = @OCIA_analysis_setIfExists;

% plot to save configuration
doPlotCaTraces = false;
doPlotCaTracesHeatMap = false;
doPlotPSCaTracesHeatMap = false;
doPlotSingleROIAverage = false;
doPlotGroupROIAverage = -1; % 0 or less to inactivate
% doPlotGroupROIAverage = 6; % 0 or less to inactivate

doPlotSingleROIAllPhasesAverage = false;
doPlotPooledAnalysis = true;
doPlotAllCaTraces = false;

% get the currently analysed data's IDs
animID = this.dw.animalIDs{get(dwh.filt.animalID, 'Value')};
shortAnimID = regexprep(regexprep(animID, 'mou_bl_', ''), '_', '');
spotID = this.dw.spotIDs{get(dwh.filt.spotID, 'Value')};

% abort if no rows loaded
if ~isfield(anh, 'paramPanElems'); return; end;


% get all the unique days and go through them
days = unique(get(this, this.an.selectedTableRows, 'day'));

% only do the day-base analysis if requested
if doPlotCaTraces || doPlotCaTracesHeatMap || doPlotPSCaTracesHeatMap || doPlotSingleROIAverage ...
        || doPlotGroupROIAverage > 0;

    %% day loop
    for iDay = 1 : numel(days);

        % select all rows for the current day
        rowsForDay = find(strcmp(get(this, this.an.selectedTableRows, 'day'), days{iDay}));
        set(anh.rowList, 'Value', rowsForDay);

        % get the relevant ROI names
        setIfExists(this, 'selROINames', 'Value', 1);
        ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;
        uniqueROINames = get(anh.paramPanElems.selROINames, 'String');
        
        set(anh.plotList, 'Value', 1); % select the calcium traces plot

%       %% mask loop
        % go through the saving once with and once without the mask
%         for iMask = 1 : 2;
%         for iMask = 1;
        iMask = 1;

            %% general plotting params
            setIfExists(this, 'sgFiltFrameSize', 'String', 15);
            setIfExists(this, 'exclFrames', 'Value', iMask, iff(iMask == 1, 'show', 'mask'));
            setIfExists(this, 'PSPer', 'String', ['{ all, [-2], [0], [0], [2]; on, [-2], [0], [0], [0.5]; ', ...
                'off, [-2], [0], [0.5], [1]; late, [-2], [0], [1], [2]; }'], ...
                {'all', -2, 0, 0, 2; 'on', -2, 0, 0, 0.5; 'off', -2, 0, 0.5, 1; ...
                    'late', -2, 0, 1, 2});

            % get the save path
            currentDaySavePath = sprintf('%s%s_%s/%s_%s_%s_', this.path.OCIASave, shortAnimID, spotID, ...
                shortAnimID, spotID, regexprep(days{iDay}, '_', ''));

            %% caTraces plot
            set(anh.plotList, 'Value', 1); % select the calcium traces plot
            setIfExists(this, 'selROINames', 'Value', 1 : numel(uniqueROINames)); % all ROIs
            setIfExists(this, 'noisyTrialsThresh', 'String', 'Inf'); % no trials/ROIs excluded
            setIfExists(this, 'selStimTypeGroups', 'Value', 1, []);
            % update the plot to get the stimulus types
            ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;
            stimIDs = get(anh.paramPanElems.selStimIDs, 'String');
            setIfExists(this, 'selStimIDs', 'Value', 1 : numel(stimIDs));
            plotAndSave(this, sprintf('%scaTracesOverview_time', currentDaySavePath), iMask, doPlotCaTraces);
            
            setIfExists(this, 'selStimTypeGroups', 'Value', 1 : 2, []);
            % update the plot to get the stimulus types
            ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;
            stimIDs = get(anh.paramPanElems.selStimIDs, 'String');
            setIfExists(this, 'selStimIDs', 'Value', ...
                find(ismember(stimIDs, {'sound_high', 'sound_low'}))); %#ok<FNDSB>
            anh = plotAndSave(this, sprintf('%scaTracesOverview_sound', currentDaySavePath), iMask, doPlotCaTraces);

            % get ROIs valid for the current day
            ROIsForDay = get(anh.paramPanElems.selROINames, 'Value');
            nROIs = numel(ROIsForDay);

            %% caTraces heat map plot
            if doPlotCaTracesHeatMap;
                set(anh.plotList, 'Value', 2); % select the calcium traces heat map plot
                setIfExists(this, 'sgFiltFrameSize', 'String', 75);
                setIfExists(this, 'colormap', 'Value', 1, 'gray');
                anh = plotAndSave(this, sprintf('%scaTracesOverview_HeatMap', currentDaySavePath), iMask, ...
                    doPlotCaTracesHeatMap);
                setIfExists(this, 'sgFiltFrameSize', 'String', 15);
            end;

            %% PS-average plots for different stimulus combinations
            % get all stimulus types and go through them
            stimTypes = get(anh.paramPanElems.selStimTypeGroups, 'String');
            
            %% PS-average heat map all ROIs
            set(anh.plotList, 'Value', 4); % select the peri-stimulus average heat map plot
            setIfExists(this, 'selROINames', 'Value', 1 : numel(uniqueROINames), []);
            setIfExists(this, 'selStimTypeGroups', 'Value', [1 3 4], []);
            % update the plot to get the stimulus types
            ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;
            
            % get all stimulus ID combinations
            stimIDs = get(anh.paramPanElems.selStimIDs, 'String');
            
            % request different combinations depending on what stimulus are available:
            % no target sound
            if numel(stimIDs) == 1 && strcmp(stimIDs{1}, 'sound_targ_noResp');
                stimTypeGroupNames = { 'time', 'timeCloud' };
                stimTypeGroups = { { 'time' }, { 'time', 'cloud' } };
                stimIDsGroups = { 'all', 'all' };
              
            % target only
            elseif all(cellfun(@(cont)isempty(regexp(cont, 'distr', 'once')), stimIDs));
                stimTypeGroupNames = { 'time', 'soundTargResp', 'lightTargResp', 'lickTargResp' };
                stimTypeGroups = { { 'time' }, { 'time', 'targ', 'resp' }, { 'time', 'targ', 'resp' }, ...
                    { 'time', 'targ', 'resp' } };
                stimIDsGroups = { 'all', ...
                    { 'sound_distr_resp', 'sound_distr_noResp', 'sound_targ_noResp', 'sound_targ_resp' }, ...
                    { 'light_distr_resp', 'light_distr_noResp', 'light_targ_noResp', 'light_targ_resp' }, ...
                    { 'lick_distr_resp', 'lick_distr_noResp', 'lick_targ_noResp', 'lick_targ_resp' }, ...
                };
                
            % full behavior
            else
                stimTypeGroupNames = { 'time', 'soundTargResp', 'lightTargResp', 'lickTargResp' };
                stimTypeGroups = { { 'time' }, { 'time', 'targ', 'resp' }, { 'time', 'targ', 'resp' }, ...
                    { 'time', 'targ', 'resp' } };
                stimIDsGroups = { 'all', ...
                    { 'sound_distr_resp', 'sound_distr_noResp', 'sound_targ_noResp', 'sound_targ_resp' }, ...
                    { 'light_distr_resp', 'light_distr_noResp', 'light_targ_noResp', 'light_targ_resp' }, ...
                    { 'lick_distr_resp', 'lick_distr_noResp', 'lick_targ_noResp', 'lick_targ_resp' }, ...
                };
                
            end;
            
            % go through each stimulus type group
            for iStimTypeGroup = 1 : numel(stimTypeGroups);

                %% PS-average heat map all ROIs
                set(anh.plotList, 'Value', 4); % select the peri-stimulus average heat map plot
                setIfExists(this, 'sortMethod', 'Value', 5, 'max_evoked');
                setIfExists(this, 'selROINames', 'Value', 1 : numel(uniqueROINames), []);
                setIfExists(this, 'selStimTypeGroups', 'Value', ...
                    find(ismember(stimTypes, stimTypeGroups{iStimTypeGroup}))); %#ok<FNDSB>

                % update the plot to get the stimulus types for sorting
                ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;

                if ~isfield(anh.paramPanElems, 'sortStim'); continue; end;

                stimIDs = get(anh.paramPanElems.selStimIDs, 'String');
                if ~iscell(stimIDsGroups{iStimTypeGroup}) && ischar(stimIDsGroups{iStimTypeGroup}) ...
                    && strcmp(stimIDsGroups{iStimTypeGroup}, 'all');
                    setIfExists(this, 'selStimIDs', 'Value', 1 : numel(stimIDs), []);
                    
                else
                    setIfExists(this, 'selStimIDs', 'Value', ...
                        find(ismember(stimIDs, stimIDsGroups{iStimTypeGroup})), []); %#ok<FNDSB>
                end;
                setIfExists(this, 'sortMethod', 'Value', 5, 'max_evoked');
                sortStims = get(anh.paramPanElems.sortStim, 'String');
                sortStims = OCIA_analysis_renameStimIDs(sortStims);
                setIfExists(this, 'sortStim', 'Value', 1, []);
                setIfExists(this, 'combineROIs', 'Value', 1, 'true');

                % update and save the PS-average heat map
                currGroupName = stimTypeGroupNames{iStimTypeGroup};
                setIfExists(this, 'colormap', 'Value', 4, 'red_white_blue');
                plotAndSave(this, sprintf('%sPSAAvg_HeatMap_%s_sortedMaxEvokedAscBy_%s_RWB', currentDaySavePath, ...
                    currGroupName, regexprep(sortStims{1}, ' ', '_')), iMask, doPlotPSCaTracesHeatMap);
                setIfExists(this, 'colormap', 'Value', 1, 'gray');
                anh = plotAndSave(this, sprintf('%sPSAAvg_HeatMap_%s_sortedMaxEvokedAscBy_%s_GRY', ...
                    currentDaySavePath, currGroupName, regexprep(sortStims{1}, ' ', '_')), iMask, ...
                    doPlotPSCaTracesHeatMap);

                % if only one stimulus present in current selection, skip the ROI PS-average saving
                if numel(sortStims) == 1; ANClearData(this); continue; end;

                %% PS-average for each ROI one by one
                if doPlotSingleROIAverage;  
                    % select the peri-stimulus average plot
                    set(anh.plotList, 'Value', 3); %#ok<*UNRCH>             
                    % go through each ROI and save its PS-average
                    for iROI = 1 : nROIs;
                        setIfExists(this, 'selROINames', 'Value', ROIsForDay(iROI), []);
                        setIfExists(this, 'combineROIs', 'Value', 1, 'true');
                        anh = plotAndSave(this, sprintf('%sPSAAvg_ROI%s_%s', currentDaySavePath, ...
                            uniqueROINames{ROIsForDay(iROI)}, currGroupName), iMask);
                    end;                    
                end;

                %% PS-average for each ROI by groups
                if doPlotGroupROIAverage > 0; 
                    set(anh.plotList, 'Value', 3); % select the peri-stimulus average plot  
                    setIfExists(this, 'combineROIs', 'Value', 1, 'true');            
                    % go through each ROI and save its PS-average
                    iROI = 1;
                    while iROI < nROIs;
                        % get the last ROI for this group, without exceeding the total number of ROIs
                        lastROI = min(iROI + doPlotGroupROIAverage - 1, nROIs);
                        setIfExists(this, 'selROINames', 'Value', ROIsForDay(iROI : lastROI), []);
                        % plot the ROIs as a group
                        anh = plotAndSave(this, sprintf('%sPSAAvg_ROIs%sTo%s_%s', currentDaySavePath, ...
                            uniqueROINames{ROIsForDay(iROI)}, uniqueROINames{ROIsForDay(lastROI)}, ...
                            currGroupName), iMask);
                        % update the counter
                        iROI = lastROI + 1;
                    end;                    
                end;

                % flush memory
                ANClearData(this);

            end; % stim types loop

%             % flush memory
%             ANClearData(this);
% 
%         end; % mask loop

        % flush memory
        ANClearData(this);

    end; % day loop

end; % if-else plot loop

%% pooled analysis
if doPlotPooledAnalysis || doPlotSingleROIAllPhasesAverage || doPlotAllCaTraces;
    
    % set plotting parameters
    set(anh.rowList, 'Value', 1 : numel(this.an.selectedTableRows));
    setIfExists(this, 'sgFiltFrameSize', 'String', 15);
    setIfExists(this, 'exclFrames', 'Value', 1, 'show');
    setIfExists(this, 'PSPer', 'String', ['{ all, [-2], [0], [0], [2]; on, [-2], [0], [0], [0.5]; ', ...
        'off, [-2], [0], [0.5], [1]; late, [-2], [0], [1], [2]; }'], ...
        { 'all', -2, 0, 0, 2; 'on', -2, 0, 0, 0.5; 'off', -2, 0, 0.5, 1; 'late', -2, 0, 1, 2});
    setIfExists(this, 'noisyTrialsThresh', 'String', 'Inf');
    % get all stimulus types and go through them
    stimTypes = get(anh.paramPanElems.selStimTypeGroups, 'String');
    setIfExists(this, 'selStimTypeGroups', 'Value', find(ismember(stimTypes, 'cloud'))); %#ok<FNDSB>
    setIfExists(this, 'respMethod', 'Value', 1, 'mean');
    
    % update the plot to get all ROIs
    ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;
    
    % get the ROIs
    uniqueROINames = get(anh.paramPanElems.selROINames, 'String');
    setIfExists(this, 'selROINames', 'Value', 1 : numel(uniqueROINames));

    savePath = sprintf('%s%s_%s/%s_%s_pooled_meanResp_', this.path.OCIASave, shortAnimID, spotID, shortAnimID, spotID);

    % plot the calcium traces for all days
    set(anh.plotList, 'Value', 1); % select the calcium traces plot
    anh = plotAndSave(this, sprintf('%sallCaTraces', savePath), 1, doPlotAllCaTraces);    

    % plot distributions
    if doPlotPooledAnalysis;
        set(anh.plotList, 'Value', 7); % select ROIStat distribution
        
        stimTypeGroupNames = { 'time', 'soundTargResp', 'lightTargResp', 'lickTargResp' };
        stimTypeGroups = { { 'time' }, { 'time', 'targ', 'resp' }, { 'time', 'targ', 'resp' }, ...
            { 'time', 'targ', 'resp' } };
        stimIDsGroups = { 'all', ...
            { 'sound_distr_resp', 'sound_distr_noResp', 'sound_targ_noResp', 'sound_targ_resp' }, ...
            { 'light_distr_resp', 'light_distr_noResp', 'light_targ_noResp', 'light_targ_resp' }, ...
            { 'lick_distr_resp', 'lick_distr_noResp', 'lick_targ_noResp', 'lick_targ_resp' }, ...
        };
            
        % go through each stimulus type group
        for iStimTypeGroup = 1 : numel(stimTypeGroups);
            currGroupName = stimTypeGroupNames{iStimTypeGroup};
            setIfExists(this, 'selStimTypeGroups', 'Value', ...
                    find(ismember(stimTypes, stimTypeGroups{iStimTypeGroup}))); %#ok<FNDSB>
            setIfExists(this, 'selStimIDs', 'Value', [], []);
            if iscell(stimIDsGroups{iStimTypeGroup});
                this.an.img.selStimIDs = stimIDsGroups{iStimTypeGroup};
            end;
            
            setIfExists(this, 'groupBy', 'Value', 3, 'stimType');
            setIfExists(this, 'groupBy2', 'Value', 2, 'day');
            plotTypeNames = { 'distr', 'hist', 'cumDistr' };
            for iROIStat = 1 : 2;
                for iPlotType = 1 : 3;
                    setIfExists(this, 'ROIStat', 'Value', iROIStat, []);
                    setIfExists(this, 'ROIStatPlotType', 'Value', iPlotType, []);
                    anh = plotAndSave(this, sprintf('%sROIStat_%s_%s_%s', savePath, ...
                        plotTypeNames{iPlotType}, iff(iROIStat == 1, 'RespAmpl', 'RespTime'), currGroupName), 1, 1);
                end;
            end;

            % save the output
            ANSaveOutput(this, sprintf('%s_%s_output.mat', savePath, currGroupName));
        end;
    end;

    % single ROI evolution over all phases plot
    if doPlotSingleROIAllPhasesAverage > 0;

        % flush memory
        ANClearData(this);

        set(anh.plotList, 'Value', 3); % select the peri-stimulus average plot
        setIfExists(this, 'combineROIs', 'Value', 2, 'false');
        setIfExists(this, 'averageROI', 'Value', 2, 'false');
        setIfExists(this, 'selROINames', 'Value', 1, []);
        % update the plot to get the stimulus types for sorting
        ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;

        % get the full ROIs names
        allROINames = get(anh.paramPanElems.selROINames, 'String');
        % get the clean ROIs names without the 'RSXX_' tag
        uniqueAllROINames = unique(regexprep(allROINames, 'RS\d+_', ''));
        % go through each ROI and save its PS-average
        for iROI = 1 : numel(uniqueAllROINames);
            setIfExists(this, 'selROINames', 'Value', ROIsForDay(iROI), []);
            anh = plotAndSave(this, sprintf('%sPSAAvgAllPhases_ROI%s_%s', currentDaySavePath, ...
                uniqueROINames{ROIsForDay(iROI)}, regexprep(stimTypes{iStimType}, '^soundStart_', '')), iMask);
        end;                  
    end;

    % flush memory
    ANClearData(this);
end;
   

end
