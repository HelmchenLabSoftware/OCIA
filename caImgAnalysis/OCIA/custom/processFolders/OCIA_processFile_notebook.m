function tableRow = OCIA_processFile_notebook(this, tableRow, fullPath, ~, ~)
% tableRow = OCIA_processFile_notebook - [no description]
%
%       tableRow = OCIA_processFile_notebook(this, tableRow, fullPath, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic; % for performance timing purposes
o('#%s: in "%s", full path: %s.', mfilename, fullPath, 3, this.verb);

% modify the time column: remove the 'h' and the 'm' and add '00' as seconds to keep the same format
tableRow = set(this, 1, 'time', [regexprep(get(this, 1, 'time', tableRow), '[hm]', '') '_00'], tableRow);

o('  #%s: %s done (%3.1f sec).', mfilename, fullPath, toc(processTic), 4, this.verb);

end
