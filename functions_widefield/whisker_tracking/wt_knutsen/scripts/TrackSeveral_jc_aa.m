function vargout=TrackSeveral_jc_aa(g_tWT)
% performs track_average_whisker_position_ks but is able to process several
% movies after oneanother using the same Pixel-Coordinates for the
% Whiskerpad position (RefLine), the pad origin (WhiskerOrigin) and the ROI
% in which the whiskers are moving (outlines);

%for this you first need to open the mat file of the previous movie
%(containing information on RefLine, Origin and Outlines) and a list with
%movies which should be processed this way needs to be available (can be
%produced using MakeMovieList)

%Routine saves data for each movie in a seperate mat file.

% Ask whether old info should be used
condchoice = questdlg('Would you like to use prior Origin and Reference Line?', ...
 'Use Data', ...
 'Yes entire List','Yes another movie','No','Yes entire List');
% Handle response
switch condchoice
    case 'Yes entire List'
        uiopen %open mat file from your first (already) tracked movie
        slash = findstr(MovieInfo.Filename, '\');
        cd (MovieInfo.Filename(1:slash(end)));
        load ('movie1list.mat');
        track_average_whisker_position_jc_aa(g_tWT, MovieInfo)
        for n=2:length(list)
            wt_load_movie(list{n})
            track_average_whisker_position_jc_aa(g_tWT, MovieInfo)
        end
    case 'Yes another movie'
        uiopen
        track_average_whisker_position_jc_aa(g_tWT, MovieInfo)
    case 'No'
        disp(['You can shortly select Origin and Reference Line'])
        track_average_whisker_position_jc_aa(g_tWT)
end