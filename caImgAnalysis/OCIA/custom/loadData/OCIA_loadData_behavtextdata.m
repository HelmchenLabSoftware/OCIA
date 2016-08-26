function OCIA_loadData_behavtextdata(this, iDWRow, loadType)
% OCIA_loadData_behavtextdata - [no description]
%
%       OCIA_loadData_behavtextdata(this, iDWRow, loadType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadTic = tic; % for performance timing purposes
o('#%s: iDWRow: %03d, loadType: %s.', mfilename, iDWRow, loadType, 3, this.verb);

% get the load status
loadStatus = getData(this, iDWRow, 'behavtext', 'loadStatus');

% only load the data if not already loaded
if ~strcmp(loadStatus, 'full');

    % load the behavior structure arrays
    behavData = import_trial_log(get(this, iDWRow, 'path'));

    % store the data
    setData(this, iDWRow, 'behavtext', 'data', behavData);
    
    % mark row as loaded
    setData(this, iDWRow, 'behavtext', 'loadStatus', 'full');
    
end;

o('  #%s: iDWRow %03d, loadType: %s done (%3.1f sec).', mfilename, iDWRow, loadType, toc(loadTic), 4, this.verb);

end
