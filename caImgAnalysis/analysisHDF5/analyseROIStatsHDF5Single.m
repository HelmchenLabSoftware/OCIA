function [data, ROIStatsData] = analyseROIStatsHDF5Single(filePath, datasetPath, data, config)

%% inputs
verb = 2;
   
if ~exist('data', 'var') || isempty(data);
    % load the data and reshape it in an easily usable form
    loadDataTic = tic; % for performance timing purposes
    o('#analyseROIStatsHDF5Single: loading data from "%s": "%s" ...', filePath, datasetPath, 2, verb);
%     data = loadDataFromHDF5(filePath, datasetPath);
    data = h5readAsStruct(filePath, datasetPath);    
    o('#analyseROIStatsHDF5Single: loading data done (%.1f sec)', toc(loadDataTic), 1, verb);
else
    o('#analyseROIStatsHDF5Single: using data from inputs.', 2, verb);
end;

if ~exist('config', 'var') || isempty(config);
    configTic = tic; % for performance timing purposes
    % get a default configuration for the analysis function
    config = getAnalyseROIStatsDefaultConfig();
    % fill the configuration with the local parameters: stim IDs, save name and frame rate
    config.stimIDs = {'low', 'high'};
    config.saveName = datestr(now(), 'yyyymmdd_HHMMSS');
    config.frameRate = 77.76;
    
    % set default analysis to do
%     config.PSAnalysisStats = {};
%     config.doROINPilAnalysis = 1;
%     config.doCrossCorrAnalysis = 1;

    o('#analyseROIStatsHDF5Single: generated a config (%.1f sec)', toc(configTic), 1, verb);
else
    o('#analyseROIStatsHDF5Single: using config from inputs.', 2, verb);
end;

%% init configs
loadConfigTic = tic; % for performance timing purposes
% get the ROISet and the number of ROIs
ROISet = data.ROISet{1, 1};
nROIs = size(ROISet, 1);

% get the concatenated traces of the selected rows
ROIStats = data.caTraces';
% % get biggest number of frames
% maxNFrames = max(cell2mat(cellfun(@(x)size(x, 2), ROIStats, 'UniformOutput', false)));
% exclMask = data.exclMask(DWRows)';
nRuns = size(ROIStats, 2); % get the number of runs (which corresponds to the number of selected rows)
% transform the data into a cell array of nROI x nRuns, with each cell containing the dFF/dRR trace
ROIStatsDataCell = cell(nROIs, nRuns);
for iROI = 1 : nROIs; % go through each ROI
    for iRun = 1 : nRuns; % go through each run
        ROIStatsForROI = ROIStats{iRun}(iROI, :);
%         ROIStatsDataCell{iROI, iRun} = nan(1, maxNFrames);
        ROIStatsDataCell{iROI, iRun}(1, 1 : size(ROIStatsForROI, 2)) = ROIStatsForROI;
%         ROIStatsDataCell{iROI, iRun}(~isnan(exclMask{iRun}(iROI, :))) = NaN; % apply mask
    end;
end;
% set the stimulus vector in the configuration
config.stim = data.stim';

% set up the run names as the trials' names
config.runFileIDs = data.runIDs;

% load the ROISet and the traces in the configuration
config.ROIStatsData = ROIStatsDataCell;
config.ROISet = ROISet;

o('#analyseROIStatsHDF5Single: configuration loaded (%.1f sec)', toc(loadConfigTic), 1, verb);

% analyse the data using the "main" analysis function
ROIStatsData = analyseROIStats(config);

end
