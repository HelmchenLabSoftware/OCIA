function removeSvnFromPath
% utility function to remove all directories containing the .svn string
% from the path
% saves new path

oldPath = path;
newPath = '';
startIdx = 1;

for n = 1:length(oldPath)
    if strcmp(oldPath(n),pathsep)
       currentDir = oldPath(startIdx:n);
       startIdx = n + 1;
       if ~isempty(strfind(currentDir,'.svn'))
%           fprintf('\nRemoved %s from path',currentDir);
       else
           newPath = [newPath currentDir];
       end
    end
end

path(newPath)

savepath

clc
