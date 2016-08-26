function BEChangeAutoRewardMode(this, h, ~)
% BEChangeAutoRewardMode - [no description]
%
%       BEChangeAutoRewardMode(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if ischar(h); % if change was requested by a input value
    this.be.params.autoRewardMode = h;
    o('#BEChangeAutoRewardMode(): h: %s, autoRewardMode: %s.', h, ...
        this.be.params.autoRewardMode, 4, this.verb);
    % change the GUI value to the right one
    set(this.GUI.handles.be.autoRewGroup, 'SelectedObject', ...
        this.GUI.handles.be.(sprintf('autoRew%sMode', this.be.params.autoRewardMode)));
else % if change was requested by the callback
    this.be.params.autoRewardMode = get(get(h, 'SelectedObject'), 'String');
    o('#BEChangeAutoRewardMode(): h: %d, selectedObject: %d, autoRewardMode: %s.', h, ...
        get(h, 'SelectedObject'), this.be.params.autoRewardMode, 4, this.verb);
end;
showMessage(this, sprintf('Auto-reward mode: %s', this.be.params.autoRewardMode));

end

