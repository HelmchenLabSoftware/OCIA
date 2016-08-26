function OCIA_startFunction_analysisPipeline_Dayra(this)
% OCIA_startFunction_analysisPipeline_Dayra - [no description]
%
%       OCIA_startFunction_analysisPipeline_Dayra(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% load data and swtich to analyser mode
OCIA_startFunction_loadDataAndOpenAnalyser(this);

%% start analysis pipeline    
% remove PNG saving warning
warning('off', 'MATLAB:LargeImage');

% get the DataWatcher's and the Analyser's GUI handle
dwh = this.GUI.handles.dw;
anh = this.GUI.handles.an;

% shorten the name
plotAndSave = @OCIA_analysis_updatePlotAndSave;

% plot to save configuration
plotCaTraces = true;
plotCaTracesHeatMap = true;
iMask = 1;

% get the currently analysed data's IDs
animalID = this.dw.animalIDs{get(dwh.filt.animalID, 'Value')};
shortAnimalID = regexprep(regexprep(animalID, 'mou_[bd]l_', ''), '_', '');
spotID = this.dw.spotIDs{get(dwh.filt.spotID, 'Value')};

% abort if no rows loaded
if ~isfield(anh, 'paramPanElems'); return; end;

% get the relevant ROI names
uniqueROINames = get(anh.paramPanElems.selROINames, 'String');

% get all the unique days and go through them
days = unique(get(this, this.an.selectedTableRows, 'day'));

% only do the day-base analysis if requested
if plotCaTraces || plotPSCaTracesHeatMap;

    %% day loop
    for iDay = 1 : numel(days);

        % select all rows for the current day
        rowsForDay = find(strcmp(get(this, this.an.selectedTableRows, 'day'), days{iDay}));
        set(anh.rowList, 'Value', rowsForDay);

        %% general plotting params
        set(anh.paramPanElems.sgFiltFrameSize, 'String', 15);
        set(anh.paramPanElems.exclFrames, 'Value', iMask);
        this.an.img.PSPer = [1 1.5];

        % get the save path
        currentDaySavePath = sprintf('%s%s_%s/%s_%s_%s_', this.path.OCIASave, shortAnimalID, spotID, shortAnimalID, ...
            spotID, regexprep(days{iDay}, '_', ''));

%         %% caTraces plot
%         set(anh.plotList, 'Value', 1); % select the calcium traces plot
%         set(anh.paramPanElems.selROINames, 'Value', 1 : numel(uniqueROINames)); % all ROIs
%         set(anh.paramPanElems.selStimTypeGroups, 'Value', 3); % low vs high
%         anh = plotAndSave(this, sprintf('%scaTracesOverview', currentDaySavePath), iMask, plotCaTraces);

        %% PS-average plots for different stimulus combinations
        set(anh.plotList, 'Value', 4); % select the peri-stimulus average heat map plot
        this.an.img.colormap = 'hot'; % hot colormap
        set(anh.paramPanElems.selROINames, 'Value', 1 : numel(uniqueROINames)); % all ROIs
        % get all stimulus types and go through them
        stimTypes = get(anh.paramPanElems.selStimTypeGroups, 'String');
        stimTypeGroupsToPlot = {1, 2, 3, 4, [3 4], [3 4]};
        stimsToPlot = {1, 1 : 10, 1 : 2, 1 : 3, 1 : 6, [1 4]};
        % go through each plot group
        for iStimTypeGroup = 1 : numel(stimTypeGroupsToPlot);

            %% PS-average heat map all ROIs
            set(anh.paramPanElems.selStimTypeGroups, 'Value', stimTypeGroupsToPlot{iStimTypeGroup}); % current stim type
            % update the plot to get the stimulus types for sorting
            ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;
            allStimIDs = this.an.img.selStimIDs;
            set(anh.paramPanElems.sortMethod, 'Value', 3); % use mean_evoked sorting method
            set(anh.paramPanElems.sortStim, 'Value', 1); % use last stim to sort
            set(anh.paramPanElems.selStimIDs, 'Value', stimsToPlot{iStimTypeGroup}); % current stim type
            stimTypeGroupNames = regexprep(sprintf('%s__', stimTypes{stimTypeGroupsToPlot{iStimTypeGroup}}), '__$', '');
            selStimIDs = regexprep(sprintf('%s__', allStimIDs{stimsToPlot{iStimTypeGroup}}), '__$', '');
            anh = plotAndSave(this, sprintf('%s_PSHeatMap__%s__%s', currentDaySavePath, stimTypeGroupNames, ...
                selStimIDs), iMask, plotCaTraces);
            
            % flush memory
            ANClearData(this);

        end; % stim types loop

        % flush memory
        ANClearData(this);

    end; % day loop

end; % if-else plot loop

end
