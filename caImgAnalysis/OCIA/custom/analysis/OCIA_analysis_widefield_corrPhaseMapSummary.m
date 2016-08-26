function OCIA_analysis_widefield_corrPhaseMapSummary(this, iDWRows)
% OCIA_analysis_widefield_corrPhaseMapSummary - [no description]
%
%       OCIA_analysis_widefield_corrPhaseMapSummary(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% %% plotting parameter UI controls
% paramConf = cell2table({ ...
% ... categ  id                   UIType  valueType       UISize  isLabAbove  label               tooltip
% 
% }, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(CLim|Filt|Delay|Shift|Thresh)', paramConf);

%% get data
varNames = { 'iDWRow', 'stimFreq', 'imDim', 'amplif', 'nSweeps', 'recDur', 'pitchLims', 'powerMapUp', 'powerMapDown', ...
    'phaseMapUp', 'phaseMapDown', 'phaseMapCorr', 'delayMap' };
nRows = numel(iDWRows);
summaryTableCell = cell(nRows, numel(varNames));
for iDWRowLoop = 1 : nRows;
    iDWRow = iDWRows(iDWRowLoop);
    DWLoadRow(this, iDWRow, 'full');
    dataForRow = getData(this, iDWRow, 'wfAn', 'data');
    rowAttribs = dataForRow.WFFileInfo_01.attribs;
    summaryTableCell(iDWRowLoop, :) = { iDWRow, 1 / rowAttribs.sweepDur, size(dataForRow.WFPowerAndPhaseMaps_01.phaseMap), ...
        rowAttribs.amplifFactor, rowAttribs.nSweeps, rowAttribs.sweepDur * rowAttribs.nSweeps, ...
        round(dataForRow.WFFileInfo_01.pitchLims / 1000), dataForRow.WFPowerAndPhaseMaps_01.powerMap, ...
        dataForRow.WFPowerAndPhaseMaps_02.powerMap, dataForRow.WFPowerAndPhaseMaps_01.phaseMap, ...
        dataForRow.WFPowerAndPhaseMaps_02.phaseMap, dataForRow.WFCorrPowerAndPhaseMaps_01.phaseMaps{3}, ...
        dataForRow.WFCorrPowerAndPhaseMaps_01.phaseMaps{4} };
end;
summaryTable = cell2table(summaryTableCell, 'VariableNames', varNames);

% get plotting axe
imgW = summaryTable{1, 'imDim'}(1);
imgH = summaryTable{1, 'imDim'}(2);

xPad = imgW * 0.05; yPad = imgH * 0.05;
nY = 6; nX = nRows + 2;
finalImg = nan(imgW * nX + xPad * (nX + 2), imgH * nY + yPad * (nY + 1));
iY = 1; iX = 1;
for iDWRowLoop = 1 : nRows;
    for iMap = 1 : 6;
        xRange = 1 + (((iX - 1) * imgW) : ((iX * imgW) - 1)) + iX * xPad;
        yRange = 1 + (((iY - 1) * imgH) : ((iY * imgH) - 1)) + iY * yPad;
        finalImg(xRange, yRange) = linScale(summaryTableCell{iDWRowLoop, 7 + iMap});
        iY = iY + 1;
    end;
    iX = iX + 1;
    iY = 1;
end

for iMap = 1 : 6;
    xRange = 1 + (((iX - 1) * imgW) : ((iX * imgW) - 1)) + (iX + 1) * xPad;
    yRange = 1 + (((iY - 1) * imgH) : ((iY * imgH) - 1)) + iY * yPad;
    a = reshape(cell2mat(summaryTableCell(1 : nRows, 7 + iMap)), imgW, nRows, imgH);
    finalImg(xRange, yRange) = linScale(reshape(nanmean(a, 2), imgW, imgH));
    iY = iY + 1;
end;

iX = iX + 1;
iY = 1;
for iMap = 1 : 6;
    xRange = 1 + (((iX - 1) * imgW) : ((iX * imgW) - 1)) + (iX + 1) * xPad;
    yRange = 1 + (((iY - 1) * imgH) : ((iY * imgH) - 1)) + iY * yPad;
    a = reshape(cell2mat(summaryTableCell(1 : nRows, 7 + iMap)), imgW, nRows, imgH);
    avgMap = linScale(reshape(nanmean(a, 2), imgW, imgH));
    if iMap == 5 || iMap == 6;
        powMap = (reshape(cell2mat(summaryTableCell(1 : nRows, 8)), imgW, nRows, imgH) ...
            + reshape(cell2mat(summaryTableCell(1 : nRows, 9)), imgW, nRows, imgH)) ./ 2;
        powMap = reshape(nanmean(powMap, 2), imgW, imgH);
        avgMap(log10(powMap(:)) < 0.6 * max(log10(powMap(:)))) = 0;
        finalImg(xRange, yRange) = avgMap;
    else
        finalImg(xRange, yRange) = avgMap;
    end;
    iY = iY + 1;
end;

%% plot

ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% get plotting axe
axeH = this.GUI.handles.an.axe;
imagesc(finalImg', 'Parent', axeH);
sizeX = size(finalImg, 1);
sizeY = size(finalImg, 2);

% annotate axes
cMap = jet(200);
cMap(1, :) = [0, 0, 0];
colormap(axeH, cMap); if gcf ~= this.GUI.figH; close(gcf); end;
axis(axeH, 'equal');
set(axeH, 'XLim', [0, sizeX], 'YLim', [0, size(finalImg, 2)]);
set(axeH, 'XTick', (1 : (nRows + 2)) * (imgW + xPad) - 0.5 * imgW, 'XTickLabel', [get(this, iDWRows, 'runNum'); 'avg'; 'avgThresh']);
set(axeH, 'YTick', (1 : 6) * (imgH + yPad) - 0.5 * imgH, 'YTickLabel', varNames(8 : 13));

comParams = { 'FontSize', 6, 'Parent', axeH, 'VerticalAlign', 'top', 'HorizontalAlign', 'left' };
for iDWRowLoop = 1 : nRows;
    runNumTxt = get(this, iDWRows(iDWRowLoop), 'runNum');
    text(sizeX + 20, (iDWRowLoop - 1) * (sizeY / nRows), sprintf('%s: %.2fHz, %.0f->%.0f, %.0f amp', ...
        runNumTxt, summaryTable{iDWRowLoop, 'stimFreq'}, summaryTable{iDWRowLoop, 'pitchLims'}, ...
        summaryTable{iDWRowLoop, 'amplif'}), comParams{:});
    text(sizeX + 20, (iDWRowLoop - 1 + 0.5) * (sizeY / nRows), sprintf('  %dx%d, %.0fsec (%d sweeps)', ...
        summaryTable{iDWRowLoop, 'imDim'}, summaryTable{iDWRowLoop, 'recDur'}, summaryTable{iDWRowLoop, 'nSweeps'}), ...
        comParams{:});
end;

dataForRow = get(this, iDWRows(1), { 'animal', 'day' });
title(axeH, sprintf('%s - %s', dataForRow{:}), 'Interpreter', 'none');

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
