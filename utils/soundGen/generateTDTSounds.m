function generateTDTSounds

rootPath = 'C:/TDT/sounds/';


%% single cloud of tones
randomSoundID = sprintf('singleCOT_%010d', randi(10E10));
freqs = 4000 * (2 .^ (((1 : 20) - 1) * 0.125));
center
soundDur = 0.21;
dutyCycle = 0.8;
cot = MakeCloudOfTonesSound(4000 * (2 .^ (((1 : 20) - 1) * 0.125)), [4 15], 2, [1 2], 0.03, 0.01, soundDur, 0, TDTSF, 0, 0);
cotAll = cell2mat(cot);
cotAll = [zeros(size(cotAll, 1), round(TDTSF * (dutyCycle - soundDur))) cotAll];
cotAllLin = reshape(cotAll', 1, numel(cotAll));


%% oddbal cloud of tones sequence
soundDur = 0.21;
dutyCycle = 0.8;
cot = MakeCloudOfTonesSound(4000 * (2 .^ (((1 : 20) - 1) * 0.125)), [4 15], 2, [1 2], 0.03, 0.01, soundDur, 0, TDTSF, 0, 0);
cotAll = cell2mat(cot);
cotAll = [zeros(size(cotAll, 1), round(TDTSF * (dutyCycle - soundDur))) cotAll];
cotAllLin = reshape(cotAll', 1, numel(cotAll));



end