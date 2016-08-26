function varargout = spikeTimeAnalyzer( s, psthT, evokedT, method, doPlot )
% inputs (all compulsory):
% s ... cell array of spike times per trial
% psthTime ... time bins relative to stim onset (=0)
% evokedT ... time to count as evoked; used for counting evoked spikes; either n x 2 matrix with
% different tStart and tStop windows or a number; in the latter case evokedT is expanded to [0 evokedT]
% method ... method for ifr calculation: 'barsP', 'turbotrend', 'turbotrendboot', 'InstantFR', 'none'
% outputs (all optional):
% count ... n x 2 matrix with base (column 1) and evoked (column 2) spike counts per trial (n),
% normalized to the respective time interval
% ifr ... 4 x t matrix with mean instantaneous firing rate (row 1), SD of IFR (row 2) and lower (row
% 3) / upper CI (row 4); depending on the method, not all statistics are computed (if not computed,
% row is NaN)
% spike raster ... n x t matrix of spike counts per psth bin

% written by Henry Luetcke (hluetck@gmail.com)

%% Parameters
lambda = 0.5; % lambda parameter for turbotrend
samples = 1000; % samples parameter for bootstrap estimation techniques
doShadedEbar = 1;
errorStats = 'sd'; % 'sd' or 'ci' ('ci' is 95% CI)

rate = 1./(psthT(2)-psthT(1));
if numel(evokedT) == 1
   evokedT = [0 evokedT];
end

%% Assemble raster and count spikes
spikeRaster = zeros(numel(s),length(psthT));
count = zeros(numel(s),size(evokedT,1)+1);
if doPlot
   hFig = figure('Name','Raster Plot Spike Times','NumberTitle','off');
   subplot(2,1,1)
end
for n = 1:length(s)
    if ~isempty(s{n}) && doPlot
        plot(s{n},repmat(n,1,numel(s{n})),'o','MarkerEdgeColor','none','MarkerFaceColor','k'), hold on
    end
    spikeTimes = s{n};
    baseSpikes = numel(find(spikeTimes>=psthT(1)&spikeTimes<0));
    count(n,1) = baseSpikes;
    for m = 1:size(evokedT,1)
        evokedSpikes = numel(find(spikeTimes>=evokedT(m,1)&spikeTimes<=evokedT(m,2)));
        count(n,m+1) = evokedSpikes;
    end
    for m = 1:numel(spikeTimes)
        [~,idx] = min(abs(psthT-spikeTimes(m)));
        spikeRaster(n,idx) = spikeRaster(n,idx) + 1;
    end
end
if doPlot, set(gca,'xlim',[psthT(1) psthT(end)]), ylabel('Trials'), end

%% Compute IFR
ifr = nan(4,numel(psthT));
switch lower(method)
    case 'barsp'
        % smooth histogram using bayesian adaptive regression splines
        bp = defaultParams;
        bp.use_logspline = 0;
        f = barsP(sum(spikeRaster,1),[psthT(1) psthT(end)],numel(s),bp);
        if isfield(f,'mean')
            ifr = f.mean';
            lowerConf = ifr-f.confBands(:,1)';
            upperConf = f.confBands(:,2)'-ifr;
            ifr(2,:) = f.sd';
            ifr(3:4,:) = [upperConf; lowerConf];
            ifr = ifr ./ length(s).*rate; % not sure if this is legitimate (statistically)
        else
            ifr(1,:) = sum(spikeRaster,1)./length(s).*rate;
        end
    case 'turbotrend'
        firingRate = sum(spikeRaster,1)./length(s).*rate;
        [~, ~, yfit] = turbotrend(psthT, firingRate, lambda, numel(psthT));
        ifr(1,:) = yfit';
    case 'turbotrendboot'
         ifr = doTurboTrendBoot(samples,spikeRaster,numel(s),rate,...
            lambda,psthT);
    case 'instantfr'
        ifr = doInstantFR(s,psthT,samples);
    case 'none'
        ifr(1,:) = sum(spikeRaster,1)./length(s).*rate;
    otherwise
        error('Method %s not implemented (yet)!',method)
end

%% Plot raster
psth = sum(spikeRaster,1)./length(s).*rate;
% sparseness of psth
psthKurtosis = kurtosis(psth);
if doPlot
    subplot(2,1,2)
    stairs(psthT,psth,'k'), hold on
    if doShadedEbar
        switch lower(errorStats)
            case 'sd'
                if ~all(isnan(ifr(2,:)))
                    shadedErrorBar(psthT,ifr(1,:),ifr(2,:),'r',1);
                    ylabel('Firing rate +- SD')
                else
                    plot(psthT,ifr(1,:),'r');
                    ylabel('Firing rate')
                end
            case 'ci'
                if ~all(isnan(ifr(3,:))) && ~all(isnan(ifr(4,:)))
                    shadedErrorBar(psthT,ifr(1,:),ifr(3:4,:),'r',1);
                    ylabel('Firing rate +- 95% CI')
                else
                    plot(psthT,ifr(1,:),'r');
                    ylabel('Firing rate')
                end
        end
    else
        plot(psthT,ifr(1,:),'r');
        ylabel('Firing rate')
    end
    
    ylims = get(gca,'ylim');
    set(gca,'xlim',[psthT(1) psthT(end)])
    hLegend = legend({sprintf('Observed (k=%1.3f)',psthKurtosis),sprintf('Fit (%s)',method)});
    set(hLegend,'box','off','location','best')
end

%% Define outputs
varargout{1} = count;
varargout{2} = ifr;
varargout{3} = spikeRaster;
varargout{4} = psthKurtosis;
end


%% Function - doTurboTrendBoot
function ifr = doTurboTrendBoot(samples,spikeCount,trials,rate,lambda,psthT)
n = numel(psthT);
% bootstrap indices for row replacement
[~,ix] = bootstrp(samples,[],zeros(1,trials));
yFit = zeros(samples,length(psthT));
for i = 1:samples
    count = spikeCount(ix(:,i),:);
    firingRate = sum(count,1)./trials.*rate;
    [~, ~, yFit(i,:)] = turbotrend(psthT, firingRate, lambda, n);
end
ifr = zeros(4,size(yFit,2));
ifr(1,:) = nanmean(yFit,1);
ifr(2,:) = nanstd(yFit,1);
ifr(3:4,:) = bootci(samples,@mean,yFit);
end


%% Function - doInstantFR
function ifr = doInstantFR(s,psthT,samples)
% try two different approaches to compute the IFR per trial, but number of spikes usually way to low
% to achieve robust results

ifrTrials = zeros(numel(s),numel(psthT));
for n = 1:numel(s)
    %     ifrTrials(n,:) = instantfr(s{n},psthT);
    try
        spikeTimes = s{n};
        spikeTimes = spikeTimes - psthT(1);
        [tt, rate] = BayesRR(spikeTimes);
        tt = tt + psthT(1);
        ifrTrials(n,:) = interp1(tt,rate,psthT);
    end
end

ifr = zeros(4,length(psthT));
ifr(1,:) = nanmean(ifrTrials,1);
ifr(2,:) = nanstd(ifrTrials,1);
ifr(3:4,:) = bootci(samples,@nanmean,ifrTrials);
end


