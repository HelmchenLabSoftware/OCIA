function BEChangeVidRecState(this, h, ~)
% BEChangeVidRecState - [no description]
%
%       BEChangeVidRecState(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if ischar(h) && ~strcmpi(h, 'reset'); % if change was requested by a input value
    recState = h;
    o('#BEChangeVidRecState(): h: %s, recState: %s.', h, recState, 4, this.verb);
    % change the GUI value to the right one
    set(this.GUI.handles.be.vidRecEnableGroup, 'SelectedObject', this.GUI.handles.be.(['vidRecEnable', recState]));
    
elseif h == this.GUI.handles.be.vidRecEnableGroup; % if change was requested by the callback
    recState = get(get(h, 'SelectedObject'), 'String');
    o('#BEChangeVidRecState(): h: %d, selectedObject: %d, recState: %s.', h, get(h, 'SelectedObject'), ...
        recState, 4, this.verb);
    
% little ugly hidden hack :-)
elseif strcmpi(h, 'reset');
    o('#BEChangeVidRecState(): sending reset ...', 2, this.verb); 
    serverSocketSendMessage('reinit', 22, 3, 1);
    o('#BEChangeVidRecState(): reset sent.', 2, this.verb);
    return;
    
else
    recState = get(get(this.GUI.handles.be.vidRecEnableGroup, 'SelectedObject'), 'String');
    
end;
showMessage(this, sprintf('Video record state: %s', recState));


end
