function wt_track_stimulus
% WT_TRACK_STIMULUS
% Track stimulus squares in upper-left hand corner made by the Redlake
% Motionscope video-system. Accepts no input parameters.

global g_tWT

for i = 1:size(g_tWT.Movies, 2)
    if strcmp(sprintf('%s', g_tWT.Movies(:,i).filename), char(g_tWT.MovieInfo.Filename)), m = i; end
end

% Track squares
for m = m
    sFilename = g_tWT.Movies(:,m).filename(1:findstr('.avi', g_tWT.Movies(:,m).filename)-1);
    
    % Clear previous head-coordinates (but not delete them from disk!)
    g_tWT.MovieInfo.StimulusA = [];
    g_tWT.MovieInfo.StimulusB = [];
    
    % Track squares
    
    %  - open waitbar
    hWaitbar = waitbar(0, 'Loading movie...');
    
    %  - get coordinates of squares from global look-up table
    % Framerate width   height  pos_x1  pos_y1  pos_x2  pos_y2
    nMatchingFormat = find( g_tWT.Stimulus(:,1) == g_tWT.MovieInfo.FramesPerSecond & ...
        g_tWT.Stimulus(:,2) == g_tWT.MovieInfo.Width & ...
        g_tWT.Stimulus(:,3) == g_tWT.MovieInfo.Height );
    if isempty(nMatchingFormat)
        wt_set_status(sprintf('ERROR: %s does not match pre-specified formats in the look-up table. Will not track squares in this movie.', sFilename));
        continue;
    end
    
    nXa = g_tWT.Stimulus(nMatchingFormat, 4);
    nYa = g_tWT.Stimulus(nMatchingFormat, 5);
    nXb = g_tWT.Stimulus(nMatchingFormat, 6);
    nYb = g_tWT.Stimulus(nMatchingFormat, 7);
    
    %  - iterate over frames
    mFrameRanges = [0:g_tWT.MovieInfo.NoFramesToLoad:g_tWT.MovieInfo.NumFrames g_tWT.MovieInfo.NumFrames];
    for fr = 1:length(mFrameRanges)-1
        nStart = mFrameRanges(fr)+1;
        nStop = mFrameRanges(fr+1);
        
        %  Load frames
        waitbar(nStart/g_tWT.MovieInfo.NumFrames, hWaitbar, 'Loading next range of frames...');
        mFrames = wt_load_avi(sprintf('%s.avi',sFilename), nStart:nStop, 'noresize');
        
        for f = nStart:nStop
            nIndx = f-nStart+1;
            %  - update waitbar
            waitbar(f/g_tWT.MovieInfo.NumFrames, hWaitbar, sprintf('Processing frame %d', nIndx));

            % Evaluate if squares are black (mean<128) or white (mean>128)
            % Square A (right)
            if round(mean(mean(double(imcrop(mFrames(:,:,nIndx), [nXa-1 nYa-1 3 3]))))) > 128
                g_tWT.MovieInfo.StimulusA(f) = 1;
            else
                g_tWT.MovieInfo.StimulusA(f) = 0;
            end
            % Square B (right)
            if round(mean(mean(double(imcrop(mFrames(:,:,nIndx), [nXb-1 nYb-1 3 3]))))) > 128
                g_tWT.MovieInfo.StimulusB(f) = 1;
            else
                g_tWT.MovieInfo.StimulusB(f) = 0;
            end
        end
    end
    
    %  - close waitbar
    close(hWaitbar)
end

msgbox('Done tracking stimulus triggers')

return


