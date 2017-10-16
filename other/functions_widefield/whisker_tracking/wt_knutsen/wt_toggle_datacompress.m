function wt_toggle_datacompress
% WT_TOGGLE_DATACOMPRESS
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

% Toggle compress status
g_tWT.CompressData = ~g_tWT.CompressData;

% Update user-menu
switch g_tWT.CompressData
    case 1
        sStatus = 'on';
    case 0
        sStatus = 'off';        
    otherwise
        wt_error('Compress status is undefined. Click continue to set compress to OFF.')
        g_tWT.CompressData = 0;
        sStatus = 'off';
end
set(findobj('Label', 'Compress datafiles'), 'checked', sStatus);

return
