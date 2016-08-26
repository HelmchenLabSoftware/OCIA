function DWWaitBar(this, percent)
% DWWaitBar - Updates the wait bar's display with the specified percent value
%
%       DWWaitBar(this, percent)
%
% Updates the wait bar's display (this.GUI.handles.dw.waitBar) with the value specified by the 'percent' double. Percent
%   should be provided as a number between 0 and 100.

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#%s(): %d%% ...', mfilename(), percent, 5, this.verb);

% if there is no GUI, do not do anything
if ~isGUI(this); return; end;

% clear previous progress
cla(this.GUI.handles.dw.waitBar);

% set boundaries of percent to minimum 0 and maximum 100
percent = min(max(percent, 0), 100);

% if percent is more than 0, draw the progress bar filling
if percent;
    this.GUI.handles.dw.waitBarRect = rectangle('Parent', this.GUI.handles.dw.waitBar, ...
        'FaceColor', 'red', 'EdgeColor', 'black', 'Position', [0 0 percent 1]);
end;

% display text
text('Parent', this.GUI.handles.dw.waitBar, 'Position', [50, 0.5, 0], 'FontSize', 9, 'Color', 'white', ...
    'String', sprintf('%04.1f%%', percent), 'HorizontalAlignment', 'center');

%     pause(0.0001); % required to let the GUI update itself

o('#%s(): %d%% done.', mfilename(), percent, 5, this.verb);
    
end