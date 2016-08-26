function [ bestBinSize ] = binSizeOptimization( s , binSizeVector, psTimes)
% binSizeOptimization finds the optimal bin size for a PSTH of spikes s
% s ... cell array of spike times per trial
% after PMID: 17444758
% Better of course to find minimum of cost function by optimization (e.g. fminsearch)

costV = zeros(1,numel(binSizeVector));
for binSiz = 1:numel(binSizeVector)
    psthT = psTimes(1):binSizeVector(binSiz):psTimes(end);
    spikeCount = zeros(numel(s),length(psthT));
    for n = 1:length(s)
        spikeTimes = s{n};
        for m = 1:numel(s{n})
            [~,idx] = min(abs(psthT-s{n}(m)));
            spikeCount(n,idx) = spikeCount(n,idx) + 1;
        end
    end
    spikeCount = sum(spikeCount,1);
    costV(binSiz) = (2.*mean(spikeCount) - var(spikeCount)) ./ (numel(s).*binSizeVector(binSiz)).^2;
    
end

[~,ix] = min(costV);
bestBinSize = binSizeVector(ix);

plot(binSizeVector,costV,'k')
xlabel('Bin size [s]'), ylabel('Cost')

end

