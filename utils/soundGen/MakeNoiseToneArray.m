function toneArray = MakeNoiseToneArray(varargin)
% generate a pure tone
% in1 ... cell array of band-limited frequencies in Hz {[lower upper]}
% in2 ... stimulus vector with 1, 2, 3 etc. specifying the noise tone
% in3 ... duration in s (each tone)
% in4 ... sampling frequency in Hz {44100}
% out1 ... cell array of tone vectors

% for each value in stimulus vector, a tone vector is generated with a
% band-limited white noise depepnding on frequencies in in1
% example:
% in1 = {[2000 15000]; [15000 25000]}
% stimVector = [1 1 2 2 1 1 2 2]
% generates 8 tones, 4 with band-limited noise from 2-15kHz and 4 with
% noise band-limited from 15-25kH

% this file written by Henry Luetcke (hluetck@gmail.com)

freqVector = varargin{1};
stimVector = varargin{2};

if max(stimVector) > numel(freqVector)
    error('Specify as many frequencies as there are condition in stimVector');
end

duration = varargin{3};
if nargin > 3
    sampleFreq = varargin{4};
    if isempty(sampleFreq)
        sampleFreq = 44100;
    end
else
    sampleFreq = 44100;
end

toneArrayStims = cell(numel(unique(stimVector)),1);

for n = 1:numel(toneArrayStims)
   if freqVector{n}
       toneArrayStims{n} = makeNoiseTone(freqVector{n},duration,sampleFreq);
   else
       toneArrayStims{n} = [];
   end
end

toneArray = cell(numel(stimVector),1);

for n = 1:numel(stimVector)
    toneArray{n} = toneArrayStims{stimVector(n)};
end


