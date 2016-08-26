function [spike time] = MakePoissonSpikeTrain(time,rate,sampling)
% create train of APs with spikes approximately Poisson-distributed
% in1 ... time / s
% in2 ... rate of spikes / Hz
% in3 ... sampling rate of spike train / Hz

% this file written by Henry Luetcke (hluetck@gmail.com)

Nspikes = rate*time;
ISI = -log(rand(1,Nspikes))/rate;
spikeTimes = cumsum(ISI);
spike = zeros(1,time*sampling);
% [dur,time] = gui_CalculateTimeVector(spike,sampling,[]);
time = linspace(0,numel(spike)/sampling,numel(spike));
for n = 1:length(spikeTimes)
    [C,idx] = min(abs(time-spikeTimes(n)));
    spike(idx(1)) = 1;
end

fprintf('\nCreated spike train with %s spikes\n',...
    int2str(length(find(spike))));
