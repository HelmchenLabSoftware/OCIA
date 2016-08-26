% WT_RESET_ALL
% Reset all movie and tracking parameters
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

function wt_reset_all

% Issue warning
sAnswer =  questdlg('This action will delete all tracked whiskers, head-movements and associated parameters. Continue?', ...
        'Title', 'Yes', 'No', 'No');
if strcmp(sAnswer, 'No'), return; end

global g_tWT

g_tWT.MovieInfo.Roi = [1 1 g_tWT.MovieInfo.Width-1 g_tWT.MovieInfo.Height-1];
g_tWT.MovieInfo.Rot = 0;
%g_tWT.MovieInfo.ResizeFactor = 1;
g_tWT.MovieInfo.Flip = [0 0];
g_tWT.MovieInfo.SplinePoints = [];
g_tWT.MovieInfo.WhiskerSide = [];
g_tWT.MovieInfo.Angle = [];
g_tWT.MovieInfo.PositionOffset = [];
g_tWT.MovieInfo.Intersect = [];
g_tWT.MovieInfo.RefLine = [0 1; 0 2];
g_tWT.MovieInfo.RightEye = [];
g_tWT.MovieInfo.LeftEye = [];
g_tWT.MovieInfo.Nose = [];
g_tWT.MovieInfo.StimulusA = [];
g_tWT.MovieInfo.StimulusB = [];
g_tWT.MovieInfo.EyeNoseAxLen = [];
g_tWT.MovieInfo.ImCropSize = [g_tWT.MovieInfo.Width g_tWT.MovieInfo.Height];
g_tWT.MovieInfo.Curvature = [];
g_tWT.MovieInfo.ObjectRadPos = [];
g_tWT.MovieInfo.WhiskerIdentity = {};
g_tWT.MovieInfo.LastFrame = [];
g_tWT.MovieInfo.CalBarLength = [];
g_tWT.MovieInfo.CalibCoords = [0 0;0 0];

wt_display_frame

return