function [SpkTime ISIs AFR CV Fano] = HomoPoisSpkGen(r, t)

% Nuo Li
% 3/24/06
%
% [ISIs AFR CV Fano] = HomoPoisSpkGen(r, t)
%
% Generates Homogenous Poisson Spike Train for a time period t at firing
% rate r. 
% The function returns the inter-spike interval (ISIs) and average firing
% rate AFR along with spike train statistics: Coefficient of variante(CV)
% and Fano factor.


% Time step to go by
deltaT=0.001;
% modified HL, 2013-06-19
deltaT = 0.0001;
SpkTime=[];
% Generating spikes from a exponential distribution
for time=0:deltaT:t
    if (r*deltaT)>=rand(1)
        SpkTime(end+1,1)=time;
    end
end


% Computing ISIs and AFR
ISIs=diff(SpkTime);
AFR=size(SpkTime,1)/t;

% Coefficent of variation (CV)
if ~isempty(ISIs)
    CV=std(ISIs)/mean(ISIs);
else
    CV=nan;
end

% Fano Factor (Bined at 50ms)
[SpkCount dummy]=hist(SpkTime, t/0.05);
Fano=var(SpkCount)/mean(SpkCount);