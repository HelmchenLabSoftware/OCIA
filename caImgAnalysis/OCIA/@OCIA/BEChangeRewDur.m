function BEChangeRewDur(this, h, ~)
% BEChangeRewDur - [no description]
%
%       BEChangeRewDur(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.GUI.handles.be.rewDurSetter ~= h; % if change was requested by a input value
    this.be.params.rewDur = h;
    o('#BEChangeRewDur(): h: %d, rewardDur: %d.', h, this.be.params.rewDur, 4, this.verb);
    % change the GUI value to the right one
    set(this.GUI.handles.be.rewDurSetter, 'String', this.be.params.rewDur);
else % if change was requested by the callback
    o('#BEChangeRewDur(): h: %d, string: %d.', h, get(h, 'String'), 4, this.verb);
    this.be.params.rewDur = str2double(get(h, 'String'));
end;
showMessage(this, sprintf('Reward duration: %4.4f', this.be.params.rewDur));

end

