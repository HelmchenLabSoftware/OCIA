function plotROITuningMaps(dimX, dimY, refImgPath, stimIDs, ROISet, ROIStimPreference, saveName, doSaveROITuningMaps)
    %Function to plot tuning maps for a set of ROIs. ROIStimPreference with
    %text-strings has to be present as it is used with galvotuninganalysis
    %metrics.
    %
    %Usage: 
    %
    %Some code adapted from doSaveMaps routine by Balazs
    %
    %Author: A. van der Bourg, 2014
    
    %% Init    
    nROIs = size(ROISet, 1);
    ROILocs = ROISet(1 : (nROIs - 1), 2);
    BSSet = unique(ROIStimPreference);
    %BSLims = [1 numel(BSSet)];
    
    
     if ischar(refImgPath);
            imgMat = tiffread2_wrapper(refImgPath);
            refImg = imgMat.data;
     else
         warning('No proper image path provided');
         return;
     end;
     
     refImg = linScale(reshape(refImg, dimX, dimY, 2));
     
     
     %% Best stimulus tuning
    fig = figure('Name', saveName, 'NumberTitle', 'off');
    %TODO: fixed color scheme for different ROIStimPreference
    nCols = size(BSSet, 1);
    cMap = jet(nCols);
    imagesc(reshape(repmat(refImg(:, :, 2), 1, 3), dimX, dimY, 3));
    hold on;
    ROICenter = zeros(numel(ROILocs), 2);
    
    %Iterate over all ROIs and color dot based on tuning preference
    for iROI = 1 : numel(ROILocs)
        [x, y] = find(ROILocs{iROI});
        ROICenter(iROI, 1) = mean(y);
        ROICenter(iROI, 2) = mean(x);
        %Obtain stim preference color index
        uIndex = strcmp(ROIStimPreference(iROI), BSSet);
        cInd = find(uIndex, 1);
        col = cMap(cInd, :);
        hScatter = scatter(ROICenter(iROI, 1), ROICenter(iROI, 2), 100, 'o');
        set(hScatter, 'MarkerFaceColor', col, 'MarkerEdgeColor', 'k');
    end;

    %Plot settings
    colormap(jet(nCols));
    hColBar = lcolorbar(BSSet','fontweight','bold', 'location', 'horizontal');
    set(get(hColBar,'XLabel'), 'String', 'Best Stimulus Tuning');
    titleHandle = title(saveName, 'Interpreter', 'none');
    set(titleHandle, 'FontSize', 8);
    set(gca, 'FontSize', 8, 'YTick', [], 'XTick', []);
    set(fig, 'Position', [100 100 600 600]);
    %Save options
     if doSaveROITuningMaps == 2
            saveNameTuning = sprintf('%s_ROI_%s_Tuning', saveName, num2str(iROI));
            saveFigToDir(fig, saveNameTuning, 'RegionTuning', doSaveROITuningMaps, 1, 1);
     end;
    
    
    
    %% TODO: Mean response heatmap
    %% TODO: Stim vs Stim heatmap tuning (slope calc)
end