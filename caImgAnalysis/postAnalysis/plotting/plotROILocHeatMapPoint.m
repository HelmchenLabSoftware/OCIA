function fig = plotROILocHeatMapPoint(ROIValues, cLims, refImg, dimX, dimY, ROIPos, saveName, colorBarLabel, pointSize, colorMap)

    fig = figure('Name', saveName, 'NumberTitle', 'off');
    nCols = 50;
    switch colorMap
        case 'jet'
            cMap = jet(nCols);
            colormap jet;
        case 'hsv'
            cMap = hsv(nCols);
            colormap hsv;
        case 'cool'
            cMap = cool(nCols);
            colormap cool;
        case 'hot'
            cMap = hot(nCols);
            colormap hot;
        case 'gray'
            cMap = gray(nCols);
            colormap gray;
    end;
    imagesc(reshape(repmat(refImg(:, :, 2), 1, 3), dimX, dimY, 3));
    hold on;
    ROICenter = zeros(numel(ROIPos), 2);
    for iROI = 1 : numel(ROIPos);
        
        [x, y] = find(ROIPos{iROI});
        ROICenter(iROI, 1) = mean(y);
        ROICenter(iROI, 2) = mean(x);
        if ROIValues(iROI) == cLims(1)
            cInd = 1;
        else
            cInd = round((ROIValues(iROI) - cLims(1)) / (cLims(end) - cLims(1)) * nCols);
        end;
        if isnan(cInd);
            hScatter = scatter(ROICenter(iROI, 1), ROICenter(iROI, 2), pointSize, 'o');
            %set(hScatter, 'MarkerFaceColor', ones(1, 3) * 0.5, 'MarkerEdgeColor', 'none');
            set(hScatter, 'MarkerFaceColor', cMap(nCols/2, :), 'MarkerEdgeColor', 'none');
        else
            if cInd < 1 || cInd > nCols;
                warning('plotROILocHeatMapPoint:cIndOutOfRange', 'cInd out of range: %d.', cInd);
                cInd = min(max(cInd, 1), nCols);
            end;
            col = cMap(cInd, :);
            hScatter = scatter(ROICenter(iROI, 1), ROICenter(iROI, 2), pointSize, 'o');
            set(hScatter, 'MarkerFaceColor', col, 'MarkerEdgeColor', 'none');
        end;
    end;
    hColBar = colorbar();
    caxis([0 1]);
    set(hColBar, 'YTick', 0 : 0.1 : 1, 'YTickLabel', cLims(1) : (cLims(end) - cLims(1)) / 10 : cLims(end));
    set(get(hColBar,'YLabel'), 'String', colorBarLabel);
    
    titleHandle = title(saveName, 'Interpreter', 'none');
    makePrettyFigure(gcf);
    set(titleHandle, 'FontSize', 8);
    set(gca, 'FontSize', 8, 'YTick', [], 'XTick', []);
    set(get(hColBar,'YLabel'), 'FontSize', 8);
    
end