% make a release of the OCIA

% define target directory
targetDirRoot = 'E:/';
% targetDirRoot = 'D:/Users/BaL/PhD/';

fprintf('#%s: targetDirRoot = "%s"\n', mfilename, targetDirRoot);

warning('off', 'MATLAB:DEPFUN:DeprecatedAPI');

% get the version
FID = fopen(which('OCIA'));
% A = regexp(fscanf(FID, '%s'), 'version=.(?<version>[\d\.]+).;', 'names');
A = regexp(fscanf(FID, '%s'), '.version.,.(?<version>[\d\.]+).', 'names');
fclose(FID);
version = regexprep(A.version, '\.', '_');

% get the target dir
targetDir = regexprep(sprintf('%sOCIAv%s\\', targetDirRoot, version), '\\', '/');

% get the OCIA folder
OCIASrcDir = regexprep(which('OCIA'), '\\', '/');
OCIASrcDir = regexprep(OCIASrcDir, '@OCIA/OCIA.m$', '');

fprintf('#%s: targetDir = "%s"\n', mfilename, targetDir);
fprintf('#%s: OCIASrcDir = "%s"\n', mfilename, OCIASrcDir);

% copy the OCIA files
copyfile([OCIASrcDir '*'], targetDir);

% make an 'etc' folder and copy all required functions for the main OCIA file
etcDir = [targetDir 'etc/'];
fprintf('#%s: etcDir = "%s"\n', mfilename, etcDir);
exportMfiles('OCIA', 0, 0, etcDir);

% copy all required functions for the custom files
customFolders = dir([OCIASrcDir 'custom/*']); % get custom folders
customFoldersNames = arrayfun(@(i)customFolders(i).name, 1 : numel(customFolders), 'UniformOutput', false);
customFoldersNames(1 : 2) = []; % remove '.' and '..'
% go through each folder and get each file's name
for iFolder = 1 : numel(customFoldersNames);
    fprintf('  #%s: processing custom folders %02d/%02d "%s" ...\n', mfilename, iFolder, ...
        numel(customFoldersNames), customFoldersNames{iFolder});
    customFiles = dir([OCIASrcDir 'custom/' customFoldersNames{iFolder} '/*']); % get custom files
    customFilesNames = arrayfun(@(i)customFiles(i).name, 1 : numel(customFiles), 'UniformOutput', false);
    if isempty(customFilesNames); continue; end;
    customFilesNames(1 : 2) = []; % remove '.' and '..'
    for iFile = 1 : numel(customFilesNames);
        exportMfiles(customFilesNames{iFile}, 0, 0, etcDir);
    end;
    
    % remove files that are in the custom files
    etcFiles = dir([etcDir '*']); % get etc folder files
    etcFilesNames = arrayfun(@(i)etcFiles(i).name, 1 : numel(etcFiles), 'UniformOutput', false);
    etcFilesNames(1 : 2) = []; % remove '.' and '..'
    for iEtcFile = 1 : numel(etcFilesNames);
        if ismember(etcFilesNames{iEtcFile}, customFilesNames);
            delete([etcDir etcFilesNames{iEtcFile}]);
        end;
    end;
end;

% remove files that are already in the @OCIA folder
OCIATargetDir = [targetDir '@OCIA/'];
OCIAFiles = dir([OCIATargetDir '*']); % get OCIA files
OCIAFileNames = arrayfun(@(i)OCIAFiles(i).name, 1 : numel(OCIAFiles), 'UniformOutput', false);
OCIAFileNames(1 : 2) = []; % remove '.' and '..'
etcFiles = dir([etcDir '*']); % get etc folder files
etcFilesNames = arrayfun(@(i)etcFiles(i).name, 1 : numel(etcFiles), 'UniformOutput', false);
etcFilesNames(1 : 2) = []; % remove '.' and '..'
fprintf('#%s: removing extra etcFiles (%02d) ...\n', mfilename, numel(etcFilesNames));
for iEtcFile = 1 : numel(etcFilesNames);
    if ismember(etcFilesNames{iEtcFile}, OCIAFileNames);
        delete([etcDir etcFilesNames{iEtcFile}]);
    end;
end;

% remove the releases folder
OCIAReleasesTargetDir = [targetDir 'releases'];
rmdir(OCIAReleasesTargetDir, 's');

% zip the folder
fprintf('#%s: zipping ...\n', mfilename);
zipFilePath = regexprep(targetDir, '/$', '.zip');
zip(zipFilePath, regexprep(targetDir, '/$', ''));

fprintf('#%s: releasing ...\n', mfilename);
copyfile(zipFilePath, regexprep(zipFilePath, targetDirRoot, 'W:/Neurophysiology/Software/Matlab/OCIA/'));
% copyfile(zipFilePath, regexprep(zipFilePath, targetDirRoot, 'D:/Users/BaL/programming/Work/PhD/matlab/caImgAnalysis/OCIA/releases/'));
copyfile(zipFilePath, regexprep(zipFilePath, targetDirRoot, 'E:/programming/Work/PhD/matlab/caImgAnalysis/OCIA/releases/'));
copyfile(zipFilePath, regexprep(zipFilePath, targetDirRoot, 'Z:/'));

warning('on', 'MATLAB:DEPFUN:DeprecatedAPI');
fprintf('#%s: doneski.\n', mfilename);
