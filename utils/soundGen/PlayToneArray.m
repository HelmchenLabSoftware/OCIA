function PlayToneArray(toneArray,sampleRate,dutyCycle,useTrigger,...
    useInitialTrigger)
% all tones in toneArray should be of equal length
% in1 ... toneArray (see makePureToneArray)
% in2 ... sampleRate {44100}
% in3 ... dutyCycle in s (time between onset of subsequent tones)
% in4 ... use Trigger (overrides dutyCycle), use external trigger to start
% in5 ... use initial trigger to start program
% next tone

% this file written by Henry Luetcke (hluetck@gmail.com)

timeout = 50; % timeout for trigger

if isempty(sampleRate)
    sampleRate = 44100;
end

currentTone = toneArray{1};

duration = numel(currentTone) / sampleRate;
isi = dutyCycle - duration;

if useInitialTrigger
    status = externalTrigger_nidaq(timeout);
    if ~status
        error('Trigger timeout');
    end
end

for n = 1:numel(toneArray)
    currentTone = toneArray{n};
    if useTrigger
        status = externalTrigger_nidaq(timeout);
        if ~status
            error('Trigger timeout');
        end
    else
        pauseTicToc(dutyCycle);
    end
    if ~isempty(currentTone)
        sound(currentTone,sampleRate);
    end
end

