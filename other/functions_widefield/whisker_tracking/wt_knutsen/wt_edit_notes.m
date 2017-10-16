function wt_edit_notes
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

if isfield(g_tWT.MovieInfo, 'Notes')
    sNotes = g_tWT.MovieInfo.Notes;
else, sNotes = ''; end

cNotes = inputdlg('', 'WT Notes', 10, {sNotes});

if isempty(cNotes), return
else, g_tWT.MovieInfo.Notes = cell2mat(cNotes); end
