function Sout = simulateSpikesCalcium

load calciumSim.mat
Sca.snr = 10;
Sca.frameRate = 10;
Sca.recycleSpikeTimes = 1;
Sca.reconAlg = 'none';

tMax = 100; % s
neurons = 20;
maxFiringRate = 2;
trials = 10;

Sca.dur = tMax;

tStim = 1/Sca.frameRate:1/Sca.frameRate:tMax;

% sinusoidal stimulus
stimA = sin(0.5.*tStim);

% half the cells are stimulus modulated
stimMod = [zeros(1,neurons/2) ones(1,neurons/2)];

spikesCells = cell(trials,neurons);
spikeRate = cell(1,trials);
for currentTrial = 1:trials
    %% stimulus-varying firing rates
    spikeRate{currentTrial} = zeros(neurons,numel(tStim));
    for cellNo = 1:neurons
        if ~stimMod(cellNo)
            f = rand(1,numel(tStim)).*maxFiringRate;
        else
            f = stimA + (rand(size(stimA)).*1);
            f = ScaleToMinMax(f,0,maxFiringRate);
        end
        spikeRate{currentTrial}(cellNo,:) = f;
    end
    
    %% Poisson spikes with time-varying rate
    for cellNo = 1:neurons
        tStart = 0;
        spikeTimes = [];
        for n = 1:numel(tStim)
            tEnd = tStim(n);
            dur = tEnd - tStart;
            s = HomoPoisSpkGen(spikeRate{currentTrial}(cellNo,n),dur);
            spikeTimes = [spikeTimes; s + tStart];
            tStart = tEnd;
        end
        %     spikeTimes = InHomoPoisSpkGen(spikeRate(cellNo,:),tStim);
        spikesCells{currentTrial,cellNo} = spikeTimes';
    end
end

dff = cell(trials,1);
for currentTrial = 1:trials
    %% Simulate corresponding calcium signals
    Sca.spkTimes = spikesCells(currentTrial,:);
    Sca = modelCalcium(Sca,0);
    dff{currentTrial,1} = Sca.data.noisyDFFlowResT;
end

% remove data fields to save disk space
Sca = rmfield(Sca,'data');
Sca = rmfield(Sca,'recon');

%% Output structure
Sout.neurons = neurons;
Sout.trials = trials;
Sout.maxFiringRate = maxFiringRate;
Sout.firingRates = spikeRate;
Sout.spikes = spikesCells;
Sout.tMax = tMax;
Sout.tStim = tStim;
Sout.stimModulation = stimMod;
Sout.stimA = stimA;
Sout.dff = dff;
Sout.dffRate = Sca.frameRate;
Sout.Sca = Sca;

Sout = orderfields(Sout);


%% Plotting (trial 1)
rasterPlotSpikeTimes(spikesCells(1,:),tMax); hold on
stimAplot = ScaleToMinMax(stimA,0,neurons/10) + neurons + 1;
% stimBplot = ScaleToMinMax(stimB,0,neurons/10) + neurons + 1;
plot(tStim,stimAplot,'r'), hold on
% plot(tStim,stimBplot,'b')
set(gca,'ylim',[0 max([max(stimAplot)])])



