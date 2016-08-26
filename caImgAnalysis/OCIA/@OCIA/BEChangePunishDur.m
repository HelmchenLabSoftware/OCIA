function BEChangePunishDur(this, h, ~)
% BEChangePunishDur - [no description]
%
%       BEChangePunishDur(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.GUI.handles.be.punishDurSetter ~= h; % if change was requested by a input value
    this.be.params.punishDur = h;
    o('#BEChangePunishDur(): h: %d, punishDur: %d.', h, this.be.params.punishDur, 4, this.verb);
    % change the GUI value to the right one
    set(this.GUI.handles.be.punishDurSetter, 'String', this.be.params.punishDur);
else % if change was requested by the callback
    o('#BEChangePunishDur(): h: %d, string: %d.', h, get(h, 'String'), 4, this.verb);
    this.be.params.punishDur = str2double(get(h, 'String'));
end;
showMessage(this, sprintf('Punish duration: %4.4f', this.be.params.punishDur));

end

