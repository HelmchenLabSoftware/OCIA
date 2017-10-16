function wt_load_data(varargin)
% WT_LOAD_DATA Load movie data from disk.
%
% Usage:
%   TODO
%


global g_tWT
sOldMovieName = '';

% Load whisker data and parameters
try
    vStrIndx = 1:findstr(g_tWT.MovieInfo.Filename, '.avi')-1;
    sFilename = sprintf('%s.mat', g_tWT.MovieInfo.Filename(vStrIndx));

    % Let user select data file to load (otherwise load default)
    if nargin==1
        switch varargin{1}
            case 'deffile'
                [sFilename, sFilepath] = uigetfile('*.mat;*.gz', 'Select data file');
                sFilename = sprintf('%s%s', sFilepath, sFilename);
                sOldMovieName = g_tWT.MovieInfo.Filename; % we keep the old filename
        end
    end

    % Uncompress .gz file if it exists
    if exist([sFilename '.gz'], 'file') == 2 % archive exists
        eval(sprintf('!copy %s %s', [sFilename '.gz'], [sFilename '.gz.bak']));
        % gzip path
        sPath = which('wt_load_data');
        eval(sprintf('!%s\\bin\\gzip -d %s', sPath(1:(end-14)), [sFilename '.gz']))
        
        tLoadedStruct = load(sprintf('%s', sFilename));
        if isfield(tLoadedStruct, 'g_tWT.MovieInfo')
            g_tWT.MovieInfo = tLoadedStruct.g_tWT.MovieInfo;
        elseif isfield(tLoadedStruct, 'g_tMovieInfo')
            g_tWT.MovieInfo = g_tMovieInfo;
        end
        
        %load(sprintf('%s', sFilename), 'g_tWT.MovieInfo');
        delete(sFilename)
        eval(sprintf('!move %s %s', [sFilename '.gz.bak'], [sFilename '.gz']));
    else
        temp = load(sprintf('%s', sFilename), 'g_tMovieInfo');
    end

    g_tWT.MovieInfo = assign_struct_array_elem(g_tWT.MovieInfo, 1, temp.g_tMovieInfo);
    %wt_set_status(sprintf('Data file found: %s', sFilename))
    
    if ~isempty(sOldMovieName)
        g_tWT.MovieInfo.Filename = sOldMovieName;
        sFilename = [sOldMovieName(1:end-3) 'mat'];
    end

    g_tWT.DefaultSavePath = sFilename;

catch
    if isempty(sFilename), return, end
    wt_set_status('Data file not found.', sFilename)
end

% If the path of the video in g_tWT.MovieInfo is not the same as the
% selected/loaded movie, then change the path in g_tWT.MovieInfo *by default*
if ~strcmp(g_tWT.MovieInfo.Filename, [sFilename(1:end-3) 'avi']) % filenames don't match
    g_tWT.MovieInfo.Filename = [sFilename(1:end-3) 'avi'];
end

% Refresh frame
wt_display_frame(1)

return
