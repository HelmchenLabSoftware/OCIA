function localTable = DWProcessCustomFolder(this, templateTableRow, fullPath, ~, folderName, customFunctionHandle, ...
    watchTypeID, ~, ~)
% DWProcessCustomFolder - [no description]
%
%       localTable = DWProcessCustomFolder(this, templateTableRow, fullPath, ~, folderName, customFunctionHandle, ...
%                       watchTypeID, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

processTic = tic; % for performance timing purposes
o('#%s: in "%s", ROISetFolderName: %s.', mfilename, fullPath, folderName, 3, this.verb);

% get the local customized template table row
localTemplateTableRow = DWProcessFileOrFolderCommon(this, templateTableRow, fullPath, watchTypeID, folderName);
% create an empty local table based on this template row
localTable = localTemplateTableRow;
localTable(:, :) = []; % make the table be empty

% process the files in this folder using the sub-file patterns for this watch type (if any) and get back the table
filePatternTable = DWGetSubFilesTable(this, fullPath, watchTypeID);

% loop trough all existing files
for iFile = 1 : size(filePatternTable, 1);
    
    % ignore files that did not match any pattern
    if ~filePatternTable.isValid(iFile); continue; end;
    
    % if new row creation is required, create a new row for the local table
    if filePatternTable.createNewRow(iFile);
        localTable = [localTable; localTemplateTableRow]; %#ok<AGROW>
    end;
    
    % get the matching pattern's name and the hits
    fileName = filePatternTable.fileName{iFile};
    patternName = filePatternTable.patternName{iFile};
    hits = filePatternTable.hits{iFile};
    o('  #DWProcessCustomFolder(): found pattern "%s" for file "%s".', patternName, fileName, 5, this.verb);
    
    % fill-in the row type
    endInd = size(localTable, 1);
    if filePatternTable.createNewRow(iFile);
        localTable = set(this, endInd, 'rowType', filePatternTable.label{iFile}, localTable);
    end;
    
    % initialize the data structure: get the data configurations that need to be initialized for this watch type
    dataConfig = this.main.dataConfig(strcmp(this.main.dataConfig.rowType, get(this, endInd, 'rowType', localTable)), :);
    % if data has not yet been initialized and there is a data configuration for this watch type, initialize the data
    if isempty(get(this, endInd, 'data', localTable)) && ~isempty(dataConfig);
        % create the structure
        dataStruct = struct();        
        % loop through all required configurations
        for iConf = 1 : size(dataConfig, 1);
            dataStruct.(dataConfig.id{iConf}) = struct('data', {[]}, 'loadStatus', '');
        end;
        localTable = set(this, endInd, 'data', dataStruct, localTable);
    end;
    
    % call the custom processing function to annotate the current row in a custom fation
    localTable(end, :) = customFunctionHandle(this, localTable(end, :), sprintf('%s/%s', fullPath, fileName), ...
        patternName, hits);
    
end;

o('  #%s: %s done (%3.1f sec).', mfilename, folderName, toc(processTic), 4, this.verb);

end
