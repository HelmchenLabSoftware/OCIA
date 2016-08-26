function [soundToPlay, sampFreq] = INGetSoundStim(this, varargin)
% INGetSoundStim - [no description]
%
%       [soundToPlay, sampFreq] = INGetSoundStim(this, showSpectrogram)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% extract the parameters structure
params = this.in.(this.in.expMode);
comParams = this.in.common;

% get the correct sampling frequency
sampFreq = iff(ismember(comParams.stimMode, { 'TDT', 'trigIn' }), comParams.TDTSampFreq, comParams.standardSampFreq);

% init to empty
soundToPlay = [];

% setup stimulus depending on the requested sound type
switch comParams.soundType;

    % pure tones
    case 'pure tone';

        switch this.in.expMode;
            
            case 'standard';
            %% Pure tone - standard

                % build the pure tone: find the number of tones based on the duration parameters
                totDur = params.stdStimDur;
                singleToneTotDur = params.stdToneDur + params.stdToneISI;
                % calculate number of tones
                nTones = floor((totDur + params.stdToneISI) / singleToneTotDur);
                % create a single pure tone
                soundToPlaySingle = makePureTone(params.stdBaseFreq, params.stdToneDur, sampFreq, comParams.rampFrac);
                % add the tone ISI
                nSamplesISI = round(sampFreq * params.stdToneISI);
                soundToPlayWithISI = [soundToPlaySingle zeros(1, nSamplesISI)];
                % create the concatenation of all tones
                soundToPlay = repmat(soundToPlayWithISI, 1, nTones);
                % remove last ISI
                soundToPlay(end + 1 - nSamplesISI : end) = [];
                
                % show spectrogram
                if ~isempty(varargin) && numel(varargin{1}) == 1 && varargin{1} ~= 0;
                    soundToPlay = [soundToPlay zeros(1, 11 * sampFreq + nSamplesISI)];
                    figure('Name', 'Spectrogram', 'NumberTitle', 'off', 'WindowStyle', 'docked');
                    [~, F, T, P] = spectrogram(soundToPlay, 1024, 1000, 1024, sampFreq);
                    P = repmat(P, 1, 3); T = [T 2 * T 3 * T];
                    imagesc(T, F / 1000, log10(abs(P) + eps) * 10);
                    makePrettyFigure();
                    colormap(gcf, 'gray_reverse');
                    set(gca, 'YLim', [4.6 7.4]);
                    set(gca, 'YDir', 'normal', 'CLim', [-52 -51], 'XLim', [-0.01 T(end) + 0.01]);
                    xlabel('Time [s]', 'FontSize', 18);
                    ylabel('Pitch [kHz]', 'FontSize', 18);
                    export_fig('spectrogram_standard_pureTone.png', gcf);
                end;

                % show message
                showMessage(this, sprintf(['Intrinsic: stimulus ''standard'' & ''pure tone'' ... (nTones = %02d, ', ...
                    'exp. dur.: %.3f, real dur.: %.3f)'], nTones, totDur, numel(soundToPlay) / sampFreq), 'yellow');

            case 'fourier';
            %% Pure tone - fourier

                % get the frequencies composing the ramp
                uniqueFreqs = params.fouBaseFreq * (2 .^ ((0 : params.fouNFreqs - 1) * (2 ^ params.fouPowOf2)));

                % invert the direction if needed
                uniqueFreqs = iff(strcmp(this.in.fourier.sweepDir, 'up'), uniqueFreqs, fliplr(uniqueFreqs));

                % simple single-tone sweep
                if params.nTones == 1 && (isempty(params.fouToneITI) || params.fouToneITI == 0);
                    % calculate frequencies of stimulation for any and each frequency
                    nStimsPerSweep = numel(uniqueFreqs);
                    stimISIDur = (params.sweepDur / nStimsPerSweep) - params.fouStimDur;                    
                    stimFreqAll = 1 / (stimISIDur + params.fouStimDur);
                    stimFreqSingle = 1 / ((stimISIDur + params.fouStimDur) * nStimsPerSweep);

                    % check for consistency of durations
                    if stimISIDur <= 0;
                        showWarning(this, 'OCIA:INGetSoundStim:stimISITooShort', sprintf(['Intrinsic: with %d stimFreqs', ...
                            ', a stimSweepDur of %.3f sec and stimToneDur (%.3f sec) then stimISI (%.3f sec) <= 0 !'], ...
                            nStimsPerSweep, params.sweepDur, params.fouStimDur, stimISIDur));
                        set(this.GUI.handles.in.testStimBut, 'Value', 0, 'Enable', 'on', 'BackgroundColor', ones(3, 1) * 0.941);
                        return;
                    end;

                    % build sound stimulation: get the pure tones as cell array
                    stimsCell = makePureTone(uniqueFreqs, params.fouStimDur, sampFreq, comParams.rampFrac);
                    if ~iscell(stimsCell); stimsCell = { stimsCell }; end;
                    stimISI = zeros(1, round(stimISIDur * sampFreq)); % get the inter-stimulus interval
                    stimsMat = cell2mat(stimsCell); % get the tones cell as matrix
                    % append the inter-stimulus intervals to each tone
                    stimsMatWithStimISI = [stimsMat repmat(stimISI, nStimsPerSweep, 1)];
                    % linearize everything as one sound (a stimISI is still at the end)
                    stim = reshape(stimsMatWithStimISI', 1, numel(stimsMatWithStimISI));
                  
                % multi-tone with specified ITI
                elseif params.nTones >= 1 && ~isempty(params.fouToneITI);
                    
                    % build sound stimulation: get the pure tones as cell array
                    stimsCell = makePureTone(uniqueFreqs, params.fouStimDur, sampFreq, comParams.rampFrac);
                    if ~iscell(stimsCell); stimsCell = { stimsCell }; end;
                    % get the inter-stimulus interval
                    stimITI = zeros(1, round(params.fouToneITI * sampFreq));
                    singleStimDur = params.nTones * (params.fouToneITI + params.fouStimDur) * sampFreq;
                    % create repetitions with ITI
                    stimsWithITI = cell(size(stimsCell));
                    for iStim = 1 : numel(stimsCell);
                        for iTone = 1 : params.nTones;
                            stimsWithITI{iStim} = [stimsWithITI{iStim} stimsCell{iStim} stimITI];
                        end;
                    end;
                    % get the tones cell as matrix
                    stimsMat = cell2mat(stimsWithITI);
                    % linearize everything as one sound (a stimITI is still at the end)
                    stim = reshape(stimsMat', 1, numel(stimsMat));
                    stim = stim(1 : min(round(singleStimDur * numel(uniqueFreqs)), numel(stim)));
                    % extend the sweep to the real duration of the sweep
                    stim = [stim zeros(1, round(params.sweepDur * sampFreq) - numel(stim))];
                    
                    %{
                    
                    % debug plots
                    plot((1 : numel(stim)) / sampFreq, stim);
                    
                    %}
                   
                    stimFreqAll = 0;
                    stimISIDur = 0;
                    stimFreqSingle = 1 / params.sweepDur;
                    
                else
                    showWarning(this, 'OCIA:INGetSoundStim:badParams', ...
                        sprintf('Intrinsic: bad parameters specified: %d tone(s) and %.1f tone ITI. Aborting.', ...
                        params.nTones, params.fouToneITI));
                    set(this.GUI.handles.in.testStimBut, 'Value', 0, 'Enable', 'on', 'BackgroundColor', ones(3, 1) * 0.941);
                    return;
                    
                end;
                
                % modulate sound amplitude
                soundToPlay = stim * comParams.amplifFactor;

                 % show message
                showMessage(this, sprintf(['Intrinsic: stimulus ''fourier'' & ''pure tone'' ... ', ...
                    '(%.1fkHz -> %.1fkHz, exp. dur.: %.3f, real dur.: %.3f, stimISI: %.5f, single tone''s ', ...
                    'frequency: %.3f, any tone''s frequency: %.3f)'], ...
                    uniqueFreqs(1) / 1000, uniqueFreqs(end) / 1000, params.sweepDur, ...
                    numel(soundToPlay) / sampFreq, stimISIDur, stimFreqSingle, stimFreqAll), 'yellow');
                
            % show spectrogram
            if ~isempty(varargin) && numel(varargin{1}) == 1 && varargin{1} ~= 0;
                soundToPlay = repmat(soundToPlay, [1, 3]);
                figure('Name', 'Spectrogram', 'NumberTitle', 'off', 'WindowStyle', 'docked');
                [~, F, T, P] = spectrogram(soundToPlay, 1024, 1000, 1024, sampFreq);
                imagesc(T, F / 1000, log10(abs(P) + eps) * 10);
%                 set(gca, 'YLim', [floorn(uniqueFreqs(1) / 1000, 1), ceiln(uniqueFreqs(end) / 1000, 1)]);
                set(gca, 'YLim', [0 70]);
                set(gca, 'YTick', [4 8 16 32 64], 'YTickLabel', [4 8 16 32 64]);
                makePrettyFigure();
                colormap(gcf, 'gray_reverse');
                set(gca, 'YDir', 'normal', 'CLim', [-52 -51], 'XLim', [-0.01 3.01]);
                xlabel('Time [s]', 'FontSize', 18);
                ylabel('Pitch [kHz]', 'FontSize', 18);
                export_fig('spectrogram_fourier_pureTone.png', gcf);
            end;

            otherwise
                % show message and set back GUI
                showWarning(this, 'OCIA:INGetSoundStim:UnknownExpMode', sprintf('Unknown experiment mode: "%s".', ...
                    this.in.expMode));
                set(this.GUI.handles.in.testStimBut, 'Value', 0, 'Enable', 'on', 'BackgroundColor', ones(3, 1) * 0.941);
                return;

        end; % end of expMode switch

    % cloud of tones
    case 'COT';

        switch this.in.expMode;

            case 'standard';
            %% COT - standard

                % build the cloud of tones
                uniqueFreqs = params.stdBaseFreq * (2 .^ ((0 : params.stdNFreqs - 1) * (2 ^ params.stdPowOf2)));
                warning('off', 'MakeCloudOfTonesSound:NumberOfTonesMismatch');
                COT = MakeCloudOfTonesSound(uniqueFreqs, params.stdCloudCenter, params.stdCloudDispersion, 1, ...
                    params.stdToneDur, params.stdToneISI, params.stdStimDur, 0, sampFreq, 0, 0);
                warning('on', 'MakeCloudOfTonesSound:NumberOfTonesMismatch');
                soundToPlay = COT{1};

                 % show message
                showMessage(this, sprintf('Stimulus ''standard'' & ''COT'' ...'), 'yellow');

            case 'fourier';
            %% COT - fourier

                soundToPlay = zeros(1, 1);
                showMessage(this, sprintf('Stimulus ''fourier'' & ''COT'' is not implemented.'), 'red');

            otherwise
                % show message and set back GUI
                showWarning(this, 'OCIA:INGetSoundStim:UnknownExpMode', sprintf('Unknown experiment mode: "%s".', ...
                    this.in.expMode));
                set(this.GUI.handles.in.testStimBut, 'Value', 0, 'Enable', 'on', 'BackgroundColor', ones(3, 1) * 0.941);
                return;

        end; % end of expMode switch

    % other sound types are unknown
    otherwise;
        % show message and set back GUI
        showWarning(this, 'OCIA:INGetSoundStim:UnknownSoundType', sprintf('Unknown sound type: "%s".', ...
            comParams.soundType));
        set(this.GUI.handles.in.testStimBut, 'Value', 0, 'Enable', 'on', 'BackgroundColor', ones(3, 1) * 0.941);
        return;
end;

% adjust sound intensity
soundToPlay = soundToPlay * comParams.amplifFactor;

% wavwrite(soundToPlay, sampFreq, 'sound.wav');
    
end
