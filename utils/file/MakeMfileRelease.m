function MakeMfileRelease(fun,varargin)
% collect all dependent files for function fun and collect them in folder
% 'etc' in current folder
% in2 ... zip {0}
% in3 ... pcode {0}

% this file written by Henry Luetcke (hluetck@gmail.com)
doZip = 0;
doPcode = 0;

if nargin > 1
   doZip = varargin{1};
end

if nargin > 2
   doPcode = varargin{2};
end

% depFiles = depfun(fun,'-quiet');
depFiles = mydepfun(fun,1);
depFiles(strcmp(depFiles,which(fun))) = [];

try
    copyfile(which(fun),pwd)
end

thisDir = pwd;
if exist(fullfile(pwd,'etc'),'dir') == 7
   rmdir('etc','s')
end
try
    mkdir('etc');
end
targetDir = sprintf('%s%setc',thisDir,filesep);
count = 0;
for n = 1:numel(depFiles)
    % exclude files which are in the ML root folder or below
    if isempty(strfind(depFiles{n},matlabroot))
        copyfile(depFiles{n},targetDir)
        count = count + 1;
    end
end

fprintf('\nCopied %1.0f files\n',count);

if doPcode
    cd etc
    pcode('*.m')
    delete('*.m')
    cd(thisDir)
end

if doZip
    zipName = [fun '.zip'];
    zip(zipName,{strrep(zipName,'.zip','.m') 'etc'})
end

