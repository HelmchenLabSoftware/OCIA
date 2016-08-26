function OCIA_startFunction_analysisPipeline_wideFieldMultiMap(this)
% OCIA_startFunction_analysisPipeline_wideFieldMultiMap - [no description]
%
%       OCIA_startFunction_analysisPipeline_wideFieldMultiMap(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% init for getting IDs
set(this.GUI.handles.dw.watchTypes.animal, 'Value', 1);
set(this.GUI.handles.dw.watchTypes.day, 'Value', 1);
set(this.GUI.handles.dw.watchTypes.wf, 'Value', 0);
set(this.GUI.handles.dw.watchTypes.wfAn, 'Value', 0);
    
OCIAChangeMode(this, 'DataWatcher');
DWProcessWatchFolder(this);

%% settings
% remove PNG saving warning
warning('off', 'MATLAB:LargeImage');

% get the DataWatcher's and the Analyser's GUI handle
anh = this.GUI.handles.an;

% save path
savePathRoot = this.path.OCIASave;
logPath = sprintf('%s%s_batchAnalysis.log', savePathRoot, datestr(now(), 'yyyymmdd_HHMMSS'));

% processing parameters
nBins = '[300, 300]';
BLCorrMethod = 'bpfilter';
BLCorrParam = '[0.05, 10]';

% plot saving
doSavePlot = 1;

% shorten the function names
plotAndSave = @OCIA_analysis_updatePlotAndSaveNoMask;
setIfExists = @(a1, a2, a3, a4, varargin)OCIA_analysis_setIfExists(a1, a2, a3, a4, varargin{:}, 'wf');
this.an.plotSaveResolution = '-r150';

diary(logPath);

%% get summary plot
animIDs = unique(get(this, 'all', 'animal'));
for iAnim = 1 : numel(animIDs);
    set(this.GUI.handles.dw.watchTypes.wfAn, 'Value', 0);
    set(this.GUI.handles.dw.filt.animalID, 'Value', iAnim + 1);
    set(this.GUI.handles.dw.filt.dayID, 'Value', 1);
    OCIAChangeMode(this, 'DataWatcher');
    DWProcessWatchFolder(this);
    dayIDs = unique(get(this, 'all', 'day'));
    
    for iDay = 1 : numel(dayIDs);
        
        set(this.GUI.handles.dw.filt.dayID, 'Value', iDay + 1);
        set(this.GUI.handles.dw.watchTypes.wfAn, 'Value', 1);
        DWProcessWatchFolder(this);
        
        set(this.GUI.handles.dw.filt.all, 'String', 'rowType = WF an. data');
        try
            DWFilterSelectTable(this, 'new');
        catch err; %#ok<NASGU>
            pause(1);
            DWFilterSelectTable(this, 'new');
        end;
        if isempty(this.dw.selectedTableRows); continue; end;

        OCIA_dataWatcherProcess_WFAnalyse(this);

        animalID = get(this, this.an.selectedTableRows(1), 'animal');
        dayID = get(this, this.an.selectedTableRows(1), 'day');
        fileSavePath = sprintf('%s%s/%s/newAnalysis/', savePathRoot, animalID, dayID);
        if exist(fileSavePath, 'dir') ~= 7; mkdir(fileSavePath); end;

        % select all files
        set(anh.rowList, 'Value', 1 : numel(get(anh.rowList, 'String')));    

        % set processing parameters
        setIfExists(this, 'nBins', 'String', nBins);
        setIfExists(this, 'stimFreq', 'String', '0', 0);
        setIfExists(this, 'BLCorrMethod', 'String', BLCorrMethod);
        setIfExists(this, 'BLCorrParam', 'String', BLCorrParam);

        % plot and save corrected phase maps
        set(anh.plotList, 'Value', 5);
        plotAndSave(this, sprintf('%s%s_summary', fileSavePath, dayID), doSavePlot);

        % clear data and move to next files
        ANClearData(this);
    
    end;
end;

diary('off');

end
