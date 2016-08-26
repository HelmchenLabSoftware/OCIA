function OCIA_annotateTable_widefield(this)
% OCIA_annotateTable_default - [no description]
%
%       OCIA_annotateTable_default(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% check if the processing should be aborted
if DWCheckProcessAbort(this, [], []); return; end;

% if there is behavior data to process
if ismember('behav', this.main.dataModes) && size(DWFilterTable(this, 'rowType = Behavior data'), 1) > 0;
    
    % match the behavior trial numbers to the imaging data
%     DWMatchBehavTrialsToWidefieldImagingData(this); 
    
end;

% find number of trials for each session
sessRows = DWFilterTable(this, 'rowType = WFLV session AND dim !~= \w+');
for iSess = 1 : size(sessRows, 1);
    % get "Matt_files" folder content
    sessRowPath = get(this, iSess, 'path', sessRows);
    mattFilesFolderFiles = dir(sprintf('%s/Matt_files/', sessRowPath));
    
    nTrialsText = '';
    condNames = { 'cond_100', 'cond_1200', 'cond_hit', 'cond_CR', 'stim' };
    for iCond = 1 : numel(condNames);
        condName = condNames{iCond};
        % count number of trials of any type
        nTrialFiles = sum(arrayfun(@(iFile) ~isempty(regexp(mattFilesFolderFiles(iFile).name, ...
            sprintf('%s_trial\\d+\\.mat', condName), 'once')), 1 : numel(mattFilesFolderFiles)));
        if nTrialFiles > 0;
            nTrialsText = sprintf('%s, %02d %s trial%s', nTrialsText, nTrialFiles, ...
                regexprep(condName, '^cond_', ''), iff(nTrialFiles > 1, 's', ''));
        end;
    end;
    
    % update column in table
    set(this, str2double(get(this, iSess, 'rowNum', sessRows)), 'dim', regexprep(nTrialsText, '^, ', ''));
    
end;

% % make the table unique
% showMessage(this, 'Making table unique ...');
% DWMakeTableUnique(this);

showMessage(this, 'Displaying table ...');
DWDisplayTable(this); % display the table

end
