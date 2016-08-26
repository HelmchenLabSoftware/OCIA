%% Function - analyseBehavPerf
function counts = analyseBehavPerf(respTypes, binWidthProp, binWidthCum, doBinCout)
    
    dbgLvl = 0;
    o('  #analyzeBehavPerf(): nTrials: %d.', size(respTypes, 2), 1, dbgLvl);
    
    % transform the response types into sums
    respTypeToRespCountTic = tic; % for performance timing purposes
    respCount = zeros(5, 1);
    respTypes(isnan(respTypes)) = 6;
    for i = 1:5; respCount(i) = sum(respTypes == i); end;
    o('  #analyzeBehavPerf(): respTypeToRespCountTic: %.2f ms...', toc(respTypeToRespCountTic) * 1000, 2, dbgLvl);
    
    singleCountsTic = tic; % for performance timing purposes
    counts = struct();
    
    % responseCount columns: correct detect, correct reject, false alarm, miss
    counts.TOT = sum(respCount);
    counts.INVALID = respCount(5);
    counts.INVALIDP = counts.INVALID / counts.TOT * 100; % INVALID response (kind of false alarm)
    counts.VTOT = counts.TOT - counts.INVALID;
    counts.VTOTP = counts.VTOT / counts.TOT * 100; % "valid" responses (non-INVALID)
    
    % all response types with their percent
    counts.TGO = respCount(1);
    counts.NTNGO = respCount(2);
    counts.NTGO = respCount(3);
    counts.TNGO = respCount(4);
    
    % targets and targets in percent
    counts.T = counts.TGO + counts.TNGO;
    counts.TP = counts.T / counts.VTOT * 100;
    % non-targets and non-targets in percent 
    counts.NT = counts.NTNGO + counts.NTGO;
    counts.NTP = counts.NT / counts.VTOT * 100;
    % GOs and GOs in percent
    counts.GO = counts.TGO + counts.NTGO;
    counts.GOP = counts.GO / counts.VTOT * 100;
    % NO-GOs and NO-GO in percent 
    counts.NGO = counts.TNGO + counts.NTNGO;
    counts.NGOP = counts.NGO / counts.VTOT * 100;
    % corrects and corrects in percent 
    counts.C = counts.TGO + counts.NTNGO;
    counts.CP = counts.C / counts.VTOT * 100;
    % falses and falses in percent 
    counts.F = counts.TNGO + counts.NTGO;
    counts.FP = counts.F / counts.VTOT * 100;
    % correctness index taking into acount falses
    counts.CiP = (counts.CP - counts.FP + 100) / 2 ;
    counts.DPRIME = dprime(counts.TGO ./ counts.T, ...
        counts.NTGO ./ counts.NT, counts.T, counts.NT);

    % reponse type percents    
    counts.TGOP = counts.TGO / counts.T * 100;
    counts.NTNGOP = counts.NTNGO / counts.NT * 100;
    counts.NTGOP = counts.NTGO / counts.NT * 100;
    counts.TNGOP = counts.TNGO / counts.T * 100;

    o('  #analyzeBehavPerf(): singleCountsTic: %.2f ms...', toc(singleCountsTic) * 1000, 2, dbgLvl);
    
    if ~doBinCout; return; end;
    
    binCountsTic = tic; % for performance timing purposes
    % evolution of indexes over time
    counts.TGOs = zeros(1, counts.TOT);
    counts.NTNGOs = zeros(1, counts.TOT);
    counts.NTGOs = zeros(1, counts.TOT);
    counts.TNGOs = zeros(1, counts.TOT);
    counts.INVALIDs = zeros(1, counts.TOT);
    counts.DPRIMEs = zeros(1, counts.TOT);

    if isempty(binWidthCum);
        useProp = 1;
        binWidth = max(fix(counts.TOT * binWidthProp), 1);
    else
        useProp = 0;
        binWidth = binWidthCum;
    end;
    if isempty(binWidth);
        error('mtrainerAnalyzer_getCounts:NoBinWidth', 'No bin width specified');
    end;
    
    for i = 1 : counts.TOT;
        if binWidth ~= -1;
            if useProp;
                iStart = max(i - binWidth, 1);
                iEnd = min(i + binWidth, counts.TOT);
            else
                iStart = ceil(max(i - 0.5 * (binWidth - 1), 1));
                iEnd = floor(min(i + 0.5 * (binWidth - 1), counts.TOT));
            end;
            T = sum(ismember(respTypes(iStart : iEnd), [1 4]));
            NT = sum(ismember(respTypes(iStart : iEnd), [2 3]));
            counts.TGOs(i) = (sum(respTypes(iStart : iEnd) == 1) / T) * 100;
            counts.NTNGOs(i) = (sum(respTypes(iStart : iEnd) == 2) / NT) * 100;
            counts.NTGOs(i) = (sum(respTypes(iStart : iEnd) == 3) / NT) * 100;
            counts.TNGOs(i) = (sum(respTypes(iStart : iEnd) == 4) / T) * 100;
            counts.INVALIDs(i) = (sum(respTypes(iStart : iEnd) == 5) / (iEnd - iStart)) * 100;
            countsForBin = analyseBehavPerf(respTypes(iStart : iEnd), binWidthProp, binWidthCum, 0);
            counts.DPRIMEs(i) = dprime(countsForBin.TGO ./ countsForBin.T, ...
                countsForBin.NTGO ./ countsForBin.NT, countsForBin.T, countsForBin.NT);
        else
            counts.TGOs(i) = sum(respTypes(1 : i) == 1) / i * 100;
            counts.NTNGOs(i) = sum(respTypes(1 : i) == 2) / i * 100;
            counts.NTGOs(i) = sum(respTypes(1 : i) == 3) / i * 100;
            counts.TNGOs(i) = sum(respTypes(1 : i) == 4) / i * 100;
            counts.INVALIDs(i) = sum(respTypes(1 : i) == 5) / i * 100;
            countsForBin = analyseBehavPerf(respTypes(1 : i), binWidthProp, binWidthCum, 0);
            counts.DPRIMEs(i) = dprime(countsForBin.TGO ./ countsForBin.T, ...
                countsForBin.NTGO ./ countsForBin.NT, countsForBin.T, countsForBin.NT);
        end;
    end;
    
    counts.RESPs = (counts.TGOs + counts.NTGOs) / 2;
    o('  #analyzeBehavPerf(): binCountsTic: %.2f ms...', toc(binCountsTic) * 1000, 2, dbgLvl);
    
end
