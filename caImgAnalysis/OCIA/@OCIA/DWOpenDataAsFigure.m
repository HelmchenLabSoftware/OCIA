function DWOpenDataAsFigure(this, varargin)
% DWOpenDataAsFigure - [no description]
%
%       DWOpenDataAsFigure(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
    % if nothing is selected, abort
    if isempty(this.dw.selectedTableRows); 
        showWarning(this, 'OCIA:DWOpenDataAsFigure:NoRowsSelected', 'No rows selected! Aborting.');
        return;
    end;
    
    % get the selected row and it's rowID
    iDWRow = this.dw.selectedTableRows(1);
    rowID = DWGetRowID(this, iDWRow);
    rowTypeID = DWGetRowTypeID(this, iDWRow);
    
    % create the user data structure
    userDataStruct = struct('RGBIm', [], 'iFrame', 1, 'channels', [1 1 1], 'imHandle', [], 'textHandle', [], ...
        'isGrayScale', 0, 'isAverage', 0, 'isFilter', 0, 'frameRate', str2double(get(this, iDWRow, 'frameRate')));
    
    % create the figure
    set(0, 'Units', 'pixels');
    prevFigH = figure('Name', sprintf('%s - data preview', rowID), 'NumberTitle', 'off', 'Position', ...
        [1 1 repmat(max(get(0, 'ScreenSize')) * 0.5, 1, 2)], ...
        'KeyPressFcn', @(h, e)DWChangeFrameForDataPreview(this, h, e));
    
    % show a black image
    userDataStruct.imHandle = imagesc(zeros([256, 256, 3]));
    % add the text display
    userDataStruct.textHandle = text(3, 3, 'Loading ...', 'Color', 'yellow');
    % remove axes
    set(gca, 'XTick', [], 'YTick', []);
    % make the figure borders tight and center the figure
    tightfig();
    movegui(prevFigH, 'center');
    pause(0.1);
    
    % call the custom function without warnings
    warning('off', 'OCIA:getPreviewFunctionNotFound');
    [~, RGBIm] = OCIAGetCallCustomFile(this, 'getPreview', rowTypeID, true, { this, iDWRow, 'full' }, false);
    warning('on', 'OCIA:getPreviewFunctionNotFound');

    % if no images obtained from the preview function, use a black square
    if isempty(RGBIm); RGBIm = zeros([256, 256, 1, 3]); end;
    
    % display the actual data
    userDataStruct.imHandle = imagesc(squeeze(RGBIm(:, :, 1, :)));    
    % add the text display
    userDataStruct.textHandle = text(2, 5, sprintf(['frame: %d/%d (%.3f s), channel: [%d, %d, %d], average: off, ', ...
        'grayscale: off, filter: off. Type "h" for shortcuts.'], userDataStruct.iFrame, size(RGBIm, 3), ...
        userDataStruct.iFrame ./ userDataStruct.frameRate, userDataStruct.channels), 'Color', 'yellow');
    % save the images in the figure's user data
    userDataStruct.RGBIm = RGBIm;
    set(prevFigH, 'UserData', userDataStruct);
    
end
