function tableRow = DWProcessFileOrFolderCommon(this, templateTableRow, fullPath, watchType, fileName)
% DWProcessFileOrFolderCommon - [no description]
%
%       tableRow = DWProcessFileOrFolderCommon(this, templateTableRow, fullPath, watchType, fileName)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic;
o('  #%s: fileName: ''%s'', watchType: ''%s''.', mfilename, fileName, watchType, 4, this.verb);

% use the template table row that might already contains some information
tableRow = templateTableRow;

% make sure directories have an ending slash
if isdir(fullPath) && ~strcmp(fullPath(end), '/'); fullPath = [fullPath '/']; end;

% save some variables for this row
tableRow = set(this, 1, 'rowType', this.dw.watchTypes.label{strcmp(this.dw.watchTypes.id, watchType)}, tableRow);
tableRow = set(this, 1, 'path', fullPath, tableRow);

% get the regular expression pattern for this watch type
regexpPattern = char(this.dw.watchTypes{strcmp(this.dw.watchTypes.id, watchType), 'pattern'});
% match the regular expression's pattern to the file's/folder's name
regexpHits = regexp(fileName, regexpPattern, 'names');
% if there was a match, fill in the variables 
if ~isempty(regexpHits);
    % fill the table using the named matchs
    hitFields = fieldnames(regexpHits); % get the names hit fields
    for iField = 1 : numel(hitFields); % loop through each field
        % if this field's name is part of the table's variable names and the replacement string is not empty
        if ismember(hitFields{iField}, this.dw.tableIDs) && ~isempty(regexpHits.(hitFields{iField}));
            % fill the variable with the matched value
            tableRow = set(this, 1, hitFields{iField}, regexpHits.(hitFields{iField}), tableRow);
        end;
    end;
% if there was no match, show a warning and leave empty
else
    showWarning(this, 'OCIA:DWProcessFileOrFolderCommon:RegexpMatchFailure', ...
        sprintf('Cannot match regular expression for file ''%s'' for watchType ''%s'' with pattern ''%s''.', ...
            watchType, fileName, regexpPattern));
end;

o('  #%s: %s done (%3.1f sec).', mfilename, fileName, toc(processTic), 4, this.verb);

end
