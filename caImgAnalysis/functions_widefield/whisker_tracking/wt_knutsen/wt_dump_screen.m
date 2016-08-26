%%%% WT_DUMP_SCREEN *****************************************
%
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
%

function wt_dump_screen

global g_tWT

hFrameWin = findobj('Tag', 'WTMainWindow');

sAnswer = questdlg('Select where to dump the screen', ...
    'Dump screen', ...
    'Copy to clipboard', 'Save to disk', 'Send to printer', ...
    'Copy to clipboard');

% Hide slider and text elements
set(g_tWT.Handles.hSlider, 'visible', 'off')
hText = findobj('tag','antpost');
set(hText, 'visible', 'off')
set(findobj('tag','gotoframe'), 'visible', 'off')
set(findobj('tag','movieandframe'), 'visible', 'off')

switch sAnswer
    case 'Copy to clipboard' % copy to clipboard
        print(hFrameWin, '-dbitmap')
    case 'Save to disk' % save to disk
        [sFilename sFilepath, nFilterIndx] = uiputfile({'*.tif';'*.eps'}, 'Select output file');
        if nFilterIndx == 1     % save as TIDD
            print(hFrameWin, '-dtiff', sprintf('%s%s', sFilepath, sFilename));
        elseif nFilterIndx == 2 % save as color EPS
            print(hFrameWin, '-depsc', sprintf('%s%s', sFilepath, sFilename));
        end
    case 'Send to printer' % send to printer
        print(hFrameWin, '-v')
end

% Turn back on slider
set(g_tWT.Handles.hSlider, 'visible', 'on')
set(hText, 'visible', 'on')
set(findobj('tag','gotoframe'), 'visible', 'on')
set(findobj('tag','movieandframe'), 'visible', 'on')

return;
