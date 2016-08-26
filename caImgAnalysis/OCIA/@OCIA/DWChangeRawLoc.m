function DWChangeRawLoc(this, h, ~)
% DWChangeRawLoc - [no description]
%
%       DWChangeRawLoc(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    radioGroupH = this.GUI.handles.dw.rawLocGroup;
    if ischar(h); % if change was requested by a string input
        o('#DWChangeRawLoc(): h: %s.', h, 3, this.verb);
        % change the radiobutton to the requested one
        set(radioGroupH, 'SelectedObject', this.GUI.handles.dw.rawLocSel.(lower(h(1:3))));
    end;
    
    o('#DWChangeRawLoc(): changed to %s.', get(get(radioGroupH, 'SelectedObject'), 'String'), 3, this.verb);
    
    % update the watch folder according to the new settings
    DWUpdateWatchFolderPath(this);

end

