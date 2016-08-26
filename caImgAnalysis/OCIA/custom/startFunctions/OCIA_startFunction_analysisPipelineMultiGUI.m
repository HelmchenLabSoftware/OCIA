function OCIA_startFunction_analysisPipelineMultiGUI(this)
% OCIA_startFunction_analysisPipelineMultiGUI - [no description]
%
%       OCIA_startFunction_analysisPipelineMultiGUI(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% load data and swtich to analyser mode
OCIA_startFunction_loadDataAndOpenAnalyserFromGUI(this);

%% start analysis pipeline    
% remove PNG saving warning
warning('off', 'MATLAB:LargeImage');

% shorten the name
plotAndSave = @OCIA_analysis_updatePlotAndSave;
setParam = @OCIA_analysis_setParam;

% get the number of animals and spots
nAnim = numel(this.dw.animalIDs) - 1;
nSpots = numel(this.dw.spotIDs) - 1;
               
% prepare the stimulus IDs: select the PS-heatmap
setParam(this, 0, 'plotList', 'Value', 4);
setParam(this, 1, 'sgFiltFrameSize', 'String', '15', 15);
setParam(this, 1, 'selStimTypeGroups', 'Value', 3 : 4, { 'target', 'resp' });

% select the rows for the current spot
setParam(this, 0, 'rowFilt', 'String', 'A01 S01.+201410(21|27|31)');
ANFiltRows(this);
      
% update the plot to get the stimulus types for sorting
ANUpdatePlot(this, 'force');

% set more parameters
setParam(this, 1, 'selStimIDs', 'Value', 1 : 4);
setParam(this, 1, 'PSPerID', 'Value', 1 : 3, { 'all', 'on', 'off' });
setParam(this, 1, 'nStimsThreshold', 'String', 0, '0');

% update the plot to get the stimulus types for sorting
ANClearData(this);
ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;

% do several response methods
respMethods = [1 3];
respMethodsNames = {'mean', 'max', '3ppmax'};

% go through them
for iRespMeth = respMethods;
    setParam(this, 1, 'respMethod', 'Value', iRespMeth, respMethodsNames{iRespMeth});

    % go through all animals and spots
    for iAnim = 1 : nAnim;
        for iSpot = 1 : nSpots;

            % create save path
            animalID = this.dw.animalIDs{iAnim + 1};
            shortAnimalID = regexprep(regexprep(animalID, 'mou_bl_', ''), '_', '');
            spotID = this.dw.spotIDs{iSpot + 1};
            baseSavePath = sprintf('%s20150210_%sResp_targDistrRespNoResp_allOnOff/%s_%s/%s_%s_pooled_%sResp_', this.path.OCIASave, ...
                respMethodsNames{iRespMeth}, shortAnimalID, spotID, shortAnimalID, spotID, respMethodsNames{iRespMeth});

            % select the rows for the current spot
            setParam(this, 0, 'rowFilt', 'String', sprintf('A%02d S%02d', iAnim, iSpot));
            ANFiltRows(this);

            % check if any rows where selected, otherwise skip
            nRows = numel(get(anh.rowList, 'Value'));
            if nRows < 1; continue; end;

            % flush memory
            ANClearData(this);

            % set the ROIStat distributions plot
            setParam(this, 0, 'plotList', 'Value', 7);
            ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;

            % select all ROIs, stims, PSPers
            setParam(this, 1, 'selROINames', 'Value', 1 : numel(get(anh.paramPanElems.selROINames, 'String')));
            setParam(this, 1, 'selStimIDs', 'Value', 1 : numel(get(anh.paramPanElems.selStimIDs, 'String')));
            setParam(this, 1, 'PSPerID', 'Value', 1 : numel(get(anh.paramPanElems.PSPerID, 'String')));
            
            % re-update the plot
            ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;

            % get the names of the groups and the plot types
            groupByList = get(anh.paramPanElems.groupBy2, 'String');
            plotTypeList = get(anh.paramPanElems.ROIStatPlotType, 'String');

            %% response amplitude analysis
            selDispStimIDsList = get(anh.paramPanElems.selDispStimIDs, 'String');
            onOffStimIndexes = find(~cellfun(@isempty, regexp(selDispStimIDsList, 'on|off$', 'once')));
            setParam(this, 1, 'selDispStimIDs', 'Value', onOffStimIndexes); % 'on' and 'off' PSPer only        
            setParam(this, 1, 'ROIStat', 'Value', 1); % select responsiveness
            for iGroupBy1 = 1 : numel(groupByList) - 1; % there is no last option 'none' for grouping1
                setParam(this, 1, 'groupBy', 'Value', iGroupBy1);
                for iGroupBy2 = 1 : numel(groupByList);
                    if iGroupBy1 == 1 || iGroupBy2 == 1; continue; end; % exclude ROI grouping plots
                    if iGroupBy1 == iGroupBy2; continue; end; % do not do same groupBy twice, 'none' groupBy will take care of this
                    setParam(this, 1, 'groupBy2', 'Value', iGroupBy2);
                    for iPlotType = 1 : numel(plotTypeList);
                        setParam(this, 1, 'ROIStatPlotType', 'Value', iPlotType);
                        try
                            anh = plotAndSave(this, sprintf('%sRespAmpl_%s_%s_%s', baseSavePath, ...
                                plotTypeList{iPlotType}, groupByList{iGroupBy1}, groupByList{iGroupBy2}), [], 1);
                        catch
                            o('!!!! Could not save "%sRespAmpl_%s_%s_%s"', baseSavePath, ...
                                plotTypeList{iPlotType}, groupByList{iGroupBy1}, groupByList{iGroupBy2}, 0, 0);
                        end;
                    end;
                end;
            end;

            %% response time analysis
            selDispStimIDsList = get(anh.paramPanElems.selDispStimIDs, 'String');
            allStimIndexes = find(~cellfun(@isempty, regexp(selDispStimIDsList, 'all$', 'once')));
            setParam(this, 1, 'selDispStimIDs', 'Value', allStimIndexes); % 'all' PSPer only   
            setParam(this, 1, 'ROIStat', 'Value', 2); % select response time
            for iGroupBy1 = 1 : numel(groupByList) - 1; % there is no last option 'none' for grouping1
                setParam(this, 1, 'groupBy', 'Value', iGroupBy1);
                for iGroupBy2 = 1 : numel(groupByList);
                    if iGroupBy1 == 1 || iGroupBy2 == 1; continue; end; % exclude ROI grouping plots
                    if iGroupBy1 == 4 || iGroupBy2 == 4; continue; end; % exclude PSPer grouping plots
                    if iGroupBy1 == iGroupBy2; continue; end; % do not do same groupBy twice, 'none' groupBy will take care of this
                    setParam(this, 1, 'groupBy2', 'Value', iGroupBy2);
                    for iPlotType = 1 : numel(plotTypeList);
                        setParam(this, 1, 'ROIStatPlotType', 'Value', iPlotType);
                        try
                            anh = plotAndSave(this, sprintf('%sRespTime_%s_%s_%s', baseSavePath, ...
                                plotTypeList{iPlotType}, groupByList{iGroupBy1}, groupByList{iGroupBy2}), [], 1);
                        catch
                            o('!!!! Could not save "%sRespTime_%s_%s_%s"', baseSavePath, ...
                                plotTypeList{iPlotType}, groupByList{iGroupBy1}, groupByList{iGroupBy2}, 0, 0);
                        end;
                    end;
                end;
            end;

            % save the output
            ANSaveOutput(this, [baseSavePath 'output.mat']);


            % flush memory
            ANClearData(this);

        end;
    end;
end;

end

