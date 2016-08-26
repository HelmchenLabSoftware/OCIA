function s = makePureTone_new(freqs,duration,varargin)
% generate a pure tone
% in1 ... carrier frequency in Hz
% in2 ... duration in s
% in3 ... sampling frequency in Hz {44100}
% in4 ... play tone {0}; 0 or 1
% in5 ... save wav file {[]}; filename of wav file
% out1 ... the sound vector s

% this file written by Henry Luetcke (hluetck@gmail.com)

if nargin > 2
    sf = varargin{1};
    if isempty(sf)
        sf = 44100;
    end
else
    sf = 44100;
end

if nargin > 3
    doPlay = varargin{2};
else
    doPlay = 0;
end

if nargin > 4
    saveWav = varargin{3};
else
    saveWav = [];
end

modFreq = 0; % modulation frequency
modIndex = 1; % modulation index
rampDur = 0.1; % ramp duration (fraction of total duration, max. 0.5)

for i = 1:length(freqs)
    % make the sound
    s = MakeSound(sf,duration,freqs(i),modFreq,modIndex,rampDur);
    
    if doPlay
        sound(s,sf);
    end
    if ~isempty(saveWav)
        wavwrite(s,sf,16,saveWav);
    end
end


function s = MakeSound(sf,d,f,mf,mi,rd)

% frequency modulated sound
n = sf * d;                    % number of samples
c = (1:n) / sf;                % carrier data preparation
c = 2 * pi * f * c;
% m = (1:n) / sf;                % modulator data preparation
% m = mi * cos(2 * pi * mf * m); % sinusoidal modulation
m = 0;
s = sin(c + m);                % frequency modulation

% ramp
rd = d .* rd;
nr = floor(sf * rd);
r = sin(linspace(0, pi/2, nr));
r = [r, ones(1, n - nr * 2), fliplr(r)];
% make ramped sound
s = s .* r;


