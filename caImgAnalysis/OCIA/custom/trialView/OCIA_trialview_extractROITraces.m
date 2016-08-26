function this = OCIA_trialview_extractROITraces(this, ~, ~)
% OCIA_trialview_extractROITraces - Extract ROI traces
%
%       OCIA_trialview_extractROITraces(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% check for presence of ROIs
nROIs = numel(this.tv.ROI.ROIIDs);
% nMaxTrials = 2;
nMaxTrials = Inf;
if nROIs == 0;
    showWarning(this, sprintf('OCIA:%s:NoROIs', mfilename()), 'No ROIs selected! Aborting.');
    return;
    
end;

%% figure out what files are to be processed
allFileList = get(this.GUI.handles.tv.paramPanElems.fileList, 'String');
cond_100Trials = find(cellfun(@(fileName)~isempty(regexp(fileName, 'cond_100_trial\d+\.mat', 'once')), allFileList));
cond_1200Trials = find(cellfun(@(fileName)~isempty(regexp(fileName, 'cond_1200_trial\d+\.mat', 'once')), allFileList));
stimTrials = find(cellfun(@(fileName)~isempty(regexp(fileName, 'stim_trial\d+\.mat', 'once')), allFileList));
hitTrials = find(cellfun(@(fileName)~isempty(regexp(fileName, 'cond_hit_trial\d+\.mat', 'once')), allFileList));
CRTrials = find(cellfun(@(fileName)~isempty(regexp(fileName, 'cond_CR_trial\d+\.mat', 'once')), allFileList));

% process according to conditions
if numel(cond_100Trials) + numel(cond_1200Trials) > 0;
    condNames = { 'cond_100', 'cond_1200' };
    
elseif numel(hitTrials) + numel(CRTrials) > 0;
    condNames = { 'cond_hit', 'cond_CR' };
    
elseif numel(stimTrials) > 0;
    condNames = { 'stim' };
    
else
    showWarning(this, sprintf('OCIA:%s:NoTrials', mfilename()), 'No trials to process found! Aborting.');
    return;
    
end;

% default condition
if ~exist('condNames', 'var') || ~iscell(condNames) || isempty(condNames);
    condNames = { 'stim' };
end;

% show message
allCondNameString = regexprep(sprintf('%s-', condNames{:}), '-$', '');
showMessage(this, sprintf('TrialView: Extracting ROI traces [using %s]...', allCondNameString));

%% get files to be processed
% initialize data to save structure
dataToSave = struct();
allFileList = get(this.GUI.handles.tv.paramPanElems.fileList, 'String');
dataToSave.allFileList = allFileList;
for iCond = 1 : numel(condNames);
    condName = condNames{iCond};
    dataToSave.([condName, '_trials']) = find(cellfun(@(fileName) ~isempty(regexp(fileName, ...
        sprintf('%s_trial\\d+\\.mat', condName), 'once')), allFileList));
    dataToSave.([condName, '_trials'])(min(nMaxTrials, numel(dataToSave.([condName, '_trials']))) + 1 : end) = [];
end;

%% prepare ROI variables
caROI = find(strcmp(this.tv.ROI.axeH, 'wf'));
nCaROI = numel(caROI);
behavROI = find(strcmp(this.tv.ROI.axeH, 'behav'));
nBehavROI = numel(behavROI);

dataToSave.caROINames = this.tv.ROI.ROINames(caROI);
dataToSave.behavROINames = this.tv.ROI.ROINames(behavROI);
dataToSave.caROIMasks = this.tv.ROI.ROIMasks(caROI);
dataToSave.behavROIMasks = this.tv.ROI.ROIMasks(behavROI);

%% prepare data store variables
for iCond = 1 : numel(condNames);
    condName = condNames{iCond};
    nTrials = numel(dataToSave.([condName, '_trials']));
    dataToSave.(['ROICaData_' condName]) = nan(nCaROI, nTrials, this.tv.params.WFDataSize(3));
    dataToSave.(['ROIBehavData_' condName]) = nan(nBehavROI, nTrials, size(this.tv.data.behavMovie, 3));
end;

% get time vector
dataToSave.tCa = ((1 : size(this.tv.data.wf, 3)) / this.tv.params.WFFrameRate) - this.tv.params.WFTimeOffset + this.tv.trigDelay;
dataToSave.tBehav = ((1 : size(this.tv.data.behavMovie, 3)) / this.tv.params.behavFrameRate) - this.tv.params.WFTimeOffset;

%% extract for each condition
for iCond = 1 : numel(condNames);
    condName = condNames{iCond};
    nTrials = numel(dataToSave.([condName, '_trials']));   
    for iTrial = 1 : nTrials;
        iRow = dataToSave.([condName, '_trials'])(iTrial);

        % load row
        this.tv.params.fileList = allFileList(iRow);
        set(this.GUI.handles.tv.paramPanElems.fileList, 'Value', iRow);
        OCIA_trialview_loadWideFieldData(this);

        % extract data
        dataToSave.(['ROICaData_' condName])(:, iTrial, :) = cell2mat(this.tv.ROI.ROITimeCourses(caROI)');
        dataToSave.(['ROIBehavData_' condName])(:, iTrial, :) = cell2mat(this.tv.ROI.ROITimeCourses(behavROI)') - this.tv.params.TCYLimROI(1);

    end;
end;

% %{

%% debug plots
doSave = true;
% doSave = false;
if doSave && exist('behaviorVectorPlots', 'dir') ~= 7; mkdir('behaviorVectorPlots'); end;
for iCond = 1 : numel(condNames);
    condName = condNames{iCond};
    nTrials = numel(dataToSave.([condName, '_trials']));
    savePath = sprintf('%sbehaviorVectorPlots/behaviorVectorPlot_%s', this.tv.params.saveLoadPath, condName);
    nTrialsPerPlot = 5;
    iPlot = 1;
    firstTrial = 1;
    for iTrial = 1 : nTrials;
        
        if mod(iTrial, nTrialsPerPlot) == 1;
            if doSave && iTrial > 1;
                lastTrial = iTrial - 1;
                savePathWithEnd = sprintf('%s_trials%02dTo%02d.png', savePath, firstTrial, lastTrial);
                export_fig(savePathWithEnd, '-r300', gcf);
                close(gcf);
                firstTrial = iTrial;
            end;
            figure('NumberTitle', 'off', 'Name', sprintf('Plot for %s trials %02d to %02d', condName, ...
                firstTrial, min(firstTrial + nTrialsPerPlot, nTrials)), 'Position', [50 90 1700 1000], 'Color', 'white');
            iPlot = 1;
        end;
        
        subplot(nTrialsPerPlot, 2, iPlot);
        plot(dataToSave.tCa, squeeze(dataToSave.(['ROICaData_' condName])(:, iTrial, :))');
        xlim([dataToSave.tCa(1) dataToSave.tCa(end)]); ylim([-0.12 0.18]);
        title(sprintf('Ca traces %s %d', condName, iTrial), 'Interpreter', 'none');
        legend(dataToSave.caROINames, 'Location', 'WestOutside', 'Interpreter', 'none');
        iPlot = iPlot + 1;
        
        subplot(nTrialsPerPlot, 2, iPlot);
        plot(dataToSave.tBehav, squeeze(dataToSave.(['ROIBehavData_' condName])(:, iTrial, :))');
        xlim([dataToSave.tBehav(1) dataToSave.tBehav(end)]); ylim([-0.05 1.05]);
        title(sprintf('Behav traces %s %d', condName, iTrial), 'Interpreter', 'none');
        legend(dataToSave.behavROINames, 'Location', 'EastOutside', 'Interpreter', 'none');
        iPlot = iPlot + 1;
    end;
    
    if doSave;
        lastTrial = iTrial;
        savePathWithEnd = sprintf('%s_trials%02dTo%02d.png', savePath, firstTrial, lastTrial);
        export_fig(savePathWithEnd, '-r300', gcf);
    end;
end;

%}

%% saving
savePath = sprintf('%sbehaviorVectors.mat', this.tv.params.saveLoadPath);
varsToSave = fieldnames(dataToSave);
for iVar = 1 : numel(varsToSave);
    eval(sprintf('%s = dataToSave.%s;', varsToSave{iVar}, varsToSave{iVar}));
end;
save(savePath, varsToSave{:});

showMessage(this,  sprintf('TrialView: Extracting ROI traces [using %s] done.', allCondNameString));

end
