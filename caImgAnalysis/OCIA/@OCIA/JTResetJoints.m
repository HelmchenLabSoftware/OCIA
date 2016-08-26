function JTResetJoints(this, ~, ~)
% JTResetJoints - [no description]
%
%       JTResetJoints(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
  
% warn the user that reset will flush all the joints
if this.GUI.jt.askResetConfirm;
    
    % show dialog
    doFlush = questdlg(sprintf(['Pressing OK will discard all joints. Make sure you saved them before!\n\n', ...
        '  Press OK to proceed.']), '/!\ Warning !', 'OK', 'Cancel', 'Cancel');
    
    % if the decision is to abort the clearing
    if ~strcmp(doFlush, 'OK');
        
        % show message and set the focus to the frame setter
        showMessage(this, 'Joints are *NOT* reset.', 'yellow');
        uicontrol(this.GUI.handles.jt.frameSetter);
        
        return;
        
    end;
end;

% clear the GUI and the coordinates on all frames, and display message
JTClearJoints(this, true, 1 : this.jt.nFrames);
showMessage(this, 'Joints reset.');

% set the focus to the frame setter
uicontrol(this.GUI.handles.jt.frameSetter);

end
