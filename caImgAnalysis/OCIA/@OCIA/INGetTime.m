function timeStr = INGetTime(this)
% INGetTime - [no description]
%
%       timeStr = INGetTime(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

elapsed = nowUNIX() - this.in.expStartTime;

timeStr = sprintf('%s (T+%s)', ...
    datestr(unix2dn(this.in.expStartTime), 'yyyy-mm-dd-HH:MM:SS'), ...
    datestr(unix2dn(elapsed), 'HH:MM:SS.FFF'));

