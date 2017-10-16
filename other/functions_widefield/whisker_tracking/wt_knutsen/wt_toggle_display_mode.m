function wt_toggle_display_mode(nStatus)
% WT_TOGGLE_VERBOSE
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

global g_tWT

% Check if head-movements are at all tracked in this video. If not, return.
if isempty(g_tWT.MovieInfo.EyeNoseAxLen), return; end

% Toggle verbose status
if exist('nStatus'), g_tWT.DisplayMode = nStatus;
else, g_tWT.DisplayMode = ~g_tWT.DisplayMode; end

% Update user-menu
switch g_tWT.DisplayMode
    case 0
        sStatus = 'on';        
    case 1
        sStatus = 'off';        
    otherwise
        wt_error('Display mode status is undefined. Click continue to set verbose to OFF.')
        g_tWT.DisplayMode = 0;
        sStatus = 'on';
end
set(findobj('Label', 'Toggle viewing mode'), 'checked', sStatus);

wt_display_frame

return
