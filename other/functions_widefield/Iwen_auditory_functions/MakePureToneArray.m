function toneArray = MakePureToneArray(varargin)
% generate a pure tone
% in1 ... vector of frequencies in Hz
% in2 ... stimulus vector with 1, 2, 3 etc. specifying the tone frequency
% in3 ... duration in s (each tone)
% in4 ... sampling frequency in Hz {44100}
% out1 ... cell array of tone vectors

% for each value in stimulus vector, a tone vector is generated with a
% frequency depepnding on frequency in in1
% example:
% freqVector = [10000 15000]
% stimVector = [1 1 2 2 1 1 2 2]
% generates 8 tones, 4 with 10kHz and 4 with 15kHz alternating as specified
% in stimVector

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

toneArray = cell(numel(stimVector),1);

for n = 1:numel(stimVector)
   %toneArray{n} = makePureTone(freqVector(stimVector(n)),duration,sampleFreq);
   toneArray{n} = makePureTone_new(freqVector(stimVector(n)),duration,sampleFreq, 0, []);
end


