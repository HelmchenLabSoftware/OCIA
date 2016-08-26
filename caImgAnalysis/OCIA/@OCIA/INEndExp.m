function INEndExp(this, ~, ~)
% INEndExp - [no description]
%
%       INEndExp(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

this.in.expRunning = false;
showMessage(this, sprintf('%s | Intrinsic: aborted experiment.', INGetTime(this)), 'yellow');
set(this.GUI.handles.in.runExpBut, 'BackgroundColor', 'red', 'Value', 0);

% clean up and free ressources
INCleanUp(this);

end
