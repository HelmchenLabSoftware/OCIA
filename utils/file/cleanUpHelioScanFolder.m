function groups = cleanUpHelioScanFolder(varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Originally created on               2013-03-25 %
% Written by B. Laurenczy (blaurenczy@gmail.com) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% parse inputs
IP = inputParser;
% path of cleaned notebook file. Must exist.
addOptional(IP,     'notebookPath',         'notebook_clean.txt',   @(p) ischar(p) && exist(p, 'file'));
% path of helioscan's imaging data folders. Must exist.
addOptional(IP,     'dataPath',             '.',                    @(p) ischar(p) && exist(p, 'dir'));
% output folder's path for renamed data. Created if non-existing.
addOptional(IP,     'outPath',              './out',                @ischar);
% channels to exclude, as an numeric array
addOptional(IP,     'excludedChans',       [],                      @isnumeric);
% verbosity level
addOptional(IP,     'v',                    0,                      @isnumeric);

% extract the arguments from varargin
parse(IP, varargin{:});

% transfer the parsed arguments into the 'in' structure
in = IP.Results;
o('cleanUpHelioScanFolder from "%s" to "%s"...', in.dataPath, in.outPath, 1, in.v);

%% initialize variables
if ~exist(in.notebookPath, 'file');
    error('cleanUpHelioScanFolder:notebookFileNotFound', ...
        'Impossible to find notebook file at "%s"!', in.notebookPath);
end;
notebookFID = fopen(in.notebookPath);
% each line group is stored as a structure
groups = struct('name', {}, 'imType', {}, 'date', {}, 'x', {}, 'y', {}, 'z', {}, 't', {},  ...
    'zoom', {}, 'laserInt', {});
iGroup = 1; % current index of line group
iLine = 1; % current index of line

%% read all lines of notebook file
o('  - checking all files...', 1, in.v);
line = fgets(notebookFID);
while ischar(line);
    o('    - iGroup: %d, processing line %d: "%s"...', iGroup, iLine, line, 4, in.v);
    % date line, which is also the folder and file name
    if ~isempty(regexp(line, '^\d\d\d\d_\d\d_\d\d__\d\d_\d\d_\d\dh:\s+$', 'once'));
        groups(iGroup).date = regexprep(line, ':\s+$', '');
        o('    - line is date line, groups(%d).date: %s.', iGroup, groups(iGroup).date, 4, in.v);
    % imaging mode line
    elseif ~isempty(regexp(line, '^- ImagingMode:', 'once'));
        % extract the relevant informations from the line
        m = regexp(line, ['- ImagingMode: 2PM (?<imType>[^,]+), ' ...
            'XY(?<zOrT>[TZ])?=(?<x>\d+)x(?<y>\d+)x?(?<zt>\d+)?'], 'names');
        % copy them in the groups structure
        groups(iGroup).imType = strrep(m.imType, 'single ', ''); % transform 'single frame' to 'frame'
        groups(iGroup).x = str2double(m.x);
        groups(iGroup).y = str2double(m.y);
        % extract 3rd dimension's resolution if any
        if ~isempty(m.zOrT); groups(iGroup).(lower(m.zOrT)) = str2double(m.zt); end;
        o('    - line %d is an ''imaging mode'' line.', iLine, 4, in.v);
        
    % scanhead line  
    elseif ~isempty(regexp(line, '^- ScanHead:', 'once'));
        % extract the relevant informations from the line
        m = regexp(line, '- ScanHead: final intensity=(?<laserInt>[\d\.]+)%; zoom=(?<zoom>[\d\.]+)', 'names');
        % copy them in the groups structure
        groups(iGroup).laserInt = str2double(m.laserInt);
        groups(iGroup).zoom = str2double(m.zoom);
        o('    - line %d is a ''scan head'' line.', iLine, 4, in.v);
    % empty line, go to next line group
    elseif ~isempty(regexp(line, '^\s+$', 'once'));
        iGroup = iGroup + 1;
        o('    - line %d is an empty line, new iGroup: %d.', iLine, iGroup, 4, in.v);
    % file title/description line
    else
        groups(iGroup).name = regexprep(regexprep(line, '[,-\s\/]', '_'), '_+$', '');
        o('    - line %d is a name/descr line, name/descr: "%s".', iLine, groups(iGroup).name, 4, in.v);
    end;
    
    % read next line
    line = fgets(notebookFID);
    iLine = iLine + 1;
end;

fclose(notebookFID);

%% rename and extract files
o('  - creating output directory.', 1, in.v);
mkdir(in.outPath); % create ouput directory

o('  - copying %d groups of file...', numel(groups), 1, in.v);
for iGroup = 1 : numel(groups);
    group = groups(iGroup);
    foundSource = 0;
    for iChan = 0 : 2;
        if any(in.excludedChans == iChan);
            o('  - Skipping channel %d.', iChan, 4, in.v);
            continue;
        end; % exlude unwanted channels
        source = sprintf('%s/%s/%s__channel0%d.tif', in.dataPath, group.date, group.date, iChan);
        if exist(source, 'file');
        % remove last 'h' in date and change format
            cleanedUpDate = cleanUpDate(group.date);
            if isnan(cleanedUpDate);
                o('  - Skipping group %d (%d) (bad format).', iGroup, group.date, 1, in.v);
                continue;
            end;
            dest = sprintf('%s/%s_%s_%dx_ch0%d.tif', in.outPath, cleanedUpDate, ...
                group.name, group.x, iChan);
            if exist(dest, 'file'); % skip existing files
                o('  - Skipping "%s" (already exists).', dest, 3, in.v);
            else
                o('  - copying "%s" -> "%s"...', source, dest, 2, in.v);
                copyfile(source, dest);
            end;
            foundSource = 1;
        else
            o('  - Warning: "%s" does not exist.', source, 3, in.v);
        end;
    end;
    
    % if no file corresponding, it's a delimiter file, create an empty file
    if ~foundSource;
        % remove last 'h' in date and change format
        cleanedUpDate = cleanUpDate(group.date);
        if isnan(cleanedUpDate);
            o('  - Skipping group %d (%d) (bad format).', iGroup, group.date, 1, in.v);
            continue;
        end;
        dest = sprintf('%s/%s_%s.txt', in.outPath, cleanedUpDate, group.name);
        if exist(dest, 'file'); % skip existing files
            o('  - Skipping "%s" (already exists).', dest, 3, in.v);
        else
            o('  - creating delimiter "%s"...', dest, 2, in.v);
            delimiterFID = fopen(dest, 'w+');
            fwrite(delimiterFID, ' ');
            fclose(delimiterFID);
        end;
    end;
end;
   
o('  - done!', dest, 1, in.v);

    function cleanedDate = cleanUpDate(dateAsString)
        if isnumeric(dateAsString);
            cleanedDate = NaN;
            return;
        end;
        cleanedDate = regexprep(dateAsString, 'h$', '');
        cleanedDate = regexprep(cleanedDate, '__', 'BREAK');
        cleanedDate = regexprep(cleanedDate, '_', '');
        cleanedDate = regexprep(cleanedDate, 'BREAK', '_');
        cleanedDate = regexprep(cleanedDate, '\/', '_');
        cleanedDate = regexprep(cleanedDate, '\\', '_');
    end

end

