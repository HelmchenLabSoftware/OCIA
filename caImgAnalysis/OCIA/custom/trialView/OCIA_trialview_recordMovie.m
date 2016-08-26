function this = OCIA_trialview_recordMovie(this, ~, ~)
% OCIA_trialview_recordMovie - Record movie
%
%       OCIA_trialview_recordMovie(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

showMessage(this, 'TrialView: Recording movie ...');

% hide control pannel
set(this.GUI.handles.tv.paramPan, 'Visible', 'off');

% create video writer
vw = VideoWriter('movie.avi');
vw.FrameRate = this.tv.params.WFAutoplaySpeedFactor * this.tv.params.WFFrameRate;
vw.open();

% move through the whole movie and capture each frame
for iFrame = 1 : this.tv.params.WFDataSize(3);
    % change frame
    this.tv.iFrame = iFrame;
    OCIA_trialview_changeFrame(this);
    % capture it
    currentFrame = getframe(this.GUI.figH);
    % write it in file
    vw.writeVideo(currentFrame);
end;

% close video writer
vw.close();

% restore control pannel
set(this.GUI.handles.tv.paramPan, 'Visible', 'on');
showMessage(this, 'TrialView: Recording movie done.');

end
