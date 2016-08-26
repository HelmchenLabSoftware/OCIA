function OCIA_startFunction_analysisPipeline_wideField(this)
% OCIA_startFunction_analysisPipeline_wideField - [no description]
%
%       OCIA_startFunction_analysisPipeline_wideField(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% init to analysis mode
OCIAChangeMode(this, 'DataWatcher');
DWProcessWatchFolder(this);
set(this.GUI.handles.dw.filt.all, 'String', 'sweepDir ~= (up|down) AND rowType = WF data');
DWFilterSelectTable(this, 'new');
OCIA_dataWatcherProcess_WFAnalyse(this);

%% general settings
% start analysis pipeline    
% remove PNG saving warning
warning('off', 'MATLAB:LargeImage');

% get the DataWatcher's and the Analyser's GUI handle
anh = this.GUI.handles.an;

% save path
savePathRoot = this.path.OCIASave;
logPath = sprintf('%s%s_batchAnalysis.log', savePathRoot, datestr(now(), 'yyyymmdd_HHMMSS'));

% processing parameters
% nBins = '[-1, -1]';
nBins = '[300, 300]';
BLCorrMethod = 'bpfilter';
BLCorrParam = '[0.05, 10]';
chunkSizeFactor = '[2, 2]';
dispModes = { 'pitch', 'phase' };
cropRect = '';
% cropRect = '[1 1 256 256]';
% cropRect = '[135, 145, 256, 256]';
% cropRect = '[180, 235, 128, 128]';

% plot saving
doSavePlot = 1;

% shorten the function names
plotAndSave = @OCIA_analysis_updatePlotAndSaveNoMask;
setIfExists = @(a1, a2, a3, a4, varargin)OCIA_analysis_setIfExists(a1, a2, a3, a4, varargin{:}, 'wf');
this.an.plotSaveResolution = '-r150';

diary(logPath);

%% go through all experiments 2 by 2

% get file names
files = regexprep(get(this, this.an.selectedTableRows, 'path'), '^.+/([^/]+)$', '$1');
nFiles = numel(files);

for iFile = 1 : 2 : nFiles;
    
    if iFile > numel(get(anh.rowList, 'String')); break; end;
    
    fileSavePathRoot = sprintf('%s%s/%s/newAnalysis/', savePathRoot, get(this, this.an.selectedTableRows(iFile), 'animal'), ...
        get(this, this.an.selectedTableRows(iFile), 'day'));
    if exist(fileSavePathRoot, 'dir') ~= 7; mkdir(fileSavePathRoot); end;
    
    % select both files
    set(anh.rowList, 'Value', [iFile, iFile + 1]);    
    
    % create save name
    fileName{1} = files{iFile};
    fileName{2} = files{iFile + 1};
    
    % extract experiment numbers
    fileExpNumStr{1} = cell2mat(regexprep(regexp(fileName{1}, 'exp(\d+)', 'match'), 'exp', ''));
    fileExpNumStr{2} = cell2mat(regexprep(regexp(fileName{2}, 'exp(\d+)', 'match'), 'exp', ''));
    
    % create output file name
    outFileName = regexprep(fileName{1}, '(up|down)Sweep_', '');
    outFileName = regexprep(outFileName, '_\d{6}_', '_');
    outFileName = regexprep(outFileName, '_exp(\d+)_', ...
        sprintf('_exp%sto%s_', fileExpNumStr{1}, fileExpNumStr{2}));
    outFileName = regexprep(outFileName, '\.h5', '');
    
    % add bin-resolution string
    nBinsStr = regexp(regexprep(nBins, '[\[\] ]', ''), ',', 'split');
    outFileName = sprintf('%s_%sx%s', outFileName, nBinsStr{:});
    
    % add base line correction string
    if strcmp(BLCorrMethod, 'bpfilter');
        BLCorrStr = regexp(regexprep(BLCorrParam, '[\[\] ]', ''), ',', 'split');
        BLCorrStr = regexprep(BLCorrStr, '\.', 'p');
        BLCorrStr = sprintf('_%sto%sBPFilter', BLCorrStr{:});
        
    elseif strcmp(BLCorrMethod, 'polynomial');
        BLCorrStr = sprintf('_degree%sPolyBLCorr', BLCorrParam);
        
    else
        BLCorrStr = sprintf('_%sBLCorr', BLCorrMethod);
        
    end;
    
    outFileName = sprintf('%s%s', outFileName, BLCorrStr);
    fileSavePath = sprintf('%s%s', fileSavePathRoot, outFileName);
    matFilePath = [fileSavePath '.mat'];
    
    % skip if output exists
    if exist(matFilePath, 'file'); continue; end;
    
    % set processing parameters
    setIfExists(this, 'nBins', 'String', nBins);
    setIfExists(this, 'cropRect', 'String', cropRect);
    setIfExists(this, 'stimFreq', 'String', '0', 0);
    setIfExists(this, 'powerMapCLim', 'String', '[0, 1000]', [0, 1000]);
    setIfExists(this, 'chunkSizeFactor', 'String', chunkSizeFactor);
    setIfExists(this, 'BLCorrMethod', 'String', BLCorrMethod);
    setIfExists(this, 'BLCorrParam', 'String', BLCorrParam);
    
    for iDispMode = 1 : numel(dispModes);
        
        dispMode = dispModes{iDispMode};
        setIfExists(this, 'dispMode', 'String', dispMode, dispMode);
        
        % plot and save corrected phase maps
        set(anh.plotList, 'Value', 3);
        plotAndSave(this, sprintf('%s_corrPhaseMaps_%s', fileSavePath, dispMode), doSavePlot);

        % plot and save overlay corrected phase maps
        set(anh.plotList, 'Value', 4);
        plotAndSave(this, sprintf('%s_overlayCorrPhaseMaps_%s', fileSavePath, dispMode), doSavePlot);
    
    end;
        
    % save output
    ANSaveOutput(this, matFilePath);    
    
    % save individual maps
    for iFileLoop = iFile : iFile + 1;
        
        set(anh.rowList, 'Value', iFileLoop);  
            
        localFileSavePath = regexprep(fileSavePath, 'exp\d+to\d+', ...
            ['exp', fileExpNumStr{iFileLoop - iFile + 1}]);

        % plot and save corrected phase map
        set(anh.plotList, 'Value', 2);
        plotAndSave(this, sprintf('%s_phaseMap', localFileSavePath), doSavePlot);
    
    end;
    
    % clear data and move to next files
    ANClearData(this);
    
end;


%{

%% init plot
set(anh.plotList, 'Value', 1);
set(anh.rowList, 'Value', 1);

%% single row plots
% set some general parameters
setIfExists(this, 'nBins', 'String', nBins);
setIfExists(this, 'chunkSizeFactor', 'String', chunkSizeFactor);
setIfExists(this, 'nBinsToPlot', 'String', '79');
setIfExists(this, 'powerMapThresh', 'String', '0');

% get the row labels and number and go through each row
rowLabels = get(anh.rowList, 'String');
nRows = numel(rowLabels);
% nRows = 4;
for iRow = 1 : nRows;
    
    %% init
    % set parameters for current row
    rowLabel = regexprep(rowLabels{iRow}, ' - ', '_');
    rowLabel = regexprep(rowLabel, '0\.', '0p');
    set(anh.rowList, 'Value', iRow);
    setIfExists(this, 'cropRect', 'String', cropRect);
    setIfExists(this, 'stimFreq', 'String', '0');
    
    % skip multi frequency mapping rows
    if ~isempty(regexp(rowLabel, 'multiFreqMapping', 'once')); continue; end;
    
    % skip if output exists
    if exist(sprintf('%smat/singleMap_%s.mat', savePathRoot, rowLabel), 'file'); continue; end;
    
    %% ref
    set(anh.plotList, 'Value', 1);
    % plot and save row
    plotAndSave(this, sprintf('%sfig/%s_ref', savePathRoot, rowLabel), doSavePlot);
    
    %% pixel time course
    set(anh.plotList, 'Value', 2);
    setIfExists(this, 'pixTCYLim', 'String', '[-5000 10000]');
    % plot and save row
    anH = plotAndSave(this, sprintf('%sfig/%s_pixelTimeCourse', savePathRoot, rowLabel), doSavePlot);
    set(anH.axe, 'XLim', [12 32], 'YLim', [-5000 12000]);
    ANSavePlot(this, sprintf('%spng/%s_pixelTimeCourse_zoomIn.png', savePathRoot, rowLabel));
    
    %% spectrogram
    set(anh.plotList, 'Value', 3);
    % plot and save row
    plotAndSave(this, sprintf('%sfig/%s_spectrogram', savePathRoot, rowLabel), doSavePlot);

    % clear useuless data and save cache (only if plotting succeeded)
    if ~exist(sprintf('%sfig/singleMap_%s.mat', savePathRoot, rowLabel), 'file'); continue; end;
    fNames = fieldnames(this.an.wf.dataHash);
    delFieldInds = ~cellfun(@isempty, regexp(fNames, '(WFPowerAndPhase|WFPixelTimeCourse|WFFileInfo)_'));
    this.an.wf.dataHash = rmfield(this.an.wf.dataHash, fNames(delFieldInds));
    ANSaveOutput(this, sprintf('%smat/singleMap_%s', savePathRoot, rowLabel));
    
end;

% flush memory
ANClearData(this);
  
% %%
% fNames = fieldnames(this.an.wf.dataHash);
% delFieldInds = ~cellfun(@isempty, regexp(fNames, '(WFPowerAndPhase|WFPixelTimeCourse|WFFileInfo)_'));
% this.an.wf.dataHash = rmfield(this.an.wf.dataHash, fNames(delFieldInds));
  
    %%
% %{
%% combined maps 
set(anh.plotList, 'Value', 5);
for iRow = 1 : nRows;

    % get row label
    rowLabel = regexprep(rowLabels{iRow}, ' - ', '_');
    rowLabel = regexprep(rowLabel, 'stim0.', 'stim0p');
    rowID = regexprep(rowLabel, '(\d{6}|upSweep|downSweep|exp\d{2})', '');

    % exclude down sweeps and last row
    if iRow == nRows || ~isempty(regexp(rowLabel, 'downSweep$', 'once')); continue; end;

    % exclude non-pairs
    rowLabelNextRow = regexprep(rowLabels{iRow + 1}, ' - ', '_');
    rowLabelNextRow = regexprep(rowLabelNextRow, 'stim0\.', 'stim0p');
    rowIDNextRow = regexprep(rowLabelNextRow, '(\d{6}|upSweep|downSweep|exp\d{2})', '');
    if ~strcmp(rowID, rowIDNextRow); continue; end;

    % set parameters for current row
    set(anh.rowList, 'Value', [iRow iRow + 1]);
    setIfExists(this, 'cropRect', 'String', cropRects{iRow});
    
    % load back maps
    ANLoadOutput(this, sprintf('%smat/singleMap_%s', savePathRoot, rowLabel));
    ANLoadOutput(this, sprintf('%smat/singleMap_%s', savePathRoot, rowLabelNextRow));
    
    % plot and save row
    rowLabel = regexprep(rowLabels{iRow}, ' - ', '_');
    plotAndSave(this, sprintf('%sfig/allMaps_%s', savePathRoot, rowLabel), doSavePlot);
    
    % flush memory
    ANClearData(this);
    
end;
%}

diary('off');

end
