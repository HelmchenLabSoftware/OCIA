function cloudOfTones = MakeCloudOfTonesSound(freqs, uniqueCloudCenterIndexes, cloudDispersion, stims, toneDur, ...
    toneISI, stimDur, atten, sampFreq, doPlot, doPlay)


% code for playing :
%{

% both sounds
a = MakeCloudOfTonesSound(4000 * (2 .^ (((1 : 33) - 1) * (2 ^ -4))), [3, 10], 3, [1 2 1 2], 0.03, 0.01, 0.5, 0, 44100, 1, 1);
cotAll = cell2mat(a);
cotAll = [cotAll zeros(4, 44100 * 1)];
cotAllLin = reshape(cotAll', 1, numel(cotAll));
lowCloud = a{1};
highCloud = a{2};
wavwrite(lowCloud, 44100, 'lowCloud.wav');
wavwrite(highCloud, 44100, 'highCloud.wav');

wavwrite(cotAllLin, 44100, ...
    'W:\Neurophysiology\Projects\Auditory\Presentations\2015\Balazs\2015_04_28_HifoDay\CloudOfTones1502_chronic.wav');



cot = MakeCloudOfTonesSound(5000 * (2 .^ (((1 : 25) - 1) * (2 ^ -3))), [3 23], 2, [1 2 1 2], 0.03, 0.01, 0.5, 0, 44100, 1, 0)
cotAll = cell2mat(cot);
cotAll = [cotAll zeros(4, 44100 * 1)];
sound(reshape(cotAll', 1, numel(cotAll)), 44100)
%}

% set(0, 'DefaultFigureWindowStyle', 'docked', 'DefaultFigureNumberTitle', 'off');
% set(0, 'DefaultFigureWindowStyle', 'normal', 'DefaultFigureNumberTitle', 'off');

%% default parameters
% toneDur = 0.03; % sec
% toneISI = 0.01; % sec
% freqs = 4000 * (2 .^ (((1 : nFreqs) - 1) * 0.25)); % kHz
% nTrials = 6;

%% parameters
% doPlot = 0;
% doPlay = 1;
useSameCloudForEachCenter = 0;
randomizeToneAmplitudes = 0;
maxToneAmplRand = 1.0; minToneAmplRand = 0.5; %#ok<NASGU>
randomizeCloudAmplitudes = 0;
maxCloudAmplRand = 1.0; minCloudAmplRand = 0.25; %#ok<NASGU>

nFreqs = numel(freqs);
nTrials = numel(stims);
nCenters = numel(uniqueCloudCenterIndexes);
rampDur = 0.05; % in percent
% stimDur = nTones * toneISI + (toneDur - toneISI); % from nTones to stimDur
nTones = round((stimDur - (toneDur - toneISI)) / toneISI); % from stimDur to nTones

%% create tones for the cloud
countsForCenter = cell(nCenters, 1);


if doPlot > 0; figure('Name', 'Cloud dispersions'); end;
    
for iCenter = 1 : nCenters;
    
    centerFreq = freqs(uniqueCloudCenterIndexes(iCenter)) / 1000;
    
    p = 1.96; % corresponds to 95% of the values on a gaussian
    % standardization of the cloud's disperion by 'p' (1.96) which results in having e.g. 95% of the gaussian curve
    sigm = cloudDispersion / p;
    center = uniqueCloudCenterIndexes(iCenter); % get the current center index
    grain = 10000; % increase the granularity between the indexes for a more precise distribution
    x = 0 : 1 / grain : nFreqs; % create the x values on which to calculate the gaussian distribution
    distr = gaussmf(x, [sigm center]); % create the distribution
    % count the number of tones at each index of the distribution (use grain for better precision)
    counts = round(distr(round((1 : nFreqs) * grain)) * grain);
    % normalize using the total number of counts and the requested number of tones
    counts = round((counts ./ sum(counts)) * nTones);
    
    if sum(counts) ~= nTones;
        
        diff = sum(counts) - nTones;
        
        % one missing tone, add it
        if diff == -1;
            [maxCount, maxCountIndex] = max(counts);
            counts(maxCountIndex(1)) = maxCount + 1;
        % one extra tone, remove it
        elseif diff == 1;
            [maxCount, maxCountIndex] = max(counts);
            counts(maxCountIndex(1)) = maxCount - 1;
        % more complicated, throw warning
        else
            oldNTones = nTones;
            oldStimDur = stimDur;
            nTones = sum(counts);
            stimDur = nTones * toneISI + (toneDur - toneISI);
            warning('MakeCloudOfTonesSound:NumberOfTonesMismatch', ...
                ['Requested stimulus duration: %6.4f, required number of tones: %d, actual number of tones: %d. ' ...
                'Thus your total stimulus duration will be: %6.4f.'], oldStimDur, oldNTones, nTones, stimDur);
        end;
    end;
    
    countsForCenter{iCenter} = counts; % store it

    if doPlot > 0;
        subplot(nCenters, 1, iCenter);
        plot(x, distr * max(counts), 'b--');
        set(gca, 'XTick', 1 : numel(freqs), 'XTickLabel', arrayfun(@(f)sprintf('%3.1f', f), ...
            freqs / 1000, 'UniformOutput', false));
%         set(gca, 'YTick', 0 : 0.1 : 1, 'YTickLabel', 0 : max(counts) / 10 : max(counts));
%         set(gca, 'YTickLabel', get(gca, 'YTick') * max(counts));
        xlabel('Frequencies [kHz]');
        ylabel('Number of tones');
        halfWidth = p * sigm; % get the half width
        leftBound = max(center - halfWidth, 1); % calculate left boundary
        rightBound = min(center + halfWidth, nFreqs); % calculate right boundary
        % plot with lines the left and right boundaries and the center
        line(repmat(leftBound, 1, 2), [0 1], 'Color', repmat(0.7, 1, 3), 'LineStyle', '--');
        line(repmat(rightBound, 1, 2), [0 1], 'Color', repmat(0.7, 1, 3), 'LineStyle', '--');
        line(repmat(center, 1, 2), [0 1], 'Color', 'green', 'LineStyle', ':');
        hold on;
        distrTrunk = distr;
        distrTrunk(1 : round(leftBound) * grain) = 0;
        distrTrunk(round(rightBound) * grain : end) = 0;
        plot(x, distrTrunk * max(counts), 'r');
        hold on;
        bar(counts, 'FaceColor', 'none');
        title(sprintf('Center freq.: %4.2fkHz, dispersion: %4.2fkHz - %4.2fkHz, nTones: %d, stimDur: %6.4f', ...
            centerFreq, freqs(leftBound) / 1000, freqs(rightBound) / 1000, nTones, stimDur));
        xlim([0 numel(freqs) + 1]);
        ylim([0 max(counts) * 1.2]);
    end;
end;

%% Distribute the frequencies using the timing to form a cloud
if doPlot > 0; figure('Name', 'CloudOfTones', 'NumberTitle', 'off'); end;
tonesFreq = cell(nTrials, 1);
cloudOfTones = cell(nTrials, 1);
cloudAttenuations = cell(nTrials, 1);

if useSameCloudForEachCenter;
    tonesFreqPerm = randperm(nTones); %#ok<UNRCH>
end;
            
for iTrial = 1 : nTrials;
    tonesFreq{iTrial} = zeros(nTones, 1);
    for iFreq = 1 : nFreqs;
        first0Index = find(tonesFreq{iTrial} == 0, 1, 'first');
        tonesFreqForCurrFreq = repmat(iFreq, 1, countsForCenter{stims(iTrial)}(iFreq));
        if ~isempty(tonesFreqForCurrFreq);
            tonesFreq{iTrial}(first0Index : first0Index + numel(tonesFreqForCurrFreq) - 1) = tonesFreqForCurrFreq;
        end;
    end;
    
    if ~useSameCloudForEachCenter;
        tonesFreqPerm = randperm(nTones);
    end;
    tonesFreq{iTrial} = tonesFreq{iTrial}(tonesFreqPerm);
    
    cloudOfTone = nan(1, ceil(sampFreq * stimDur));
    colors = lines(nTones);
    for iTone = 1 : nTones;
        toneFreq = freqs(tonesFreq{iTrial}(iTone));
        tone = makePureTone(toneFreq, toneDur, sampFreq);
        
        % randomize the amplitude of each tone
        if randomizeToneAmplitudes;
            tone = tone .* (rand .* (maxToneAmplRand - minToneAmplRand) + minToneAmplRand); %#ok<UNRCH>
        end;
        
        nSamples = numel(tone);
        startIndex = round(((iTone - 1) * toneISI * sampFreq) + 1);
        presentSamples = cloudOfTone(startIndex : startIndex + nSamples - 1);
        presentSamples(isnan(presentSamples)) = 0;
        cloudOfTone(startIndex : startIndex + nSamples - 1) = presentSamples + tone;
        
        if doPlot > 0;
            subplot(2, nTrials, iTrial + nTrials);
            jitterFactor = 0; % jittering in Y position of lines
            line([startIndex, startIndex + nSamples - 1] / sampFreq, ...
                repmat(toneFreq / 1000, 2, 1) + ((1 + rand - 0.5) * jitterFactor), 'Color', colors(iTone, :));
            hold on;
        end;
    end;
    
    % normalize by the absolute maximum
    cloudOfTone = cloudOfTone ./ max(abs(cloudOfTone));
    
    % make a ramp
    nSamples = numel(cloudOfTone);
    totRampDur = stimDur .* rampDur;
    nSamplesRamp = ceil(sampFreq * totRampDur);
    rampIntensity = sin(linspace(0, pi / 2, nSamplesRamp));
    totRampIntensity = [rampIntensity, ones(1, nSamples - nSamplesRamp * 2), fliplr(rampIntensity)];
    % apply the ramp
    cloudOfTone = cloudOfTone .* totRampIntensity;
    
    % randomize the amplitude of each tone
    if randomizeCloudAmplitudes;
        cloudAttenuations{iTrial} = (rand .* (maxCloudAmplRand - minCloudAmplRand) + minCloudAmplRand); %#ok<UNRCH>
        cloudOfTone = cloudOfTone .* cloudAttenuations{iTrial};
    end;
    
    % attenuate
    cloudOfTone = cloudOfTone .* (1 - (atten / 100));
    
    % remove NaNs
    cloudOfTone(isnan(cloudOfTone)) = 0;
    
    % store the cloud of tone sound
    cloudOfTones{iTrial} = cloudOfTone;
    
    if doPlot > 0;
        centerFreq = freqs(uniqueCloudCenterIndexes(stims(iTrial))) / 1000;
        
        subplot(2, nTrials, iTrial);
        plot((1 : numel(cloudOfTone)) / sampFreq, cloudOfTone);
        xlim([0, stimDur]);
        ylim([-2, 2]);
        title(sprintf('%4.2f kHz / att: %4.2f', centerFreq, cloudAttenuations{iTrial}));
        xlabel('Time [s]');
        ylabel('Amplitude');

        subplot(2, nTrials, iTrial + nTrials);
        xlim([0, stimDur]);
        ylim([freqs(1) - (freqs(2) - freqs(1)), freqs(end) + (freqs(end) - freqs(end - 1))] / 1000);
        xlabel('Time [s]');
        ylabel('Frequencies [kHz]');
        title(sprintf('%4.2f kHz', centerFreq));
    end;
    
end;


%% randomize amplitude !!!!
%% "The stream of tones continued until the rat withdrew from the centre port"
%% "Sound intensity of individual tones was constant during each trial. To discourage subjects from using loudness
%% differences in discrimination, tone intensity was randomly selected on each trial from a uniform distribution
%% 45?to 75?dB (SPL) during training. During manipulation and recording sessions, sound intensity was kept
%% constant at 60?dB."

%% play the cloud
if doPlay;
%     o('Frequencies [kHz]: %s', sprintf('%4.2f ', freqs / 1000), 0, 0);
%     o('Attenuation: %4.2f ', atten, 0, 0);
    for iTrial = 1 : nTrials;
        centerFreq = freqs(uniqueCloudCenterIndexes(stims(iTrial))) / 1000;
%         o('Playing cloud of tones with center: %4.2f kHz', centerFreq, 0, 0);
        sound(cloudOfTones{iTrial}, sampFreq);
        pause(0.6);
    end;
end;

end

