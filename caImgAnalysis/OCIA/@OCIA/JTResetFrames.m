function JTResetFrames(this, ~, ~)
% JTResetFrames - [no description]
%
%       JTResetFrames(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% reset frames and display message
this.jt.frames = this.jt.oriFrames;
showMessage(this, 'Frames reset.');

% set the focus to the frame setter
uicontrol(this.GUI.handles.jt.frameSetter);

end
