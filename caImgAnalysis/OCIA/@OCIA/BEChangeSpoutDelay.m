function BEChangeSpoutDelay(this, h, ~)
% BEChangeSpoutDelay - [no description]
%
%       BEChangeSpoutDelay(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.GUI.handles.be.spoutDelaySetter ~= h; % if change was requested by a input value
    this.be.params.spoutDelay = eval(h);
    o('#BEChangeSpoutDelay(): h: %d, spoutDelay: %d.', h, this.be.params.spoutDelay, 4, this.verb);
    % change the GUI value to the right one
    set(this.GUI.handles.be.spoutDelaySetter, 'String', h);
else % if change was requested by the callback
    o('#BEChangeSpoutDelay(): h: %d, "value": %d.', h, get(h, 'String'), 4, this.verb);
    this.be.params.spoutDelay = eval(get(h, 'String'));
end;
showMessage(this, sprintf('Spout delay: [%4.4f %4.4f]', this.be.params.spoutDelay));

end
