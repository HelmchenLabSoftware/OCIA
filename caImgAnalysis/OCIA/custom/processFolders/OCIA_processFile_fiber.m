function tableRow = OCIA_processFile_fiber(this, tableRow, fullPath, ~, ~)
% tableRow = OCIA_processFile_fiber - [no description]
%
%       tableRow = OCIA_processFile_fiber(this, tableRow, fullPath, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic; % for performance timing purposes
o('#%s: in "%s", full path: %s.', mfilename, fullPath, 3, this.verb);

% fill in the table's variable that are independant on the match type
tableRow = set(this, 1, 'path', fullPath,  tableRow);
fileInfo = dir(fullPath); % get the file's information
tableRow = set(this, 1, 'dim',  sprintf('%.1f MB', fileInfo.bytes / 1E6),  tableRow);

o('  #%s: %s done (%3.1f sec).', mfilename, fullPath, toc(processTic), 4, this.verb);

end
