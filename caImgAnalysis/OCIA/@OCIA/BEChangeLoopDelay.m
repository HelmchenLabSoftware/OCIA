function BEChangeLoopDelay(this, h, ~)
% BEChangeLoopDelay - [no description]
%
%       BEChangeLoopDelay(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.GUI.handles.be.loopBehavDelaySetter ~= h; % if change was requested by a input value
    this.be.params.loopBehavDelay = h;
    o('#%s(): h: %d, loopBehavDelay: %d.', mfilename(), h, this.be.params.loopBehavDelay, 4, this.verb);
    % change the GUI value to the right one
    set(this.GUI.handles.be.loopBehavDelaySetter, 'String', this.be.params.loopBehavDelay);
else % if change was requested by the callback
    o('#%s(): h: %d, string: %d.', mfilename(), h, get(h, 'String'), 4, this.verb);
    this.be.params.loopBehavDelay = eval(get(h, 'String'));
end;
showMessage(this, sprintf('Loop delay: %.1f sec', this.be.params.loopBehavDelay));

end

