function isROIResponsive = OCIA_analysis_testROIsForResponse(this, PSCaTraces, hashStruct)
% OCIA_analysis_testROIsForResponse - [no description]
%
%       OCIA_analysis_testROIsForResponse(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

totalTic = tic; % for performance timing purposes

%% general plotting parameter UI controls
if ~ismember('ROCNReps', this.GUI.an.paramPanConfig.id);
    paramConf = cell2table({ ...
    ... categ  id                   UIType      valueType               UISize  isLabAbove      label
    ...     tooltip
        'img', 'ROCNReps',          'text',     {'numeric' },           [1 0],  false,          'Number of repeats', ...
            'Number of repeats to use in the shuffling for the ROC analysis.';
        }, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
    % append the new configuration to the table and update the row names using the ids
    this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
    this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;
end;

%% do ROC analysis
% get the data in memory
hashStruct.ROCNReps = this.an.img.ROCNReps;
hashStruct.dataType = 'ROC';
cachedData = ANGetCachedData(this, 'img', hashStruct);

% if the processed peri-stimulus calcium traces are not in cache yet, create it
if isempty(cachedData) || iscell(cachedData);    

    ROCTic = tic; % for performance timing purposes
    
    % get the size of the dataset
    [~, nStims, nROIs, nFrames] = size(PSCaTraces);
    nReps = this.an.img.ROCNReps;
    
    ROIAUCs = cell(nROIs, 1);
    truePX = nan(nROIs, nFrames - 1);
    truePY = nan(nROIs, nFrames - 1);
    shufPX = nan(nReps, nROIs, nFrames - 1);
    shufPY = nan(nReps, nROIs, nFrames - 1);

    % go through each ROI
    parfor iROI = 1 : nROIs;

        % extract relevant traces
        ROIPSTraces1Ori = reshape(PSCaTraces(1, :, iROI, :), nStims, nFrames);
        ROIPSTraces2Ori = reshape(PSCaTraces(2, :, iROI, :), nStims, nFrames); %#ok<PFBNS>

        % remove NaNs
        ROIPSTraces1Ori(all(isnan(ROIPSTraces1Ori), 2), :) = [];
        ROIPSTraces2Ori(all(isnan(ROIPSTraces2Ori), 2), :) = [];

        % calculate ROC for the true dataset and store it
        [trueAUC, truePX(iROI, :), truePY(iROI, :)] = calculate_AUC_ROC(ROIPSTraces1Ori, ROIPSTraces2Ori);
        ROIAUCs{iROI} = trueAUC;

        % do shuffling
        shufROIAUCs = nan(nReps, 1);
        for iRep = 1 : nReps;
            [ROIPSTraces1Shuf, ROIPSTraces2Shuf] = shuffle_AUC(ROIPSTraces1Ori, ROIPSTraces2Ori);
            [shufAUC, shufPX(iRep, iROI, :), shufPY(iRep, iROI, :)] ...
                = calculate_AUC_ROC(ROIPSTraces1Shuf, ROIPSTraces2Shuf);
            shufROIAUCs(iRep) = shufAUC;
        end;
        
        % store all AUC values
        ROIAUCs{iROI} = [trueAUC; shufROIAUCs];

    end;
    
    o('#%s: ROC done (%3.1f sec).', mfilename(), toc(ROCTic), 2, this.verb);
    
    % store the variables
    cachedData = struct('ROIAUCs', { ROIAUCs }, 'truePX', truePX, 'truePY', truePY, 'shufPX', shufPX, ...
        'shufPY', shufPY, 'dataType', 'ROC', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'img', hashStruct, cachedData);
    
    
% if data was in memory, fetch it
else
    
    % fetch the data
    ROIAUCs = cachedData.ROIAUCs;
    truePX = cachedData.truePX;
    truePY = cachedData.truePY;
    shufPX = cachedData.shufPX;
    shufPY = cachedData.shufPY;

end;


o('#%s done (%3.1f sec).', mfilename(), toc(totalTic), 2, this.verb);

end