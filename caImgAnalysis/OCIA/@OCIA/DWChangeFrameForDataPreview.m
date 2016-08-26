function DWChangeFrameForDataPreview(this, h, e)
% DWChangeFrameForDataPreview - [no description]
%
%       DWChangeFrameForDataPreview(this, h, e)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
% get the images and the current frame
uData = get(h, 'UserData');
RGBIm = uData.RGBIm;

% do different actions for different key presses
switch e.Key;
    
    % change frame
    case 'leftarrow';
        % no frame update in average mode
        if uData.isAverage; return; end;
        
        % if control is down, jump by 10 % of the frame
        if ismember(e.Modifier, 'control');
            uData.iFrame = uData.iFrame - round(size(RGBIm, 3) * 0.1);
        % if shift is down, jump to the first frame
        elseif ismember(e.Modifier, 'shift');
            uData.iFrame = 1;
        % otherwise go to the previous frame
        elseif uData.iFrame > 1;
            uData.iFrame = uData.iFrame - 1;
        end;
        
    % change frame
    case 'rightarrow';
        % no frame update in average mode
        if uData.isAverage; return; end;
        
        % if control is down, jump by 10 % of the frame
        if ismember(e.Modifier, 'control');
            uData.iFrame = uData.iFrame + round(size(RGBIm, 3) * 0.1);
        % if shift is down, jump to the last frame
        elseif ismember(e.Modifier, 'shift');
            uData.iFrame = size(RGBIm, 3);
        % otherwise go to the next frame
        else
            uData.iFrame = uData.iFrame + 1;
        end;
        
    % switch channel visibility
    case { '1', '2', '3' };
        iChan = str2double(e.Key);
        uData.channels(iChan) = ~uData.channels(iChan);
        
    % change average to frames
    case 'a';
        uData.isAverage = ~uData.isAverage;
        
    % change grayscale to color
    case 'g';
        uData.isGrayScale = ~uData.isGrayScale;
        
    % change grayscale to color
    case 'f';
        uData.isFilter = ~uData.isFilter;
        
    % show help
    case { 'h', 'f1' };
        showMessage(this, ['"left/right arrow" (+ control/shift): navigate frames; ', ...
            '"1/2/3": toggle channel visibility; ', ...
            '"a": toggle average <=> single frame; ', ...
            '"g": toggle grayscale <=> color; ', ...
            'any other key: show help']);
        
    % otherwise abort
    otherwise
        return;
end;

% make sure frame is in the range of the available frames
uData.iFrame = min(max(uData.iFrame, 1), size(RGBIm, 3));

% if an average is required, show the average of all frames
if uData.isAverage;
    RGBImage = squeeze(nanmean(RGBIm, 3));

% otherwise show the frames
else
    % get the image to show
    RGBImage = squeeze(RGBIm(:, :, uData.iFrame, :));
end;
    
% hide the non selected channels (if any)
for iChan = 1 : 3;
    if ~uData.channels(iChan);
        RGBImage(:, :, iChan) = zeros(size(RGBImage, 1), size(RGBImage, 2));
    end;
end;

% if grayscale image is required, average the channel dimension
if uData.isGrayScale;
    RGBImage = repmat(squeeze(nanmean(RGBImage, 3)), [1 1 3]);
end;

% if filtering is required, apply it
if uData.isFilter;
    for iChan = 1 : size(RGBImage, 3);
%         RGBImage(:, :, iChan) = medfilt2(RGBImage(:, :, iChan), [3 3]);
        RGBImage(:, :, iChan) = imfilter(RGBImage(:, :, iChan), fspecial('gaussian', [15 15]));
    end;
end;

% update the text display
if ishandle(uData.textHandle);
    delete(uData.textHandle);
end;
uData.textHandle = text(2, 5, sprintf(['frame: %d/%d (%.3f s), channel: [%d, %d, %d], average: %s, ', ...
        'grayscale: %s, filter: %s. Type "h" for shortcuts.'], uData.iFrame, size(RGBIm, 3), ...
        uData.iFrame ./ uData.frameRate, uData.channels, iff(uData.isAverage, 'on', 'off'), ...
        iff(uData.isGrayScale, 'on', 'off'), iff(uData.isFilter, 'on', 'off')), ...
        'Color', 'yellow');

% update the user data
set(h, 'UserData', uData);

% update image
set(uData.imHandle, 'CData', RGBImage);
    
end
