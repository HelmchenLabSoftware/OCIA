function [vOut, sUnit] = wt_pix_2_mm(vIn)
% WT_PIX_2_MM
% Convert from pixels to millimeters according to calibration settings.
% Syntax: [OUT,UNIT] = wt_pix_2_mm(IN), where
%   IN is a trace in pixels
%   UNIT is the unit of the trace returned (mm or pix)
%
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

% Defaults
vOut = vIn;
sUnit = 'pix';

if isfield(g_tWT.MovieInfo, 'PixelsPerMM')
    if ~isempty(g_tWT.MovieInfo.PixelsPerMM)
        vOut = vIn ./ g_tWT.MovieInfo.PixelsPerMM;
        sUnit = 'mm';
    end
end

return;
