function OCIA_startFunction_imagingSummary(this)
% OCIA_startFunction_imagingSummary - [no description]
%
%       OCIA_startFunction_imagingSummary(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    OCIAChangeMode(this, 'DataWatcher');
    
    %% set filters
    set(this.GUI.handles.dw.watchTypes.animal, 'Value', 1);
    set(this.GUI.handles.dw.watchTypes.day, 'Value', 1);
    set(this.GUI.handles.dw.watchTypes.spot, 'Value', 1);
    set(this.GUI.handles.dw.watchTypes.behav, 'Value', 0);
    set(this.GUI.handles.dw.watchTypes.img, 'Value', 0);
    set(this.GUI.handles.dw.watchTypes.intrinsic, 'Value', 0);
    set(this.GUI.handles.dw.watchTypes.roiset, 'Value', 0);
    set(this.GUI.handles.dw.watchTypes.notebook, 'Value', 0);
   
    set(this.GUI.handles.dw.filt.animalID, 'String', { '-' }, 'Value', 1);
    set(this.GUI.handles.dw.filt.dayID, 'String', { '-' }, 'Value', 1);
    set(this.GUI.handles.dw.filt.spotID, 'String', { '-' }, 'Value', 1);
    set(this.GUI.handles.dw.filt.rowTypeID, 'String', { '-' }, 'Value', 1);
    
    %% update table
    DWProcessWatchFolder(this);
            
    % set the right filtering watch types
    set(this.GUI.handles.dw.watchTypes.spot, 'Value', 1);
    set(this.GUI.handles.dw.watchTypes.img, 'Value', 1);
    set(this.GUI.handles.dw.watchTypes.roiset, 'Value', 1);
    set(this.GUI.handles.dw.watchTypes.notebook, 'Value', 1);
    set(this.GUI.handles.dw.watchTypes.behav, 'Value', 1);
    
    animalIDs = this.dw.animalIDs;
    nAnimals = numel(animalIDs);
    spotIDs = this.dw.spotIDs;
    nSpots = numel(spotIDs);
    dayIDs = this.dw.dayIDs;
    nDays = numel(dayIDs);
    
    
    %% process each animal
    for iAnim = 2 : nAnimals;
        
        animalID = animalIDs{iAnim}; % get the animal ID        
        % filter for the current animal
        set(this.GUI.handles.dw.filt.animalID, 'String', animalIDs, 'Value', iAnim);
        
        %% process each spot
        for iSpot = 2 : nSpots;
            
            spotID = spotIDs{iSpot}; % get the spot ID
            
            % info cell holding all the information and images for the current spot
            infoCellAll = cell(0, 11);
        
            %% process each day
            for iDay = 2 : nDays;
                 
                % filter for the current day
                set(this.GUI.handles.dw.filt.dayID, 'String', dayIDs, 'Value', iDay);   
                % filter for the current spot
                set(this.GUI.handles.dw.filt.spotID, 'String', spotIDs, 'Value', iSpot);

                % update table
                % filter for the current spot
                set(this.GUI.handles.dw.filt.spotID, 'Value', 1);
                DWProcessWatchFolder(this);
            
                %% process day            
                % get the reference imaging rows and skip this day if none found
                imgRows = DWFilterTable(this, sprintf('rowType = ROISet AND spot = %s', spotID)); 
                imgRows = [imgRows; DWFilterTable(this, ...
                    sprintf('rowType = Imaging data AND runType = Ref AND spot = %s', spotID))]; %#ok<AGROW>
                imgRows = [imgRows; DWFilterTable(this, ...
                    'rowType = Imaging data AND runType = comment AND comments ~= surface')]; %#ok<AGROW>
                nRows = size(imgRows, 1);
                if nRows <= 0; continue; end;
                
                % filter for max 5 reference rows
                refRows = DWFilterTable(this, 'rowType = Imaging data AND runType = Ref', imgRows);
                nRefRows = size(refRows, 1);
                if nRefRows > 4;
                    imgRows = DWFilterTable(this, sprintf('rowType = ROISet AND spot = %s', spotID)); 
                    imgRows = [imgRows; refRows(unique([1 2 nRefRows - 1, nRefRows]), :)]; %#ok<AGROW>
                    imgRows = [imgRows; DWFilterTable(this, ...
                        'rowType = Imaging data AND runType = comment AND comments ~= surface')]; %#ok<AGROW>
                end;
                nRows = size(imgRows, 1);
                
                % separate rows by color
                redGreenRows = DWFilterTable(this, 'comments ~= red/green', imgRows);
                greenBlueRows = DWFilterTable(this, 'comments !~= red/green', imgRows);
                
                set(this.GUI.handles.dw.procOptsList, 'Value', [1, 3, 5 : 6]);
%                 set(this.GUI.handles.dw.procOptsList, 'Value', 1);
                this.an.img.funcMovieNFramesLimit = 1; % make sure all rows get processed
                    
                % select all red/green rows, and process them
                if ~isempty(redGreenRows);
                    this.an.img.preProcChan = 2;
                    iDWRowList = str2double(get(this, 'all', 'rowNum', redGreenRows));
                    OCIA_dataWatcherProcess_processRows(this, [], iDWRowList);
                end;
                
                % select all green/blue rows, and process them
                if ~isempty(greenBlueRows);
                    if str2double(animalID(end - 1 : end)) <= 4;
                        this.an.img.preProcChan = 1;
                    else
                        this.an.img.preProcChan = 2;
                    end;
                    iDWRowList = str2double(get(this, 'all', 'rowNum', greenBlueRows));
                    OCIA_dataWatcherProcess_processRows(this, [], iDWRowList);
                end;
                
                %% storage for images
                infoCell = cell(nRows, 11);            
                % process each row
                for iRow = 1 : nRows;            
                    % get the row number and extract the imaging data
                    iDWRow = str2double(get(this, iRow, 'rowNum', imgRows));
                    imgData = getData(this, iDWRow, 'procImg', 'data');
                    comments = get(this, iDWRow, 'comments');
                    if isempty(comments); comments = ''; end;
                    if ~isempty(imgData);
                        isRedGreen = ~isempty(comments) && ~isempty(regexp(comments, 'red/green', 'once'));
                        imgRGB = cell2RGB(imgData, iff(isRedGreen || str2double(animalID(end - 1 : end)) >= 5, [1 2 0], [0 1 2]), true);
                    else
                        imgRGB = OCIA_getPreview_ROISetMatFile(this, iDWRow);
                    end;
                    depth = regexp(regexp(comments, 'at\s*(\d+\s*um)\s*deep', 'match'), '(\d+\s*um)', 'match');
                    if iscell(depth) && ~isempty(depth); depth = depth{1}; end;
                    if isempty(depth) && strcmp(get(this, iDWRow, 'runType'), 'surface');
                        depth = 'surface';
                    elseif isempty(depth);
                        depth = ' ';
                    end;
                    
                    if strcmp(DWGetRowTypeID(this, iDWRow), 'ROISetMatFile');
                        depth = 'ROISet';
                        ROISet = ANGetROISetForRow(this, iDWRow);
                        ROISetNames = ROISet(1 : end - 1, 1);
                        ROISetMasks = ROISet(:, 2);
                        coords = cell(numel(ROISetMasks) - 1, 1);
                        for iROI = 1 : (numel(ROISetMasks) - 1);
                            [row, col] = ind2sub(size(ROISetMasks{iROI}), find(ROISetMasks{iROI}));
                            xRange = unique(row);
                            coords{iROI} = zeros(numel(xRange) * 2, 2);
                            for iX = 1 : numel(xRange);
                                yValues = col(row == xRange(iX));
                                coords{iROI}(iX, :) = [xRange(iX) max(yValues)];
                                coords{iROI}(end - iX + 1, :) = [xRange(iX) min(yValues)];
                            end;
                            coords{iROI}(end + 1, :) = coords{iROI}(1, :);
                            tmpCoords = coords{iROI}(:, 1);
                            coords{iROI}(:, 1) = coords{iROI}(:, 2);
                            coords{iROI}(:, 2) = tmpCoords;
                        end;
                    else
                        coords = [];
                        ROISetNames = [];
                    end;
                    
                    infoCell(iRow, :) = [get(this, iDWRow, { 'animal', 'spot', 'day', 'time', 'laserInt', 'zoom' }), ...
                        depth, { imgRGB }, { '' }, { coords }, { ROISetNames }];
                    
                    % fill up animal and spot
                    if isempty(infoCell{iRow, 1}); infoCell{iRow, 1} = regexprep(animalID, 'mou_bl_', ''); end;
                    if isempty(infoCell{iRow, 2}); infoCell{iRow, 2} = regexprep(spotID, 'spot', 'sp'); end;
                    % create label
                    infoCell{iRow, 9} = sprintf('(%02d/%02d) %s - %s - %s - %sh%s - L%s%% - Z%s - %s', ...
                        iRow, nRows, regexprep(infoCell{iRow, 1}, 'mou_bl_', ''), infoCell{iRow, 2}, ...
                        regexprep(infoCell{iRow, 3}, '_', ''), ...
                        infoCell{iRow, 4}(1:2), infoCell{iRow, 4}(4:5), infoCell{iRow, 5 : 7});
                    % clean up label
                    infoCell{iRow, 9} = regexprep(infoCell{iRow, 9}, ' - L% - ', ' - ');
                    infoCell{iRow, 9} = regexprep(infoCell{iRow, 9}, ' - Z - ', ' - ');
                    
                    % add comments
                    commentsForRow = get(this, iDWRow, 'comments');
                    if ~isempty(commentsForRow);
                        commentsForRow = regexprep(commentsForRow, 'at \d+um( deep)?', '');
                    end;
                    if ~isempty(commentsForRow);
                        commentsForRow = regexprep(commentsForRow, '\w+/\w+ filter ?cube, \d+nm', '');
                    end;
                    if ~isempty(commentsForRow);
                        infoCell{iRow, 9} = sprintf('%s - %s', infoCell{iRow, 9}, commentsForRow);
                    end;
                end;
                
                % store the informations
                infoCellAll(end + 1 : end + nRows, :) = infoCell;
                
            end;
            
            % clear data
            DWFlushData(this, 'all', 0);
            
            %% create the overall figure
            % create the figure for this spot
            figName = sprintf('%s - %s', animalID, spotID);
            figH = figure('Name', figName, 'NumberTitle', 'off', 'Visible', 'off');
            
            % count the rows
            nTotRows = size(infoCellAll, 1);
            
            % make everything a string
            infoCellAll(~cellfun(@ischar, infoCellAll(:, 9)), 9) = { '' };
            % abreviate "spot" to "sp"
            infoCellAll(:, 9) = regexprep(infoCellAll(:, 9), 'spot', 'sp');
            infoCellAll(:, 9) = regexprep(infoCellAll(:, 9), ' ?zoomed out ?', '');
            infoCellAll(:, 9) = regexprep(infoCellAll(:, 9), ' - +- ', ' - ');
            infoCellAll(:, 9) = regexprep(infoCellAll(:, 9), ' +- ', ' - ');
            infoCellAll(:, 9) = regexprep(infoCellAll(:, 9), ' - +', ' - ');
            infoCellAll(:, 9) = regexprep(infoCellAll(:, 9), ' - , ', ' - ');
            infoCellAll(:, 9) = regexprep(infoCellAll(:, 9), ' - $', '');
            
            if nTotRows == 0; continue; end;
            
            sizesX = cellfun(@(imgRGB)size(imgRGB, 2), infoCellAll(:, 8));
            sizesY = cellfun(@(imgRGB)size(imgRGB, 1), infoCellAll(:, 8));
            bigRGB = zeros(nanmean(sizesY), nTotRows * nanmean(sizesX), 3);
            axeH = gca;
            hIm = imagesc(bigRGB, 'Parent', axeH);
            hold(axeH, 'on');
            
            uData = struct();
            uData.imDim = size(infoCellAll{1, 8});
            uData.ROIIDHandles = [];
            uData.ROIHandles = [];

            x = 1; y = 1;
            maxX = x;
            uData.titleHands = [];
            for iRow = 1 : nTotRows;
                imDim = size(infoCellAll{iRow, 8});
                bigRGB(y : y + imDim(2) - 1, x : x + imDim(1) - 1, :) = infoCellAll{iRow, 8};
                uData.titleHands(iRow) = text(x + 10, y + 10, infoCellAll{iRow, 9}, 'Color', 'yellow', ...
                    'Interpreter', 'none', 'FontSize', 8, 'Parent', axeH);
                if ~isempty(infoCellAll{iRow, 10});
                    for iROI = 1 : size(infoCellAll{iRow, 10}, 1);
                        coordsForROI = infoCellAll{iRow, 10}{iROI};
                        h = plot(axeH, x + coordsForROI(:, 1) - 1, y + coordsForROI(:, 2) - 1, 'y');
                        uData.ROIHandles = [uData.ROIHandles h];
                        ROIIDHandle = text(x + mean(coordsForROI(:, 1)) - 5, y + mean(coordsForROI(:, 2)) - 1, ...
                            infoCellAll{iRow, 11}{iROI}, 'Color', 'red', 'Interpreter', 'none', ...
                            'FontSize', 9, 'Parent', axeH);
                        uData.ROIIDHandles = [uData.ROIIDHandles ROIIDHandle];
                    end;
                end;
                x = x + imDim(1);
                if iRow < nTotRows && ~strcmp(infoCellAll{iRow, 3}, infoCellAll{iRow + 1, 3});
                    y = y + imDim(2);
                    maxX = max(x, maxX);
                    x = 1;
                end;
            end;
            maxX = max(x, maxX);
            bigRGB = linScale(bigRGB);
            set(hIm, 'CData', bigRGB);
            uistack(uData.titleHands, 'top');
            xlim([1, imDim(1)]);
            ylim([1, imDim(2)]);
            set(axeH, 'XTick', [], 'YTick', []);
            
            % add customisations
            baseX = 551; baseY = 81; baseW = 510; baseH = 510;
            set(figH, 'MenuBar', 'none', 'ToolBar', 'none', 'Visible', 'on');
            set(gca, 'Position', [0 0 1 1]);
            pos = [baseX, baseY + baseH, baseW, baseH];
            set(figH, 'Position', pos);
%             set(figH, 'KeyPressFcn', @(h, e)helioScanFigureKeyPressFcn(h, e, pos), ...
%                 'CreateFcn', @(h, e) start(timer('StartDelay', 0.1, 'TimerFcn', @(~, ~) ...
%                 helioScanFigureKeyPressFcn(h, struct('Key', 'space'), pos))), 'UserData', uData);
            set(figH, 'UserData', uData);

            %% save as figure
            saveFolder = sprintf('%s%s/ref/spots/', this.path.OCIASave, animalID);
            if exist(saveFolder, 'dir') ~= 7; mkdir(saveFolder); end;
            savePath = sprintf('%s%s__%s', saveFolder, animalID, spotID);
            saveas(figH, savePath);

            %% prepare for save as png
            if (nTotRows > 1 && ~strcmp(infoCellAll{iRow, end}, infoCellAll{end - 1, 3})) || nTotRows == 1;
                y = y + imDim(2);
            end;
            
            resolution = '-r200';
            
            set(figH, 'Position', [10, 10, max(maxX - 1, imDim(1)), max(y - 1, imDim(2))]);
            set(uData.titleHands, 'FontSize', 4);
            set(uData.ROIIDHandles, 'FontSize', 4);
            
            %% save PNGs
            pauseTime = 0.3;
            procSteps = {
                '', { 'i', ; 'o' };
                '_ROI', { 'o' };
                '_ROI_ROIID', { 'i' };
                '_ROIID', { 'o' };
            };
        
            warning('off', 'MATLAB:LargeImage');
        
            for iStep = 1 : size(procSteps, 1);
                isDone = false;
                fullSavePath = [savePath procSteps{iStep, 1}];
                nTry = 1;
                
                while ~isDone;
                    
                    for iKey = 1 : numel(procSteps{iStep, 2});
                        helioScanFigureKeyPressFcn(figH, struct('Key', procSteps{iStep, 2}{iKey}), []);
                    end;
                    
                    xlim([1, max(maxX - 1, imDim(1))]); ylim([1, max(y - 1, imDim(2))]);
                    pause(pauseTime); drawnow(); pause(pauseTime);
                    
                    try
                        
                        o('Trying to save %s - %s (try %d, step "%s" )...', animalID, spotID, ...
                            nTry, procSteps{iStep, 1}, 0, this.verb);
                        export_fig(fullSavePath, '-png', resolution, figH);
                        isDone = true;
                        
                    catch err;
                        
                        o('Caught error "%s" for %s - %s (try %d, step "%s"): %s', err.identifier, animalID, spotID, ...
                            nTry, procSteps{iStep, 1}, err.message, 0, this.verb);
                        isDone = false;
                        pause(pauseTime);
                        nTry = nTry + 1;
                        
                    end;
                end;
            end;
            
            warning('on', 'MATLAB:LargeImage');
            
            %% close all figures
            close all;   
        end;
    end;
    
end

