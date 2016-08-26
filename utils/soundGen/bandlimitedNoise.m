function [y,t] = bandlimitedNoise(fLo,fHi,sf,dur,doOutput,varargin)

t = 1/sf:1/sf:dur;
noise = randn(1,sf*dur); % Noise signal
if doOutput;
    plot(t,ScaleToMinMax(noise,-1,1), 'r');
    sound(noise,sf);
    hold on;
end;

y = mpi_BandPassFilterTimeSeries(noise,1/sf,fLo,fHi);
y = ScaleToMinMax(y,-1,1);

% prepare ramp
rf = 0.1; % ramp fraction (time of total)
dr = rf*dur;
nr = floor(sf * dr);
r = sin(linspace(0, pi/2, nr));
r = [r, ones(1, numel(t) - nr * 2), fliplr(r)];

% make ramped sound
y = y .* r;

if doOutput
    plot(t,y)
    sound(y,sf)
end
