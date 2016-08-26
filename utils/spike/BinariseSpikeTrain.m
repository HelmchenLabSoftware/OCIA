function varargout = BinariseSpikeTrain(spike,spikeFreq)
% threshold spike train and binarise

% this file written by Henry Luetcke (hluetck@gmail.com)

% bandpass filter the spike train (spikes are only a few ms in width)
spike = mpi_BandPassFilterTimeSeries(spike,1/spikeFreq,100,1000);
spikeTime = (1/spikeFreq):(1/spikeFreq):length(spike)/spikeFreq;
spike(spike<mean(spike)) = 0;
max_spike = max(spike);
% threshold at 1/4 of max. spike amplitude
spike_thr = max_spike / 4;
spike_bin = zeros(size(spike));
spike_yn = 0;
spike_count = 0;
for n = 1:length(spike)
    if spike(n) > spike_thr && ~spike_yn
        spike_count = spike_count + 1;
        spike_yn = 1;
        spike_start = n;
    elseif spike(n) <= spike_thr && spike_yn
        spike_yn = 0;
        spike_stop = n;
        current_spike = spike(spike_start:spike_stop);
        max_pos = find(current_spike==max(current_spike));
        spike_events(spike_count) = spike_start + max_pos - 1;
    end
end
if spike_count
    spike_bin(spike_events) = 1;
end

spike_times = spikeTime(spike_bin==1);
varargout{1} = spike_bin;

if nargout == 2
    varargout{2} = spike_times;
end



