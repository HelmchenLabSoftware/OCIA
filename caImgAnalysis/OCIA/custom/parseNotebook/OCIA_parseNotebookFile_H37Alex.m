function notebookInfo = OCIA_parseNotebookFile_H37Alex(notebookFilePath)

% written by B. Laurenczy - 2013/10/15

%% init variables
notebookInfo = cell(1, 14);
% notebookInfo = cell(1, 10);
iRow = 1;
skipLineRead = false;
% regular expression patterns
% mouseIDPattern = '^mou_[db]l_\d{6}_\d{2}$';
mouseIDPattern = '^\w+$';
headerPattern = '^(?<regionID>R\dS\d)(?<runType>, [adc][HL])?(?<comments>[\w \/-,\.\!]+)?$';
dateTimePattern = '^(?<date>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h: +?$';
imageModePattern = ['- ImagingMode: 2PM (?<imType>[^,]+), XY(?<zOrT>[TZ])?=(?<x>\d+)x(?<y>\d+)x?(?<zt>\d+)?' ...
    '(, frame rate=)?(?<rate>[\d\.]+)?( Hz)?(, z-dist=)?(?<zStep>[\d\.]+)?( um)?'];
scanHeadPattern = '- ScanHead: final intensity=(?<laserInt>[\d\.]+)%; zoom=(?<zoom>[\d\.]+)';
%% open notebook file
nbFileID = fopen(notebookFilePath);
% get the first line to start the reading
line = fgetl(nbFileID);
if line == -1;
    warning('OCIA_parseNotebookFile_H37Alex:EmptyFile', 'Notebook file at %s is empty! Aborting.', notebookFilePath);
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
        notebookInfo{iRow, 1} = mouseID;
        notebookInfo{iRow, 2} = lower(headerHits.regionID);
        notebookInfo{iRow, 3} = regexprep(headerHits.runType, '^[ ,]+', '');
        notebookInfo{iRow, 5} = regexprep(headerHits.comments, '^[ ,]+', ''); % remove initial space character
        
        dateTimeLine = fgetl(nbFileID);
        if numel(dateTimeLine) < 4;
            % store some information for the comment line
            notebookInfo{iRow, 1} = mouseID;
            notebookInfo{iRow, 2} = 'unknown';
            notebookInfo{iRow, 3} = 'comment';
            notebookInfo{iRow, 5} = regexprep(line, '^[ ,]+', ''); % store the commentaries in the 'comments' column
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
        dateTimeHits = regexp(dateTimeLine, dateTimePattern, 'names');
        % if a match was found, process the following lines as if there had been a header
        if ~isempty(dateTimeHits);
            
            % store some informations for this row even if it didn't have a header line
            notebookInfo{iRow, 1} = mouseID;
            notebookInfo{iRow, 2} = 'unknown';
            
            extractDateTimeImModeScanHeadInfos();
            
            iRow = iRow + 1; % increment the row counter
            
        % otherwise consider it just as a comment
        else
            
            % store some information for the comment line
            notebookInfo{iRow, 1} = mouseID;
            notebookInfo{iRow, 2} = 'unknown';
            notebookInfo{iRow, 3} = 'comment';
            notebookInfo{iRow, 5} = regexprep(line, '^[ ,]+', ''); % store the commentaries in the 'comments' column
            
            % check wether next line is a date-time line
            line = fgetl(nbFileID);
            % empty line, move to next row with the empty-line already read, no skip needed
            if numel(line) < 4;
                iRow = iRow + 1; % increment the row counter
            % non-empty line, check if it's a date-time line or already a new line of something
            else
                dateTimeHits = regexp(line, dateTimePattern, 'names');
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
nRows = size(notebookInfo, 1);
for iRow = 1 : nRows;
    
    % missing runTypes : try to fill with first word from "comments"
    if isempty(notebookInfo{iRow, 3});
       if ~isempty(notebookInfo{iRow, 5});
          commentsFirstWord = regexp(notebookInfo{iRow, 5}, '^\w+', 'match');
          if isempty(commentsFirstWord); continue; end;
          notebookInfo{iRow, 3} = commentsFirstWord{1};
          notebookInfo{iRow, 5} = strrep(notebookInfo{iRow, 5}, commentsFirstWord{1}, ' ');
          notebookInfo{iRow, 5} = regexprep(notebookInfo{iRow, 5}, '^ +', ''); % remove leading spaces
       else
%             warning('OCIA_parseNotebookFile_H37Alex:NoRunType', 'Could not find a runType for row %d (spotID: "%s").', ...
%                 iRow, notebookInfo{iRow, 2});
       end
    end
    
end;
%% function: #extractDateTimeImModeScanHeadInfos
function extractDateTimeImModeScanHeadInfos()

% try to match the next line with the "dateTime" pattern. The date-time line is already read here.
dateTimeHits = regexp(dateTimeLine, dateTimePattern, 'names');
% if a match was found, fill the row in the notebookInfo cell-array
if ~isempty(dateTimeHits);
    notebookInfo{iRow, 6} = dateTimeHits.day;
    notebookInfo{iRow, 7} = dateTimeHits.time;
else % if not matching, show a warning and leave notebookInfo empty
    warning('OCIA_parseNotebookFile_H37Alex:DateTimeMatchFailure', ['Could not match date-time line "%s" with ' ...
        'dateTimePattern "%s" ! Trying to continue ...'], dateTimeLine, dateTimePattern);
end;
% try to match the next line with the "imageMode" pattern
imageModeLine = fgetl(nbFileID);
imageModeHits = regexp(imageModeLine, imageModePattern, 'names');
% if a match was found, fill the row in the notebookInfo cell-array
if ~isempty(imageModeHits);
    % store the image type, eventually transforming 'single frame' to 'frame'
    notebookInfo{iRow, 8} = imageModeHits.imType;
    notebookInfo{iRow, 8} = strrep(notebookInfo{iRow, 8}, 'single ', '');
    % if recorded data had a 3rd dimension (either Z or T)
    if ~isempty(imageModeHits.zOrT) || ~isempty(imageModeHits.zt);
        % create a 3rd dimension tag depending on the Z/T labeling: either stack or movie
        if strcmp(imageModeHits.zOrT, 'T');
            notebookInfo{iRow, 9} = 'movie';
        elseif strcmp(imageModeHits.zOrT, 'Z');
            notebookInfo{iRow, 9} = 'stack';
        else
            warning('OCIA_parseNotebookFile_H37Alex:UnknownZorT', ['3rd dimension of file unknown, neither T (time) or ' ...
                'Z (stack): %s. Continuing ... '], imageModeHits.zOrT);
        end;
        % create a dimension tag like '256x256' or '100x100x500' if there is a 3rd dimension
        if ~isempty(imageModeHits.zt);
            notebookInfo{iRow, 10} = sprintf('%sx%sx%s', imageModeHits.x, imageModeHits.y, imageModeHits.zt);
        else
            warning('OCIA_parseNotebookFile_H37Alex:ZorTButNoZTValue', ['File has a 3rd dimension (type: %s) but no ' ...
                'dimension for that.'], imageModeHits.zt);
        end;
    % if there is no 3rd dimension, also create a 2D dimension tag like '256x256'
    else
        notebookInfo{iRow, 10} = sprintf('%sx%s', imageModeHits.x, imageModeHits.y);
    end;
    % store the rate and the z-dist (Z step for stacks in micro-meters) if they are not empty
    if ~isempty(imageModeHits.rate); notebookInfo{iRow, 11} = imageModeHits.rate; end;
    if ~isempty(imageModeHits.zStep); notebookInfo{iRow, 12} = imageModeHits.zStep; end;
else % if not matching, show a warning and leave notebookInfo empty
    warning('OCIA_parseNotebookFile_H37Alex:ImagingModeMatchFailure', ['Could not match imaging mode line "%s" with ' ...
        'imageModePattern "%s" ! Trying to continue ...'], imageModeLine, imageModePattern);
end;
% try to match the next line with the "scanHead" pattern
scanHeadLine = fgetl(nbFileID);
scaneHeadHits = regexp(scanHeadLine, scanHeadPattern, 'names');
% if a match was found, fill the row in the notebookInfo cell-array
if ~isempty(dateTimeHits);
    notebookInfo{iRow, 13} = scaneHeadHits.laserInt;
    notebookInfo{iRow, 14} = scaneHeadHits.zoom;
else % if not matching, show a warning and leave notebookInfo row empty
    warning('OCIA_parseNotebookFile_H37Alex:ScanHeadMatchFailure', ['Could not match scan-head line "%s" with ' ...
        'scanHeadPattern "%s" ! Trying to continue ...'], scanHeadLine, scanHeadPattern);
end;
end

end
