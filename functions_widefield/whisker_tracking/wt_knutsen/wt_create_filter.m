function tFilter = wt_create_filter(tDefaultFilter, sOption)
% Whisker Tracker (WT)
%
% Authors: Per Magne Knutsen, Dori Derdikman
%
% (c) Copyright 2004 Yeda Research and Development Company Ltd.,
%     Rehovot, Israel
%
% This software is protected by copyright and patent law. Any unauthorized
% use, reproduction or distribution of this software or any part thereof
% is strictly forbidden. 
%
% Citation:
% Knutsen, Derdikman, Ahissar (2004), Tracking whisker and head movements
% of unrestrained, behaving rodents, J. Neurophys, 2004, IN PRESS

% Create a mexican hat (DoG) filter interactively
%
% Usage:
% Set filter interactively
%   tFilter = wt_create_filter(tDefaultFilter)
%
% Create filter only (don't open GUI)
%   tFilter = wt_create_filter(tDefaultFilter, 'create-only')
%

if exist('sOption')
    switch lower(sOption)
        case 'create-only'
            tFilter = CreateFilter(tDefaultFilter);
            return
    end
end

hWT_win = findobj('Tag', 'WTMainWindow');
if ~isempty(hWT_win)
    wt_display_frame; % refresh frame
end

if ~exist('tDefaultFilter')
    tDefaultFilter.Size = 10;
    tDefaultFilter.Sigma_A = 3;
    tDefaultFilter.Sigma_B = 1;
end

% Open window
hFig = figure;
set(hFig, 'Position', [350 520 520 180], 'MenuBar', 'none', 'NumberTitle', 'off', 'Name' ,'WT - GENERATE FILTER', 'Tag', 'WT_GENERATE_FILTER', 'Resize', 'off')

hSub = subplot('Position', [.65 .1 .35 .8]);
set(hSub, 'xtick', [], 'ytick', [], 'Color', 'k', 'Tag', 'WT_GENERATE_FILTER_SUBPLOT')
axis square

% Slide bars
hSliderAB_size = uicontrol(hFig, 'style', 'slider');
SetSliderProps(hSliderAB_size, [.15 .85 .4 .1], 1, 101, [.01 .1], tDefaultFilter.Size, 'AB_SIZE', 'Size', @UpdateFilter)

hSliderA_sigma = uicontrol(hFig, 'style', 'slider');
SetSliderProps(hSliderA_sigma, [.15 .54 .4 .1], 0.001, 10, [.01 .1], tDefaultFilter.Sigma_A, 'A_SIGMA', 'A sigma', @UpdateFilter)

hSliderB_sigma = uicontrol(hFig, 'style', 'slider');
SetSliderProps(hSliderB_sigma, [.15 .41 .4 .1], 0.001, 10, [.01 .1], tDefaultFilter.Sigma_B, 'B_SIGMA', 'B sigma', @UpdateFilter)

hTxt = uicontrol(gcf, 'style', 'text'); % Text string indicating slider value
set(hTxt, 'units', 'normalized', 'string', 'Size should greater than the maximal expected frame to frame displacement', 'Position', [.05 .675 .575 .15], 'HorizontalAlignment', 'left')

hTxt = uicontrol(gcf, 'style', 'text'); % Text string indicating slider value
set(hTxt, 'units', 'normalized', 'string', 'Sigmas should be adjusted so that the object of interest appears dark in the image', 'Position', [.05 .23 .575 .15], 'HorizontalAlignment', 'left')


hSaveButton = uicontrol(hFig, 'style', 'pushbutton'); % SAVE button
set(hSaveButton, 'units', 'normalized', 'Position', [.15 .05 .15 .15], 'string', 'Save', 'Callback', ['uiresume(gcf);'])
hCancelButton = uicontrol(hFig, 'style', 'pushbutton'); % CANCEL button
set(hCancelButton, 'units', 'normalized', 'Position', [.4 .05 .15 .15], 'string', 'Cancel', 'Callback', ['close(gcf);'])

TestFilter;

uiwait(hFig)

if ~isempty(findobj('Tag', 'WT_GENERATE_FILTER'))
    tFilter.Size = round(get(findobj('Tag', 'AB_SIZE'), 'Value'));
    tFilter.Sigma_A = get(findobj('Tag', 'A_SIGMA'), 'Value');
    tFilter.Sigma_B = get(findobj('Tag', 'B_SIGMA'), 'Value');
    tFilter = CreateFilter(tFilter);
    close(hFig)
else
    tFilter = tDefaultFilter;
end

wt_display_frame

TestFilter('clear')

return

% Create filter
function TestFilter(sOption)

global g_tWT
persistent mImg

if exist('sOption')
    switch lower(sOption)
        case 'clear'
            clear mImg;
            return
    end
end

nSize = round(get(findobj('Tag', 'AB_SIZE'), 'Value'));
mGaussA = fspecial('gaussian', nSize, get(findobj('Tag', 'A_SIGMA'), 'Value')); % Gaussian A
mGaussB = fspecial('gaussian', nSize, get(findobj('Tag', 'B_SIGMA'), 'Value')); % Gaussian B
mFilter = mGaussA - mGaussB; % DoG (Difference of Gaussians)

hSub = findobj('Tag', 'WT_GENERATE_FILTER_SUBPLOT');
axis(hSub);
imagesc(mFilter);
colormap pink
set(hSub, 'xtick', [], 'ytick', [], 'Color', 'k', 'Tag', 'WT_GENERATE_FILTER_SUBPLOT')
axis square
drawnow

% Convolve WT window
hWT_win = findobj('Tag', 'WTMainWindow');
if ~isempty(hWT_win) % don't convolve if WT window is closed
    if isempty(mImg)
        hAx = findobj(hWT_win, 'type', 'axes');
        mImg = get(findall(hAx, 'type', 'image'), 'cdata');
    end
    mImg_conv = conv2(double(mImg), mFilter, 'same'); % convolve
    wt_display_frame(get(g_tWT.Handles.hSlider, 'value'), mImg_conv); % FIX FRAMENUMBER!!!!!!
end

figure(findobj('Tag', 'WT_GENERATE_FILTER'))

return
% end test filter

% Update filter parameters
function UpdateFilter(varargin)
hAB_SIZE = findobj('Tag', 'AB_SIZE');
hAB_SIZE_txt = findobj('Tag', 'AB_SIZE-txt');
set(hAB_SIZE_txt, 'String', round(get(hAB_SIZE, 'Value')));

hA_SIGMA = findobj('Tag', 'A_SIGMA');
hA_SIGMA_txt = findobj('Tag', 'A_SIGMA-txt');
set(hA_SIGMA_txt, 'String', get(hA_SIGMA, 'Value'));

hB_SIGMA = findobj('Tag', 'B_SIGMA');
hB_SIGMA_txt = findobj('Tag', 'B_SIGMA-txt');
set(hB_SIGMA_txt, 'String', get(hB_SIGMA, 'Value'));

TestFilter;

return
% end update filter

% Set slider properties
function SetSliderProps(hSlider, vPos, nMin, nMax, vStep, nDefault, sTag, sString, sCallback)
set(hSlider, 'units', 'normalized' ...
    , 'Position', vPos ...
    , 'Style', 'slider' ...
    , 'Tag', sTag ...
    , 'Min', nMin ...
    , 'Max', nMax ...
    , 'SliderStep', vStep ...
    , 'Value', nDefault ...
    , 'CallBack', sCallback );
hTxt = uicontrol(gcf, 'style', 'text'); % Text string indicating slider value
set(hTxt, 'units', 'normalized', 'string', get(hSlider, 'Value'), 'Position', [vPos(1)+vPos(3) vPos(2) .075 vPos(4)], 'Tag', sprintf('%s-txt', sTag))

hTxt = uicontrol(gcf, 'style', 'text'); % Descriptive text string
set(hTxt, 'units', 'normalized', 'string', sString, 'Position', [.05 vPos(2), vPos(1)-.05 vPos(4)], 'HorizontalAlignment', 'left', 'FontWeight','bold')

return
% end slider properties

% Create filter
function tFilter = CreateFilter(tFilter)
mGaussA = fspecial('gaussian', tFilter.Size, tFilter.Sigma_A); % Gaussian A
mGaussB = fspecial('gaussian', tFilter.Size, tFilter.Sigma_B); % Gaussian B
tFilter.Filter = mGaussA - mGaussB; % DoG (Difference of Gaussians)
return
% end create filter
