function s = makeNoiseTone(freqs,duration,varargin)
% generate a pure tone
% in1 ... band-limiting frequencies in Hz [lower upper]
% in2 ... duration in s
% in3 ... sampling frequency in Hz {44100}
% in4 ... play tone {0}; 0 or 1
% in5 ... rd
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
    doPlay = varargin{2};
    rd = varargin{3}; % ramp duration (fraction of total duration, max. 0.5)
else
    rd = 0.05; % ramp duration (fraction of total duration, max. 0.5)
end

s = randn(1,round(sf*duration)); % Noise signal
s = mpi_BandPassFilterTimeSeries(s,1/sf,freqs(1),freqs(2));
s = ScaleToMinMax(s,-1,1);

% ramp
n = round(sf .* duration);
rd = duration .* rd;
nr = floor(sf * rd);
r = sin(linspace(0, pi/2, nr));
r = [r, ones(1, n - nr * 2), fliplr(r)];
% make ramped sound
s = s .* r;

if doPlay
    sound(s,sf);
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


