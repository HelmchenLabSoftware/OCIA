function [ status ] = addFolders2Path( folderList , recursive)

% check for env MATLABLOCALPATH
envVarName = 'MATLABLOCALPATH'; % the name of the env var
try
    localPath = getenv(envVarName);
catch
    error('Failed to load environement variable %s',envVarName)
end

folderList = strrep(folderList,'\',filesep);
folderList = strrep(folderList,'/',filesep);
if isempty(localPath)
    status = 0;
    return
else
    status = 1;
end

for n = 1:numel(folderList)
    folder2add = sprintf('%s%s%s',localPath,filesep,folderList{n});
    if ~exist(folder2add,'dir')
        fprintf('\nFolder %s not found. Skipping ...\n',folder2add)
        continue
    end
    if recursive
        folder2add = genpath(folder2add);
    end
    addpath(folder2add);
end


end

