function BEChangeEOFrac(this, h, ~)
% BEChangeEOFrac - [no description]
%
%       BEChangeEOFrac(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.GUI.handles.be.EORewDelaySetter ~= h; % if change was requested by a input value
    this.be.params.autoRewardEarlyOnTimeFraction = h;
    o('#%s(): h: %d, punishDur: %d.', mfilename(), h, this.be.params.autoRewardEarlyOnTimeFraction, 4, this.verb);
    % change the GUI value to the right one
    set(this.GUI.handles.be.EORewDelaySetter, 'String', this.be.params.autoRewardEarlyOnTimeFraction);
else % if change was requested by the callback
    o('#%s(): h: %d, string: %d.', mfilename(), h, get(h, 'String'), 4, this.verb);
    this.be.params.autoRewardEarlyOnTimeFraction = eval(get(h, 'String'));
end;
showMessage(this, sprintf('EOFrac: %.2f', this.be.params.autoRewardEarlyOnTimeFraction));

end

