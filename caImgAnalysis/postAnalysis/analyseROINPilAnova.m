function pVals = analyseROINPilAnova(PSStats)

%% init
dbgLevel = 0;

nROIs = size(PSStats, 1);
nStims = size(PSStats, 2);

downSampleFactor = 1;
frameRate = 10;
frameRateDS = frameRate / downSampleFactor;

o('#analyseROINPilAnova: %d ROI(s), %d stim(s), frameRate: %.2f, frameRate down-sampled %.2f', ...
    nROIs, nStims, frameRate, frameRateDS, 1, dbgLevel);

%% run

pValsROI = nan(nROIs - 1, nStims);
pValsTime = nan(nROIs - 1, nStims);
pValsInterac = nan(nROIs - 1, nStims);

for iStim = 1 : nStims;
    
    NPilPSStats = reshape(PSStats{end, iStim}', 1, numel(PSStats{end, iStim}));
    NPilPSStatsDS = interp1DS(frameRate, frameRateDS, NPilPSStats);
    
    for iROI = 1 : nROIs - 1;

        ROIPSStats = reshape(PSStats{iROI, iStim}', 1, numel(PSStats{iROI, iStim}));
        ROIPSStatsDS = interp1DS(frameRate, frameRateDS, ROIPSStats);

        nTrials = size(PSStats{iROI, iStim}, 1);
        nFramesDS = size(PSStats{iROI, iStim}, 2) / downSampleFactor;
        
        y = [NPilPSStatsDS ROIPSStatsDS]';
        groupNPilROI = [ones(1, numel(NPilPSStatsDS)) ones(1, numel(ROIPSStatsDS)) * 2]';
        groupTime = repmat(repmat(1 : nFramesDS, 1, nTrials), 1, 2)';
        
        p = anovan(y, { groupNPilROI, groupTime }, 'varnames', {'ROI', 'Time'}, 'model', 'interaction', ...
            'display', 'off');
        pValsROI(iROI, iStim) = p(1);
        pValsTime(iROI, iStim) = p(2);
        pValsInterac(iROI, iStim) = p(3);
        
        o('#analyseROINPilAnova: ROI %d, stim %d, p-value ROI: %f, p-val time: %f, p-value interaction: %f', ...
            iROI, iStim, pValsROI(iROI, iStim), pValsTime(iROI, iStim), pValsInterac(iROI, iStim), 2, dbgLevel);
    end;
end;

pVals = {pValsROI, pValsTime, pValsInterac};

end