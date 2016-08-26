function tableRow = OCIA_processFolder_behav(this, tableRow, fullPath, patternName, hits)
% tableRow = OCIA_processFolder_behav - [no description]
%
%       tableRow = OCIA_processFolder_behav(this, tableRow, fullPath, patternName, hits)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic; % for performance timing purposes
o('#%s: in "%s", full path: %s.', mfilename, fullPath, 3, this.verb);

% fill in the table's variable that are independant on the match type
tableRow = set(this, 1, 'path', fullPath,  tableRow);
tableRow = set(this, 1, 'day',  hits.day,  tableRow);
tableRow = set(this, 1, 'time', hits.time, tableRow);

% process the different match types differently
switch patternName;

    % behavior movie
    case 'behavMovie';
        
        % annotate this row
        day = hits.day; timeStr = hits.time;
        tableRow = set(this, 1, 'day',  sprintf('%s_%s_%s', day(1:2), day(3:4), day(5:6)),   tableRow);
        tableRow = set(this, 1, 'time',  sprintf('%s_%s_%s', timeStr(1:2), timeStr(3:4), timeStr(5:6)),   tableRow);
        tableRow = set(this, 1, 'runNum', hits.runNum, tableRow);
        tableRow = set(this, 1, 'runType', 'Trial', tableRow);
        
end;

o('  #%s: %s done (%3.1f sec).', mfilename, fullPath, toc(processTic), 4, this.verb);

end
