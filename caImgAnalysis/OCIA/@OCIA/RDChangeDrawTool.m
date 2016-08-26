function RDChangeDrawTool(this, h, ~)
% RDChangeDrawTool - [no description]
%
%       RDChangeDrawTool(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the currently selected drawing tool
for iTool = 1 : size(this.GUI.rd.drawTools, 1);
    if (~ischar(h) && ishandle(h) && h == this.GUI.handles.rd.drawTool.(this.GUI.rd.drawTools.id{iTool})) ...
            || (ischar(h) && strcmp(this.GUI.rd.drawTools.id{iTool}, h));
        set(this.GUI.handles.rd.drawTool.(this.GUI.rd.drawTools.id{iTool}), 'Value', 1);
        o('#%s(): changed to %s.', mfilename(), this.GUI.rd.drawTools.id{iTool}, 34, this.verb);
        showMessage(this, sprintf('Changed drawing tool to "%s".', this.GUI.rd.drawTools.tooltip{iTool}));
    else
        set(this.GUI.handles.rd.drawTool.(this.GUI.rd.drawTools.id{iTool}), 'Value', 0);
    end;
end;

end

