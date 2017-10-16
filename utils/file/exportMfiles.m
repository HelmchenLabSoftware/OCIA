function exportMfiles(funcname,doPcode,doZip,saveDir)
% find dependencies for function funcname
% copy all dependencies to saveDir
% create zip-archive saveDir.zip
% optionally, pcode

% this file written by Henry Luetcke (hluetck@gmail.com)

if ~iscell(funcname)
    funcname = {funcname};
end

if isempty(funcname)
    error('No function names specified');
end

if ~iscellstr(funcname)
    error('Function names must be strings');
end

if nargin<2
    zipfilename = fullfile(pwd,[ funcname{1} '.zip' ]);
end

req = cell(size(funcname));
for i=1:numel(funcname)
    req{i} = depfunFast(funcname{i},1); % recursive
end
req = vertcat(req{:}); % cell arrays of full file names
req = unique(req);

% filename for the first function file
[~, baseFuncName, ext] = fileparts(funcname{1});

% Find the common root directory
d = i_root_directory(req);
% Calculate relative paths for all required files.
n = numel(d);
for i=1:numel(req)
    % This is the bit that can't be vectorised
    req{i} = req{i}(n+1:end); % step over last character (which is the separator)
end

if exist(saveDir, 'dir') ~= 7; mkdir(saveDir); end;

% req is a cell array with all functions, d is the root directory
for n = 1:length(req)
    currentFile = req{n};
    [~, currentBaseName, ext] = fileparts(currentFile);
    if ~exist(fullfile(pwd,[currentBaseName ext]),'file')
        copyfile(fullfile(d,currentFile),'.');
        doFileMove = 1;
    else
        doFileMove = 0;
    end
    currentFile = fullfile(pwd,[currentBaseName ext]);
    if doPcode
        if exist([saveDir filesep 'protected'],'dir') ~= 7
            mkdir([saveDir filesep 'protected'])
        end
        if strcmp(saveDir, '.'); saveDir = './.'; end;
        % never pcode the top-most function
        if strcmp(currentBaseName,baseFuncName)
            if doFileMove
                movefile(currentFile,saveDir)
            else
                copyfile(currentFile,saveDir)
            end
        else
            pcode(currentFile)
            delete(currentFile)
            currentFile = strrep(currentFile,'.m','.p');
            if doFileMove
                movefile(currentFile,[saveDir filesep 'protected'])
            else
                copyfile(currentFile,[saveDir filesep 'protected'])
            end
        end
    else
        if doFileMove
            movefile(currentFile,saveDir)
        else
            copyfile(currentFile,saveDir)
        end
    end
end

% zip up saveDir
if doZip;
    zip([saveDir '.zip'],saveDir)
end;

% delete saveDir
% rmdir(saveDir)


%%%%%%%%%%%%%%%%%%%%%
% Identifies the common root directory of all files in cell array "req"
function d = i_root_directory(req)

d = i_parent(req{1});
for i=1:numel(req)
    t = i_parent(req{i});
    if strncmp(t,d,numel(d))
        % req{i} is in directory d.  Next file.
        continue;
    end
    % req{i} is not in directory d.  Up one directory.
    count = 1;
    while true
        % Remove trailing separator before calling fileparts.  Add it
        % again afterwards.
        tempd = i_parent(d(1:end-1));
        if strcmp(d,tempd)
            % fileparts didn't find us a higher directory
            error('Failed to find common root directory for %s and %s',req{1},req{i});
        end
        d = tempd;
        if strncmp(t,d,numel(d))
            % req{i} is in directory d.  Next file.
            break;
        end
        % Safety measure for untested platform.
        count = count+1;
        if count>1000
            error('Bug in i_root_directory.');
        end
    end
end

%%%%%%%%%%%%%%%%%%%
function d = i_parent(d)
% Identifies the parent directory, including a trailing separator

% Include trailing separator in all comparisons so we don't assume that
% file C:\tempX\file.txt is in directory C:\temp
d = fileparts(d);
if d(end)~=filesep
    d = [d filesep];
end
