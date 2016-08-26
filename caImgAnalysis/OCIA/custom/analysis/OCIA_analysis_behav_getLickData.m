function [lickData, behavInd, trialInd, trialRespTypes, dateForTrials, nTotTrials, nMaxSamples, allBehavStructs] = ...
    OCIA_analysis_behav_getLickData(this, iDWRows)
% OCIA_analysis_behav_getLickData - [no description]
%
%       [lickData, behavInd, trialInd, trialRespTypes, dateForTrials, nTotTrials, nMaxSamples, allBehavStructs] = ...
%           OCIA_analysis_behav_getLickData(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

[lickData, behavInd, trialInd, trialRespTypes, dateForTrials, nTotTrials, nMaxSamples, allBehavStructs] = deal([]);

% if no rows, abort with a warning
if isempty(iDWRows);
    showWarning(this, sprintf('OCIA:%s:NoBehavData', mfilename()), 'No rows selected!');
    ANShowHideMessage(this, 1, 'No rows selected!');
    return;
end;

%% load data
for iRow = 1 : numel(iDWRows);
    DWLoadRow(this, iDWRows(iRow), 'full');
end;

%% get the "raw" data structure from the rows
% get the behavior data: get the rows that have behavior data
selectedLoadedBehavRows = DWFilterTable(this, 'data.behav.loadStatus = full', this.dw.table(iDWRows, :));
% get the DataWatcher table indexes for these rows
selectedLoadedBehavRowsIndexes = str2double(get(this, 'all', 'rowNum', selectedLoadedBehavRows));
% get the data for these rows
allBehavStructs = getData(this, selectedLoadedBehavRowsIndexes, 'behav', 'data');
% make sure data is cell
if ~iscell(allBehavStructs); allBehavStructs = { allBehavStructs }; end;
nBehavStructs = numel(allBehavStructs); % count the number of strutures

% if no behavior data, abort with a warning
if isempty(allBehavStructs);
    showWarning(this, 'OCIA:OCIA_analysis_behav_licks:NoBehavData', 'No behavior data to plot in selected rows!');
    ANShowHideMessage(this, 1, 'No behavior data to plot in selected rows!');
    return;
end;


%% extract lick data
ANShowHideMessage(this, 1, 'Extracting licking data ...');

% get the data in memory
hashStruct = struct('iDWRows', iDWRows, 'dataType', 'lickData');
cachedData = ANGetCachedData(this, 'be', hashStruct);

% if the lick data is not in cache yet, create it
if isempty(cachedData) || iscell(cachedData);
    
    % calculate trial numbers
    nTotTrials = 0;
    nTrials = zeros(nBehavStructs, 1);
    for iBehav = 1 : nBehavStructs;
        behavStruct = allBehavStructs{iBehav};
        nTrials(iBehav) = find(~isnan(behavStruct.times.end) & ~isnan(behavStruct.resps), 1, 'last');
        nTotTrials = nTotTrials + nTrials(iBehav);
    end;

    % extract the lick data as a cell-array
    lickDataCell = cell(nTotTrials, 1);
    behavInd = nan(nTotTrials, 1); % behavior file index for each trial
    trialInd = nan(nTotTrials, 1); % trial number within a behavior file
    trialRespTypes = nan(nTotTrials, 1); % trial response type
    dateForTrials = cell(nTotTrials, 1); % date for each trial
    % go through all behavior files
    iTrialTot = 0;
    for iBehav = 1 : nBehavStructs;
        lickDataForBehav = allBehavStructs{iBehav}.record.piezo(1 : nTrials(iBehav));
        for iTrial = 1 : numel(lickDataForBehav);
            lickDataForBehav{iTrial}(lickDataForBehav{iTrial} < allBehavStructs{iBehav}.params.piezoThresh * 0.95) = 0;
        end;
        lickDataCell(iTrialTot + 1 : iTrialTot + nTrials(iBehav)) = lickDataForBehav;
        behavInd(iTrialTot + 1 : iTrialTot + nTrials(iBehav)) = iBehav;
        trialInd(iTrialTot + 1 : iTrialTot + nTrials(iBehav)) = 1 : nTrials(iBehav);
        localTrialRespTypes = allBehavStructs{iBehav}.respTypes(1 : nTrials(iBehav));
        localTrialRespTypes(localTrialRespTypes == 1 ...
            & allBehavStructs{iBehav}.autoRewardGiven(1 : nTrials(iBehav))) = 6;
        trialRespTypes(iTrialTot + 1 : iTrialTot + nTrials(iBehav)) = localTrialRespTypes;
        dateForTrials(iTrialTot + 1 : iTrialTot + nTrials(iBehav)) ...
            = { datestr(unix2dn(allBehavStructs{iBehav}.expStartTime * 1000), 'yyyymmdd') };
        iTrialTot = iTrialTot + nTrials(iBehav);
    end;

    % store the licking data as a big matrix of nTrials x nSamples
    nMaxSamples = max(cellfun(@numel, lickDataCell));
    lickData = nan(nTotTrials, nMaxSamples);
    for iTrial = 1 : nTotTrials;
        lickData(iTrial, 1 : numel(lickDataCell{iTrial})) = lickDataCell{iTrial};
    end;
    
    % store the variables in the cached structure
    cachedData = struct('lickData', lickData, 'behavInd', behavInd, 'trialInd', trialInd, 'dateForTrials', { dateForTrials }, ...
        'trialRespTypes', trialRespTypes, 'nTotTrials', nTotTrials, 'nMaxSamples', nMaxSamples, 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'be', hashStruct, cachedData);

% if data was in memory, fetch it
else
    
    % fetch the data
    lickData = cachedData.lickData;
    behavInd = cachedData.behavInd;
    trialInd = cachedData.trialInd;
    trialRespTypes = cachedData.trialRespTypes;
    dateForTrials = cachedData.dateForTrials;
    nTotTrials = cachedData.nTotTrials;
    nMaxSamples = cachedData.nMaxSamples;
    
end;

end
