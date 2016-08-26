function RDChangeFrame(this, h, ~)
% RDChangeFrame - [no description]
%
%       RDChangeFrame(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    % if change was requested by a number
    if h ~= this.GUI.handles.rd.frameSetter && h ~= -1;
        selFrame = h;
    % if change was requested by the callback
    else
        selFrame = round(get(this.GUI.handles.rd.frameSetter, 'Value'));
    end;
    
    % get the first selected row (in case there is more than one selected)
    iRow = get(this.GUI.handles.rd.tableList, 'Value');
    if isempty(iRow); iRow = 1; end;
    iRow = iRow(1);
    
    % whether to show the average of all frames or each frame
    showAverage = get(this.GUI.handles.rd.showAvg, 'Value');
    % check whether we have a movie (series of frames) or only frame
    if ndims(this.rd.rawFrames{iRow}) < 4 && ~showAverage;
        % if only one frame, switch back to average mode with a warning
        set(this.GUI.handles.rd.showAvg, 'Value', 1);
        showWarning(this, 'OCIA:RDChangeFrame:OnlyOneFrame', 'Only one frame available for this row, keeping average mode.');
        showAverage = true;
    end;
        
    % if an average is requested
    if showAverage;        
        % use the average frame
        this.GUI.rd.img = this.rd.avgImages{iRow};        
        % change the frame label
        set(this.GUI.handles.rd.frameLabel, 'String', 'Average');
        
    % if a frame is requested
    else
        % get the frames
        RGBIm = this.rd.rawFrames{iRow};
        % show the selected frame
        this.GUI.rd.img = squeeze(RGBIm(:, :, selFrame, :));
        % change the frame label
        set(this.GUI.handles.rd.frameLabel, 'String', sprintf('Frame %03d', selFrame));
    end;
    
    % restrict the image between 0 and 1
    img = this.GUI.rd.img; img(img < 0) = 0; img(img > 1) = 1;
    % if image is already RGB
    if ndims(img) == 3;
        % check how many channels are empty
        chanNonEmpty = arrayfun(@(iChan)nansum(nansum(img(:, :, iChan))), 1 : 3) > 0;
        % if only one channel is actually used, transform image into a grayscale RGB image
        if sum(chanNonEmpty) == 1;
            img(:, :, ~chanNonEmpty) = repmat(img(:, :, chanNonEmpty), [1, 1, 2]);
        end;
    % if image is not RGB, create a gray-scale RGB by replicating the single channel
    else
        img = repmat(img, [1 1 3]);
    end;
    
    for iChan = 1 : 3;
        if ~ismember(iChan, get(this.GUI.handles.rd.colorChannels, 'Value'));
            img(:, :, iChan) = 0;
        end;
    end;
    
    % set the image to the display and reset the limits
    set(this.GUI.handles.rd.img, 'CData', img);
    set(this.GUI.handles.rd.axe, 'XLim', [-size(img, 2) * 0.05 size(img, 2) * 1.05], ...
        'YLim', [-size(img, 1) * 0.05 size(img, 1) * 1.05]);
        
    % remove the applied image corrections
    this.GUI.rd.applImCorr = {};
    
end
