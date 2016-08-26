function OCIA_analysis_widefield_addParamPanConfigUIControls(this, excludeIDs, appendTable)
% OCIA_analysis_widefield_addParamPanConfigUIControls - [no description]
%
%       OCIA_analysis_widefield_addParamPanConfigUIControls(this)
%       OCIA_analysis_widefield_addParamPanConfigUIControls(this, excludeIDs)
%       OCIA_analysis_widefield_addParamPanConfigUIControls(this, excludeIDs, appendTable)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
if ~ismember('nBins', this.GUI.an.paramPanConfig.id);
    paramConf = cell2table({ ...
    ... categ  id                       UIType  valueType       UISize  isLabAbove  label               tooltip
        'wf',  'nBins',                 'text', { 'array' },    [1 0],  false,      'Num. bins',        'Number of bins for the pixel time course.';
        'wf',  'frameRange',            'text', { 'array' },    [1 0],  false,      'Frame range',      'Frame range to use (use "[1 Inf]" for all frames).';
        'wf',  'cropRect',              'text', { 'array' },    [1 0],  true,       'Crop rect.',       'Crop rectangle position as [X Y W H]. No cropping if empty.';
        'wf',  'imRotationAngle',       'text', { 'numeric' },  [1 0],  true,       'Rot. angle',       'Rotation angle for all frames.';
        'wf',  'BLCorrMethod',          'dropdown', { 'none', 'mean', 'slidingAvg', 'bpfilter', 'polynomial' }, ...
                                                                [1 0],  false,      'BL corr. meth.',   'Baseline correction method: "none", "mean", "slidingAvg", "bpfilter", "polynomial".';
        'wf',  'BLCorrParam',           'text', { 'array' },    [1 0],  false,      'BL corr. param.',  'Baseline correction parameter.';
        'wf',  'chunkSizeFactor',       'text', { 'array' },    [1 0],  false,      'Chunk fact.',      'Number of chunks to use for the pixel time course extraction (low = memory, high = speed).';
        'wf',  'stimFreq',              'text', { 'numeric' },  [1 0],  false,      'Stim. freq.',      'Frequency (in Hertz) of stimulation for a single tone/pitch.';
        'wf',  'stimFreqInterval',      'text', { 'numeric' },  [1 0],  false,      'Freq. interv.',    'Frequency interval (in Hertz) relative to the stimulation frequency that is still used for the power & phase map (stimFreq +- stimFreqInterval)';
        'wf',  'powerMapFilt',          'text', { 'array' },    [1 0],  true,       'Filt. set.',       'Filtering parameters: [gaussX gaussY gaussSigma medianX medianY]. Use 0 to desactivate.';
        'wf',  'powerMapThresh',        'text', { 'array' }     [1 0],  true,       'Thresh.',          'Thresholds to mask.';
        'wf',  'phaseMapFilt',          'text', { 'array' },    [1 0],  true,       'Filt. set.',       'Filtering parameters: [gaussX gaussY gaussSigma medianX medianY]. Use 0 to desactivate.';
        'wf',  'phaseMapDelay',         'text', { 'numeric' },  [1 0],  true,       'Delay',            'Phase map delay in seconds.';
        'wf',  'phaseMapShift',         'text', { 'array' },    [1 0],  true,       'Shift',            'Phase map shift in radiants.';
        'wf',  'baseFrames',            'text', { 'array' },    [1 0],  false,      'Baseline',         'Frame numbers for baseline.';
        'wf',  'evokedFrames',          'text', { 'array' },    [1 0],  false,      'Evoked',           'Frame numbers for evoked response.';

    }, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
    % append the new configuration to the table and update the row names using the ids
    this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
    this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;
end;

% remove unwanted IDs
if exist('excludeIDs', 'var') && ~isempty(excludeIDs);
    
    % cell-array of strings with IDs
    if iscellstr(excludeIDs);
        this.GUI.an.paramPanConfig(ismember(this.GUI.an.paramPanConfig.id, excludeIDs), :);
        
    % regexp exclude
    elseif ischar(excludeIDs);
        IDs = this.GUI.an.paramPanConfig.id;
        for iID = 1 : numel(IDs);
            ID = IDs{iID};
            if ~isempty(regexp(ID, excludeIDs, 'once'));
                this.GUI.an.paramPanConfig(ID, :) = [];
            end;
        end;
    end;
end;

% append the input configuration to the table and update the row names using the ids
if exist('appendTable', 'var') && ~isempty(appendTable);
    % turn cell-array into table
    if iscell(appendTable);
        appendTable = cell2table(appendTable, 'VariableNames', ...
            this.GUI.an.paramPanConfig.Properties.VariableNames);
    end;
    this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; appendTable];
    this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;
end;

end
