function [SpkTime,ISIs] = InHomoPoisSpkGen(r, t, rmax)


% [ISIs] = InHomoPoisSpkGen(r, t, rmax)
% 
% by Nuo Li
% 3/27/06
% 
% Takes in a firing rate r as a function of time t, and generate Inhomogeneous
% Poisson spike train. rmax is optional input specify the maximum firing
% rate of the neuron. rmax = 80Hz is the default value. 

if nargin==2
    rmax=80;
end

if length(r)~=length(t)
    help InHomoPoisSpkGen
    error('r and t have to agree in size')
end

% First Generate Homogeneous Poisson Spike Train at rmax
deltaT=0.001;
SpkTime=[];
% Generating spikes from a exponential distribution
for time=0:deltaT:t(end)
    if (rmax*deltaT)>=rand(1)
        SpkTime(end+1,1)=time;
    end
end


%Spike thinning
for i=1:size(SpkTime,1)
    time=SpkTime(i,1);
    indx=find(t<time);
    if isempty(indx)
        indx=1;
    else
        indx=indx(end);
    end
    rest=r(indx);
    
    if rest/rmax<rand(1)
        SpkTime(i,1)=nan;
    end
end

SpkTime(find(isnan(SpkTime)))=[];


% Computing ISIs
ISIs=diff(SpkTime);