function rasterPlotSpikeTimes(spkT,dur)
% spkT ... cell array of spike times / s
% dur ... total duration / s

% tic
% h = figure('Name','Raster plot','NumberTitle','off');
% for n = 1:length(spkT)
%     spikes = spkT{n};
%     plot(spikes,repmat(n,1,numel(spikes)),'k.'), hold on
%     % average firing rate
%     spikeRate = numel(spikes) / dur;
% %     fprintf('Neuron %1.0f: %1.2f Hz\n',n,spikeRate);
% end
% set(gca,'xlim',[0 dur+(dur*0.01)],'ylim',[0 n+1])
% toc

% tic
h = figure('Name','Raster plot','NumberTitle','off');
for n = 1:length(spkT)
    spikes = spkT{n};
    plot([spikes; spikes],[repmat(n-0.3,1,length(spikes)); ...
        repmat(n+0.3,1,length(spikes))],'k'), hold on
    % average firing rate
%     spikeRate = numel(spikes) / dur;
    %     fprintf('Neuron %1.0f: %1.2f Hz\n',n,spikeRate);
end
set(gca,'xlim',[0 dur+(dur*0.01)],'ylim',[0 n+1])
% toc

