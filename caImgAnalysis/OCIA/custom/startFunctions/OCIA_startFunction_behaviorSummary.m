function OCIA_startFunction_behaviorSummary(this)
% OCIA_startFunction_behaviorSummary - [no description]
%
%       OCIA_startFunction_behaviorSummary(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


    doBehavPlots = true;
    doLickPlots = false;
    iStartAnimal = 3;
    iEndAnimal = 3;
    iStartDay = 20; %#ok<NASGU>
    iEndDay = Inf; %#ok<NASGU>

    %% get all behavior data
    OCIAChangeMode(this, 'DataWatcher');
    
    % get the DataWatcher's and the Analyser's GUI handles
    dwh = this.GUI.handles.dw;
    
    % set the watch types
    set(dwh.watchTypes.animal,      'Value', 1);
    set(dwh.watchTypes.day,         'Value', 1);
%     set(dwh.watchTypes.spot,        'Value', 0);
%     set(dwh.watchTypes.img,         'Value', 0);
%     set(dwh.watchTypes.notebook,    'Value', 0);
    set(dwh.watchTypes.wfLV,        'Value', 0);
    set(dwh.watchTypes.wfLVSess,    'Value', 0);
    set(dwh.watchTypes.wfLVMat,     'Value', 0);
    set(dwh.watchTypes.wfAn,        'Value', 0);
    set(dwh.watchTypes.behav,       'Value', 1);
%     set(dwh.watchTypes.roiset,      'Value', 0);
%     set(dwh.watchTypes.intrinsic,   'Value', 0);
    
    % set the filters
    set(dwh.filt.animalID,          'Value', 1, 'String', { '-' });
    set(dwh.filt.dayID,             'Value', 1, 'String', { '-' });
    set(dwh.filt.wfLVSessID,        'Value', 1, 'String', { '-' });
    set(dwh.filt.rowTypeID,         'Value', 1, 'String', { '-' });
    set(dwh.filt.dataLoadStatus,    'Value', 0, 'String', '');
    set(dwh.filt.rowNum,            'Value', 0, 'String', '');
    set(dwh.filt.runNum,            'Value', 0, 'String', '');
    set(dwh.filt.all,               'Value', 0, 'String', '');
    
    % update the table
    DWProcessWatchFolder(this);
            
    %% go through each animal
    for iAnimal = max(iStartAnimal, 2) : min(numel(this.dw.animalIDs), iEndAnimal)
        
        
        %% switch to Analyser
        % select the animal and the behavior data and filter the table
        set(dwh.filt.animalID, 'Value', iAnimal);
        set(dwh.filt.rowTypeID, 'Value', find(strcmp(get(dwh.filt.rowTypeID, 'String'), 'Behavior data')));
        set(dwh.filt.all, 'String', 'day ~= ^2016_0[^12]');
        DWFilterSelectTable(this, 'new');
        
        % abort if no rows selected
        if numel(this.dw.selectedTableRows) == 0; continue; end;
        
        % go to analyser mode
%         OCIA_dataWatcherProcess_analyseRows(this);
        OCIA_dataWatcherProcess_WFAnalyse(this);
        
        if doBehavPlots;
        
            % create save path
            baseSavePath = sprintf('%s%s/%s__behavior__', this.path.OCIASave, this.dw.animalIDs{iAnimal}, ...
                regexprep(this.dw.animalIDs{iAnimal}, 'mou_bl_', '')); %#ok<*UNRCH>
            % select all runs and right plot
            set(this.GUI.handles.an.rowList, 'Value', 1 : numel(get(this.GUI.handles.an.rowList, 'String')));
            set(this.GUI.handles.an.plotList, 'Value', 7);
            ANUpdatePlot(this, 'force');
            % get the list of variables
            varList = get(this.GUI.handles.an.paramPanElems.behavVarToPlot, 'String'); 
        
            warning('off', 'MATLAB:LargeImage');

            %% summary plot of performance with runs
            savePath = sprintf('%ssummary.png', baseSavePath);
            toSelVars = { 'date', 'animal ID', 'hit rate', 'false alarm rate', 'earlies', 'performance (d'')'};
            set(this.GUI.handles.an.paramPanElems.behavVarToPlot, 'Value', find(ismember(varList, toSelVars)));
            set(this.GUI.handles.an.paramPanElems.plotLims, 'String', '[0, 100; 0, 100; 0, 100; -1, 7]');
            set(this.GUI.handles.an.paramPanElems.binWidth, 'String', '150');
            ANUpdatePlot(this, 'force'); ANSavePlot(this, savePath, [], 300);

            %% summary plot of performance with days
            savePath = sprintf('%ssummary_date.png', baseSavePath);
            toSelVars = { 'date', 'animal ID', 'hit rate - date', 'false alarm rate - date', ...
                'earlies - date', 'performance (d'') - date' };
            set(this.GUI.handles.an.paramPanElems.behavVarToPlot, 'Value', find(ismember(varList, toSelVars)));
            set(this.GUI.handles.an.paramPanElems.plotLims, 'String', '[0, 100; 0, 100; 0, 100; -1, 7]');
            ANUpdatePlot(this, 'force'); ANSavePlot(this, savePath, [], 300);

            %% summary plot of trials number
            savePath = sprintf('%ssummary_trials.png', baseSavePath); 
            toSelVars = { 'date', 'animal ID', 'n. of trials - date' };
            set(this.GUI.handles.an.paramPanElems.behavVarToPlot, 'Value', find(ismember(varList, toSelVars)));
            set(this.GUI.handles.an.paramPanElems.plotLims, 'String', '[0, 1500]');
            ANUpdatePlot(this, 'force'); ANSavePlot(this, savePath, [], 300);

            %% summary plot of trials and delays
            savePath = sprintf('%ssummary_delays.png', baseSavePath); 
            toSelVars = { 'date', 'animal ID', 'delay', 'allowedEarlies - run', 'NoGo percent - run', 'hit rate', 'earlies' };
            set(this.GUI.handles.an.paramPanElems.behavVarToPlot, 'Value', find(ismember(varList, toSelVars)));
            set(this.GUI.handles.an.paramPanElems.plotLims, 'String', '[0, 5; 0, 100; 0, 100; 0, 100; 0, 100]');
            set(this.GUI.handles.an.paramPanElems.binWidth, 'String', '350');
            ANUpdatePlot(this, 'force'); ANSavePlot(this, savePath, [], 300);

            %% output to make the pooled summary accross mice
            savePath = sprintf('%soutput', baseSavePath);
            ANSaveOutput(this, savePath);

        end;
            
        %% lick data
        if doLickPlots;
            
            set(this.GUI.handles.an.rowList, 'Value', 1);
            set(this.GUI.handles.an.plotList, 'Value', 9);
            ANClearData(this); ANUpdatePlot(this, 'force'); 

            set(this.GUI.handles.an.paramPanElems.plotLimits, 'String', '[0, 0.0000001]');
            set(this.GUI.handles.an.paramPanElems.sgFiltFrameSize, 'String', '51');
            set(this.GUI.handles.an.paramPanElems.PSPer, 'String', '[-3, 5]');
            set(this.GUI.handles.an.paramPanElems.selTrialTypes, 'Value', [1, 2, 3, 4, 5, 6]);
            set(this.GUI.handles.an.paramPanElems.selTimes, 'Value', [2, 3]);
            set(this.GUI.handles.an.paramPanElems.colormap, 'Value', 3);
            ANUpdatePlot(this, 'force'); 

            % check if folder exists, otherwise create it
            lickBaseSavePath = sprintf('%s%s/lickPlots/', this.path.OCIASave, this.dw.animalIDs{iAnimal});  
            if exist(lickBaseSavePath, 'dir') ~= 7; mkdir(lickBaseSavePath); end;
            lickSavePath = [lickBaseSavePath, this.dw.animalIDs{iAnimal}, '_lick_'];
            
            % go through each day
            for iDay = max(iStartDay, 2) : min(numel(this.dw.dayIDs), iEndDay);
                dayID = this.dw.dayIDs{iDay};
                
                savePath = sprintf('%s%s.png', lickSavePath, regexprep(dayID, '_', ''));
                set(this.GUI.handles.an.rowFilt, 'String', regexprep(dayID, '_', ' '));
                ANFiltRows(this);
                
                % do nothing if no rows selected
                if numel(get(this.GUI.handles.an.rowList, 'Value')) == 0; continue; end;
                ANUpdatePlot(this, 'force'); ANSavePlot(this, savePath, [], 300);
                
                % clear memory of loaded behavior data
                DWFlushData(this, 'all', false, 'behav');
                ANClearData(this);
                
            end;
            
        end;
        
        %% flush
        warning('on', 'MATLAB:LargeImage');
        ANClearData(this);
        % get back to data watcher and flush the data
        OCIAChangeMode(this, 'DataWatcher');
        DWFilterSelectTable(this, 'new');
        set(dwh.SLROptDataList, 'Value', find(strcmp(get(dwh.SLROptDataList, 'String'), 'Behavior data (raw)')));
        DWFlushData(this, 'all', false);
        
        % display the flushed table
        DWDisplayTable(this);
        
        % set back original plot
        set(this.GUI.handles.an.plotList, 'Value', 11);
        
    end;
    
end
