function filePatternTable = DWGetSubFilesTable(this, fullPath, watchType)
% DWGetSubFilesTable - [no description]
%
%       filePatternTable = DWGetSubFilesTable(this, fullPath, watchType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic;
o('  #%s: fullPath: ''%s'', watchType: ''%s''.', mfilename, fullPath, watchType, 4, this.verb);

    
% get the content of the ROISet folder
files = dir(fullPath);
nFiles = numel(files); % get the number of files
fileNames = struct2cell(files); % get the file names
o('#%s(): watchType %s: found %d file(s).', mfilename, watchType, nFiles, 5, this.verb);

% create a table with each file's name and their matching pattern (if any)
filePatternTable = table(fileNames(1, :)', false(nFiles, 1), false(nFiles, 1), cell(nFiles, 1), cell(nFiles, 1), ...
    cell(nFiles, 1), 'VariableNames', {'fileName', 'isValid', 'createNewRow', 'patternName', 'label', 'hits'});
% get the patterns for this watch type
patternsCell = this.dw.watchTypes{watchType, 'subFilePatterns'};
patternsTable = patternsCell{1}; % extract the table from the cell

% if there is no sub-folder/sub-file patterns to be matched for this watch type
if isempty(patternsTable);
    % fill the filePattern table with the matches from the "main" folder/file itself using the watch type's pattern
    filePatternTable.isValid(1) = true;
    filePatternTable.createNewRow(1) = true;
    filePatternTable.patternName{1} = watchType;
    filePatternTable.label(1) = this.dw.watchTypes{watchType, 'label'};
    filePatternTable.hits{1} = regexp(files(1).name, this.dw.watchTypes.pattern{watchType}, 'names');    
    return;
end;

% filter files according to this watch type's sub-file pattern list
for iFile = 1 : nFiles;
    % get the file's name
    fileName = filePatternTable.fileName{iFile};
    % go through all patterns
    for iPattern = 1 : size(patternsTable, 1);
        % get the regular expression pattern
        pattern = patternsTable.pattern{iPattern};
        % match the regular expression to the file's name
        hits = regexp(fileName, pattern, 'names');
        % if the current file matches the current pattern
        if ~isempty(hits);
            % mark the file as valid and save the matching pattern's name and the resulting regexp hits
            filePatternTable.isValid(iFile) = true;
            isAlreadyANewRow = any(filePatternTable.createNewRow(1 : iFile - 1));
            filePatternTable.createNewRow(iFile) = ~isAlreadyANewRow || patternsTable.createNewRow(iPattern);
            filePatternTable.patternName{iFile} = patternsTable.id{iPattern};
            filePatternTable.label{iFile} = patternsTable.label{iPattern};
            filePatternTable.hits{iFile} = hits;            
            break; % do not match other patterns but go on with the next file
        end;
    end;
end;

o('  #%s: fullPath: ''%s'', watchType: ''%s'' done (%3.1f sec).', mfilename, fullPath, watchType, ...
    toc(processTic), 4, this.verb);

end
