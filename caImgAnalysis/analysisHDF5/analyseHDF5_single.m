function ROIStatsData = analyseHDF5_single(filePath, datasetPath)

% load the data and reshape it in an easily usable form
data = loadDataFromHDF5(filePath, datasetPath);

% get a default configuration for the analysis function
config = getAnalyseROIStatsDefaultConfig();

% fill the configuration with the local parameters: stim IDs, save name and frame rate
config.stimIDs = {'low', 'high'};
config.saveName = datestr(now(), 'yyyymmdd_HHMMSS');
config.frameRate = 77.76;

% get the ROISet and the number of ROIs
ROISet = data.ROISet{1, 1};
nROIs = size(ROISet, 1);

% get the concatenated traces of the selected rows
ROIStats = data.caTraces';
% get biggest number of frames
maxNFrames = max(cell2mat(cellfun(@(x)size(x, 2), ROIStats, 'UniformOutput', false)));
% exclMask = data.exclMask(DWRows)';
nRuns = size(ROIStats, 2); % get the number of runs (which corresponds to the number of selected rows)
% transform the data into a cell array of nROI x nRuns, with each cell containing the dFF/dRR trace
ROIStatsDataCell = cell(nROIs, nRuns);
for iROI = 1 : nROIs; % go through each ROI
    for iRun = 1 : nRuns; % go through each run
        ROIStatsForROI = ROIStats{iRun}(iROI, :);
        ROIStatsDataCell{iROI, iRun} = nan(1, maxNFrames);
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

config.doROINPilAnalysis = 0;

ROIStatsData = analyseROIStatsSingleDay(config);

end
