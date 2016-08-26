function stim = SoundFile2StimVector(soundFile,soundFreq,stimIDs,imgFreq)

% this file written by Henry Luetcke (hluetck@gmail.com)

[tone,stimOnset] = AnalyzePureToneVector(soundFile,soundFreq,1);
[dur,toneT] = gui_CalculateTimeVector(tone,soundFreq,[]);
dur = max(toneT);
maxFrames = ceil(dur*imgFreq);
stim = zeros(1,maxFrames);

if numel(stimOnset) ~= numel(stimIDs)
   error('Number of stimuli in sound file and stim vector do not match!');
end

for n = 1:numel(stimOnset)
   currentOnset = stimOnset(n);
   currentOnset = round(currentOnset*imgFreq);
   stim(currentOnset) = stimIDs(n);
end

