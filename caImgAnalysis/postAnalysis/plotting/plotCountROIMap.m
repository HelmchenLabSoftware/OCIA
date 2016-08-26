function fig = plotCountROIMap(eventCounts, dimX, dimY, ROIPos)

    fig = figure('Name', 'Event counts', 'NumberTitle', 'off');
    % first create a X-by-Y map with the event counts as values in the ROIs positions
    eventCountMap = zeros(dimX, dimY);
    for iROI = 1 : size(ROIPos, 1);
        eventCountMap(ROIPos{iROI}) = eventCounts(iROI);
    end;
    
    % create a colormap for the coloring of the event counts
    maxEvents = fix(median(eventCounts(:)) + 4 * std(eventCounts(:)));
    colorScale = hot(maxEvents);
    
    % then create a X-by-Y map with the event counts as RGB colors
    eventCountRGBMap = zeros(dimX, dimY, 3);
    % go through each coordinate and color that pixel
    for x = 1 : dimX;
        for y = 1 : dimY;
            if eventCountMap(x, y) > 0; % if there is an event (meaning there is an ROI)
                eventCountRGBMap(x, y, :) = colorScale(min(eventCountMap(x, y) + 1, maxEvents), :);
            else % otherwise leave black
                eventCountRGBMap(x, y, :) = [0, 0, 0];
            end;
        end;
    end;
    imshow(eventCountRGBMap);
    
end