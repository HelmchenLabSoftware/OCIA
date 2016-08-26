function toneArray = MakePureToneArray_duration(varargin)
% generate a pure tone series with different tone durations
% in1 ... vector of durations in s
% in2 ... stimulus vector with 1, 2, 3 etc. specifying the tone frequency
% in3 ... frequency in Hz (each tone)
% in4 ... sampling frequency in Hz {44100}
% out1 ... cell array of tone vectors

% for each value in stimulus vector, a tone vector is generated with a
% frequency depepnding on frequency in in1
% example:
% durVector = [0.3 0.5]
% stimVector = [1 1 2 2 1 1 2 2]

% this file written by Henry Luetcke (hluetck@gmail.com)

durVector = varargin{1};
stimVector = varargin{2};

if max(stimVector) > numel(durVector)
    error('Specify as many frequencies as there are condition in stimVector');
end

f = varargin{3};
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
   toneArray{n} = makePureTone(f,durVector(stimVector(n)),sampleFreq);
end


