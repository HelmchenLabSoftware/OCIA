function glmAnalysis2P
% GLM analysis function for two-photon imaging data
% input: structure created by GetRoiStats (*_RoiStats)


% make GLM design matrix
if config.doGLMstats
    onsettau = 0.05;
    tau = 0.5;
    tAxis_singleRun = (1:numel(config.stim{1}))./config.frameRate{1};
    modelTransient = spkTimes2Calcium(0,onsettau,1,tau,0,0,...
        config.frameRate{1},tAxis_singleRun(end));
    modelC = cell(1,numel(config.stim));
    for n = 1:numel(config.stim)
        currentStim = config.stim{n};
        uniqueStims = unique(currentStim);
        uniqueStims(uniqueStims==0) = [];
        currentModel = [];
        for m = 1:numel(uniqueStims)
            stimOn = zeros(size(currentStim));
            stimOn(currentStim==uniqueStims(m)) = 1;
            stimOnConv = conv(stimOn,modelTransient);
            stimOnConv = stimOnConv(1:numel(stimOn));
            currentModel = [currentModel reshape(stimOnConv,numel(stimOnConv),1)];
        end
        % apply low-pass filter to the model
        modelC{n} = doLowPassFilter(currentModel,config.LowPass);
    end
    % concatenate model
    A = modelC{1};
    for n = 2:length(modelC)
        A = [A; modelC{n}];
    end
    % ensure column vectors for model
    if size(A,1) < size(A,2)
        A = A';
    end
    modelC = A;
    tAxis_runs = (1:size(modelC,1))./config.frameRate{1};
    % Orthogonalize the model
    model = Gram_Schmidt_Process(modelC);
end

% Significance level, corrected for multiple comparisons
% number of comparisons = cell number + 1 (neuropil)
% this applies to significance tests of the GLM only
switch lower(config.multiCompareProc)
    case 'none'
        alphaCorrected = config.alpha;
    case 'bonf'
        alphaCorrected = config.alpha ./ (cellNo+1);
    otherwise
        error('Multiple comparison procedure %s not implemented',...
            config.multiCompareProc);
end

%% GLM analysis
if config.doGLMstats
    for currentRoi = 1:size(RoiMatAllRuns,1)
        config.glmStatsRoi{currentRoi} = ...
            doGLMfit(model,RoiMatAllRuns(currentRoi,:),alphaCorrected);
    end
end



%% Plot GLM and PS
psPlotDir = sprintf('PsPlots_%s',config.saveName);
if exist(psPlotDir) ~= 7
    mkdir(psPlotDir)
end

for currentRoi = 1:size(RoiMatAllRuns,1)
    if config.doGLMstats
        if currentRoi == size(RoiMatAllRuns,1)
            figName = sprintf('GLM fit Npil');
        else
            figName = sprintf('GLM fit Roi%s',roiLabel{currentRoi});
        end
        fig = figure('Name',figName,'NumberTitle','off'); hold all
        
        glmStats = config.glmStatsRoi{currentRoi};
        plot(tAxis_runs,RoiMatAllRuns(currentRoi,:),'k'), hold on
        plot(tAxis_runs,model,'r'), hold on
        hErr = errorbar(tAxis_runs,glmStats.yfit,glmStats.ciL,glmStats.ciU,...
            'g','LineWidth',1.5);
        removeErrorBarEnds(hErr)
        legend({'DRR' 'Stim' 'Model'})
        set(gca,'xlim',[0 max(tAxis_runs)])
        xlabel('Time / s')
        ylabel('DRR / %')
        titleStr = sprintf('b=%1.2f (p=%1.2f)',glmStats.b(2),glmStats.pBeta(2));
        title(titleStr)
    end
    
    if currentRoi == size(RoiMatAllRuns,1)
        figName = sprintf('PsPlot Npil');
    else
        figName = sprintf('PsPlot Roi%s',roiLabel{currentRoi});
    end
    fig = figure('Name',figName,'NumberTitle','off'); hold all
    % setup subplot
    if numel(uniqueStims) > 3
        subIdx = repmat(ceil(sqrt(numel(uniqueStims))),1,2);
    elseif numel(uniqueStims) == 3
        subIdx = [1 3];
    elseif numel(uniqueStims) == 2
        subIdx = [1 2];
    elseif numel(uniqueStims) == 1
        subIdx = [1 1];
    end
    AllStims = [];
    for currentStim = 1:size(PsPlotDataRoi,2)
        stimPsPlot = PsPlotDataRoi{currentRoi,currentStim};
        AllStims = [AllStims;stimPsPlot];
        subplot(subIdx(1),subIdx(2),currentStim)
        psTime = (1:size(stimPsPlot,2))./config.frameRate{1};
        psTime = psTime - (config.psConfig.baseFrames./config.frameRate{1});
        hErr = errorbar(psTime,nanmean(stimPsPlot,1),sem(stimPsPlot,1),...
            'k','LineWidth',2); hold on
        removeErrorBarEnds(hErr);
        xlabel('Time / s')
        ylabel('DFF / % +- SEM')
        if currentRoi == size(RoiMatAllRuns,1)
            title(sprintf('Peri-stim plot Npil Stim %1.0f',currentStim))
        else
            title(sprintf('Peri-stim plot Roi%s Stim %1.0f',...
                roiLabel{currentRoi},currentStim))
        end
    end
    adjustSubplotAxes(fig,'y',[],'x',[min(psTime) max(psTime)])
    saveStr = sprintf('%s%s%s',psPlotDir,filesep,strrep(figName,' ',''));
    saveas(fig,saveStr)
    close(fig)
    [psPeak(currentRoi),idx] = max(nanmean(stimPsPlot,1));
    psPeakSD(currentRoi) = nanstd(stimPsPlot(:,idx));
    
    figName = strrep(figName,'PsPlot','PsPlotAllStims');
    fig = figure('Name',figName,'NumberTitle','off'); hold all
    plot(psTime,AllStims,'Color',[0.5 0.5 0.5]), hold on 
    hErr = errorbar(psTime,nanmean(AllStims,1),sem(AllStims,1),...
        'r','LineWidth',2); hold on
    removeErrorBarEnds(hErr);
    xlabel('Time / s')
    ylabel('DFF / % +- SEM')
    saveStr = sprintf('%s%s%s',psPlotDir,filesep,strrep(figName,' ',''));
    saveas(fig,saveStr)
    close(fig)
end


%% Function - ParseConfig
function config = ParseConfig(config)
% check for missing fields in config structure and add them with
% default values

if ~isfield(config,'doGLMstats')
    config.doGLMstats = 1;
end

% significance level for GLM stats
if ~isfield(config,'alpha')
    config.alpha = 0.05;
end

% multiple comparison correction procedure (correct for the number of cells
% / neuropil which are statistically tested)
if ~isfield(config,'multiCompareProc')
    config.multiCompareProc = 'bonf';
end
% these procedures are currently implemented (beta is the corrected sig. level):
% 'none' ... beta = alpha
% 'bonf' ... Bonferroni correction, beta = alpha/n
% possible future options:
% Sidak procedure
% FDR procedure



%% Function - doGLMfit
function glmStats = doGLMfit(model,data,alpha)
[b,dev,stats] = glmfit(model,data);
[yfit,ciL,ciU] = glmval(b,model,'identity',stats);
% important parameters from fit
glmStats = struct;
glmStats.b = b;
glmStats.dfe = stats.dfe; % degrees of freedom
glmStats.seBeta = stats.se; % SE for beta
glmStats.tBeta = stats.t; % t = beta ./ sqrt((sum(res.^2)/dfe))
glmStats.pBeta = stats.p;
glmStats.res = stats.resid;
glmStats.yfit = yfit;
glmStats.ciL = ciL;
glmStats.ciU = ciU;
if stats.p(2) <= alpha
   glmStats.sig = 1; % reject the null hypothesis 
else
    glmStats.sig = 0; % accept the null hypothesis
end


