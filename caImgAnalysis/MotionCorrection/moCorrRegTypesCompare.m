function comp = moCorrRegTypesCompare(doMoCorr, inComp, doSavePlots)
% compare motion correction types

%% load OCIA and parameters

regTypes = {'translation', 'rigidBody', 'affine', 'bilinear'}; % registration transformations
nRegTypes = numel(regTypes);
% runs = [13 16 19 20 25]; % runs to analyse
runs = [13 14 16 18 19 21 24 28 29 33 39 40 42 45 47]; % runs to analyse
nRuns = numel(runs);
figPos = [10, 50, 1900, 940];
figCommons = {'NumberTitle', 'off', 'Position', figPos}; % figure options
UF = {'UniformOutput', false};
comp = struct(); % comparison structure
if ~isempty(inComp);
    comp = inComp;
end;

this = OCIA('dataWatcher', true, {'mou_bl_140110_02', '2014_02_25', 'spot01', 'data', 'B05'}, 'all', false);

% get the runIDs
runIDs = regexprep(arrayfun(@(iDWRow) sprintf('%s-%sh', this.dw.table{iDWRow, 2 : 3}), runs, UF{:}), '_', '');

% get number of ROIs used for frame-wise correlations on ROIs
nROIs = size(ANGetROISetForRow(this, runs(1)), 1) - 1;


%% do motion corrections
if isempty(inComp) && doMoCorr;
    for iRegType = 1 : nRegTypes;
        for iRun = 1 : nRuns;
            iDWRow = runs(iRun);
            this.flushData('preproc,raw');
            this.an.an.regTransf = regTypes{iRegType};
            o('************ %s - ROW %02d ************', this.an.an.regTransf, iDWRow, 0, 0);
            ANFrameJitterCorrection(this, iDWRow);
            ANMotionCorrection(this, iDWRow);
        end;
    end;
end;

if isempty(inComp);
    %% load data into structure
    for iRegType = 1 : nRegTypes;
        regType = regTypes{iRegType};
        for iRun = 1 : nRuns;
            iDWRow = runs(iRun);
            runID = sprintf('%s__%s', this.dw.table{iDWRow, 2 : 3});
            loadPath = sprintf('%smotionCorrectionComparison/%s_%d_%s_moCorr.mat', this.path.OCIASave, ...
                regexprep(runID, '_', ''), iDWRow, regType);
            loadData = load(loadPath);
            fieldNames = fieldnames(loadData);
            for iField = 1 : numel(fieldNames);
                comp.(regexprep(fieldNames{iField}, ['_' regType], '')){iRegType, iRun} = loadData.(fieldNames{iField});
            end;
        end;
    end;
end;

%% plot original average images
figure('Name', 'AvgImgOri', figCommons{:});
i = 1;
axeHands = zeros(nRegTypes, nRuns);
for iRegType = 1 : nRegTypes;
    for iRun = 1 : nRuns;
        subplot(nRegTypes, nRuns, i);
%         imshow(linScale(comp.avgImg{iRegType, iRun}));
        imagesc(comp.avgImg{iRegType, iRun});
        axeHands(iRegType, iRun) = gca;
        i = i + 1; % counter
    end;
end;
moCorrRegTypesCompareAnnotate(axeHands, regTypes, runIDs, [], figPos);
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%smotionCorrectionComparison', this.path.OCIASave), ...
    doSavePlots, true, true);

%% plot registered average images
figure('Name', 'AvgImgReg', figCommons{:});
i = 1;
axeHands = zeros(nRegTypes, nRuns);
for iRegType = 1 : nRegTypes;
    for iRun = 1 : nRuns;
        subplot(nRegTypes, nRuns, i);
%         imshow(linScale(comp.avgImgReg{iRegType, iRun}));
        imagesc(comp.avgImgReg{iRegType, iRun});
        axeHands(iRegType, iRun) = gca;
        i = i + 1; % counter
    end;
end;
moCorrRegTypesCompareAnnotate(axeHands, regTypes, runIDs, [], figPos);
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%smotionCorrectionComparison', this.path.OCIASave), ...
    doSavePlots, true, true);

%% plot registration times by frame
figure('Name', 'RegTimeByFrame', figCommons{:});
i = 1;
axeHands = zeros(nRegTypes, nRuns);
for iRegType = 1 : nRegTypes;
    for iRun = 1 : nRuns;
        subplot(nRegTypes, nRuns, i);
        plot(comp.regTimes{iRegType, iRun});
        ylim([0 1]);
        axeHands(iRegType, iRun) = gca;
        i = i + 1; % counter
    end;
end;
moCorrRegTypesCompareAnnotate(axeHands, ...
    cellfun(@(x)sprintf('{\\bf%s} \n Time per frame [s]', x), regTypes, UF{:}), ...
    cellfun(@(x)sprintf('{\\bf%s}', x), runIDs, UF{:}), ...
    'Frames', []);
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%smotionCorrectionComparison', this.path.OCIASave), ...
    doSavePlots, true, true);

%% plot mean registration time
% single
figure('Name', 'MeanRegTime', figCommons{:});
subplot(1, 5, 1 : 3);
barerrorbar(cellfun(@nansum, comp.regTimes'), cellfun(@nanstd, comp.regTimes'));
set(gca, 'XTickLabel', arrayfun(@(iRun)sprintf('%02d', iRun), runs, UF{:}));
xlabel('Runs');
ylabel('Registration time \pm SD [sec]');
title('Registration times');
legend(regTypes);
% pooled
subplot(1, 5, 4 : 5);
barerrorbar(mean(cellfun(@nansum, comp.regTimes), 2)', std(cellfun(@nansum, comp.regTimes), [], 2)');
set(gca, 'XTickLabel', regTypes);
xlabel('Registration types');
ylabel('Registration time \pm SD [sec]');
title(sprintf('Pooled registration times, N = %d run(s)', nRuns));
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%smotionCorrectionComparison', this.path.OCIASave), ...
    doSavePlots, true, true);

%% plot reference point movements
figure('Name', 'RefPointsMov', figCommons{:});
i = 1;
axeHands = zeros(nRegTypes, nRuns);
for iRegType = 1 : nRegTypes;
    for iRun = 1 : nRuns;
        subplot(nRegTypes, nRuns, i);
        hold on;
        
        shifts = comp.srcPoints{iRegType, iRun} - comp.targPoints{iRegType, iRun};
        % for translation, take only the first point
        if strcmpi(regTypes{iRegType}, 'translation');
            shifts = shifts(:, 1, :);
        end;
        nRegPoints = size(shifts, 2);
        colBase = [1 0 0; 1 0.5 0; 1 0.125 0; 1 0.25 0];
        colors = {colBase, fliplr(colBase)};
        for iCoord = 1 : 2;
            for iPoint = 1 : nRegPoints;
                plot(1 : size(shifts, 1) + iPoint * (1 / (nRegPoints + 3)), shifts(:, iPoint, iCoord), ...
                    'Color', colors{iCoord}(iPoint, :));
            end;
        end;
        ylim([-6 6]); xlim([0 size(shifts, 1) + 1]);
        axeHands(iRegType, iRun) = gca;
        i = i + 1; % counter
    end;
end;
subplot(nRegTypes, nRuns, 1);
hold on;
legend({'X', 'Y'}, 'Location', 'NorthEast', 'FontSize', 5);
moCorrRegTypesCompareAnnotate(axeHands, ...
    cellfun(@(x)sprintf('{\\bf%s} \n X/Y Movement [pixel]', x), regTypes, UF{:}), ...
    cellfun(@(x)sprintf('{\\bf%s}', x), runIDs, UF{:}), ...
    'Frames', []);
suptitle('Movement of reference point(s)');
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%smotionCorrectionComparison', this.path.OCIASave), ...
    doSavePlots, true, true);
    
%% plot reference points mean movements
figure('Name', 'MeanRefPointsMov', figCommons{:});
% single
sumMov = permute(abs( ...
    cell2mat(cellfun(@nanmean, cellfun(@nanmean, cellfun(@abs, comp.srcPoints, UF{:}), UF{:}), UF{:})) ...
    - cell2mat(cellfun(@nanmean, cellfun(@nanmean, cellfun(@abs, comp.targPoints, UF{:}), UF{:}), UF{:}))), [2 1 3]);
% for x and y
coordNames = {'X Movement', 'Y Movement'};
for iCoord = 1 : 2;
    subplot(2, 5, (5 * (iCoord - 1)) + (1 : 3));
    bar(sumMov(:, :, iCoord));
    set(gca, 'XTickLabel', arrayfun(@(iRun)sprintf('%02d', iRun), runs, UF{:}));
    xlabel('Runs');
    ylabel('Mean frame-wise correlation difference');
    title(coordNames{iCoord})
end;
legend(regTypes, 'Location', 'NorthEast');
% pooled
subplot(2, 5, [4 : 5, 9 : 10]);
barerrorbar(mean(mean(sumMov, 3)), std(mean(sumMov, 3)));
set(gca, 'XTickLabel', regTypes);
xlabel('Registration types');
ylabel('Mean movements \pm SD');
title(sprintf('Mean movements on both axis for all reference points, N = %d run(s)', nRuns));
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%smotionCorrectionComparison', this.path.OCIASave), ...
    doSavePlots, true, true);



%% plot frame-wise ROI correlations
figure('Name', 'FrameWiseROICorr', figCommons{:});
i = 1;
axeHands = zeros(nRegTypes, nRuns);
for iRegType = 1 : nRegTypes;
    for iRun = 1 : nRuns;
        subplot(nRegTypes, nRuns, i);
        hold on;
        plot(nanmean(comp.frameCorrROINoReg{iRegType, iRun}), 'r');
        plot(nanmean(comp.frameCorrROIReg{iRegType, iRun}), 'b');
        ylim([0 1]);
        axeHands(iRegType, iRun) = gca;
        i = i + 1; % counter
    end;
end;
moCorrRegTypesCompareAnnotate(axeHands, ...
    cellfun(@(x)sprintf('{\\bf%s} \n Correlation', x), regTypes, UF{:}), ...
    cellfun(@(x)sprintf('{\\bf%s}', x), runIDs, UF{:}), ...
    'Frames', []);
suptitle(sprintf('Frame-wise correlation on %d ROIs', nROIs));
legend('No reg.', 'Reg.', 'Location', 'NorthEast');
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%smotionCorrectionComparison', this.path.OCIASave), ...
    doSavePlots, true, true);

%% plot pooled frame-wise ROI correlations
% single
figure('Name', 'FrameWiseROICorrPooled', figCommons{:});
subplot(1, 5, 1 : 3);
corrImprov = cellfun(@nanmean, cellfun(@nanmean, comp.frameCorrROIReg, UF{:}))' ...
    - cellfun(@nanmean, cellfun(@nanmean, comp.frameCorrROINoReg, UF{:}))';
bar(corrImprov);
set(gca, 'XTickLabel', arrayfun(@(iRun)sprintf('%02d', iRun), runs, UF{:}));
xlabel('Runs');
ylabel('Mean frame-wise correlation difference');
title(sprintf('Difference of frame-wise correlations on %d ROIs (reg. - no reg.)', nROIs));
legend(regTypes, 'Location', 'SouthWest');
% pooled
subplot(1, 5, 4 : 5);
barerrorbar(mean(corrImprov), std(corrImprov));
set(gca, 'XTickLabel', regTypes);
xlabel('Registration types');
ylabel('Mean frame-wise correlation difference \pm SD');
title(sprintf('Pooled difference of frame-wise correlations on %d ROIs (reg. - no reg.), N = %d run(s)', nROIs, nRuns));
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%smotionCorrectionComparison', this.path.OCIASave), ...
    doSavePlots, true, true);


%% plot frame-wise correlations
figure('Name', 'FrameWiseCorr', figCommons{:});
i = 1;
axeHands = zeros(nRegTypes, nRuns);
for iRegType = 1 : nRegTypes;
    for iRun = 1 : nRuns;
        subplot(nRegTypes, nRuns, i);
        hold on;
        plot(comp.frameCorrNoReg{iRegType, iRun}, 'r');
        plot(comp.frameCorrReg{iRegType, iRun}, 'b');
        ylim([0 1]);
        axeHands(iRegType, iRun) = gca;
        i = i + 1; % counter
    end;
end;
moCorrRegTypesCompareAnnotate(axeHands, ...
    cellfun(@(x)sprintf('{\\bf%s} \n Correlation', x), regTypes, UF{:}), ...
    cellfun(@(x)sprintf('{\\bf%s}', x), runIDs, UF{:}), ...
    'Frames', []);
suptitle('Frame-wise correlation');
legend('No reg.', 'Reg.', 'Location', 'NorthEast');
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%smotionCorrectionComparison', this.path.OCIASave), ...
    doSavePlots, true, true);

%% plot pooled frame-wise ROI correlations
% single
figure('Name', 'FrameWiseCorrPooled', figCommons{:});
subplot(1, 5, 1 : 3);
corrImprov = cellfun(@nanmean, comp.frameCorrReg)' - cellfun(@nanmean, comp.frameCorrNoReg)';
bar(corrImprov);
set(gca, 'XTickLabel', arrayfun(@(iRun)sprintf('%02d', iRun), runs, UF{:}));
xlabel('Runs');
ylabel('Mean correlation difference');
title('Difference of frame-wise correlations (reg. - no reg.)');
legend(regTypes, 'Location', 'SouthWest');
% pooled
subplot(1, 5, 4 : 5);
barerrorbar(mean(corrImprov), std(corrImprov));
set(gca, 'XTickLabel', regTypes);
xlabel('Registrations types');
ylabel('Mean correlation difference \pm SD');
title(sprintf('Pooled difference of frame-wise correlations (reg. - no reg.), N = %d run(s)', nRuns));
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%smotionCorrectionComparison', this.path.OCIASave), ...
    doSavePlots, true, true);

%% save the comparison structure
save(sprintf('%smotionCorrectionComparison/comp.mat', this.path.OCIASave), 'comp');
compNoMovie = rmfield(comp, 'imgMovie'); %#ok<NASGU>
save(sprintf('%smotionCorrectionComparison/compNoMovie.mat', this.path.OCIASave), 'compNoMovie');

end

