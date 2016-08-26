function BEChangeVidRecDelay(this, h, ~)
% BEChangeVidRecDelay - [no description]
%
%       BEChangeVidRecDelay(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.GUI.handles.be.vidRecDelaySetter ~= h; % if change was requested by a input value
    this.be.params.vidRecDelay = h;
    o('#%s(): h: %d, punishDur: %d.', mfilename(), h, this.be.params.vidRecDelay, 4, this.verb);
    % change the GUI value to the right one
    set(this.GUI.handles.be.vidRecDelaySetter, 'String', this.be.params.vidRecDelay);
else % if change was requested by the callback
    o('#%s(): h: %d, string: %d.', mfilename(), h, get(h, 'String'), 4, this.verb);
    this.be.params.vidRecDelay = eval(get(h, 'String'));
end;
showMessage(this, sprintf('Video record delays: start: %.1f sec, end: %.1f sec', this.be.params.vidRecDelay));

end

