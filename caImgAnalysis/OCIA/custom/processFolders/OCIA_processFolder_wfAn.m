function tableRow = OCIA_processFolder_wfAn(this, tableRow, fullPath, patternName, hits)
% tableRow = OCIA_processFolder_wfAn - [no description]
%
%       tableRow = OCIA_processFolder_wfAn(this, tableRow, fullPath, patternName, hits)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic; % for performance timing purposes
o('#%s: in "%s", full path: %s.', mfilename, fullPath, 3, this.verb);

% fill in the table's variable that are independant on the match type
tableRow = set(this, 1, 'day', sprintf('%s_%s_%s', hits.day(1:4), hits.day(5:6), hits.day(7:8)), tableRow);
tableRow = set(this, 1, 'runNum', regexprep(hits.runNum, 'to', '/'), tableRow);

% process the different match types differently
switch patternName;

    % wide-field analysed mat file
    case 'wfAnMatFile';
        
        % set correct path
        tableRow = set(this, 1, 'path', fullPath, tableRow);
        
        % extract parameters from file name
        paramRegexp = {
            'stimFreq',     'stim([\dp]+)Hz';
            'frameRate',    '([\dp]+)HzFrameRate';
            'amplif',       'amplif([\dp]+)';
            'recordDur',    '([\dp]+)sec';
            'pitchLims',    '([\dp]+to[\dp]+)kHz';
        };
        for iRegexp = 1 : size(paramRegexp, 1);
            paramHit = regexp(hits.fileNameParams, paramRegexp{iRegexp, 2}, 'tokens');
            if isempty(paramHit); continue; end;
            hitVal = paramHit{1};
            hitVal = regexprep(hitVal, '(\d)p(\d)', '$1.$2');
            hitVal = regexprep(hitVal, '(\d+)to(\d+)', '$1->$2');
            tableRow = set(this, 1, paramRegexp{iRegexp, 1}, hitVal, tableRow);                
        end;
        
end;

o('  #%s: %s done (%3.1f sec).', mfilename, fullPath, toc(processTic), 4, this.verb);

end
