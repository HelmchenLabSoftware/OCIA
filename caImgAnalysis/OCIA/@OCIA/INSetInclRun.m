function INSetInclRun(this, ~, ~)
% INSetInclRun - [no description]
%
%       INSetInclRun(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the current run
iRun = round(get(this.GUI.handles.in.standard.runChooser, 'Value'));
% set its include value
this.in.data.includeInAvg(iRun) = get(this.GUI.handles.in.standard.inclRun, 'Value');

end
