function tableRow = OCIA_processFolder_wf(this, tableRow, fullPath, patternName, hits)
% tableRow = OCIA_processFolder_wf - [no description]
%
%       tableRow = OCIA_processFolder_wf(this, tableRow, fullPath, patternName, hits)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic; % for performance timing purposes
o('#%s: in "%s", full path: %s.', mfilename, fullPath, 3, this.verb);

% fill in the table's variable that are independant on the match type
tableRow = set(this, 1, 'day', sprintf('%s_%s_%s', hits.day(1:4), hits.day(5:6), hits.day(7:8)), tableRow);
tableRow = set(this, 1, 'time', sprintf('%s_%s_%s', hits.time(1:2), hits.time(3:4), hits.time(5:6)), tableRow);
tableRow = set(this, 1, 'runNum', hits.runNum, tableRow);
        
% extract parameters from file name
paramRegexp = {
    'stimFreq',     'stim([\dp]+)Hz';
    'frameRate',    '([\dp]+)HzFrameRate';
    'amplif',       'amplif([\dp]+)';
    'recordDur',    '([\dp]+)sec';
    'pitchLims',    '([\dp]+to[\dp]+)kHz';
    'sweepDir',     '(up|down)Sweep';
    'sweepDir',     'multiFreq(Map)ping';
};
for iRegexp = 1 : size(paramRegexp, 1);
    paramHit = regexp(hits.fileNameParams, paramRegexp{iRegexp, 2}, 'tokens');
    if isempty(paramHit); continue; end;
    hitVal = paramHit{1};
    hitVal = regexprep(hitVal, '(\d)p(\d)', '$1.$2');
    hitVal = regexprep(hitVal, '(\d+)to(\d+)', '$1->$2');
    tableRow = set(this, 1, paramRegexp{iRegexp, 1}, hitVal, tableRow);                
end;

% process the different match types differently
switch patternName;

    % wide-field file
    case 'wfData';
        
        % set correct path
        tableRow = set(this, 1, 'path', fullPath, tableRow);
        
        
        
%     % extract the actual file information
%     [~, ~, ~, ~, dims, frameRate, ~, pitchLims, recordDur, attribs] ...
%         = OCIA_analysis_widefield_extractFileInfo(this, fullPath);
% 
%     % skip the 3rd dimension if it's 1 (display '256x256' and not '256x256x1')
%     if dims(3) == 1; dims = dims(1 : 2); end;
% 
%     % create and store a dimension tag like : '256x256' or '100x100x3'
%     dimTag = regexprep(sprintf(repmat('%dx', 1, numel(dims)), dims), 'x$', '');
%     tableRow = set(this, 1, 'dim', dimTag, tableRow);
%     
%     % set other parameters
%     tableRow = set(this, 1, 'frameRate', frameRate, tableRow);
%     tableRow = set(this, 1, 'pitchLims', pitchLims, tableRow);
%     tableRow = set(this, 1, 'recordDur', recordDur, tableRow);
        
    % wide-field log files
    case 'wfLog';
        
end;

o('  #%s: %s done (%3.1f sec).', mfilename, fullPath, toc(processTic), 4, this.verb);

end
