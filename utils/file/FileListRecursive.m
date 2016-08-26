function allFiles = FileListRecursive(varargin)

if nargin
    startDir = varargin{1};
    cd(startDir)
end

% find all .eeg files and delete them
rawDataDirs = DirListRecursive;
startDir = pwd;
targetRegexp = '*.eeg';

doDelete = 1;

allFiles = {}; pos = 0;
totalBytes = 0;

for n = 1:length(rawDataDirs)
    cd(rawDataDirs{n})
    targetFiles = dir(targetRegexp);
    if length(targetFiles) > 0
        for m = 1:length(targetFiles)
            pos = pos + 1;
            allFiles{pos,1} = fullfile(rawDataDirs{n},targetFiles(m).name);
            totalBytes = totalBytes + targetFiles(m).bytes;
        end
    end
    cd(startDir)
end

fprintf('\nFound %1.0f files of type %s\n',pos,targetRegexp);

if totalBytes < 1000
    fprintf('Total size ca. %1.0f bytes\n',totalBytes);
elseif totalBytes < 1000000
    fprintf('Total size ca. %1.2f kB\n',totalBytes/1000);
else
    fprintf('Total size ca. %1.2f MB\n',totalBytes/1000000);
end

if ~doDelete
    return
end

promptStr = sprintf('Type ''yes'' to delete files of type %s? ',targetRegexp);
pos = 0;

answer = input(promptStr,'s');

switch answer
    case 'yes'
        % delete
        for n = 1:length(allFiles)
            try
                delete(allFiles{n})
                pos = pos + 1;
            catch
                fprintf('Failed to delete file \n%s\n',allFiles{n});
            end
        end
        fprintf('Deleted %1.0f files \n',pos);
    otherwise
        fprintf('Deleted %1.0f files \n',pos);
end
