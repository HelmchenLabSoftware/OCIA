function [infoTable, tIDs] = OCIA_parseNotebookFile_default(notebookFilePath)

% written by B. Laurenczy - 2014/02/11

%% init variables
infoTable = cell(1000, 9);
tIDs = { 'animal', 'spot', 'runType', 'comments', 'day', 'time', 'imType', 'imType2', 'dimNB'};
iRow = 1;
skipLineRead = false;
% regular expression patterns
% mouseIDPattern = '^mou_[db]l_\d{6}_\d{2}$';
mouseIDPattern = '^\w+$';
headerPattern = '^(?<spotID>sp\d{2})(?<runType>[^_ ]+)?_?(?<stimNum>\d+)?\s*(?<comments>.+)?';
dayTimePattern = '^(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h: +?$';
imageModePattern = '- ImagingMode: 2PM (?<imType>[^,]+), XY(?<zOrT>[TZ])?=(?<x>\d+)x(?<y>\d+)x?(?<zt>\d+)?';
%% open notebook file
nbFileID = fopen(notebookFilePath);
if nbFileID == -1;
    warning('OCIA_parseNotebookFile_default:CannotOpenFile', 'Notebook file at %s cannot be opened! Aborting.', notebookFilePath);
    return;
end;
% get the first line to start the reading
line = fgetl(nbFileID);
if line == -1;
    warning('OCIA_parseNotebookFile_default:EmptyFile', 'Notebook file at %s is empty! Aborting.', notebookFilePath);
    return;
end;
% if present, extract the mouseID at the first line
if regexp(line, mouseIDPattern, 'once');
    mouseID = line; % store the mouseID
    line = fgetl(nbFileID); % jump to next line
else % otherwise mouseID is not present
    mouseID = '-';
end;
%% mainLoop: read all lines one by one
while ischar(line); % if last line was read, next line will be -1
    
    %% - empty lines
    if numel(line) < 4; % skip empty lines
        line = fgetl(nbFileID); % jump to next line
        continue;
    end;
    
    % try to match the line with the "header" pattern
    headerHits = regexp(line, headerPattern, 'names');
    
    %% - headerPattern match
    % if a match was found, create a row in the notebookInfo cell-array
    if ~isempty(headerHits);
        
        % store all the extracted informations
        infoTable{iRow, strcmp(tIDs, 'animal')} = mouseID;
        infoTable{iRow, strcmp(tIDs, 'spot')} = regexprep(headerHits.spotID, 'sp(\d+)', 'spot$1');
        infoTable{iRow, strcmp(tIDs, 'runType')} = headerHits.runType;
        % store the stimulus number, but only if it's not empty
        if ~isempty(headerHits.stimNum); infoTable{iRow, 4} = headerHits.stimNum; end;
        infoTable{iRow, strcmp(tIDs, 'comments')} = regexprep(headerHits.comments, '^ +', ''); % remove initial space character
        
        dateTimeLine = fgetl(nbFileID);
        if numel(dateTimeLine) < 4;
            % store some information for the comment line
            infoTable{iRow, strcmp(tIDs, 'animal')} = mouseID;
            infoTable{iRow, strcmp(tIDs, 'spot')} = '';
            infoTable{iRow, strcmp(tIDs, 'comments')} = 'comment';
            infoTable{iRow, strcmp(tIDs, 'comments')} = line; % store the commentaries in the 'comments' column
        else
            extractDateTimeImModeScanHeadInfos();
        end;
        
        iRow = iRow + 1; % increment the row counter
        
    %% - headerPattern no-match
    % other non-empty lines could either be "orphan" date-time lines that didn't have any "header",
    %   or simple comment lines with no other date-time/imageMode/etc. informations
    else
        
        % check wether it's a date-time line
        dateTimeLine = line;
        dateTimeHits = regexp(dateTimeLine, dayTimePattern, 'names');
        % if a match was found, process the following lines as if there had been a header
        if ~isempty(dateTimeHits);
            
            % store some informations for this row even if it didn't have a header line
            infoTable{iRow, strcmp(tIDs, 'animal')} = mouseID;
            infoTable{iRow, strcmp(tIDs, 'spot')} = '';
            
            extractDateTimeImModeScanHeadInfos();
            
            iRow = iRow + 1; % increment the row counter
            
        % otherwise consider it just as a comment
        else
            
            % store some information for the comment line
            infoTable{iRow, strcmp(tIDs, 'animal')} = mouseID;
            infoTable{iRow, strcmp(tIDs, 'spot')} = '';
            infoTable{iRow, strcmp(tIDs, 'runType')} = 'comment';
            infoTable{iRow, strcmp(tIDs, 'comments')} = line; % store the commentaries in the 'comments' column
            
            % check wether next line is a date-time line
            line = fgetl(nbFileID);
            % empty line, move to next row with the empty-line already read, no skip needed
            if numel(line) < 4;
                iRow = iRow + 1; % increment the row counter
            % non-empty line, check if it's a date-time line or already a new line of something
            else
                dateTimeHits = regexp(line, dayTimePattern, 'names');
                if ~isempty(dateTimeHits); % line was date-time for this comment
                    dateTimeLine = line;
                    extractDateTimeImModeScanHeadInfos();
                    iRow = iRow + 1; % increment the row counter
                else % more stuff and not date-time on next line, jump to next row without re-reading a line
                    skipLineRead = true;
                    iRow = iRow + 1; % increment the row counter
                end;
            end;
        end
    end;
    
    if ~skipLineRead; line = fgetl(nbFileID); end; % get next line
    skipLineRead = false;
end;

%% close the notebook file
fclose(nbFileID);

%% check consistency
% fill in missing run types
nRows = size(infoTable, 1);
for iRow = 1 : nRows;
    
    % missing runTypes : try to fill with first word from "comments"
    if isempty(infoTable{iRow, strcmp(tIDs, 'runType')});
       if ~isempty(infoTable{iRow, strcmp(tIDs, 'comments')});
          commentsFirstWord = regexp(infoTable{iRow, strcmp(tIDs, 'comments')}, '^\w+', 'match');
          infoTable{iRow, strcmp(tIDs, 'runType')} = commentsFirstWord{1};
          infoTable{iRow, strcmp(tIDs, 'comments')} = strrep(infoTable{iRow, strcmp(tIDs, 'comments')}, commentsFirstWord{1}, ' ');
          infoTable{iRow, strcmp(tIDs, 'comments')} = regexprep(infoTable{iRow, strcmp(tIDs, 'comments')}, '^ +', ''); % remove leading spaces
       else
%             warning('OCIA_parseNotebookFile_default:NoRunType', 'Could not find a runType for row %d (spotID: "%s").', ...
%                 iRow, notebookInfo{iRow, 2});
       end
    end
    
end;

%% remove empty lines
infoTableCell = infoTable;
emptyRows = arrayfun(@(iRow)all(cellfun(@isempty, infoTableCell(iRow, :))), 1 : size(infoTableCell, 1));
infoTable(emptyRows, :) = [];


%% function: #extractDateTimeImModeScanHeadInfos
function extractDateTimeImModeScanHeadInfos()

% try to match the next line with the "dateTime" pattern. The date-time line is already read here.
dateTimeHits = regexp(dateTimeLine, dayTimePattern, 'names');
% if a match was found, fill the row in the notebookInfo cell-array
if ~isempty(dateTimeHits);
    infoTable{iRow, strcmp(tIDs, 'day')} = dateTimeHits.day;
    infoTable{iRow, strcmp(tIDs, 'time')} = dateTimeHits.time;
else % if not matching, show a warning and leave notebookInfo empty
    warning('OCIA_parseNotebookFile_default:DateTimeMatchFailure', ['Could not match date-time line "%s" with ' ...
        'dateTimePattern "%s" ! Trying to continue ...'], dateTimeLine, dayTimePattern);
end;
% try to match the next line with the "imageMode" pattern
imageModeLine = fgetl(nbFileID);
imageModeHits = regexp(imageModeLine, imageModePattern, 'names');
% if a match was found, fill the row in the notebookInfo cell-array
if ~isempty(imageModeHits);
    
    % store the image type, eventually transforming 'single frame' to 'frame'
    infoTable{iRow, strcmp(tIDs, 'imType')} = imageModeHits.imType;
    infoTable{iRow, strcmp(tIDs, 'imType')} = strrep(infoTable{iRow, strcmp(tIDs, 'imType')}, 'single ', '');
    % if recorded data had a 3rd dimension (either Z or T)
    if ~isempty(imageModeHits.zOrT) || ~isempty(imageModeHits.zt);
        % create a 3rd dimension tag depending on the Z/T labeling: either stack or movie
        if strcmp(imageModeHits.zOrT, 'T');
            infoTable{iRow, strcmp(tIDs, 'imType2')} = 'movie';
        elseif strcmp(imageModeHits.zOrT, 'Z');
            infoTable{iRow, strcmp(tIDs, 'imType2')} = 'stack';
        else
            warning('OCIA_parseNotebookFile_default:UnknownZorT', ['3rd dimension of file unknown, neither T (time) or ' ...
                'Z (stack): %s. Continuing ... '], imageModeHits.zOrT);
        end;
        % create a dimension tag like '256x256' or '100x100x500' if there is a 3rd dimension
        if ~isempty(imageModeHits.zt);
            infoTable{iRow, strcmp(tIDs, 'dimNB')} = sprintf('%sx%sx%s', imageModeHits.x, imageModeHits.y, imageModeHits.zt);
        else
            warning('OCIA_parseNotebookFile_default:ZorTButNoZTValue', ['File has a 3rd dimension (type: %s) but no ' ...
                'dimension for that.'], imageModeHits.zt);
        end;
    % if there is no 3rd dimension, also create a 2D dimension tag like '256x256'
    else
        infoTable{iRow, strcmp(tIDs, 'dimNB')} = sprintf('%sx%s', imageModeHits.x, imageModeHits.y);
    end;
    
else % if not matching, show a warning and leave notebookInfo empty
    warning('OCIA_parseNotebookFile_default:ImagingModeMatchFailure', ['Could not match imaging mode line "%s" with ' ...
        'imageModePattern "%s" ! Trying to continue ...'], imageModeLine, imageModePattern);
end;
end

end
