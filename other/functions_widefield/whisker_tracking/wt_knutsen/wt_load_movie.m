function wt_load_movie(varargin)
% WT_LOAD_MOVIE
% Load new movie into WT. Run the WT GUI before executing this function.
%
% Syntax: wt_load_movie(MOV), where
%           N is either an integer representing the Nth movie in the
%           currently loaded list of movies (see File->Movies in the WT
%           GUI) or a string containing the path and name of the AVI file
%           to be loaded.
%
% You can call this function from other applications by calling it with the
% string parameter (i.e. passing the filename as a string). In any case,
% the WT GUI must be running before doing this.
%

global g_tWT

wt_save_data('check1st')

% If a movie is currently loaded, check that its uncompressed is deleted (if it exists)
if isfield(g_tWT.MovieInfo, 'FilenameUncompressed')
    if ~isempty(g_tWT.MovieInfo.FilenameUncompressed)
        delete(g_tWT.MovieInfo.FilenameUncompressed);
    end
end

persistent p_nCurrMov;

if ~isempty(varargin)
    if isnumeric(varargin{1})
        p_nCurrMov = varargin{1};
        sFileName = g_tWT.Movies(p_nCurrMov).filename;
    else
        sFileName = varargin{1};
        g_tWT.Movies = struct([]);
        g_tWT.Movies(1).filename = sFileName;
        p_nCurrMov = 1;
    end
else
    % If no movie is specified, the load the next in the order of loading
    if isempty(p_nCurrMov), p_nCurrMov = 1;
    else, p_nCurrMov = p_nCurrMov + 1; end
    if p_nCurrMov > size(g_tWT.Movies, 2)
        errordlg('No more movies in list!', 'WT Error');
        p_nCurrMov = p_nCurrMov -1;
        return
    end
    sFileName = g_tWT.Movies(p_nCurrMov).filename;
end

% Try to load selected .mat file
if strcmp(sFileName(end-3:end), '.mat') % is .mat
    if exist(sFileName, 'file') % and it exists...
        % Try to load
        tT = load(sFileName);
        if isfield(tT, 'g_tMovieInfo') % is a WT file
            g_tWT.MovieInfo = tT.g_tMovieInfo;
        else
            errordlg('The selected .mat file is not in a supported format', 'WT Error')
            return
        end
    end
end

% Load AVI info
if strcmp(sFileName(end-3:end), '.avi')
    if exist(sFileName, 'file'), g_tWT.MovieInfo = aviinfo(sFileName);
    else, wt_error(sprintf('Cannot read %s', wt_check_path(sFileName))); end
end

% Initialize parameters with default values
g_tWT.MovieInfo.FilenameUncompressed = [];
g_tWT.MovieInfo.Roi = [1 1 g_tWT.MovieInfo.Width-1 g_tWT.MovieInfo.Height-1];
g_tWT.MovieInfo.Rot = 0;
g_tWT.MovieInfo.Flip = [0 0];
g_tWT.MovieInfo.Invert = 0;
%g_tWT.MovieInfo.ResizeFactor = 1;
g_tWT.MovieInfo.SplinePoints = [];
g_tWT.MovieInfo.WhiskerSide = [];
g_tWT.MovieInfo.Angle = [];
g_tWT.MovieInfo.PositionOffset = [];
g_tWT.MovieInfo.Intersect = [];
g_tWT.MovieInfo.AngleDelta = 0;
g_tWT.MovieInfo.HorJitter = [1 2 3];
g_tWT.MovieInfo.HorJitterSlow = [1 1 1];
g_tWT.MovieInfo.RadJitter = 1;
g_tWT.MovieInfo.RefLine = [0 1; 0 2];
g_tWT.MovieInfo.ViewMag = 1;
g_tWT.MovieInfo.WhiskerWidth = 1;
g_tWT.MovieInfo.FilterLen = 11;
g_tWT.MovieInfo.UsePosExtrap = 0;
g_tWT.MovieInfo.WhiskerLabels = {};
g_tWT.MovieInfo.ExtrapFiltHw = 10;
g_tWT.MovieInfo.AverageFrames = [0 0];
g_tWT.MovieInfo.MidPointConstr = [];
g_tWT.MovieInfo.ScreenRefresh = 5;
g_tWT.MovieInfo.NoFramesToLoad = 100;
g_tWT.MovieInfo.RightEye = [];
g_tWT.MovieInfo.LeftEye = [];
g_tWT.MovieInfo.Nose = [];
g_tWT.MovieInfo.StimulusA = [];
g_tWT.MovieInfo.StimulusB = [];
g_tWT.MovieInfo.EyeNoseAxLen = [];
g_tWT.MovieInfo.RadExt = 150;
g_tWT.MovieInfo.HorExt = 50;
g_tWT.DisplayMode = 1;
g_tWT.HideImage = 0;
g_tWT.MovieInfo.ImCropSize = [g_tWT.MovieInfo.Width g_tWT.MovieInfo.Height];
g_tWT.MovieInfo.ObjectRadPos = [];
g_tWT.MovieInfo.CalBarLength = [];
g_tWT.MovieInfo.CalibCoords = [0 0;0 0];
g_tWT.MovieInfo.LastFrame = [];
g_tWT.MovieInfo.WhiskerLength = [];
g_tWT.MovieInfo.BGFrameLowPass = 5;
g_tWT.DefaultSavePath = [];
g_tWT.PixelsPerMM = [];
g_tWT.ShowLabelIdentity = 0;


% Reset the averaged frame
wt_subtract_bg_frame('reset');

% Load previously collected data
% If that fails (e.g. if there is none), then attempt to load the default
% parameters file (wt_default_parameteres)

try, wt_load_data
catch
    try
        % Use local default parameters
        global g_tOptFields
        if ispc
            load('C:\wt_default_parameters.mat', 'g_tOptFields');
        elseif isunix
            load('~.wt_default_parameters', 'g_tOptFields');
        end
        wt_set_parameters('updatevars', size(fieldnames(g_tOptFields), 1))
    end
end

% We set it here, in case movies with saved data are moved around
g_tWT.MovieInfo.Filename = [sFileName(1:end-4) '.avi'];

% Re-load parameters and make sure that g_tWT.MovieInfo contains correct AVI
% info
if strcmp(sFileName(end-3:end), '.avi')
    tMovieInfo = aviinfo(g_tWT.MovieInfo.Filename);
    g_tWT.MovieInfo.FramesPerSecond = tMovieInfo.FramesPerSecond;
    g_tWT.MovieInfo.NumFrames = tMovieInfo.NumFrames;
    g_tWT.MovieInfo.Width = tMovieInfo.Width;
    g_tWT.MovieInfo.Height = tMovieInfo.Height;
    if ~isfield(g_tWT.MovieInfo, 'CalBarLength'), g_tWT.MovieInfo.CalBarLength = []; end
    if ~isfield(g_tWT.MovieInfo, 'CalibCoords'), g_tWT.MovieInfo.CalibCoords = [0 0;0 0];    end
    g_tWT.MovieInfo.FilenameUncompressed = [];

    % Initialize image buffer
    g_tWT.CurrentFrameBuffer.Img   = [];
    g_tWT.CurrentFrameBuffer.Frame = 1;
    
end


% Display frame number 1, or the first frame where head-position is known
wt_prep_gui
if ~isempty(g_tWT.MovieInfo.EyeNoseAxLen)
    vKnownFrames = find(~isnan(g_tWT.MovieInfo.Nose(:,1)));
    wt_display_frame(vKnownFrames(1));
else, wt_display_frame(1), end

wt_autosize_window

% If notes exist for this movie, pop up the Notes window UNLESS we are in
% batch mode
if isfield(g_tWT.MovieInfo, 'Notes')
    bShow = 1;
    if isfield(g_tWT, 'BatchMode')
        if g_tWT.BatchMode, bShow = 0; end 
    end
    if ~isempty(g_tWT.MovieInfo.Notes) & bShow, wt_edit_notes, end
end

% If the WT Plots window is open, refresh it with new data
if ~isempty(findobj('name','WT Plots'))
    wt_graphs('refresh')
    wt_graphs('',1)
end

return
