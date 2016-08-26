function daysWithSpot = getDaysWithSpot(year, dataPath, animalID, ignoreNotebook)
% getDaysWithSpot: get all days from the data path with at least one "spot**" folder inside for 'animalID'

dbgLevel = 0;
fullRawDataPath = [dataPath year filesep animalID filesep];

% search for 'YYYY_*' folders
days = dir([fullRawDataPath year '_*']);
daysWithSpot = struct('date', '', 'spotList', {}, 'notebookFileName', '');
o('#getDaysWithSpot: found %d day(s) in "%s", searching for spots in them ...', ...
    numel(days), fullRawDataPath, 1, dbgLevel);
iDayWithSpot = 1;
for iDay = 1 : numel(days);
    dayPath = [fullRawDataPath days(iDay).name filesep];
    spots = dir([dayPath 'spot*']);
    
    if numel(spots) > 0; % if some spots where found
        o('  #getDaysWithSpot: found %d spot(s) in "%s".', numel(spots), dayPath, 2, dbgLevel);
        % store the informations for this day
        daysWithSpot(iDayWithSpot).day = days(iDay).name;
        % for each spot add 'spot01' and 'sp01' in the list
        for iSpot = 1 : numel(spots);
            daysWithSpot(iDayWithSpot).spotList{iSpot, 1} = spots(iSpot).name;
            daysWithSpot(iDayWithSpot).spotList{iSpot, 2} = regexprep(spots(iSpot).name, 'ot', '');
        end;
        
        % do not bother with notebook file if ignoring it required
        if ~ignoreNotebook;
            notebookFiles = dir([dayPath 'notebook__' days(iDay).name '*']);
            if numel(notebookFiles) < 1;
                warning('getDaysWithSpot:NoNotebookFileFound', ...
                    'No notebook file could be found at "%s", skipping that day.', dayPath);
                daysWithSpot(iDayWithSpot) = []; % clear that day
                continue;
            elseif numel(notebookFiles) > 1;
                warning('getDaysWithSpot:TooManyNotebookFilesFound', ...
                    '%d files found at "%s", skipping that day.', numel(notebookFiles), dayPath);
                daysWithSpot(iDayWithSpot) = []; % clear that day
                continue;
            else
                daysWithSpot(iDayWithSpot).notebookFileName = [dayPath notebookFiles(1).name];
            end;
        end;
        iDayWithSpot = iDayWithSpot + 1;
    else
        o('  #getDaysWithSpot: no spots in "%s".', dayPath, 2, dbgLevel);
    end;
end;

end
