function tableRow = OCIA_processFolder_behavtext(this, tableRow, fullPath, patternName, ~)
% tableRow = OCIA_processFolder_behavtext - [no description]
%
%       tableRow = OCIA_processFolder_behavtext(this, tableRow, fullPath, patternName, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic; % for performance timing purposes
o('#%s: in "%s", full path: %s.', mfilename, fullPath, 3, this.verb);

% fill in the table's variable that are independant on the match type
tableRow = set(this, 1, 'path', fullPath,  tableRow);

% process the different match types differently
switch patternName;

    % lick traces
    case 'behavtextdata';
        

    % behavior times
    case 'behavtextnbdata';
        
        
end;

o('  #%s: %s done (%3.1f sec).', mfilename, fullPath, toc(processTic), 4, this.verb);

end
