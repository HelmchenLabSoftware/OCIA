function [PSLickDataProc, trialRespTypes, lickTimes, selTimes] = OCIA_analysis_behav_getPSLickData(this, iDWRows)
% OCIA_analysis_behav_getPSLickData - [no description]
%
%       [PSLickDataProc, trialRespTypes, lickTimes, selTimes] = OCIA_analysis_behav_getPSLickData(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

[PSLickDataProc, trialRespTypes, lickTimes, selTimes] = deal([]);

% if no rows, abort with a warning
if isempty(iDWRows);
    showWarning(this, sprintf('OCIA:%s:NoBehavData', mfilename()), 'No rows selected!');
    ANShowHideMessage(this, 1, 'No rows selected!');
    return;
end;

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType               UISize      isLabAbove      label               tooltip
    'be',  'selTimes',          'list',     {  },                   [2 3],      true,           'Times',            'Selection of stimulus time points.';
    'be',  'allTimes',          'text',     { 'cellArray' },        [1 0],      false,          'All times',        'Time IDs for all the stimulus time points as a cell-array.';
    'be',  'sgFiltFrameSize',   'text',     { 'numeric' },          [1 0],      false,          'Sav.-Gol. filt.',  'Frame size of the Savitzky-Golay filter for the lick traces, value must be an odd number.';
    'be',  'PSPer',             'text',     { 'array' },            [0.75 0],   false,          'P.S. per.',        'Peri-stimulus period in seconds.';
    'be',  'normTrialsPrctile', 'text',     { 'array' },            [0.75 0],   false,          'Norm. trials %',   'Normalize the trials (percentile method).';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

this.GUI.an.paramPanConfig{'selTimes', 'valueType'} = { this.an.be.allTimes };

%% extract lick data
[lickData, behavInd, trialInd, trialRespTypes, dateForTrials, nTotTrials, nMaxSamples, allBehavStructs] = ...
    OCIA_analysis_behav_getLickData(this, iDWRows);
if isempty(lickData); return; end;


%% extract PS lick data
ANShowHideMessage(this, 1, 'Extracting licking data peri-stimulus samples ...');

% get the stimulus IDs
selTimes = this.an.be.selTimes;
if isempty(selTimes);
    selTimes = this.an.be.allTimes;
    this.an.be.selTimes = selTimes;
end;
nStimTypes = numel(selTimes);
    
% get the data in memory
hashStruct = struct('iDWRows', iDWRows, 'PSPer', this.an.be.PSPer, 'selTimes', { selTimes }, ...
    'dataType', 'PSLickData');
cachedData = ANGetCachedData(this, 'be', hashStruct);

% if the peri-stimulus lick data is not in cache yet, create it
if isempty(cachedData);

    % create the stimulus vector to splice up the matrix
    stimVects = zeros(nTotTrials, nMaxSamples);
    nanStimTypes = true(nStimTypes, nTotTrials);
    for iTrial = 1 : nTotTrials;
        % extract all times
        BETimes = allBehavStructs{behavInd(iTrial)}.times;
        % delay to add between the initial time and the starting time
        delay = BETimes.start(trialInd(iTrial)) - BETimes.init(trialInd(iTrial));
        % go through each stimulus
        for iStim = 1 : nStimTypes;
            % if the stimulus' time field exists and is not a NaN value, mark it as the stimulus sample
            if isfield(BETimes, selTimes{iStim}) && ~isnan(BETimes.(selTimes{iStim})(trialInd(iTrial)));
                stimSample = round((delay + BETimes.(selTimes{iStim})(trialInd(iTrial))) * this.an.be.anInSampleRate);
                nanStimTypes(iStim, iTrial) = false;
             
            % stimulus type is absent/invalid for this trial, mark it as not valid
            else
                % make sure the samples are not the same otherwise they overlap in the stim vector
                stimSample = 100 + iStim;
                
                % mark the non-valid trials
                nanStimTypes(iStim, iTrial) = true;
%                 o('#%s: problem with trial %d, stim %d (%s): using fake sample number %d ...', ...
%                     mfilename(), iTrial, iStim, selTimes{iStim}, stimSample, 0, this.verb);
                
            end;
            % if sample would be outside of the recording, ignore it
            if stimSample > nMaxSamples;
                o('#%s: problem with trial %d, stim %d (%s): outside of the recording (%d > %d), skipping.', ...
                    mfilename(), iTrial, iStim, selTimes{iStim}, stimSample, nMaxSamples, 3, this.verb);
                stimSample = 100 + iStim;
                nanStimTypes(iStim, iTrial) = true;
            end;
            % mark the stimulus sample as belonging to the current stimulus
            stimVects(iTrial, stimSample) = iStim;
        end;
    end;
    
    % transform lick data into the right format
    lickData = permute(lickData, [1, 3, 2]);
    % extract the peri-stimulus samples
    PSLickData = extractPSTrace(lickData, stimVects, round(this.an.be.PSPer * this.an.be.anInSampleRate), 1, 0, 1);
    PSLickData = reshape(PSLickData, [size(PSLickData, 1), size(PSLickData, 2) size(PSLickData, 4)]);
    nTotTrials = size(PSLickData, 2);
    % hide the non-valid trials so that the same line always represents the same trial
    for iTrial = 1 : nTotTrials;
        % go through each stimulus
        for iStim = 1 : nStimTypes;
            if nanStimTypes(iStim, iTrial);
                PSLickData(iStim, iTrial, :) = NaN;
            end;
        end;
    end;
    
    % store the variables in the cached structure
    cachedData = struct('PSLickData', PSLickData, 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'be', hashStruct, cachedData);

% if data was in memory, fetch it
else
    
    % fetch the data
    PSLickData = cachedData.PSLickData;
    
end;

%% pre-process the data
% get the data in memory
hashStruct = struct('iDWRows', iDWRows, 'PSPer', this.an.be.PSPer, 'selTimes', { selTimes }, ...
    'normTrialsPrctile', this.an.be.normTrialsPrctile, 'sgFilt', this.an.be.sgFiltFrameSize, ...
    'dataType', 'PSLickDataProc');
cachedData = ANGetCachedData(this, 'be', hashStruct);

% if the processed peri-stimulus lick data is not in cache yet, create it
if isempty(cachedData);
    
    ANShowHideMessage(this, 1, 'Pre-processing lick data ...');

    PSLickDataProc = PSLickData;
    
    sgFiltFrameSize = this.an.be.sgFiltFrameSize;
    if sgFiltFrameSize > 1;
        if mod(sgFiltFrameSize, 2) == 0;
            sgFiltFrameSize = sgFiltFrameSize + 1;
        end;
        parfor iStimType = 1 : nStimTypes;
            for iTrial = 1 : nTotTrials;
                PSLickDataProc(iStimType, iTrial, :) = sgolayfilt(PSLickDataProc(iStimType, iTrial, :), 1, sgFiltFrameSize);
            end;
        end;
    end;
        
%     normTrialsPrctile = this.an.be.normTrialsPrctile;
%     if ~isempty(normTrialsPrctile) && isnumeric(normTrialsPrctile) && all(normTrialsPrctile >= 0) ...
%             && all(normTrialsPrctile <= 100);

        %% pre-process the data : find min/max
        % get the max and the min for each day
        uniqueDays = unique(dateForTrials);
        nDays = numel(uniqueDays);
        minMaxForTrials = zeros(nTotTrials, 2);
        for iDay = 1 : nDays;
            dayMask = strcmp(dateForTrials, uniqueDays{iDay});
            if numel(dayMask) > size(PSLickDataProc, 2);
                o('#%s: problem with day %d: day mask size (%d) > number of trials (%d), resizing but this is weird ...', ...
                    mfilename(), iDay, numel(dayMask), size(PSLickDataProc, 2), 1, this.verb);
                dayMask = dayMask(1 : size(PSLickDataProc, 2));
                trialRespTypes = trialRespTypes(1 : size(PSLickDataProc, 2));
            end;
            valuesForDayAllStim = reshape(permute(PSLickDataProc(:, dayMask, :), [3 1 2]), ...
                [nStimTypes * size(PSLickDataProc, 3), nansum(dayMask)]);
%             minMaxForTrials(dayMask, 1) = prctile(valuesForDayAllStim(1 : 2000, :), normTrialsPrctile(1), 1);
%             minMaxForTrials(dayMask, 2) = prctile(valuesForDayAllStim(1 : 2000, :), normTrialsPrctile(2), 1);
            minMaxForTrials(dayMask, 1) = nanmedian(valuesForDayAllStim, 1);
        end;
        
        %% pre-process the data : apply
        for iTrial = 1 : nTotTrials;
            PSLickDataForTrial = PSLickDataProc(:, iTrial, :);
%             minVal = minMaxForTrials(iTrial, 1);
%             maxVal = minMaxForTrials(iTrial, 2);
            trialRange = iTrial - 1 : iTrial + 1;
            trialRange(trialRange < 1 | trialRange > nTotTrials) = [];
%             minVal = nanmean(minMaxForTrials(trialRange, 1));
%             maxVal = nanmean(minMaxForTrials(trialRange, 2));
%             minVal = nanmean(minMaxForTrials(:, 1));
%             maxVal = nanmean(minMaxForTrials(:, 2));
%             minVal = prctile(PSLickDataForTrial(:), normTrialsPrctile(1));
%             maxVal = prctile(PSLickDataForTrial(:), normTrialsPrctile(2));
%             PSLickDataForTrial(PSLickDataForTrial < minVal) = minVal;
%             PSLickDataForTrial(PSLickDataForTrial > maxVal) = maxVal;
            PSLickDataForTrial = PSLickDataForTrial - nanmean(minMaxForTrials(trialRange, 1));
%             PSLickDataForTrial = PSLickDataForTrial - minVal;
            PSLickDataForTrial(PSLickDataForTrial < 0) = 0;
%             PSLickDataForTrial(PSLickDataForTrial > maxVal) = maxVal;
%             PSLickDataProc(:, iTrial, :) = linScale(PSLickDataForTrial);
            PSLickDataProc(:, iTrial, :) = PSLickDataForTrial;
        end;
        
%     end;
    
    % order trials by response type
    [trialRespTypes, respTypeSortIndex] = sort(trialRespTypes);
    PSLickDataProc = PSLickDataProc(:, respTypeSortIndex, :);
    nTrialTypes = numel(unique(trialRespTypes));
    lickTimes = cell(1, nTrialTypes);
%     for iRespType = 1 : nTrialTypes;
%         PSLickDataProcRespType = PSLickDataProc(:, trialRespTypes == iRespType, :);
%         lickTimes{iRespType} = cell(size(PSLickDataProcRespType, 2), 1);
%         for iTrial = 1 : size(PSLickDataProcRespType, 2);
%             lickTimes{iRespType}{iTrial} = findpeaks(squeeze(PSLickDataProcRespType(1, iTrial, :)), 'MinPeakWidth', 0.040 * this.an.be.anInSampleRate);
%         end;
%     end;
    
    % store the variables in the cached structure
    cachedData = struct('PSLickDataProc', PSLickDataProc, 'trialRespTypes', trialRespTypes, ...
        'lickTimes', { lickTimes }, 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'be', hashStruct, cachedData);

% if data was in memory, fetch it
else
    
    % fetch the data
    PSLickDataProc = cachedData.PSLickDataProc;
    trialRespTypes = cachedData.trialRespTypes;
    lickTimes = cachedData.lickTimes;
    
end;

end
