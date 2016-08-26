function tableRow = OCIA_processFolder_roiset(this, tableRow, fullPath, patternName, hit)
% tableRow = OCIA_processFolder_roiset - [no description]
%
%       tableRow = OCIA_processFolder_roiset(this, tableRow, fullPath, patternName, hit)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic; % for performance timing purposes
o('#%s: in "%s", full path: %s.', mfilename, fullPath, 3, this.verb);

% process the different match types differently
switch patternName;

    % ROISet .mat file
    case 'ROISetMatFile';

        % fill in the table's variable for this file
        tableRow = set(this, 1, 'path', fullPath, tableRow);
        tableRow = set(this, 1, 'day',  hit.day,  tableRow);
        tableRow = set(this, 1, 'time', hit.time, tableRow);
end;

o('  #%s: %s done (%3.1f sec).', mfilename, fullPath, toc(processTic), 4, this.verb);

end
