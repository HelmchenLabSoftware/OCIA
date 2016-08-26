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
varNames = { 'iDWRow', 'stimFreq', 'imDim', 'amplif', 'pitchLims', 'powerMapUp', 'powerMapDown', ...
    'phaseMapUp', 'phaseMapDown', 'phaseMapCorr', 'delayMap' };
summaryTableCell = cell(numel(iDWRows), numel(varNames));
for iDWRowLoop = 1 : numel(iDWRows);
    iDWRow = iDWRows(iDWRowLoop);
    DWLoadRow(this, iDWRow, 'full');
    dataForRow = getData(this, iDWRow, 'wfAn', 'data');
    rowAttribs = dataForRow.WFFileInfo_01.attribs;
    summaryTableCell(iDWRow, :) = { iDWRow, 1 / rowAttribs.sweepDur, size(dataForRow.WFPowerAndPhaseMaps_01.phaseMap), ...
        rowAttribs.amplifFactor, dataForRow.WFFileInfo_01.pitchLims, dataForRow.WFPowerAndPhaseMaps_01.powerMap, ...
        dataForRow.WFPowerAndPhaseMaps_02.powerMap, dataForRow.WFPowerAndPhaseMaps_01.phaseMap, ...
        dataForRow.WFPowerAndPhaseMaps_02.phaseMap, dataForRow.WFCorrPowerAndPhaseMaps_01.phaseMaps{3}, ...
        dataForRow.WFCorrPowerAndPhaseMaps_01.phaseMaps{4} };
end;
summaryTable = cell2table(summaryTableCell, 'VariableNames', varNames);

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% get plotting axe
imgH = summaryTable{iDWRow, 'imDim'}(1);
imgW = summaryTable{iDWRow, 'imDim'}(2);

% create the axe configuration cell-array
axeConfig = cell(numel(iDWRows) * 6, 12);

for iDWRowLoop = 1 : numel(iDWRows);
    axeConfig((iDWRowLoop - 1) * 6 + 1 : (iDWRowLoop - 1) * 6 + 6, :) = {
        summaryTable{iDWRowLoop, 'powerMapUp'}, '..', 'jet', '', false, false, false, [], [], [], [], [];
        summaryTable{iDWRowLoop, 'powerMapDown'}, '..', 'jet', '', false, false, false, [], [], [], [], [];
        summaryTable{iDWRowLoop, 'phaseMapUp'}, '..', 'jet', '', false, false, false, [], [], [], [], [];
        summaryTable{iDWRowLoop, 'phaseMapDown'}, '..', 'jet', '', false, false, false, [], [], [], [], [];
        summaryTable{iDWRowLoop, 'phaseMapCorr'}, '..', 'jet', '', false, false, false, [], [], [], [], [];
        summaryTable{iDWRowLoop, 'delayMap'}, '..', 'jet', '', false, false, false, [], [], [], [], [];
    };

end;

% plot the maps
axeH = OCIA_analysis_widefield_plotMaps(this, numel(iDWRows), 6, axeConfig, imgW, imgH, 0, [0.001, 0.001]);
this.an.wf.axeHandles = axeH;

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
