function [results,gof,fitData,residual] = fitSpike_exponential(time,...
    data,varargin)
% fit single spike with double exponential model
% parameters:
% amplitude, onset, tauOn, tauOff
% data ... segmented spike data
% time ... corresponding time vector
% varargin{1} ... vector of lower bounds
% varargin{2} ... vector of upper bounds
% varargin{3} ... vector of startpoints
% varargin{4} ... max fun eval {2000}
% varargin{5} ... max iter {2000}
% this file written by Henry Luetcke (hluetck@gmail.com)

% ensure column vectors
time = reshape(time,numel(time),1);
data = reshape(data,numel(data),1);

time = time - time(1);
% data = ScaleToMinMax(data,0,1); % this should ensure that a = 1

defaultAmpLower = 0;
defaultAmpUpper = 100*(max(data)-min(data));
defaultAmpStart = max(data)-min(data);

defaultOnsetLower = 0;
defaultOnsetUpper = max(time);
defaultOnsetStart = 0;

defaultTauOnLower = 0.001 / 1000; % 1 us
defaultTauOnUpper = 1 / 1000; % 1 ms
defaultTauOnStart = 0.05 / 1000; % 50 us

defaultTauOffLower = 0.1 / 1000; % 100 us
defaultTauOffUpper = 5 / 1000; % 5 ms
defaultTauOffStart = 0.5 / 1000; % 500 us

% boundary and start points for parameters
% a, onset, tauOn, tauOff / all times in s
if nargin > 2
   lowerBounds = varargin{1};
else
   lowerBounds = [defaultAmpLower defaultOnsetLower defaultTauOnLower ...
       defaultTauOnLower];
end

if nargin > 3
   upperBounds = varargin{2};
else
   upperBounds = [defaultAmpUpper defaultOnsetUpper defaultTauOnUpper ...
       defaultTauOnUpper];
end

if nargin > 4
   startPoints = varargin{3};
else
    startPoints = [defaultAmpStart defaultOnsetStart defaultTauOnStart ...
       defaultTauOnStart];
end

if nargin > 5
    maxFunEvals = varargin{4};
else
    maxFunEvals = 2000;
end

if nargin > 6
    maxIter = varargin{5};
else
    maxIter = 2000;
end

s = fitoptions('Method','NonlinearLeastSquares',...
    'Lower',lowerBounds, 'Upper',upperBounds,...
    'Startpoint',startPoints, 'MaxFunEvals',maxFunEvals,'MaxIter',maxIter);

f = fittype('expRiseDecay(x,a,onset,tauOn,tauOff,c)','problem','c','options',s);

[results,gof] = fit(time,data,f,'problem',min(data));

figure
plot(time,data,'k'), hold on
plot(results)

coef = coeffvalues(results);

fitData = expRiseDecay(time,coef(1),coef(2),coef(3),coef(4),min(data));

residual = data - fitData;





