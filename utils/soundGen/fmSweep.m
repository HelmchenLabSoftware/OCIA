function [y,t] = fmSweep(f0,f1,sf,dur,varargin)
% f0 ... starting frequency / Hz
% f1 ... final frequency / Hz
% sf ... sampling rate / Hz
% dur ... duration / s

% written by Henry Luetcke (hluetck@gmail.com)

t = 1./sf:1./sf:dur;

y=chirp(t,f0,dur,f1);

if numel(varargin) > 0; % get ramp fraction from input arguments if it exists
    rf = varargin{1};
else
    rf = 0.4; % ramp fraction (time of total)
end;
% prepare ramp
dr = rf*dur;
nr = floor(sf * dr);
r = sin(linspace(0, pi/2, nr));
r = [r, ones(1, numel(t) - nr * 2), fliplr(r)];

% make ramped sound
y = y .* r;

if numel(varargin) > 1; % get if sound should be played or not from input arguments
    shouldPlaySound = varargin{2};
else
    shouldPlaySound = 1;
end;

if shouldPlaySound;
    sound(y,sf)
end;

end
