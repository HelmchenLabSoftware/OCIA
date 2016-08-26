function BEChangePiezoThresh(this, h, ~)
% BEChangePiezoThresh - [no description]
%
%       BEChangePiezoThresh(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% if change was requested by a mouse click
if ischar(h) && strcmp(h, 'mouseAdjust') && ~isempty(get(this.GUI.figH, 'CurrentObject')) ...
        && get(this.GUI.figH, 'CurrentObject') == this.GUI.handles.be.monAxes ...
        && strcmp(get(this.GUI.figH, 'SelectionType'), 'extend');
    coords = get(this.GUI.handles.be.monAxes, 'CurrentPoint');
    coords = coords(1, :);
    piezoIndex = find(strcmp(this.be.hw.analogIns, 'piezo'));
    piezoThresh = roundn((coords(2) - this.GUI.be.anInOffset(piezoIndex)) ./ this.GUI.be.anInMagnifs(piezoIndex), -5);
    o('#%s(): h: %s, piezoThresh: %.6f -> %.6f, coords: %d, %d, %d.', mfilename(), h, this.be.params.piezoThresh, ...
        piezoThresh, coords, 4, this.verb);
    this.be.params.piezoThresh = piezoThresh;
    set(this.GUI.handles.be.piezoThreshSetter, 'String', this.be.params.piezoThresh);
    
elseif ~ischar(h) && (isnumeric(h) || ishandle(h)) && this.GUI.handles.be.piezoThreshSetter ~= h; % if change was requested by a input value
    this.be.params.piezoThresh = h;
    o('#%s(): h: %d, piezoThresh: %.6f.', mfilename(), h, this.be.params.piezoThresh, 4, this.verb);
    % change the GUI value to the right one
    set(this.GUI.handles.be.piezoThreshSetter, 'String', this.be.params.piezoThresh);
    
elseif ~ischar(h) && (isnumeric(h) || ishandle(h)); % if change was requested by the callback
    o('#%s(): h: %d, "value": %.6f.', mfilename(), h, get(h, 'String'), 4, this.verb);
    this.be.params.piezoThresh = str2double(get(h, 'String'));
    
else
    % do nothing
    return;
end;
showMessage(this, sprintf('Piezo threshold: %.6f', this.be.params.piezoThresh));

end
