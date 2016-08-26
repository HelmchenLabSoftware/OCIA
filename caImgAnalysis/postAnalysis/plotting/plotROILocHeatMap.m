function fig = plotROILocHeatMap(ROIValues, cLims, dimX, dimY, ROIPos, saveName, colorBarLabel)

%     fig = -1;
    fig = figure('Name', saveName, 'NumberTitle', 'off');
    % first create a X-by-Y map with the values as numbers in the ROIs positions
    valuesMap = zeros(dimX, dimY);
    for iROI = 1 : min(size(ROIPos, 1), size(ROIValues, 2));
        valuesMap(ROIPos{iROI}) = ROIValues(iROI);
    end;
    
    % create a colormap for the coloring of the values
%     maxValues = fix(median(ROIValues) + 4 * std(ROIValues));
%     colorScale = jet(cLims(end) - cLims(1));
%     colorScale = jet(numel(cLims));
    nColorSteps = 100;
    colorScale = jet(nColorSteps);
    
    % then create a X-by-Y map with the event counts as RGB colors
    valuesRGBMap = zeros(dimX, dimY, 3);
    % go through each coordinate and color that pixel
    for x = 1 : dimX;
        for y = 1 : dimY;
            % if there is a number there (meaning there is an ROI at those coordinates)
            if valuesMap(x, y);
                val = valuesMap(x, y);
                % bound the value between the range of cLims
                boundedVal = max(min(val, cLims(end)), cLims(1));
                valRatio = (boundedVal - cLims(1)) /  cLims(end);
                valIndex = round(valRatio * nColorSteps);
                valIndexBounded = max(min(valIndex, nColorSteps), 1);
                valuesRGBMap(x, y, :) = colorScale(valIndexBounded, :);
            else % otherwise leave black
                valuesRGBMap(x, y, :) = [0, 0, 0];
            end;
        end;
    end;

    imshow(valuesRGBMap, colorScale, 'Border', 'loose');
    hColBar = colorbar();
    set(get(hColBar,'YLabel'), 'String', colorBarLabel);
    set(hColBar, 'YTick', 0 : 10 : 100, 'YTickLabel', cLims(1) : (cLims(end) - cLims(1)) / 10 : cLims(end));
    
    titleHandle = title(saveName, 'Interpreter', 'none');
    makePrettyFigure(gcf);
    set(titleHandle, 'FontSize', 8);
    set(gca, 'FontSize', 8);
    set(get(hColBar,'YLabel'), 'FontSize', 8);
    
end