function tableRow = OCIA_processFolder_wfLVMat(this, tableRow, fullPath, patternName, hits)
% tableRow = OCIA_processFolder_wfLV - [no description]
%
%       tableRow = OCIA_processFolder_wfLV(this, tableRow, fullPath, patternName, hits)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic; % for performance timing purposes
o('#%s: in "%s", full path: %s.', mfilename, fullPath, 3, this.verb);
        
% set correct path
tableRow = set(this, 1, 'path', fullPath, tableRow);

% set time
fileInfo = dir(fullPath);
tableRow = set(this, 1, 'time', regexprep(fileInfo.date, '^[\w-\.]+ (\d+):(\d+):(\d+)$', '$1_$2_$3'), tableRow);

% process the different match types differently
switch patternName;

    % wide-field trial file
    case 'wfTr';
        
        tableRow = set(this, 1, 'runNum', sprintf('%03s', hits.runNum), tableRow);
        
    % wide-field average file
    case 'wfTrAvg';
        
        if isfield(hits, 'condition') && ~isempty(hits.condition);
            tableRow = set(this, 1, 'runNum', hits.condition, tableRow);
        end;
        
end;

o('  #%s: %s done (%3.1f sec).', mfilename, fullPath, toc(processTic), 4, this.verb);

end
