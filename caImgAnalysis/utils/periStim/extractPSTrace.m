function PSCaTraces = extractPSTrace(caTraces, stims, PSFrames, varargin)

if numel(varargin) > 0 && isnumeric(varargin{1}) && numel(varargin{1}) == 1;
    nMaxStimPerTrial = varargin{1};
else
    nMaxStimPerTrial = 10;
end;

if numel(varargin) > 1 && islogical(varargin{2}) && varargin{2};
    useROIParFor = true;
else
    useROIParFor = false;
end;

% make sure the peri-stimulus frames are specified as a structure
if isnumeric(PSFrames) && numel(PSFrames) == 2;
    PSFrames = struct('base', [PSFrames(1) 0], 'evoked', [0 PSFrames(2)]);
% make sure the peri-stimulus frames are specified as a structure
elseif isnumeric(PSFrames) && numel(PSFrames) == 4;
    PSFrames = struct('base', [PSFrames(1) PSFrames(2)], 'evoked', [PSFrames(3) PSFrames(4)]);
end;

% get all different stims "indexes"
stimTypes = unique(stims(stims ~= 0 & ~isnan(stims)));

% get the size of the dataset
nTrials = size(caTraces, 1);
nStims = nTrials * nMaxStimPerTrial; % maximum possible stimulus per trial (to allocate enough space)
nROIs = size(caTraces, 2);
nFrames = size(caTraces, 3);
nStimTypes = numel(stimTypes);
% get the peri-stimulus frames' range
PSFramesRange = unique([PSFrames.base(1) : PSFrames.base(2) PSFrames.evoked(1) : PSFrames.evoked(2)]);
nPeriStimFrames = max(PSFramesRange) - min(PSFramesRange) + 1;

% create a nStimTypes x nStims x nROIs x nPeriStimFrames matrix
PSCaTraces = nan(nStimTypes, nStims, nROIs, nPeriStimFrames);
% go through each ROI and concatenate all repetitions:
% using parallel loop
if useROIParFor;
    parfor iROI = 1 : nROIs;
        % store in the output structure
        PSCaTraces(:, :, iROI, :) = extractPSTraceForROI(reshape(caTraces(:, iROI, :), nTrials, nFrames), ...
            stims, nStims, nTrials, nPeriStimFrames, stimTypes, PSFrames);
    end
% without parallel loop
else
    for iROI = 1 : nROIs;
        % store in the output structure
        PSCaTraces(:, :, iROI, :) = extractPSTraceForROI(reshape(caTraces(:, iROI, :), nTrials, nFrames), ...
            stims, nStims, nTrials, nPeriStimFrames, stimTypes, PSFrames);
    end
end;

% remove empty trials
emptyTrials = arrayfun(@(iTrial) all(all(all(isnan(PSCaTraces(:, iTrial, :, :))))), 1 : size(PSCaTraces, 2));
PSCaTraces(:, emptyTrials, :, :) = [];

end

function PSCaTrace = extractPSTraceForROI(caTraces, stims, nStims, nTrials, nPeriStimFrames, stimTypes, PSFrames)
    % collect relevant data, ignoring empty runs
    concatCaTraces = []; concatStims = [];
    % go trough each repetition
    for iPFTrial = 1 : nTrials;
        if ~isempty(caTraces(iPFTrial, :)); % ignore empty runs
            concatCaTraces = cat(2, concatCaTraces, caTraces(iPFTrial, :));
            concatStims = cat(2, concatStims, stims(iPFTrial, :));
        end;
    end;
    % extract the peri-stimulus averages
    PSCaTrace = extractPSTraceSingleTrace(concatCaTraces, concatStims, stimTypes, PSFrames.base, PSFrames.evoked);
    % pad with nans
    PSCaTrace = cat(2, PSCaTrace, nan(numel(stimTypes), nStims - size(PSCaTrace, 2), nPeriStimFrames));
end